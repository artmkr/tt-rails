module ProjectsHelper
  def new_request?(project)
    !(project.requests.exists?(user: current_user,status: 'pending') || project.memberships.exists?(user: current_user))
  end

  def bumpable?(project)
    ((DateTime.now.to_i - project.bumped_at.to_i ) / 1.hours) >= 24 
  end

  def links_blank?(project)
    project.trello.blank? && project.slack.blank?
  end

end
