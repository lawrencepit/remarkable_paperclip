module Remarkable
  module Paperclip
    module Matchers
      class HaveAttachedFileMatcher < Remarkable::ActiveRecord::Base
        arguments :attribute

        optionals :styles, :default_style

        assertions :defined?, :has_column?, :styles_match?, :default_style_match?

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
              actual == value || case actual
              when Hash then actual[:geometry]
              when Array then actual[0]
              else actual
              end == value
            end
            return (match && actuals.size == 0),
                   :styles => @options[:styles].inspect, :actual => attachment_definition[:styles].inspect
          end

          def default_style_match?
            return true unless @options.key?(:default_style)
            return @options[:default_style] == attachment_definition[:default_style],
                   :style => @options[:default_style].inspect, :actual => attachment_definition[:default_style].inspect
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
