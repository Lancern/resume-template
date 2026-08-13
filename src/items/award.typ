#import "../lib.typ": item

/// A resume item that represents an award received.
///
/// - name: content, name of the competition, activity, or other source of the
///   award.
/// - date: content, date when the award was received.
/// - award: content, name of the award.
/// - body: content, zero or more additional content arguments.
/// -> content, the laid-out award item.
#let award(
  name,
  date,
  award,
  ..body,
) = {
  item(name, badge: date, subtitles: (award,), ..body)
}
