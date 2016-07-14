class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :confirmed?
  before_action :set_project
  before_action :set_request, only: [:accept, :decline, :destroy]

  before_action :check_request_status, only: [:accept, :decline, :destroy]
  before_action :new_request?, only: [:create]

  before_action :authorize_user, only: [:destroy]
  before_action :authorize_author, only: [:accept, :decline]

  def create
    @project.requests.new(user: current_user, status: 'pending', role:request_params[:role])

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
    @project.memberships.new(user: @request.user,role: @request.role)
    respond_to do |format|
      if @project.save
        @request.update(status: 'accepted') 
        format.html { redirect_to edit_project_path(@project), notice: 'User was successfully added' }
      else
        format.html { redirect_to edit_project_path(@project), notice: 'Something went wrong' }
      end
    end
  end

  def decline
    @request.update(status: 'declined') 
    respond_to do |format|
      format.html { redirect_to edit_project_path(@project), notice: 'User was successfully declined' }
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_request
      @request = Request.find(params[:id])
    end

    def check_request_status
      redirect_to @project, notice: "Request not pending" if @request.status != 'pending'
    end

    def new_request?
      if (@project.requests.exists?(user: current_user, status: 'pending') || @project.memberships.exists?(user: current_user))
        redirect_to @project, notice: "Request was already sent"
      end
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:role)
    end

    def confirmed?
      redirect_to root_path, notice: "Confirm your email" unless current_user.confirmed?
    end
end
