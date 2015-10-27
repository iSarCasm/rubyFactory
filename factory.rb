class Factory
  def self.new *args, &block
    if args[0].is_a?(String)
      class_name = args.shift.capitalize
    end
    dynamic_class = Class.new do
      args.each { |x| attr_accessor x }
      define_method :initialize do |*attr|
        attr.each.with_index do |x,i|
          instance_variable_set("@#{args[i]}", x)
        end
      end
      class_eval &block if block_given?
      # Array-like getter
      def [] index
        case index.class.to_s
        when "String", "Symbol"
          self.send(index)
        when "Fixnum"
          self.instance_variable_get(instance_variables[index])
        end
      end
      # Array-like setter
      def []= index, value
        case index.class.to_s
        when "String", "Symbol"
          self.send("#{index}=", value)
        when "Fixnum"
          self.instance_variable_set(instance_variables[index], value)
        end
      end
      # More API
      def size
        instance_variables.size
      end
      alias_method :length, :size
      alias_method :count, :size
      # Enumerables
      include Enumerable
      def each &block
        self.instance_variables.map{|x| self.instance_variable_get(x.to_sym)}.each &block
      end
      def each_pair &block
        hash = Hash.new
        self.instance_variables.each do |x|
          hash[x] =  self.instance_variable_get(x.to_sym)
        end
        return hash.each_pair &block
      end
    end

    self.const_set(class_name, dynamic_class) if class_name
    return dynamic_class
  end
end
