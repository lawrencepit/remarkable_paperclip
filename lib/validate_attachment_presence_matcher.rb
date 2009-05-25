module Remarkable
  module Paperclip
    module Matchers
      class ValidateAttachmentPresenceMatcher < Remarkable::ActiveRecord::Base
        arguments :attribute

        assertions :invalid_when_not_present?

        protected

          def invalid_when_not_present?
            attachment = @subject.attachment_for(@attribute)
            attachment.assign(nil)
            !attachment.errors[:presence].nil?
          end

      end

      def validate_attachment_presence(*args)
        ValidateAttachmentPresenceMatcher.new(*args).spec(self)
      end

    end
  end
end
