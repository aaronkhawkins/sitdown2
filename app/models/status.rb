class Status < ActiveRecord::Base
  belongs_to :profile
  
  # def self.find_active(options = {})
  #    with_scope :find => options do
  #      find_all_by_active(true, :order => 'created_at DESC')      
  #    end 
  #  end
  # 
  #  def self.find_inactive(options = {})
  #    with_scope :find => options do
  #      find_all_by_active(false, :order => 'created_at DESC')      
  #    end 
  #  end
  
  def after_create
    feed_item = FeedItem.create(:item => self)
    ([profile] + profile.friends + profile.followers).each{ |p| p.feed_items << feed_item }
  end
  
  
  def to_param
    "#{self.id}-#{description.to_safe_uri}"
  end
  
end
