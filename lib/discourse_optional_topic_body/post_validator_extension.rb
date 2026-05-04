# frozen_string_literal: true

module ::DiscourseOptionalTopicBody
  module PostValidatorExtension
    def validate(post)
      is_first = first_post?(post)
      enabled = DiscourseOptionalTopicBody.enabled?

      Rails.logger.warn(
        "[OTB] enabled=#{enabled} first_post=#{is_first} pn=#{post.post_number.inspect} tid=#{post.topic_id.inspect} raw_len=#{post.raw.to_s.length}",
      )

      super

      if enabled && is_first
        before = post.errors[:raw].map { |e| e.respond_to?(:type) ? e.type : e.to_s }
        post.errors.delete(:raw)
        after = post.errors[:raw].map { |e| e.respond_to?(:type) ? e.type : e.to_s }
        Rails.logger.warn("[OTB] cleared raw errors: before=#{before} after=#{after}")
      end
    end

    def first_post?(post)
      Rails.logger.warn(
        "[OTB] first_post? check: pn=#{post.post_number.inspect} tid=#{post.topic_id.inspect} topic_exists=#{post.topic.present?} posts_count=#{post.topic&.posts_count.to_i}",
      )

      return true if post.post_number == 1
      return true if post.post_number.nil? && post.topic_id.nil?

      if post.post_number.nil? && post.topic_id.present?
        topic = post.topic || Topic.find_by(id: post.topic_id)
        result = topic&.posts_count.to_i == 0
        Rails.logger.warn(
          "[OTB] first_post? looked up topic: posts_count=#{topic&.posts_count} result=#{result}",
        )
        return result
      end

      false
    end
  end
end
