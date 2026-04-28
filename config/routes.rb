# frozen_string_literal: true

DiscourseOptionalTopicBody::Engine.routes.draw do
  get "/examples" => "examples#index"
  # define routes here
end

Discourse::Application.routes.draw do
  mount ::DiscourseOptionalTopicBody::Engine, at: "discourse-optional-topic-body"
end
