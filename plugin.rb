# frozen_string_literal: true

# name: discourse-optional-topic-body
# about: Makes topic body optional for first post of new topics
# version: 0.0.1
# authors: Jahan Gagan
# url: https://github.com/jahan-ggn/discourse-optional-topic-body

enabled_site_setting :discourse_optional_topic_body_enabled

module ::DiscourseOptionalTopicBody
  PLUGIN_NAME = "discourse-optional-topic-body"

  def self.enabled?
    SiteSetting.discourse_optional_topic_body_enabled
  end
end

require_relative "lib/discourse_optional_topic_body/engine"

after_initialize do
  reloadable_patch { PostValidator.prepend(::DiscourseOptionalTopicBody::PostValidatorExtension) }
end
