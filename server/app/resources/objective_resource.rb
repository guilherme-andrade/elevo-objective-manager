class ObjectiveResource < ApplicationResource
  type 'objectives'

  attributes :title, :weight, :created_at, :updated_at
end
