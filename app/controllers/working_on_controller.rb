class WorkingOnController < ApplicationController
  def index
    @stories = PivotalTracker::Project.find(68332).stories.all(:story_type => ['chore'], :label => '@working_on') 
  end
end
