#import "../lib.typ": item

#let _prog-lang-catalog = yaml("prog-langs.yml")

/// A resume item that represents an open source contribution.
///
/// - name: string, name of the open source project.
/// - lang: string or array of strings, programming languages used in the
///   project.
/// - role: string, role in the project.
/// - body: content, additional content associated with the project.
#let oss-contrib(
  name,
  lang,
  role,
  ..body,
) = {
  if type(lang) == str {
    lang = (lang,)
  }

  let badge = lang
    .map(i => (_prog-lang-catalog.at(i, default: none), i))
    .filter(i => i.first() != none)
    .map(i => [
      #box(baseline: 0.2em, circle(height: 1em, fill: rgb(i.first().color)))
      #i.last()
    ])
    .join()

  item(name, badge: badge, subtitle: role, ..body)
}
