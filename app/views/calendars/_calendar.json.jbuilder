# frozen_string_literal: true

json.extract!(calendar, :id, :created_at, :updated_at)
json.url(calendar_url(calendar, format: :json))
