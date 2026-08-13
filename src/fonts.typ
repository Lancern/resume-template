#let font-sets-catalog = (
  noto: (
    title: (
      (name: "Noto Serif", covers: "latin-in-cjk"),
      (name: "Noto Serif CJK SC"),
      (name: "Noto Serif SC"),
    ),
    heading: (
      (name: "Noto Sans", covers: "latin-in-cjk"),
      (name: "Noto Sans CJK SC"),
      (name: "Noto Sans SC"),
    ),
    body: (
      (name: "Noto Serif", covers: "latin-in-cjk"),
      (name: "Noto Serif CJK SC"),
      (name: "Noto Serif SC"),
    ),
    raw: "Noto Sans Mono",
  ),
  adobe-source: (
    title: (
      (name: "Source Serif 4", covers: "latin-in-cjk"),
      (name: "Source Han Serif")
    ),
    heading: (
      (name: "Source Sans 3", covers: "latin-in-cjk"),
      (name: "Source Han Sans")
    ),
    body: (
      (name: "Source Serif 4", covers: "latin-in-cjk"),
      (name: "Source Han Serif")
    ),
    raw: "Source Code Pro",
  )
)

/// Get the built-in font set with the specified name.
///
/// This function would result in an error if the specified builtin font set
/// does not exist.
///
/// - name string, name of the built-in font set.
/// -> a dictionary that contains the keys "title", "heading", and "body" which
///    represents the font set.
#let font-set(name) = font-sets-catalog.at(name)
