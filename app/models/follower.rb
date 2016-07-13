class Follower
  def initialize(follow)
    @name = follow["login"]
    @url  = follow["html_url"]
  end
end
