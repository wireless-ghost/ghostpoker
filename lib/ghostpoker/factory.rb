module Ghostpoker
  module Factory
    def self.extended(klass)
      klass.include InstanceMethods
    end
    module InstanceMethods
      def validate(args)
        raise "Missing keys for #{self.class}. Required keys are: [#{self.class::REQUIRED_KEYS.join(',')}], provided keys are: [#{args.keys.join(',')}]" unless (self.class::REQUIRED_KEYS & args.keys).size == self.class::REQUIRED_KEYS.size
      end
    end
    def get(args)
      if args.is_a? String
        self.new JSON.parse args
      else
        self.new args
      end
    end
  end
end
