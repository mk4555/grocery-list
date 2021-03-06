class User < ActiveRecord::Base
  has_secure_password
  has_many :grocery_lists
  has_many :items

  def slug
    self.username.downcase.gsub(" ",'-')
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end
