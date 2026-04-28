# frozen_string_literal: true

module ::DiscourseOptionalTopicBody
  module PostValidatorExtension
    def validate(post)
      return super unless DiscourseOptionalTopicBody.enabled?
      return super unless post.post_number.nil? || post.post_number == 1

      super
      post.errors.delete(:raw)
    end
  end
end
