#import "github-pl-colors.typ": github-pl-colors

// Fonts used for different languages.
#let lang-fonts = (
  en: (heading: "Linux Libertine", body: "Linux Libertine"),
  cn: (
    heading: ("Noto Sans CJK SC", "Heiti SC"),
    body: ("Noto Serif CJK SC", "Songti SC"),
  ),
)

// Set the localization dictionary according to the given language.
#let _set-locale-dict(lang) = {
  if lang == "cn" {
    [
      #metadata("简历") <locale-dict-resume>
      #metadata("导师") <locale-dict-supervisor>
      #metadata("至今") <locale-dict-now>
    ]
  } else {
    [
      #metadata("Resume") <locale-dict-resume>
      #metadata("Supervisor") <locale-dict-supervisor>
      #metadata("Now") <locale-dict-now>
    ]
  }
}

#let _get-locale-keyword(tag) = {
  locate(loc => {
    query(tag, loc).first().value
  })
}

// This function defines the resume template.
#let resume(
  name,     // string. Your name.
  phone,    // string. Your phone number.
  email,    // string. Your email address.
  webpage: none,    // string, optional. URL to your home page.
  github-id: none,  // string, optional. Your GitHub ID.
  twitter-id: none, // string, optional. Your Twitter ID.
  zhihu-id: none,   // string, optional. Your Zhihu ID.
  lang: "en",       // string, optional. Language of the resume.
  text-size: none,  // length, optional. The text size of 1em.
  page-margin: none, // dict (top, bottom, left, right), optional. Page margin.
  body,     // content, optional. The main content of the resume.
) = {
  if text-size == none {
    text-size = 10pt
  }
  if page-margin == none {
    page-margin = (top: 1.2cm, bottom: 1.2cm, left: 1cm, right: 1cm)
  }

  // Set the document's basic properties.
  set document(author: name, title: "CV - " + name)
  set page(
    paper: "a4",
    margin: page-margin,
    footer: context [
      #set text(size: 0.95em, fill: rgb(90, 90, 90))

      #datetime.today().display()
      #h(1fr)
      #counter(page).display("1 / 1", both: true)
    ]
  )
  set text(lang: lang, size: text-size)

  // Set localization dictionary as metadata.
  _set-locale-dict(lang)

  let lang-fonts-config = lang-fonts.at(lang, default: none)
  if lang-fonts-config == none {
    lang-fonts-config = lang-fonts.en
  }

  set text(font: lang-fonts-config.body)

  // Section heading styles.
  show heading: it => block[
    #set text(font: lang-fonts-config.heading, size:0.92em)
    #stack(
      spacing: 0.3em,
      smallcaps(it.body),
      line(length: 6cm)
    )
  ]

  let personal-info-block = {
    // An item listed in the personal information.
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
    let twitter-item = none
    let zhihu-item = none
    if webpage != none {
      webpage-item = info-item(raw(webpage), icon: image("figures/web.svg"), url: webpage)
    }
    if github-id != none {
      github-item = info-item(raw(github-id), icon: image("figures/github.svg"), url: "https://github.com/" + github-id)
    }
    if (twitter-id != none) {
      twitter-item = info-item(raw(twitter-id), url: "https://twitter.com/" + twitter-id)
    }
    if (zhihu-id != none) {
      zhihu-item = info-item(raw(zhihu-id), icon: image("figures/zhihu.svg"), url: "https://www.zhihu.com/people/" + lower(zhihu-id))
    }

    let layout-phone(phone) = {
      box(phone.split("-").map(raw).join(h(0.25em)))
    }

    // Personal information at the top.
    block(text(font: lang-fonts-config.heading, size: 2em, weight: 700, name))  // Name
    stack(
      dir: ltr,
      spacing: 1.5em,
      info-item(layout-phone(phone), icon: image("figures/phone.svg")),
      info-item(raw(email), icon: image("figures/email.svg"), url: "mailto:" + email),
      webpage-item,
      github-item,
      twitter-item,
      zhihu-item,
    )
  }

  personal-info-block

  // Main body.
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
  let stack-items = (
    [
      #text(weight: "bold", title)
      #h(1em)
      #text(fill: rgb(140, 140, 140), style: "italic", subtitle)
      #h(1fr)
      #text(weight: "bold", badge)
    ],
  )

  if body != none {
    stack-items.push(body)
  }

  stack(
    spacing: 0.6em,
    ..stack-items
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
    end-date = _get-locale-keyword(<locale-dict-now>)
  }

  let duration = [ #start-date - #end-date ]
  let subtitle = (degree, major, department).filter(i => i != none).join(", ")

  if supervisor != none {
    let supervisor-line = block[
      #set text(fill: rgb(140, 140, 140))
      #_get-locale-keyword(<locale-dict-supervisor>): #supervisor
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
    end-date = _get-locale-keyword(<locale-dict-now>)
  }

  let duration = start-date + " - " + end-date
  let subtitle = (position, group).filter(i => i != none).join(", ")

  resume-item(organization, badge: duration, subtitle: subtitle, body: body)
}

// Generate a resume item that represents a development project.
#let develop-item(
  name,     // string. Name of the project.
  languages, // string. Programming languages used in the project.
  role,     // string. Name of your role.
  body: none,   // string, optional. Any additional content associated with the project.
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

  resume-item(name, badge: badge, subtitle: role, body: body)
}
