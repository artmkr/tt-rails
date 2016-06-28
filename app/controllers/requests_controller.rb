class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_request, only: [:accept, :decline, :destroy]
  before_action :check_request, only: [:accept, :decline, :destroy]
  before_action :authorize_user, only: [:destroy]
  before_action :authorize_author, only: [:accept, :decline]
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
      unless current_user == @request.user 
        redirect_to @project, notice: "Not authorized to Delete request"
      end 
    end

    def authorize_author
      unless current_user == @project.user 
        redirect_to @project, notice: "Not authorized to accept or decline"
      end 
    end
end
