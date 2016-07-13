class UserService

  def initialize(current_user)
    @current_user = current_user
    @connection = Faraday.new("https://api.github.com")
    @connection.headers["Authorization"] = "token #{current_user.token}"
  end

  def stars
    response = @connection.get("/user/starred")
    parse(response)
  end

  def following
    response = @connection.get("/user/following")
    parse(response)
  end

  def followers
    response = @connection.get("/user/followers")
    parse(response)
  end

  def organizations
    response = @connection.get("/users/#{@current_user.nickname}/orgs")
    parse(response)
  end

  def repos
    response = @connection.get("/user/repos")
    parse(response)
  end

  def repo_commits(repo)
    response = @connection.get("/repos/#{repo["full_name"].split("/").first}/#{repo["name"]}/commits")
    parse(response)
  end

  def parse(response)
    JSON.parse(response.body)
  end

end
