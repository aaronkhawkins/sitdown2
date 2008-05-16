class AchievementsController < ApplicationController
  skip_filter :login_required, :only => [:index, :show]
  before_filter :setup
  def new
    @achievement = Achievement.new
    
  end

  def create
    # active_statuses = @profile.achievements.find_active
    @achievement = @profile.achievements.new(params[:achievement])
    # @achievement.active = true
    if @achievement.save!
        
      render :update do |page| 
        page.replace_html "recent_activity", :partial => "profiles/recent_activity", :locals => { :feed_items => @profile.feed_items }
        page['new_achievement'].reset
      end
   
    end
  end

private

def setup
  @profile = Profile[params[:profile_id]]
  @user = @profile.user
end

def allow_to
  super :owner, :all => true
  super :all, :only => [:index, :show]
end

end
