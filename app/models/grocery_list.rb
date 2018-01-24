class GroceryList < ActiveRecord::Base
  belongs_to :user

  def slug
    self.name.downcase.gsub(' ','-')
  end

  def self.find_by_slug(slug)
    GroceryBag.all.find{|bag| bag.slug == slug}
  end
end
