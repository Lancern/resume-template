#import "../lib.typ": item
#import "../vocab.typ": vocab

/// A resume item that represents an educational experience.
///
/// - school: content, school name.
/// - degree: content, degree name.
/// - start-date: string, start date of the education experience.
/// - end-date: string or none, end date of the education experience. Default to
///   none, indicating that the experience has not ended.
/// - department: content or none, department name. Default to none.
/// - major: content or none, major name. Default to none.
/// - body: content, zero or more additional content arguments.
/// -> content, the laid-out education item.
#let edu(
  school,
  degree,
  start-date,
  end-date: none,
  department: none,
  major: none,
  ..body,
) = {
  if end-date == none {
    end-date = vocab("tonow")
  }

  let duration = [ #start-date - #end-date ]
  let subtitles = (degree, major, department).filter(i => i != none)

  item(
    school,
    badge: duration,
    subtitles: subtitles,
    ..body,
  )
}
