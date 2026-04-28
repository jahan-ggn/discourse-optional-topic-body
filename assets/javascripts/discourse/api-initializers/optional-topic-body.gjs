import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {
  api.registerValueTransformer(
    "composer-service-cannot-submit-post",
    ({ value, context }) => {
      const model = context.model;
      if (
        model.siteSettings.discourse_optional_topic_body_enabled &&
        (model.creatingTopic || model.editingFirstPost)
      ) {
        return false;
      }
      return value;
    }
  );

  api.modifyClass(
    "model:composer",
    (Superclass) =>
      class extends Superclass {
        save(opts) {
          if (
            this.siteSettings.discourse_optional_topic_body_enabled &&
            (this.creatingTopic || this.editingFirstPost)
          ) {
            return this.editingFirstPost
              ? this.editPost(opts)
              : this.createPost(opts);
          }
          return super.save(opts);
        }
      }
  );
});
