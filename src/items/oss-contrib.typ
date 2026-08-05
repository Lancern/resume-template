#import "../lib.typ": item
#import "../prog-lang.typ": prog-lang-badges

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
  item(name, badge: prog-lang-badges(lang), subtitles: (role,), ..body)
}
