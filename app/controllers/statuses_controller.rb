class StatusesController < ApplicationController
  skip_filter :login_required, :only => [:index, :show]
  before_filter :setup
  def new
    @status = Status.new
    
  end

  def create
    # active_statuses = @profile.statuses.find_active
    @status = @profile.statuses.new(params[:status])
    # @status.active = true
    if @status.save!
      # active_statuses.each do |status|
      #       status.active = false
      #       status.active_until = @status.created_at
      #       status.save!
      #     end
      
      render :update do |page| 
        page.replace_html "recent_activity", :partial => "profiles/recent_activity", :locals => { :feed_items => @profile.feed_items }
        page['new_status'].reset
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
