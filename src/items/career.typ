#import "../lib.typ": item
#import "../vocab.typ": vocab

/// A resume item that represents a work experience.
///
/// - organization: string, name of the organization.
/// - position: string, name of the position.
/// - start-date: string, start date of the work experience.
/// - end-date: string or none, end date of the work experience. Default to
///   none, indicating that the work has not ended.
/// - group: string or none, name of the internal group within the organization.
///   Default to none.
/// - body: content, additional content associated with the work experience.
#let career(
  organization,
  position,
  start-date,
  end-date: none,
  group: none,
  ..body,
) = {
  if end-date == none {
    end-date = vocab("tonow")
  }

  let duration = start-date + " - " + end-date
  let subtitle = (position, group).filter(i => i != none).join(", ")

  item(organization, badge: duration, subtitle: subtitle, ..body)
}