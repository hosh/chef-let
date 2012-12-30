# Implementation based on Rspec let()
#   https://github.com/rspec/rspec-core/blob/07be957b7f69447bf59ffe3ede9530436e6267ee/lib/rspec/core/let.rb
# License of RSpec:
#   https://github.com/rspec/rspec-core/blob/07be957b7f69447bf59ffe3ede9530436e6267ee/License.txt

class Chef
  module Mixin
    module Language
      # Cookbooks are eval'd in the instance, not defined a a class. We do not
      # need to put let() as a class definition.
      def let(name, &block)
        self.class.send(:define_method, name) do
          __memoized[name] ||= instance_eval(&block)
        end
      end

      private

      # The instance variable should be eval'd in the context of the object,
      # so that let() definition is scoped to within cookbooks
      def __memoized # :nodoc:
        @__memoized ||= {}
      end
    end # Language
  end # Mixin
end # Chef

