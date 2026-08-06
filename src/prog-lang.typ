#let _prog-lang-catalog = yaml("prog-langs.yml")

/// A sequence of badges showing a sequence of programming languages together
/// with their GitHub theme color.
///
/// - names: string or array of strings, name(s) of the programming language(s).
#let prog-lang-badges(names) = {
  if type(names) == str {
    names = (names,)
  }

  names
    .map(i => (_prog-lang-catalog.at(i, default: none), i))
    .filter(i => i.first() != none)
    .map(i => [
      #box(
        baseline: 0.15em,
        rect(fill: rgb(i.first().color), width: 0.35em, height: 1em),
      )
      #i.last()
    ])
    .join()
}
