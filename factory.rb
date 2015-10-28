class Factory
  def self.new *args, &block
    if args[0].is_a?(String)
      class_name = args.shift.capitalize
    end
    new_class = Class.new do
      args.each { |x| attr_accessor x }

      define_method :initialize do |*attr|
        attr.each.with_index do |x,i|
          instance_variable_set("@#{args[i]}", x)
        end
      end

      # Basic stuff
      def == (other)
        if other.kind_of?(self.class)
          instance_hash == other.instance_hash
        end
      end
      def eql? other
        self == other
      end
      def hash
        instance_hash.hash
      end

      # Array-like getter
      def [] index
        case index
        when String, Symbol
          self.instance_variable_get("@" << index.to_s)
        when Fixnum
          self.instance_variable_get(instance_variables[index])
        end
      end
      # Array-like setter
      def []= index, value
        case index
        when String, Symbol
          self.instance_variable_set("@" << index.to_s, value)
        when Fixnum
          self.instance_variable_set(instance_variables[index], value)
        end
      end

      # More API
      def size
        instance_variables.size
      end
      alias_method :length, :size
      alias_method :count, :size

      def instance_values
        self.instance_variables.map do |var|      # => [:name, :age]
          self.instance_variable_get(var.to_sym)  # => ['John', 42]
        end
      end
      def instance_hash
        self.instance_variables.inject(Hash.new) do |hash,var|
          hash[var.to_sym] = self.instance_variable_get(var.to_sym) # => value
          hash                                                      # => a_hash
        end
      end

      # Enumerables
      include Enumerable
      def each &block
        instance_values.each &block
      end
      def each_pair &block
        instance_hash.each_pair &block
      end

      # Output
      def inspect
        super.gsub(/@/,"")  # get out!!11
                            # \_O__
                            #  \__
                            #  |  \,@
                            # /
      end
      alias_method :to_s, :inspect

      # Block call
      class_eval &block if block_given?
    end

    self.const_set(class_name, new_class) if class_name
    return new_class
  end
end
