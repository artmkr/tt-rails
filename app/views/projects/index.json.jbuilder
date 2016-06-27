json.array!(@projects) do |project|
  json.extract! project, :id, :name, :description, :short_description
  json.url project_url(project, format: :json)
end
