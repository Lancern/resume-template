# API Reference

`resume.typ` is the package entrypoint and exports every public definition. Import only the definitions a document uses:

```typst
#import "resume.typ": career, edu, resume
```

The examples below assume that the document is stored beside `resume.typ`. Strings are accepted wherever Typst can convert them to content. Parameters shown as `..body` accept zero or more positional content values; a trailing content block is the usual way to supply one.

## `resume`

Applies the document metadata, page layout, typography, contact header, and resume styles. It is intended for use through `#show: resume.with(...)` so the show rule supplies `body`.

```typst
resume(
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
)
```

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `name` | string | required | Name shown as the title and written to PDF metadata. |
| `phone` | string | required | Displayed phone number. Its link target is normalized to digits and an optional `+`. |
| `email` | string | required | Displayed address and `mailto:` link target. |
| `webpage` | string or `none` | `none` | Optional displayed URL and link target. |
| `github-id` | string or `none` | `none` | Optional GitHub user ID, linked to `https://github.com/<id>`. |
| `locale` | string | `"en-us"` | Locale for metadata, text language, and built-in labels. Supported values: `"en-us"` and `"zh-cn"`. |
| `paper` | string | `"a4"` | Paper identifier passed to `page(paper:)`. |
| `page-margin` | relative length or dictionary | `1.4cm` | Value passed to `page(margin:)`. |
| `text-size` | length | `11pt` | Base body text size; title and heading sizes scale from it. |
| `fonts` | dictionary | `(:)` | Overrides for the `title`, `heading`, `body`, and `raw` font roles. Missing roles use `font-set("adobe-source")`. |
| `display-date` | boolean | `false` | Adds `document.date` to the left side of the footer when enabled. An `auto` date displays the compilation date. |
| `body` | content | supplied by show rule | Main resume content. |

Every footer shows the current and total page count. The template also writes a localized title, description, and keyword plus the user's name to document metadata. It returns the styled contact header followed by `body`.

```typst
#import "resume.typ": resume

#set document(date: datetime(year: 2026, month: 8, day: 13))

#show: resume.with(
  "Taylor Hacker",
  "+1 555 010 1234",
  "taylor@example.com",
  webpage: "https://example.com",
  github-id: "taylor",
  locale: "en-us",
  display-date: true,
)

= Experience
Resume content goes here.
```

## `item`

Creates a general-purpose resume entry. The title is emitted as a level-two heading, the subtitles appear beside it, and the badge is right-aligned.

```typst
item(
  title,
  badge: none,
  subtitles: (),
  ..body,
)
```

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `title` | content | required | Entry title. |
| `badge` | content or `none` | `none` | Right-aligned label, commonly a date range. |
| `subtitles` | array of content | `()` | Zero or more emphasized subtitles. |
| `body` | content arguments | empty | Additional content below the entry heading. |

Returns the laid-out entry as content.

```typst
#import "resume.typ": item

#item(
  "Program Analysis",
  badge: "2023 - 2025",
  subtitles: ("Security", "Static analysis"),
)[
  Designed an analysis for finding unsafe data flows.
]
```

## `sub-item`

Creates a named block within another entry.

```typst
sub-item(name, body)
```

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `name` | content | required | Bold label at the start of the block. |
| `body` | content | required | Content shown after the label. |

Returns a block containing the label and body.

```typst
#import "resume.typ": sub-item

#sub-item("Build performance")[
  Reduced clean build time by 35%.
]
```

## `edu`

Creates an education entry using `item`.

```typst
edu(
  school,
  degree,
  start-date,
  end-date: none,
  department: none,
  major: none,
  ..body,
)
```

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `school` | content | required | School name and entry title. |
| `degree` | content | required | Degree shown as the first subtitle. |
| `start-date` | string | required | Start of the displayed date range. |
| `end-date` | string or `none` | `none` | End of the range; `none` uses the locale's “Now” label. |
| `department` | content or `none` | `none` | Optional subtitle after the major. |
| `major` | content or `none` | `none` | Optional subtitle after the degree. |
| `body` | content arguments | empty | Additional details. |

