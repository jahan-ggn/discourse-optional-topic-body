# frozen_string_literal: true

# name: discourse-optional-topic-body
# about: TODO
# meta_topic_id: TODO
# version: 0.0.1
# authors: Discourse
# url: TODO
# required_version: 2.7.0

enabled_site_setting :discourse_optional_topic_body_enabled

module ::DiscourseOptionalTopicBody
  PLUGIN_NAME = "discourse-optional-topic-body"
end

require_relative "lib/discourse_optional_topic_body/engine"

after_initialize do
  # Code which should run after Rails has finished booting
end
