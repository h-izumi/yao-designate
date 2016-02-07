module Yao
  module Designate
    module Timestamp
      def created
        if date = self['created_at']
          Time.parse(date)
        end
      end

      def updated
        if date = self['updated_at']
          Time.parse(date)
        end
      end
    end
  end
end

