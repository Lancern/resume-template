#let catalog = (
  en-us: (
    resume-title: "Resume of {}",
    resume-description: "Resume of {}",
    resume-keyword: "resume",
    tonow: "Now",
  ),
  zh-cn: (
    resume-title: "{}的简历",
    resume-description: "{}的个人简历",
    resume-keyword: "简历",
    tonow: "至今",
  ),
)

/// A context expression that evaluates to the vocabulary for the given
/// identifier.
///
/// - id: string, the vocabulary identifier.
#let vocab(id) = context {
  let locale = text.lang + "-" + lower(text.region)
  catalog.at(locale).at(id)
}
