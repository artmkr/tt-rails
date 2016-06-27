class RequestsController < ApplicationController
  before_action :set_project
  before_action :set_request, only: [:accept, :decline, :destroy]
  before_action :authenticate_user!

  def create
    @project.requests.new(user: current_user)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Request was successfully sent.' }
        format.json { render :'project/show', status: :sent, location: @project }
      else
        format.html { redirect_to @project, notice: 'Something went wrong' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to project_path(@project), notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def accept

  end

  def decline 
    
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_request
      @request = Request.find(params[:id])
    end
end
