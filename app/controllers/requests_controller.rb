class RequestsController < ApplicationController
  before_action :set_project
  before_action :set_request, only: [:accept, :decline, :destroy]
  before_action :authenticate_user!

  def create
    @project.requests.new(user: current_user)
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
        @request.destroy
        format.html { redirect_to @project, notice: 'User was successfully added' }
      else
        format.html { redirect_to @project, notice: 'Something went wrong' }
      end
    end
  end

  def decline 
    @request.destroy
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
end
