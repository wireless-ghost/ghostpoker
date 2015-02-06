module Ghostpoker
  module Factory
    def get(args)
      if args.is_a? String
        self.new JSON.parse args
      else
        self.new args
      end
    end
  end
end
