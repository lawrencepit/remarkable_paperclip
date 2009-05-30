module Remarkable
  module Paperclip
    module Matchers
      class AllowAttachmentContentTypeForMatcher < Remarkable::ActiveRecord::Base
        arguments :attribute

        optional :in, :splat => true

        assertions :is_valid?

        protected

          def is_valid?
            @options[:in].each do |value|
              return false, :value => value.inspect unless allow?(value)
            end
            true
          end

          def interpolation_options
            { :in => array_to_sentence(@options[:in].map{|i| i.inspect}) }
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

      def allow_attachment_content_type_for(attribute, *args, &block)
        options = args.extract_options!
        AllowAttachmentContentTypeForMatcher.new(attribute, options.merge!(:in => args), &block).spec(self)
      end
      alias_method :validate_attachment_content_type, :allow_attachment_content_type_for

    end
  end
end
