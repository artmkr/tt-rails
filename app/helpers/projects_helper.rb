module ProjectsHelper
  def new_request?(project)
    !(project.requests.exists?(user: current_user) || project.memberships.exists?(user: current_user))
  end
end
