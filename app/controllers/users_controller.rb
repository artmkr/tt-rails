class UsersController < ApplicationController
  before_action :set_user

  def show
  end

  def requests
    @pending_requests = @user.requests.select { |req| req[:status] == 'pending'  }
    @old_requests = @user.requests.select { |req| req[:status] != 'pending'  }
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
