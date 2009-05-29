module Remarkable
  module Paperclip
    module Matchers
      class ValidateAttachmentContentTypeMatcher < Remarkable::ActiveRecord::Base
        arguments :attribute

        optionals :allows, :rejects

        assertions :allows_match?, :rejects_match?

        protected

          def allows_match?
            return true unless @options.key?(:allows)
            allow?(@options[:allows])
          end

          def rejects_match?
            return true unless @options.key?(:rejects)
            !allow?(@options[:rejects])
          end

          def interpolation_options
            { :allows => @options[:allows].inspect, :rejects => @options[:rejects].inspect }
          end

        private

          def allow?(content_types)
            content_types.all? do |content_type|
              file = StringIO.new
              file.content_type = content_type
              attachment = @subject.attachment_for(@attribute)
              attachment.assign(file)
              attachment.errors[:content_type].nil?
            end
          end

      end

      def validate_attachment_content_type(*args)
        ValidateAttachmentContentTypeMatcher.new(*args).spec(self)
      end

    end
  end
end
