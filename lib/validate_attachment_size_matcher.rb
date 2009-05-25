module Remarkable
  module Paperclip
    module Matchers
      class ValidateAttachmentSizeMatcher < Remarkable::ActiveRecord::Base
        Infinity = (1.0/0)

        arguments :attribute

        optionals :in, :less_than, :greater_than

        assertions :is_minimum?, :less_than_minimum?, :is_maximum?, :more_than_maximum?

        before_assert do
          if @options[:in]
            @minimum, @maximum = @options[:in].first, @options[:in].last
          elsif @options[:less_than]
            @minimum, @maximum = 0, @options[:less_than]
          elsif @options[:greater_than]
            @minimum, @maximum = @options[:greater_than], Infinity
          end
        end

        protected

          def is_minimum?
            valid_with_size?(@minimum)
          end

          def less_than_minimum?
            !valid_with_size?(@minimum - 1)
          end

          def is_maximum?
            valid_with_size?(@maximum == Infinity ? 2*256 : @maximum)
          end

          def more_than_maximum?
            return true if @maximum == Infinity
            !valid_with_size?(@maximum + 1)
          end

          def interpolation_options
            { :minimum => @minimum, :maximum => @maximum }
          end

        private
          def valid_with_size?(size)
            file = StringIO.new
            file.instance_variable_set(:@stubbed_size, size)
            def file.size ; @stubbed_size ; end
            attachment = @subject.attachment_for(@attribute)
            attachment.assign(file)
            attachment.errors[:size].nil?
          end
      end

      def validate_attachment_size(*args)
        ValidateAttachmentSizeMatcher.new(*args).spec(self)
      end

    end
  end
end
