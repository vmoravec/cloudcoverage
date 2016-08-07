module Cloudcoverage
  module Resource
    class << self
      def get resource_name, filter: :default, format: :ruby
        registered[resource_name].get(filter, format)
      end

      def register name, instance
        registered[name] = instance
      end

      def registered
        @registered ||= OpenStruct.new
      end
    end
  end
end
