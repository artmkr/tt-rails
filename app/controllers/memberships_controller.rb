class MembershipsController < ApplicationController
  before_action :set_project
  before_action :set_membership, only: [:accept, :decline, :destroy]

  def destroy
    unless @membership.user == @project.user
      @membership.destroy
      respond_to do |format|
        format.html { redirect_to edit_project_path(@project), notice: 'Membership was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
     respond_to do |format|
        format.html { redirect_to edit_project_path(@project), notice: 'You can\'t delete yourself' }
        format.json { head :no_content }
      end
    end 
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_membership
      @membership = Membership.find(params[:id])
    end
end