Returns an `item` whose badge is the date range and whose subtitles are ordered as degree, major, then department.

```typst
#import "resume.typ": edu

#edu(
  "Example University",
  "BSc",
  "2018.09",
  end-date: "2022.06",
  major: "Computer Science",
)
```

## `career`

Creates a work-experience entry using `item`.

```typst
career(
  organization,
  position,
  start-date,
  end-date: none,
  group: none,
  ..body,
)
```

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `organization` | content | required | Organization name and entry title. |
| `position` | content | required | Position shown as the first subtitle. |
| `start-date` | string | required | Start of the displayed date range. |
| `end-date` | string or `none` | `none` | End of the range; `none` uses the locale's “Now” label. |
| `group` | content or `none` | `none` | Optional second subtitle for a team or internal group. |
| `body` | content arguments | empty | Additional details. |

Returns an `item` whose badge is the date range.

```typst
#import "resume.typ": career

#career(
  "Example Corp.",
  "Software Engineer",
  "2022.07",
  group: "Developer Infrastructure",
)[
  Built reliable engineering tools.
]
```

## `award`

Creates an award entry using `item`.

```typst
award(name, date, award, ..body)
```

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `name` | content | required | Competition, activity, or other source of the award. |
| `date` | content | required | Right-aligned date badge. |
| `award` | content | required | Award name shown as the subtitle. |
| `body` | content arguments | empty | Additional details. |

Returns an `item` for the award.

```typst
#import "resume.typ": award

#award("Regional Programming Contest", "2021.11", "Gold Medal")
```

## `oss-contrib`

Creates an open-source contribution entry using `item` and `prog-lang-badges`.

```typst
oss-contrib(name, lang, role, ..body)
```

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `name` | content | required | Project name or linked project content. |
| `lang` | string or array of strings | required | Programming-language names passed to `prog-lang-badges`. |
| `role` | content | required | Role shown as the subtitle. |
| `body` | content arguments | empty | Additional contribution details. |

Returns an `item` whose badge contains the recognized language names and their GitHub theme colors.

```typst
#import "resume.typ": github-repo, oss-contrib

#oss-contrib(
  github-repo("typst", "typst"),
  ("Rust", "TypeScript"),
  "Contributor",
)[
  Improved diagnostics and documentation.
]
```

## `font-set`

Looks up a built-in font-role dictionary.

```typst
font-set(name)
```

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `name` | string | required | Built-in set name: `"adobe-source"` or `"noto"`. |

The returned dictionary contains `title`, `heading`, `body`, and `raw`. An unknown name raises a dictionary lookup error.

| Set | `title` and `body` | `heading` | `raw` |
| --- | --- | --- | --- |
| `adobe-source` | Source Serif 4, Source Han Serif | Source Sans 3, Source Han Sans | Source Code Pro |
| `noto` | Noto Serif, Noto Serif CJK SC, Noto Serif SC | Noto Sans, Noto Sans CJK SC, Noto Sans SC | Noto Sans Mono |

The Latin fonts in each fallback list use Typst's `covers: "latin-in-cjk"` font coverage option.

```typst
#import "resume.typ": font-set, resume

#show: resume.with(
  "Taylor Hacker",
  "+1 555 010 1234",
  "taylor@example.com",
  fonts: font-set("noto"),
)
```

## `github-repo`

Creates a link whose visible text is `user/name` and whose target is the corresponding GitHub repository URL.

```typst
github-repo(user, name)
```

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `user` | string | required | Repository owner ID. |
| `name` | string | required | Repository name. |

Returns linked content targeting `https://github.com/<user>/<name>/`.

```typst
#import "resume.typ": github-repo

Project: #github-repo("typst", "typst")
```

## `prog-lang-badges`

Renders programming-language names with their GitHub theme colors.

```typst
prog-lang-badges(names)
```

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `names` | string or array of strings | required | Case-sensitive language name or ordered language-name array. |

Returns joined content for languages found in the bundled catalog. Unknown names are silently omitted; recognized names preserve their input order.

```typst
#import "resume.typ": prog-lang-badges

Primary languages: #prog-lang-badges(("C++", "Python", "Rust"))
```
