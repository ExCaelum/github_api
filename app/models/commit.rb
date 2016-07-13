class Commit

  def initialize(repo, commit)
    @repo = repo
    @message = commit["message"]
  end

end
