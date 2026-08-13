#import "../lib.typ": item
#import "../vocab.typ": vocab

/// A resume item that represents a work experience.
///
/// - organization: content, name of the organization.
/// - position: content, name of the position.
/// - start-date: string, start date of the work experience.
/// - end-date: string or none, end date of the work experience. Default to
///   none, indicating that the work has not ended.
/// - group: content or none, name of the internal group within the
///   organization. Default to none.
/// - body: content, zero or more additional content arguments.
/// -> content, the laid-out work experience item.
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
  let subtitles = (position, group).filter(i => i != none)

  item(organization, badge: duration, subtitles: subtitles, ..body)
}
