module Remarkable
  module Paperclip
    module Matchers
      class HaveAttachedFileMatcher < Remarkable::ActiveRecord::Base
        arguments :attribute

        optionals :styles

        assertions :defined?, :has_column?, :styles_match?

        protected
          def defined?
            !attachment_definition.nil?
          end

          def has_column?
            column_name = "#{@attribute}_file_name"
            return @subject.class.column_names.include?(column_name),
                   :table_name => @subject.class.table_name, :column_name => column_name
          end

          def styles_match?
            return true unless @options.key?(:styles)
            actuals = attachment_definition[:styles].clone
            match = @options[:styles].all? do |key, value|
              actual = actuals.delete(key)
              (actual.instance_of?(Hash) ? actual[:geometry] : actual) == value
            end
            return (match && actuals.size == 0),
                   :styles => @options[:styles].inspect, :actual => attachment_definition[:styles].inspect
          end

        private
          def attachment_definition
            @subject.class.attachment_definitions[@attribute]
          end
      end

      def have_attached_file(*args)
        HaveAttachedFileMatcher.new(*args).spec(self)
      end

    end
  end
end
