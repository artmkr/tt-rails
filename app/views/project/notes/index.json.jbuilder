json.array!(@project_notes) do |project_note|
  json.extract! project_note, :id, :title, :body
  json.url project_note_url(project_note, format: :json)
end
