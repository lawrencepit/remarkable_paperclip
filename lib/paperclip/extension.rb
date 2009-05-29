require 'paperclip' unless defined?(Paperclip)

# Always test using filesystem storage for speedy tests.
module Remarkable
  module Paperclip
    module Extensions
      private

      def self.included(base)
        base.class_eval do
          alias_method :initialize_without_remarkable, :initialize
          alias_method :initialize, :initialize_with_remarkable
        end
      end

      def initialize_with_remarkable(name, instance, options = {})
        options[:storage] = :filesystem
        initialize_without_remarkable(name, instance, options)
      end
    end
  end
end

if defined?(Paperclip::PaperclipAttachment)
  Paperclip::PaperclipAttachment.send(:include, Remarkable::Paperclip::Extensions)
else
  Paperclip::Attachment.send(:include, Remarkable::Paperclip::Extensions)
end