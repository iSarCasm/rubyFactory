class Factory
  def self.new *args, &block
    Class.new do
      args.each { |x| attr_accessor x }
      define_method :initialize do |*attr|
        attr.each.with_index do |x,i|
          instance_variable_set("@#{args[i]}", x)
        end
      end
      public yield(block) if block_given?
      # Array-like getter
      def [] index
        case index.class.to_s
        when "String"
          self.send(index.to_sym)
        when "Symbol"
          self.send(index)
        when "Fixnum"
          self.instance_variable_get(instance_variables[index])
        end
      end
      # Array-like setter
      def []= index, value
        case index.class.to_s
        when "String"
          self.send((index+"=").to_sym, value)
        when "Symbol"
          self.send((index.to_s<<"=").to_sym, value)
        when "Fixnum"
          self.instance_variable_set(instance_variables[index], value)
        end
      end
      # Enumerables
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

  end
end
