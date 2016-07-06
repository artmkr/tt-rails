require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @note = notes(:one)
  end

  test "should get index" do
    get :index, params: { project_id: @project }
    assert_response :success
  end

  test "should get new" do
    get :new, params: { project_id: @project }
    assert_response :success
  end

  test "should create note" do
    assert_difference('Note.count') do
      post :create, params: { project_id: @project, note: @note.attributes }
    end

    assert_redirected_to project_note_path(@project, Note.last)
  end

  test "should show note" do
    get :show, params: { project_id: @project, id: @note }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { project_id: @project, id: @note }
    assert_response :success
  end

  test "should update note" do
    put :update, params: { project_id: @project, id: @note, note: @note.attributes }
    assert_redirected_to project_note_path(@project, Note.last)
  end

  test "should destroy note" do
    assert_difference('Note.count', -1) do
      delete :destroy, params: { project_id: @project, id: @note }
    end

    assert_redirected_to project_notes_path(@project)
  end
end
