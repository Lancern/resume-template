#import "@preview/oxifmt:1.0.0": strfmt

#import "github-pl-colors.typ": github-pl-colors

#let vocab = state("vocab", none)
#let get-vocab(id) = context vocab.get().at(id)

// This function defines the resume template.
#let resume(
  name, // string. Your name.
  phone, // string. Your phone number.
  email, // string. Your email address.
  webpage: none, // string, optional. URL to your home page.
  github-id: none, // string, optional. Your GitHub ID.
  locale: "en-us", // string, optional. Locale of the resume.
  paper: "a4", // string, optional. The paper size of the resume.
  page-margin: (top: 1.8cm, bottom: 1.8cm, left: 1.4cm, right: 1.4cm), // Page margin settings.
  text-size: 10pt, // size, optional. The size of the main text.
  body, // content, optional. The main content of the resume.
) = {
  // Load vocabulary
  let vocab-catalog = toml("resources/vocab.toml")
  vocab.update(old => vocab-catalog.at(locale))

  // Set the document's basic properties.
  set document(
    title: strfmt(vocab-catalog.at(locale).resume-title, name),
    author: name,
    description: strfmt(vocab-catalog.at(locale).resume-description, name)
  )
  set page(
    paper: paper,
    margin: page-margin,
    footer: context [
      #set text(size: 0.9em, fill: rgb(90, 90, 90))
      #datetime.today().display()
      #h(1fr)
      #counter(page).display("1 / 1", both: true)
    ],
  )

  let lang = locale.split("-").at(0)
  let region = locale.split("-").at(1)

  let all-fonts = toml("resources/fonts.toml")
  let fonts = all-fonts.at(locale)

  // Body text style
  set text(
    lang: lang,
    size: text-size,
    font: fonts.body,
  )

  // Title style
  show title: set text(
    font: fonts.title,
    weight: "bold",
    size: text-size * 2,
  )

  // Section heading style
  show heading: it => block[
    #set text(font: fonts.heading, size: text-size * 1.25)
    #stack(
      spacing: 0.3em,
      smallcaps(it.body),
      line(length: 8cm),
    )
  ]

  // An item listed in the personal information area.
  let info-item(icon: none, url: none, body) = {
    set text(size: 1em, fill: rgb(60, 60, 60))
    if icon != none {
      box(height: 1.1em, width: 1.1em, baseline: 0.26em, icon)
      h(0.2em)
    }
    if url != none {
      link(url, body)
    } else {
      body
    }
  }

  let webpage-item = none
  let github-item = none
  if webpage != none {
    webpage-item = info-item(raw(webpage), icon: image("resources/web.svg"), url: webpage)
  }
  if github-id != none {
    github-item = info-item(
      raw(github-id),
      icon: image("resources/github.svg"),
      url: "https://github.com/" + github-id,
    )
  }

  let layout-phone(phone) = {
    box(phone.split(" ").map(raw).join(h(0.25em)))
  }

  // Personal information at the top.
  title(name)
  stack(
    dir: ltr,
    spacing: 1em,
    info-item(layout-phone(phone), icon: image("resources/phone.svg")),
    info-item(raw(email), icon: image("resources/email.svg"), url: "mailto:" + email),
    webpage-item,
    github-item,
  )

  // Main body.
  body
}

// Generate an item listed on the resume. An item may represent an education experience, an award received, a work
// experience, a project development, anything that worth it on a resume.
#let resume-item(
  title, // string. The title of the item.
  badge: none, // content, optional. The badge of the item. The badge appears at the right-top corner of the item.
  subtitle: none, // string, optional. The subtitle of the item.
  ..body, // content, optional. Any additional content associated with this item.
) = stack(
  spacing: 0.6em,
  [
    #text(weight: "bold", title)
    #h(1em)
    #text(fill: rgb(140, 140, 140), style: "italic", subtitle)
    #h(1fr)
    #text(weight: "bold", badge)
  ],
  ..body,
)

// Generate a resume item that represent an educational experience.
#let edu(
  school, // string. The school name.
  degree, // string. The degree name.
  start-date, // string. The start date of this education experience.
  end-date: none, // string, optional. The end date of this education experience.
  // Lack of this parameter indicates the experience lasted up to now.
  department: none, // string, optional. The department name.
  major: none, // string, optional. The major name.
  supervisor: none, // string, optional. The supervisor's name.
  ..body, // content, optional. Any additional content included in this item.
) = {
  if end-date == none {
    end-date = get-vocab("tonow")
  }

  let duration = [ #start-date - #end-date ]
  let subtitle = (degree, major, department).filter(i => i != none).join(", ")

  if supervisor != none {
    let supervisor-line = block[
      #set text(fill: rgb(140, 140, 140))
      #context get-vocab("supervisor"): #supervisor
    ]
    if body.pos().len() == 0 {
      body = (supervisor-line,)
    } else {
      body = (
        stack(
          supervisor-line,
          body,
        ),
      )
    }
  }

  resume-item(
    school,
    badge: duration,
    subtitle: subtitle,
    ..body,
  )
}

// Generate a resume item that represents an award received.
#let award(
  name, // string. Name of the competition, activity, etc. from which you received the award.
  date, // string. Date when you received the award.
  award, // string. Name of the award.
  ..body, // content, optional. Any additional content associated with the award.
) = {
  resume-item(name, badge: date, subtitle: award, ..body)
}

// Generate a resume item that represents a work experience.
#let career(
  organization, // string. Name of the organization that you worked for.
  position, // string. Name of your position.
  start-date, // string. The start date of this work experience.
  end-date: none, // string, optional. The end date of this work experience.
  // Lack of this parameter indicates that the work lasted up to now.
  group: none, // string, optional. Name of the internal group that you worked for within the organization.
  ..body, // content, optional. Any additional content associated with the work experience.
) = {
  if end-date == none {
    end-date = get-vocab("tonow")
  }

  let duration = start-date + " - " + end-date
  let subtitle = (position, group).filter(i => i != none).join(", ")

  resume-item(organization, badge: duration, subtitle: subtitle, ..body)
}

// Generate a resume item that represents a development project.
#let project(
  name, // string. Name of the project.
  languages, // string. Programming languages used in the project.
  role, // string. Name of your role.
  ..body, // content, optional. Any additional content associated with the project.
) = {
  let badge = languages
    .split(regex(", *"))
    .map(i => (github-pl-colors.at(lower(i), default: none), i))
    .filter(i => i.first() != none)
    .map(i => [
      #box(baseline: 0.2em, circle(height: 1em, fill: i.first()))
      #i.last()
    ])
    .join()

  resume-item(name, badge: badge, subtitle: role, ..body)
}
