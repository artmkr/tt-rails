class MembershipsController < ApplicationController
  before_action :set_project
  before_action :set_membership, only: [:accept, :decline, :destroy]

  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to project_path(@project), notice: 'Membership was successfully destroyed.' }
      format.json { head :no_content }
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
