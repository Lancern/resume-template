#import "../lib.typ": item
#import "../prog-lang.typ": prog-lang-badges

/// A resume item that represents an open source contribution.
///
/// - name: content, name of the open source project.
/// - lang: string or array of strings, programming languages used in the
///   project.
/// - role: content, role in the project.
/// - body: content, zero or more additional content arguments.
/// -> content, the laid-out open source contribution item.
#let oss-contrib(
  name,
  lang,
  role,
  ..body,
) = {
  item(name, badge: prog-lang-badges(lang), subtitles: (role,), ..body)
}
