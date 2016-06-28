class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_request, only: [:accept, :decline, :destroy]
  before_action :check_request, only: [:accept, :decline, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def create
    @project.requests.new(user: current_user, status: 'pending')

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Request was successfully sent.' }
      else
        format.html { redirect_to @project, notice: 'Something went wrong' }
      end
    end
  end

  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to @project, notice: 'Request was successfully destroyed.' }
    end
  end

  def accept
    @project.memberships.new(user: @request.user)
    respond_to do |format|
      if @project.save
        @request.update(status: 'accepted') 
        format.html { redirect_to @project, notice: 'User was successfully added' }
      else
        format.html { redirect_to @project, notice: 'Something went wrong' }
      end
    end
  end

  def decline
    @request.update(status: 'declined') 
    respond_to do |format|
      format.html { redirect_to @project, notice: 'User was successfully declined' }
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_request
      @request = Request.find(params[:id])
    end

    def check_request
      redirect_to @project, notice: "Request not pending" if @request.status != 'pending'
    end

    def authorize_user
      @requests = current_user.requests.find_by(id: params[:id])
      redirect_to projects_path, notice: "Not authorized to edit this project" if @project.nil?
    end
end
