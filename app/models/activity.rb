class Activity
  attr_reader :name

  def initialize(activity, current_user)
    @name = activity["repo"]["name"]
    @all_commits = activity["payload"]["commits"]
    @current_user = current_user
  end

  def commits
    user_commits = find_valid_commits
    commits = user_commits.map do |commit|
      Commit.new(@name, commit)
    end
    commits
  end

  def find_valid_commits
    @all_commits.find_all {|commit| commit["author"]["name"] == @current_user.name}
  end

end
