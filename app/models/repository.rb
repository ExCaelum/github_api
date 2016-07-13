class Repository
  attr_reader :name, :owner, :url, :description

  def initialize(repository)
    @name        = repository["name"]
    @owner       = repository["owner"]["login"]
    @url         = repository["url"].sub("api.", "")
    @description = repository["description"]
  end

end
