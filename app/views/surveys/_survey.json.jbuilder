json.extract! survey, :id, :title, :company_id, :created_at, :updated_at
json.url survey_url(survey, format: :json)
