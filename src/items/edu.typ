#import "../lib.typ": item
#import "../vocab.typ": vocab

/// A resume item that represents an educational experience.
///
/// - school: string, school name.
/// - degree: string, degree name.
/// - start-date: string, start date of the education experience.
/// - end-date: string or none, end date of the education experience. Default to
///   none, indicating that the experience has not ended.
/// - department: string or none, department name. Default to none.
/// - major: string or none, major name. Default to none.
/// - supervisor: string or none, supervisor's name. Default to none.
/// - body: content, additional content included in this item.
#let edu(
  school,
  degree,
  start-date,
  end-date: none,
  department: none,
  major: none,
  supervisor: none,
  ..body,
) = {
  if end-date == none {
    end-date = vocab("tonow")
  }

  let duration = [ #start-date - #end-date ]
  let subtitle = (degree, major, department).filter(i => i != none).join(", ")

  if supervisor != none {
    let supervisor-line = block[
      #set text(fill: rgb(140, 140, 140))
      #context vocab("supervisor"): #supervisor
    ]
    if body.pos().len() == 0 {
      body = (supervisor-line,)
    } else {
      body = (
        stack(
          supervisor-line,
          body,
        ),
      )
    }
  }

  item(
    school,
    badge: duration,
    subtitle: subtitle,
    ..body,
  )
}