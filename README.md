# resume

This repository contains a simple resume template written in [Typst].

<div style="display:flex;">
  <img src="figures/example_zh-ch.png" height="300px" style="margin-right:4px;" />
  <img src="figures/example_en-us.png" height="300px" />
</div>

## Usage and Build

You need to install [Typst] before you start. If you have a Rust installation, you could install Typst via `cargo`:

```bash
cargo install --locked typst-cli
```

The file `resume.typ` contains the template definition, which defines the resume's layout and provides some useful utility functions to help typeset your resume. You can import this file into your own Typst file to use the template:

```typst
#import "resume.typ": *

#show: resume.with(
  "Your name",
  "Your phone number",
  "Your email",
  webpage: "https://your.home.page",  // Optional
  github-id: "YourGithubId",          // Optional
  lang: "en",
)

= Education
// Your education experiences

= Professional Skills
// Your professional skills

= Work Experiences
// Your work experiences

// And more
```

This repository provides two examples that you can refer and modify:

- `main_en-us.typ`: A resume example written in locale `en-us`;
- `main_zh-cn.typ`: A resume example written in locale `zh-cn`.

To build the resume, execute:

```bash
typst compile main.typ
```

Where `main.typ` is the file name of your Typst source file.

## Contribution

Any kinds of contributions are welcomed, including bug reports, bug fixes, features requests, feature implementations, documentation improvements, etc.
Feel free to open a new issue or PR!
If you have any questions on the usage of this template, feel free to open a new issue.

## License

This repository is open-source under the [Creative Commons Zero v1.0 Universal (CC0-1.0)](./LICENSE) license.

[typst]: (https://typst.app/)
