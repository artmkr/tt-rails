class NotesController < ApplicationController
  before_action :set_notes
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET projects/1/notes
  def index
    @notes = @project.notes
  end

  # GET projects/1/notes/1
  def show
  end

  # GET projects/1/notes/new
  def new
    @note = @project.notes.build
  end

  # GET projects/1/notes/1/edit
  def edit
  end

  # POST projects/1/notes
  def create
    @note = @project.notes.build(note_params)

    if @note.save
      redirect_to([@note.project, @note], notice: 'Note was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT projects/1/notes/1
  def update
    if @note.update_attributes(note_params)
      redirect_to([@note.project, @note], notice: 'Note was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE projects/1/notes/1
  def destroy
    @note.destroy

    redirect_to project_notes_url(@project)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notes
      @project = Project.find(params[:project_id])
    end

    def set_note
      @note = @project.notes.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def note_params
      params.require(:note).permit(:title, :body)
    end
end
