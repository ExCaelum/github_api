class Organization
  attr_reader :name, :url

  def initialize(org)
    @name = org["login"]
    @url = org["url"].sub("api.", "")
  end

end
