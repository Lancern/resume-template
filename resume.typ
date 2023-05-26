// This function defines the resume template.
#let resume(
  name,     // string. Your name.
  phone,    // string. Your phone number.
  email,    // string. Your email address.
  webpage: none,    // string, optional. URL to your home page.
  github-id: none,  // string, optional. Your GitHub ID.
  twitter-id: none, // string, optional. Your Twitter ID.
  photo: none,      // content, optional. Your personal photograph.
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
  set text(font: "Linux Libertine", size: 11pt)

  // Section heading styles.
  show heading: it => block[
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
    block(text(weight: 700, 2em, name))  // Name
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
  let subtitle = degree
  if major != none {
    subtitle = subtitle + ", " + major
  }
  if department != none {
    subtitle = subtitle + ", " + department
  }

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
  let subtitle = position
  if group != none {
    subtitle = subtitle + ", " + group
  }

  resume-item(organization, badge: duration, subtitle: subtitle, body: body)
}

// This list is fetched from https://github.com/ozh/github-colors/blob/master/colors.json.
#let github-pl-colors = (
  actionscript: rgb(136, 43, 15),
  ada: rgb(2, 248, 140),
  agda: rgb(49, 86, 101),
  antlr: rgb(157, 195, 255),
  applescript: rgb(16, 31, 31),
  assembly: rgb(110, 76, 19),
  asm: rgb(110, 76, 19),
  basic: rgb(255, 0, 0),
  brainfuck: rgb(47, 37, 48),
  c: rgb(85, 85, 85),
  clojure: rgb(219, 88, 85),
  cmake: rgb(218,52, 52),
  coffeescript: rgb(36, 71, 118),
  commonlisp: rgb(63, 182, 139),
  coq: rgb(208, 182, 140),
  css: rgb(86, 61, 124),
  cuda: rgb(58, 78, 58),
  "c++": rgb(243, 75, 125),
  "c#": rgb(23, 134, 0),
  d: rgb(186, 89, 94),
  dart: rgb(0, 180, 171),
  dockerfile: rgb(56, 77, 84),
  elixir: rgb(110, 74, 126),
  elm: rgb(96, 181, 204),
  emacslisp: rgb(192, 101, 219),
  erlang: rgb(184, 57, 152),
  fortran: rgb(77, 65, 177),
  fish: rgb(74, 174, 71),
  "f#": rgb(184, 69, 252),
  go: rgb(55, 94, 171),
  golang: rgb(55, 94, 171),
  haskell: rgb(41, 181, 68),
  html: rgb(228, 75, 35),
  idris: rgb(179, 0, 0),
  java: rgb(176, 114, 25),
  javascript: rgb(241, 224, 90),
  julia: rgb(162, 112, 186),
  kotlin: rgb(241, 142, 51),
  lex: rgb(219, 202, 0),
  llvm: rgb(24, 86, 25),
  lua: rgb(0, 0, 128),
  markdown: rgb(8, 63, 161),
  mathematica: rgb(221, 17, 0),
  matlab: rgb(187, 146, 172),
  mlir: rgb(94, 200, 219),
  nim: rgb(255, 194, 0),
  objectivec: rgb(67, 142, 255),
  ocaml: rgb(59, 225, 51),
  pascal: rgb(227, 241, 113),
  perl: rgb(2, 152, 195),
  php: rgb(79, 93, 149),
  postscript: rgb(218, 41, 28),
  powershell: rgb(1, 36, 86),
  prolog: rgb(116, 40, 60),
  python: rgb(53, 114, 165),
  r: rgb(25, 140, 231),
  racket: rgb(34, 34, 143),
  rescript: rgb(237, 80, 81),
  ruby: rgb(112, 21, 22),
  rust: rgb(222, 165, 132),
  scala: rgb(220, 50, 47),
  scheme: rgb(30, 74, 236),
  shell: rgb(137, 224, 81),
  smalltalk: rgb(89, 103, 6),
  solidity: rgb(170, 103, 70),
  sql: rgb(227, 140, 0),
  svelte: rgb(255, 62, 0),
  swift: rgb(255, 172, 69),
  systemverilog: rgb(218, 225, 194),
  tcl: rgb(228, 204, 152),
  tex: rgb(61, 97, 23),
  typescript: rgb(43, 116, 137),
  unrealscript: rgb(165, 76, 77),
  v: rgb(79, 135, 196),
  vba: rgb(134, 125, 177),
  vbscript: rgb(21, 220, 220),
  verilog: rgb(178, 183, 248),
  visualbasic: rgb(148, 93, 183),
  vue: rgb(65, 184, 131),
  webassembly: rgb(4, 19, 59),
  yacc: rgb(75, 108, 75),
  zig: rgb(236, 145, 92),
)

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
