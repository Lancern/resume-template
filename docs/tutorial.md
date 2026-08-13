# Tutorial

This tutorial builds a resume with the public helpers provided by the template. It assumes that you already know basic Typst markup and how to run the Typst CLI.

## Get the template

Template template is tested with Typst 0.15.1. Download the source archive from the [v0.3.0 release](https://github.com/Lancern/resume-template/releases/tag/v0.3.0) and extract it, or clone the tag:

```bash
git clone --branch v0.3.0 --depth 1 https://github.com/Lancern/resume-template.git
cd resume-template
```

The release directory is a complete project, not a single-file template. Keep this layout intact:

```text
resume-template/
├── resume.typ
├── resources/
├── src/
├── example_en-us.typ
└── example_zh-cn.typ
```

The quickest starting point is to copy the example for your locale and edit the copy in place:

```bash
cp example_en-us.typ my-resume.typ
typst watch my-resume.typ
```

Typst downloads the `oxifmt` dependency the first time it compiles the template unless that package is already cached.

## Configure the document

Import `resume` and apply it with a show rule. The first three arguments are your name, phone number, and email address. The phone number, email address, website, and GitHub ID are rendered as links in the PDF.

```typst
#import "resume.typ": resume

#show: resume.with(
  "Taylor Hacker",
  "+1 555 010 1234",
  "taylor@example.com",
  webpage: "https://example.com",
  github-id: "taylor",
  locale: "en-us",
)
```

Only `"en-us"` and `"zh-cn"` are supported. A locale controls document metadata, language-aware text behavior, and built-in labels such as "Now". Use the exact lowercase language-region spelling.

## Compose the resume

Level-one Typst headings become resume section headings. Ordinary Typst paragraphs, lists, links, and other content can be used inside each section.

```typst
= Professional Skills

- *Languages:* C++, Python, Rust
- *Tools:* Git, Linux, Typst
```

Use the semantic entry helpers for common sections.

### Education

`edu` lays out a school, degree, date range, and optional academic details. If `end-date` is omitted, it displays the locale's word for the present.

```typst
#import "resume.typ": edu

#edu(
  "Example University",
  "BSc",
  "2018.09",
  end-date: "2022.06",
  department: "School of Computing",
  major: "Computer Science",
)[
  Graduated with honors.
]
```

### Careers

`career` lays out an organization, position, date range, and optional group. Use `sub-item` to give a longer entry named subsections.

```typst
#import "resume.typ": career, sub-item

#career(
  "Example Corp.",
  "Software Engineer",
  "2022.07",
  group: "Developer Infrastructure",
)[
  Built tools used across the engineering organization.

  #sub-item("Build performance")[
    Reduced clean build time by 35% through caching and dependency analysis.
  ]
]
```

### Awards, open-source work, and custom entries

`award` displays the award as a subtitle and its date as the right-aligned badge. `oss-contrib` displays a role plus programming-language badges. Use `github-repo` when a linked `owner/repository` name is useful.

```typst
#import "resume.typ": award, github-repo, oss-contrib

#award("Regional Programming Contest", "2021.11", "Gold Medal")

#oss-contrib(
  github-repo("typst", "typst"),
  ("Rust", "TypeScript"),
  "Contributor",
)[
  Improved diagnostics and documentation.
]
```

Use `item` when none of the semantic helpers match. Its `subtitles` argument is always an array; a one-element array needs a trailing comma.

```typst
#import "resume.typ": item

#item(
  "Program Analysis Research",
  badge: "2023 - 2025",
  subtitles: ("Security", "Static analysis"),
)[
  Designed an analysis for finding unsafe data flows.
]
```

`prog-lang-badges` can also be used independently. Language names are matched against the bundled GitHub language catalog; unknown names are silently omitted.

```typst
#import "resume.typ": prog-lang-badges

Primary languages: #prog-lang-badges(("C++", "Python", "Rust"))
```

## Customize the layout

Pass layout settings to `resume.with`. The defaults are A4 paper, `1.4cm` margins, and `11pt` body text.

```typst
#show: resume.with(
  "Taylor Hacker",
  "+1 555 010 1234",
  "taylor@example.com",
  paper: "us-letter",
  page-margin: (x: 1.5cm, y: 1.2cm),
  text-size: 10.5pt,
)
```

Every page footer includes the current page and total page count. Set `display-date: true` to add the document date on the left. When the document date is `auto`, the compilation date is used. Set it explicitly before the template show rule for reproducible output:

```typst
#set document(date: datetime(year: 2026, month: 8, day: 13))

#show: resume.with(
  "Taylor Hacker",
  "+1 555 010 1234",
  "taylor@example.com",
  display-date: true,
)
```

## Fonts

The default `adobe-source` font set uses these font families:

| Role | Families |
| --- | --- |
| Title and body | Source Serif 4, Source Han Serif |
| Headings | Source Sans 3, Source Han Sans |
| Raw text, including contact details | Source Code Pro |

Check available families with `typst fonts`. If the Adobe Source families are not available, install them or use the built-in `noto` set:

```typst
#import "resume.typ": font-set, resume

#show: resume.with(
  "Taylor Hacker",
  "+1 555 010 1234",
  "taylor@example.com",
  fonts: font-set("noto"),
)
```

You can instead pass a dictionary containing any of the `title`, `heading`, `body`, and `raw` roles. Omitted roles keep their `adobe-source` defaults. Values accept the same font family forms as Typst's `text(font:)` parameter.

```typst
fonts: (
  title: "Noto Serif",
  heading: "Noto Sans",
  body: "Noto Serif",
  raw: "Noto Sans Mono",
),
```

## Complete example

The following source exercises the complete public workflow. Save it as `my-resume.typ` beside `resume.typ` and compile it with `typst compile my-resume.typ`.

```typst
#import "resume.typ": award, career, edu, font-set, github-repo, item, oss-contrib, prog-lang-badges, resume, sub-item

#set document(date: datetime(year: 2026, month: 8, day: 13))

#show: resume.with(
  "Taylor Hacker",
  "+1 555 010 1234",
  "taylor@example.com",
  webpage: "https://example.com",
  github-id: "taylor",
  locale: "en-us",
  paper: "a4",
  page-margin: 1.4cm,
  text-size: 11pt,
  fonts: font-set("noto"),
  display-date: true,
)

= Education
#edu(
  "Example University",
  "BSc",
  "2018.09",
  end-date: "2022.06",
  major: "Computer Science",
)

= Experience
#career(
  "Example Corp.",
  "Software Engineer",
  "2022.07",
  group: "Developer Infrastructure",
)[
  Built reliable tools used across the engineering organization.

  #sub-item("Build performance")[
    Reduced clean build time by 35% through caching and dependency analysis.
  ]
]

= Research
#item(
  "Program Analysis",
  badge: "2023 - 2025",
  subtitles: ("Security", "Static analysis"),
)[
  Designed an analysis for finding unsafe data flows.
]

= Open Source
#oss-contrib(
  github-repo("typst", "typst"),
  ("Rust", "TypeScript"),
  "Contributor",
)[
  Improved diagnostics and documentation.
]

= Awards
#award("Regional Programming Contest", "2021.11", "Gold Medal")

= Skills
Primary languages: #prog-lang-badges(("C++", "Python", "Rust"))
```

## Troubleshooting

### Typst reports missing fonts

Run `typst fonts` and compare the output with the families listed under [Fonts](#fonts). Install the missing fonts, select `font-set("noto")`, or pass a font dictionary using families available on your machine.

### A locale lookup fails

Use exactly `locale: "en-us"` or `locale: "zh-cn"`. Other locales and shortened forms such as `"en"` are not defined.

### A programming-language badge is empty

Names are case-sensitive and must match the bundled GitHub language catalog. Unknown names are intentionally omitted. Check the spelling or use ordinary Typst content for technologies that are not programming languages.

### Typst cannot find source files or icons

Do not copy `resume.typ` by itself. It imports modules from `src/` and loads icons from `resources/`. Restore the release directory layout and keep your resume source inside that project, adjusting only the path in its `#import` if you place it in a subdirectory.

### The first build cannot download `oxifmt`

The template imports `@preview/oxifmt:1.0.0`. Allow Typst network access for the first build, then reuse its package cache for offline builds.

For exact signatures and defaults, continue to the [API reference](api-reference.md).
