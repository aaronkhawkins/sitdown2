class Achievement < ActiveRecord::Base
  belongs_to :profile
  
  def self.historical()
    find(:all, :order => 'created_at DESC')
  end
  
  def after_create
    feed_item = FeedItem.create(:item => self)
    ([profile] + profile.friends + profile.followers).each{ |p| p.feed_items << feed_item }
  end
  
  
  def to_param
    "#{self.id}-#{description.to_safe_uri}"
  end
  
end
