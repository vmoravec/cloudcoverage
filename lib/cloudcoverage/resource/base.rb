module Cloudcoverage
  module Resource
    class Base
      class << self
        attr_reader :resource_key

        def resource_key= name
          @resource_key = name
          Resource.register(name, new)
        end
      end

      attr_accessor :loaded, :data
      attr_reader   :app, :data, :base

      def initialize
        @base = { self.resource_key => [] }
        @loaded = false
      end

      def resource_key
        self.class.resource_key
      end

      def update new_data
        self.data = base.dup
        self.data[resource_key] = base[resource_key].concat(new_data)
        self.data
      end

      def present data
        new_data = base.dup
        new_data[resource_key] = data
        new_data
      end

      def values
        data[resource_key]
      end

      def get filter=:default, format=:ruby
        default unless loaded

        data =
          case filter
          when :default
            data
          else
            send(filter)
          end

        case format
          when :ruby then data
          when :json then data.to_json
        end
      end

      def app
        @app ||= Cloudcoverage.app
      end

      def default
        raise NotImplementedError, "default data representation for #{self.class}"
      end

    end
  end
end
