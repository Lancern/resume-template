#import "@preview/oxifmt:1.0.0": strfmt

#import "fonts.typ": font-set
#import "vocab.typ": catalog as vocab-catalog, vocab

/// The resume template.
///
/// - name: string, your name.
/// - phone: string, your phone number.
/// - email: string, your email address.
/// - webpage: string or none, URL to your home page. Default to none.
/// - github-id: string or none, your GitHub ID. Default to none.
/// - locale: string, locale of the resume. Default to `"en-us"`.
/// - paper: string, paper size of the resume. Default to `"a4"`.
/// - page-margin: length or dictionary, page margin settings. Default to
///   `1.4cm`.
/// - text-size: length, size of the main text. Default to `11pt`.
/// - fonts: dictionary, font overrides for the title, body, and headings.
///   Default to an empty dictionary.
/// - display-date: bool, a flag that controls whether the document's date
///   should be displayed in the footer of the page. Default to false.
/// - body: content, main content of the resume.
#let resume(
  name,
  phone,
  email,
  webpage: none,
  github-id: none,
  locale: "en-us",
  paper: "a4",
  page-margin: 1.4cm,
  text-size: 11pt,
  fonts: (:),
  display-date: false,
  body,
) = {
  // Set the document's basic properties.
  set document(
    title: strfmt(vocab-catalog.at(locale).resume-title, name),
    author: name,
    description: strfmt(vocab-catalog.at(locale).resume-description, name),
    keywords: (vocab-catalog.at(locale).resume-keyword, name),
  )
  set page(
    paper: paper,
    margin: page-margin,
    footer: [
      #set text(size: 0.8em, fill: rgb(150, 150, 150))
      #if display-date {
        context {
          if document.date == auto {
            datetime.today().display()
          } else {
            document.date.display()
          }
        }
      }
      #h(1fr)
      #context { counter(page).display("1 / 1", both: true) }
    ],
  )

  let lang = locale.split("-").at(0)
  let region = locale.split("-").at(1)

  let default-font-set = font-set("adobe-source")
  let title-font = fonts.at("title", default: default-font-set.at("title"))
  let body-font = fonts.at("body", default: default-font-set.at("body"))
  let heading-font = fonts.at(
    "heading",
    default: default-font-set.at("heading")
  )

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
  show heading: set text(font: heading-font)
  show heading.where(level: 1): it => block(above: 1.2em, below: 0.4em)[
    #set text(size: text-size * 1.35)
    #stack(
      spacing: 0.3em,
      smallcaps(it.body),
      line(length: 8cm),
    )
  ]
  show heading.where(level: 2): set text(font: body-font, size: text-size * 1.1)

  // An item listed in the personal information area.
  let info-item(icon: none, url: none, body) = box({
    set text(size: 1.1em, fill: rgb(80, 80, 80))
    if icon != none {
      box(height: 1.1em, width: 1.1em, baseline: 0.26em, icon)
      h(0.2em)
    }
    if url != none {
      link(url, body)
    } else {
      body
    }
  })

  let webpage-item = none
  let github-item = none
  if webpage != none {
    webpage-item = info-item(raw(webpage), icon: image("../resources/web.svg"), url: webpage)
  }
  if github-id != none {
    github-item = info-item(
      raw(github-id),
      icon: image("../resources/github.svg"),
      url: "https://github.com/" + github-id,
    )
  }

  let layout-phone(phone) = {
    box(phone.split(" ").map(raw).join(h(0.25em)))
  }

  let make-phone-link(phone) = {
    // A canonicalized `tel:` link would only contain digit characters and the
    // `+` character.
    return "tel:" + phone.replace(regex("[^\\d\\+]"), "")
  }

  // Personal information at the top.
  title(name)
  stack(
    dir: ltr,
    spacing: 1em,
    info-item(
      layout-phone(phone),
      icon: image("../resources/phone.svg"),
      url: make-phone-link(phone),
    ),
    info-item(
      raw(email),
      icon: image("../resources/email.svg"),
      url: "mailto:" + email,
    ),
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
/// - subtitles: array, subtitles of the item. Default to an empty array.
/// - body: content, additional content associated with this item.
#let item(
  title,
  badge: none,
  subtitles: (),
  ..body,
) = {
  let subtitle-texts = subtitles.map(st => text(
    fill: rgb(100, 100, 100),
    emph(st),
  ))

  block(
    above: 0.6em,
    below: if body.len() > 0 { 1.35em } else { 1em },
  )[
    #block(below: 0.75em)[
      #box(heading(level: 2, title))
      #h(3em)
      #box(stack(dir: ltr, spacing: 1em, ..subtitle-texts))
      #h(1fr)
      #text(weight: "bold", badge)
    ]
    #if body.pos().len() > 0 {
      body.pos().join()
    }
  ]
}

/// A named subitem listed within a resume item.
///
/// - name: string, name of the sub-item.
/// - body: content, additional content associated with the sub-item.
#let sub-item(name, body) = block[
  #text(weight: "bold", name)
  #h(1.2em)
  #body
]
