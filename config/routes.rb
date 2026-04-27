# frozen_string_literal: true

DiscourseOptionalTopicBody::Engine.routes.draw do
  get "/examples" => "examples#index"
  # define routes here
end

Discourse::Application.routes.draw { mount ::DiscourseOptionalTopicBody::Engine, at: "discourse-optional-topic-body" }
