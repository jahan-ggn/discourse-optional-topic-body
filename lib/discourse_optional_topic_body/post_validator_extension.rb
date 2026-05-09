# frozen_string_literal: true

module ::DiscourseOptionalTopicBody
  module PostValidatorExtension
    def validate(post)
      is_first = first_post?(post)
      enabled = DiscourseOptionalTopicBody.enabled?

      super

      if enabled && is_first
        before = post.errors[:raw].map { |e| e.respond_to?(:type) ? e.type : e.to_s }
        post.errors.delete(:raw)
        after = post.errors[:raw].map { |e| e.respond_to?(:type) ? e.type : e.to_s }
      end
    end

    def first_post?(post)
      return true if post.post_number == 1
      return true if post.post_number.nil? && post.topic_id.nil?

      if post.post_number.nil? && post.topic_id.present?
        topic = post.topic || Topic.find_by(id: post.topic_id)
        result = topic&.posts_count.to_i == 0
        return result
      end

      false
    end
  end
end
