#import "@preview/oxifmt:1.0.0": strfmt

#let _vocab-catalog = toml("resources/vocab.toml")
#let _get-vocab(id) = context {
  let locale = text.lang + "-" + lower(text.region)
  _vocab-catalog.at(locale).at(id)
}

/// The resume template.
///
/// - name: string, your name.
/// - phone: string, your phone number.
/// - email: string, your email address.
/// - webpage: string or none, URL to your home page. Default to none.
/// - github-id: string or none, your GitHub ID. Default to none.
/// - date: datetime, the date when the resume is generated. Default to the
///   current date.
/// - locale: string, locale of the resume. Default to `"en-us"`.
/// - paper: string, paper size of the resume. Default to `"a4"`.
/// - page-margin: length or dictionary, page margin settings. Default to
///   `1.4cm`.
/// - text-size: length, size of the main text. Default to `11pt`.
/// - fonts: dictionary, font overrides for the title, body, and headings.
///   Default to an empty dictionary.
/// - body: content, main content of the resume.
#let resume(
  name,
  phone,
  email,
  webpage: none,
  github-id: none,
  date: datetime.today(),
  locale: "en-us",
  paper: "a4",
  page-margin: 1.4cm,
  text-size: 11pt,
  fonts: (:),
  body,
) = {
  // Set the document's basic properties.
  set document(
    title: strfmt(_vocab-catalog.at(locale).resume-title, name),
    author: name,
    description: strfmt(_vocab-catalog.at(locale).resume-description, name),
  )
  set page(
    paper: paper,
    margin: page-margin,
    footer: context [
      #set text(size: 0.9em, fill: rgb(150, 150, 150))
      #date.display()
      #h(1fr)
      #counter(page).display("1 / 1", both: true)
    ],
  )

  let lang = locale.split("-").at(0)
  let region = locale.split("-").at(1)

  let all-fonts = toml("resources/fonts.toml")
  let default-fonts = all-fonts.at(locale)
  let title-font = fonts.at("title", default: default-fonts.title)
  let body-font = fonts.at("body", default: default-fonts.body)
  let heading-font = fonts.at("heading", default: default-fonts.heading)

  // Body text style
  set text(
    lang: lang,
    region: region,
    size: text-size,
    font: body-font,
  )

  // Title style
  show title: set text(
    font: title-font,
    weight: "bold",
    size: text-size * 2,
  )

  // Section heading style
  show heading: it => block[
    #set text(font: heading-font, size: text-size * 1.25)
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

/// An item listed on the resume. An item may represent an education experience,
/// an award, a work experience, a project, or anything else worth listing.
///
/// - title: string, title of the item.
/// - badge: content or none, badge displayed in the top-right corner of the
///   item. Default to none.
/// - subtitle: string or none, subtitle of the item. Default to none.
/// - body: content, additional content associated with this item.
#let resume-item(
  title,
  badge: none,
  subtitle: none,
  ..body,
) = stack(
  spacing: 0.6em,
  [
    #text(weight: "bold", title)
    #h(1em)
    #text(fill: rgb(120, 120, 120), style: "italic", subtitle)
    #h(1fr)
    #text(weight: "bold", badge)
  ],
  ..body,
)

/// A resume item that represents an educational experience.
///
/// - school: string, school name.
/// - degree: string, degree name.
/// - start-date: string, start date of the education experience.
/// - end-date: string or none, end date of the education experience. Default to
///   none, indicating that the experience has not ended.
/// - department: string or none, department name. Default to none.
/// - major: string or none, major name. Default to none.
/// - supervisor: string or none, supervisor's name. Default to none.
/// - body: content, additional content included in this item.
#let edu(
  school,
  degree,
  start-date,
  end-date: none,
  department: none,
  major: none,
  supervisor: none,
  ..body,
) = {
  if end-date == none {
    end-date = _get-vocab("tonow")
  }

  let duration = [ #start-date - #end-date ]
  let subtitle = (degree, major, department).filter(i => i != none).join(", ")

  if supervisor != none {
    let supervisor-line = block[
      #set text(fill: rgb(140, 140, 140))
      #context _get-vocab("supervisor"): #supervisor
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

/// A resume item that represents an award received.
///
/// - name: string, name of the competition, activity, or other source of the
///   award.
/// - date: string, date when the award was received.
/// - award: string, name of the award.
/// - body: content, additional content associated with the award.
#let award(
  name,
  date,
  award,
  ..body,
) = {
  resume-item(name, badge: date, subtitle: award, ..body)
}

/// A resume item that represents a work experience.
///
/// - organization: string, name of the organization.
/// - position: string, name of the position.
/// - start-date: string, start date of the work experience.
/// - end-date: string or none, end date of the work experience. Default to
///   none, indicating that the work has not ended.
/// - group: string or none, name of the internal group within the organization.
///   Default to none.
/// - body: content, additional content associated with the work experience.
#let career(
  organization,
  position,
  start-date,
  end-date: none,
  group: none,
  ..body,
) = {
  if end-date == none {
    end-date = _get-vocab("tonow")
  }

  let duration = start-date + " - " + end-date
  let subtitle = (position, group).filter(i => i != none).join(", ")

  resume-item(organization, badge: duration, subtitle: subtitle, ..body)
}

/// A resume item that represents an open source contribution.
///
/// - name: string, name of the open source project.
/// - lang: string or array of strings, programming languages used in the
///   project.
/// - role: string, role in the project.
/// - body: content, additional content associated with the project.
#let open-source-contribution(
  name,
  lang,
  role,
  ..body,
) = {
  if type(lang) == str {
    lang = (lang,)
  }

  let language-catalog = yaml("resources/languages.yml")

  let badge = lang
    .map(i => (language-catalog.at(i, default: none), i))
    .filter(i => i.first() != none)
    .map(i => [
      #box(baseline: 0.2em, circle(height: 1em, fill: rgb(i.first().color)))
      #i.last()
    ])
    .join()

  resume-item(name, badge: badge, subtitle: role, ..body)
}

#let project(name, body) = {
  text(weight: "bold", name)
  h(1.2em)
  body
  parbreak()
}
