/// Create a link to the specified GitHub repository.
///
/// - user: string, the user ID of the repository's owner.
/// - name: string, the name of the repository.
/// -> content, a link whose visible text is `user/name`.
#let github-repo(user, name) = {
  let repr = user + "/" + name
  let url = "https://github.com/" + repr + "/"
  link(url, repr)
}
