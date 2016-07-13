class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid                = auth_info.uid
      new_user.name               = auth_info.extra.raw_info.name
      new_user.nickname           = auth_info.extra.raw_info.login
      new_user.token              = auth_info.credentials.token
      new_user.avatar_url         = auth_info.extra.raw_info.avatar_url
      new_user.followers          = auth_info.extra.raw_info.followers
      new_user.following          = auth_info.extra.raw_info.following
    end
  end

  def stars
    stars = UserService.new(self).stars
  end
end
