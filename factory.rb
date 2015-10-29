# Fancy Factory
class Factory
  def self.new(*args, &block)
    class_name = args.shift.capitalize if args[0].is_a?(String)
    new_class = Class.new do
      args.each { |x| attr_accessor x }

      define_method :initialize do |*atr|
        args.each.with_index do |arg, i|
          instance_variable_set("@#{arg}", (atr[i] || nil))
        end
      end

      # Basic stuff
      define_method :== do |other|
        instance_hash == other.instance_hash if other.is_a?(self.class)
      end
      alias_method :eql?, :==

      define_method :hash do
        instance_hash.hash
      end

      # Array-like getter
      define_method :[] do |index|
        case index
        when String, Symbol
          if instance_variable_defined?('@' << index.to_s)
            instance_variable_get('@' << index.to_s)
          else
            fail NameError, "no member '#{index}' in factory"
          end
        when Fixnum
          if instance_variables[index]
            instance_variable_get(instance_variables[index])
          else
            fail IndexError, "offset '#{index}' too large for factory(size:#{size})"
          end
        end
      end
      # Array-like setter
      define_method :[]= do |index, value|
        case index
        when String, Symbol
          instance_variable_set('@' << index.to_s, value)
        when Fixnum
          instance_variable_set(instance_variables[index], value)
        end
      end

      # More API
      define_method :members do
        instance_variables
      end

      define_method :size do
        instance_variables.size
      end
      alias_method :length, :size
      alias_method :count, :size

      define_method :instance_values do
        instance_variables.map do |var_name|  # => [:name, :age]
          instance_variable_get(var_name)     # => ['John', 42]
        end
      end
      alias_method :to_a, :instance_values
      alias_method :values, :instance_values

      define_method :instance_hash do
        instance_variables.each_with_object({}) do |var_name, hash|
          hash[var_name] = instance_variable_get(var_name)
        end
      end
      alias_method :to_h, :instance_hash

      define_method :values_at do |*selector|
        instance_values.values_at(*selector)
      end

      # Enumerables
      include Enumerable
      define_method :each do |&passed_block|
        instance_values.each(&passed_block)
      end

      define_method :each_pair do |&passed_block|
        instance_hash.each_pair(&passed_block)
      end

      # Output
      define_method :inspect do
        super().gsub(/@/, '')  # get out!!11
                               # \_O__
                               #  \__
                               #  |  \,@
                               # /
      end
      alias_method :to_s, :inspect

      # Block call
      class_eval(&block) if block_given?
    end

    const_set(class_name, new_class) if class_name
    new_class
  end
end
