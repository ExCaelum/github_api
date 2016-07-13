class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid                = auth_info.uid
      new_user.name               = auth_info.extra.raw_info.name
      new_user.nickname           = auth_info.extra.raw_info.login
      new_user.token              = auth_info.credentials.token
      new_user.avatar_url         = auth_info.extra.raw_info.avatar_url
    end
  end

  def stars
    stars = UserService.new(self).stars
  end

  def following
    following = UserService.new(self).following
    formatted_following = following.map do |follow|
      Following.new(follow)
    end
  end

  def followers
    followers = UserService.new(self).followers
    formatted_followers = followers.map do |follow|
      Follower.new(follow)
    end
  end

  def repos
    repos = UserService.new(self).repos
    formatted_repos = repos.map do |repo|
      Repository.new(repo)
    end
    formatted_repos
  end

  def organizations
    organizations = UserService.new(self).organizations
    formatted_orgs = organizations.map do |organization|
      Organization.new(organization)
    end
    formatted_orgs
  end

  def commits
    formatted_commits = []
    repos = UserService.new(self).repos
    repos_commits = repos.map do |repo|
      UserService.new(self).repo_commits(repo)
    end
    repos_commits.map do |commits|
      commits.find_all do |commit|
        commit["author"]["id"] == self.uid.to_i
      end.each do |commit|
        formatted_commits << Commit.new(commit)
      end
    end
    sorted_commits = formatted_commits.sort_by do |commit|
      commit.created_at
    end.reverse
    sorted_commits[0...10]
  end
end
