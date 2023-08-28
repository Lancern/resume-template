#import "github-pl-colors.typ": github-pl-colors

// Fonts used for different languages.
#let lang-fonts = (
  en: (heading: "Linux Libertine", body: "Linux Libertine"),
  cn: (
    heading: ("Heiti SC", "Noto Sans CJK SC"),
    body: ("Songti SC", "Noto Serif CJK SC")
  ),
)

// This function defines the resume template.
#let resume(
  name,     // string. Your name.
  phone,    // string. Your phone number.
  email,    // string. Your email address.
  webpage: none,    // string, optional. URL to your home page.
  github-id: none,  // string, optional. Your GitHub ID.
  twitter-id: none, // string, optional. Your Twitter ID.
  photo: none,      // content, optional. Your personal photograph.
  lang: "en",       // string, optional. Language of the resume.
  body,     // content, optional. The main content of the resume.
) = {
  // Set the document's basic properties.
  set document(author: name, title: "Resume of " + name)
  set page(
    paper: "a4",
    margin: (top: 20mm, bottom: 20mm, left: 15mm, right: 15mm),
    numbering: "1",
    number-align: center,
  )
  set text(lang: lang, size: 11pt)

  let lang-fonts-config = lang-fonts.at(lang, default: none)
  if lang-fonts-config == none {
    lang-fonts-config = lang-fonts.en
  }

  set text(font: lang-fonts-config.body)

  // Section heading styles.
  show heading: it => block[
    #set text(font: lang-fonts-config.heading)
    #stack(
      spacing: 0.3em,
      smallcaps(it.body),
      line(length: 80%)
    )
  ]

  let personal-info-block = {
    // An item listed in the personal information.
    let info-item(icon: none, url: none, body) = {
      set text(size: 1.1em, fill: rgb(80, 80, 80))
      if icon != none {
        box(height: 1em, baseline: 0.2em, icon)
        h(0.2em)
      }
      if url != none {
        link(url, body)
      } else {
        body
      }
    }

    // Personal information at the top.
    block(text(font: lang-fonts-config.heading, size: 2em, weight: 700, name))  // Name
    stack(
      spacing: 0.3em,
      stack(
        dir: ltr,
        spacing: 2em,
        info-item(phone, icon: image("figures/phone.svg")),
        info-item(email, icon: image("figures/email.svg"), url: "mailto:" + email),
      ),
      stack(
        dir: ltr,
        spacing: 2em,
        if webpage != none { info-item(webpage, icon: image("figures/web.svg"), url: webpage) },
        if github-id != none { info-item(github-id, icon: image("figures/github.svg"), url: "https://github.com/" + github-id) },
        if twitter-id != none { info-item(twitter-id, url: "https://twitter.com/" + twitter-id) },
      )
    )
  }

  if photo != none {
    // Measure the height of persona-info-block, which will be the maximum height of the photo.
    style(sty => {
      let pib-size = measure(personal-info-block, sty)
      place(
        top + right,
        dy: -15mm,
        box(height: pib-size.height + 15mm, photo),
      )
    })
  }

  personal-info-block
  v(1.2em)

  // Main body.
  show: columns.with(2, gutter: 1.5em)
  body
}

// Generate an item listed on the resume. An item may represent an education experience, an award received, a work
// experience, a project development, anything that worth it on a resume.
#let resume-item(
  title,        // string. The title of the item.
  badge: none,  // content, optional. The badge of the item. The badge appears at the right-top corner of the item.
  subtitle: none,  // string, optional. The subtitle of the item.
  body: none,   // content, optional. Any additional content associated with this item.
) = {
  stack(
    spacing: 0.6em,
    block[
      #set text(weight: "bold")
      #title #h(1fr) #badge
    ],
    block[
      #set text(fill: rgb(140, 140, 140), style: "italic")
      #subtitle
    ],
    body,
  )
}

// Generate a resume item that represent an educational experience.
#let edu-item(
  school,      // string. The school name.
  degree,      // string. The degree name.
  start-date,  // string. The start date of this education experience.
  end-date: none,    // string, optional. The end date of this education experience.
                     // Lack of this parameter indicates the experience lasted up to now.
  department: none,  // string, optional. The department name.
  major: none,       // string, optional. The major name.
  supervisor: none,  // string, optional. The supervisor's name.
  body: none,        // content, optional. Any additional content included in this item.
) = {
  if end-date == none {
    end-date = "Now"
  }

  let duration = start-date + " - " + end-date
  let subtitle = (degree, major, department).filter(i => i != none).join(", ")

  if supervisor != none {
    let supervisor-line = block[
      #set text(fill: rgb(140, 140, 140))
      Supervisor: #supervisor
    ]
    if body == none {
      body = supervisor-line
    } else {
      body = stack(
        supervisor-line,
        body,
      )
    }
  }

  resume-item(
    school,
    badge: duration,
    subtitle: subtitle,
    body: body,
  )
}

// Generate a resume item that represents an award received.
#let award-item(
  name,  // string. Name of the competition, activity, etc. from which you received the award.
  date,  // string. Date when you received the award.
  award, // string. Name of the award.
  body: none,  // content, optional. Any additional content associated with the award.
) = {
  resume-item(name, badge: date, subtitle: award, body: body)
}

// Generate a resume item that represents a work experience.
#let work-item(
  organization, // string. Name of the organization that you worked for.
  position,     // string. Name of your position.
  start-date,   // string. The start date of this work experience.
  end-date: none, // string, optional. The end date of this work experience.
                  // Lack of this parameter indicates that the work lasted up to now.
  group: none,  // string, optional. Name of the internal group that you worked for within the organization.
  body: none,   // string, optional. Any additional content associated with the work experience.
) = {
  if end-date == none {
    end-date = "Now"
  }

  let duration = start-date + " - " + end-date
  let subtitle = (position, group).filter(i => i != none).join(", ")

  resume-item(organization, badge: duration, subtitle: subtitle, body: body)
}

// Generate a resume item that represents a development project.
#let develop-item(
  name,     // string. Name of the project.
  language, // string. Programming language used in the project.
  role,     // string. Name of your role.
  body: none,   // string, optional. Any additional content associated with the project.
) = {
  let badge-color = github-pl-colors.at(lower(language), default: none)

  let badge = language
  if badge-color != none {
    badge = [
      #box(baseline: 0.2em, circle(height: 1em, fill: badge-color))
      #language
    ]
  }

  resume-item(name, badge: badge, subtitle: role, body: body)
}
