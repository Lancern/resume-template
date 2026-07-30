#import "../lib.typ": item

/// A resume item that represents an award received.
///
/// - name: string, name of the competition, activity, or other source of the
///   award.
/// - date: string, date when the award was received.
/// - award: string, name of the award.
/// - body: content, additional content associated with the award.
#let award(
  name,
  date,
  award,
  ..body,
) = {
  item(name, badge: date, subtitle: award, ..body)
}
