class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s # make sure it's a string
    attr_reader attr_name # create the attribute's getter
    attr_reader attr_name+"_history" # create bar_history getter
    class_eval %Q{
      # YOUR CODE HERE
      def #{attr_name}
        @#{attr_name}
      end

      def #{attr_name}= val
        @#{attr_name}_history ||= []
        @#{attr_name}_history << #{attr_name}

        @#{attr_name} = val
      end

      def #{attr_name}_history
        @#{attr_name}_history
      end
    }
  end
end
