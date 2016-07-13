class Commit
  attr_reader :author, :message, :repo, :created_at

  def initialize(commit)
    @author     = commit["commit"]["author"]["name"]
    @message    = commit["commit"]["message"]
    @repo       = commit["commit"]["url"].split("/")[5]
    @created_at = commit["commit"]["author"]["date"]
  end

end
