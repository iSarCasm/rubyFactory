require 'rspec'

require_relative '../factory'

describe Factory do
  it 'creates a new class' do
    expect(Factory.new).to be_a(Class)
  end

  context 'when first argument is a String' do
    before { Factory.new("Klass") }

    it 'sets a class constant' do
      expect(Factory.const_get("Klass")).to be_a(Class)
    end
  end

  context 'when block given' do
    before do
      @block = proc { def meth; "meth"; end}
      @klass = Factory.new(:name, :age, &@block)
      @instance = @klass.new("John Doe", 42)
    end

    it 'evals block' do
      # No idea
    end

    it 'can define custom public methods' do
      expect(@instance).to respond_to(:meth)
    end
  end

  describe 'class instances' do
    let(:instance)  { Factory.new(:name, :age).new("John", 42) }

    describe '#==, #eql?' do
      let(:factory)   { Factory.new(:name, :age)}
      let(:instance)  { factory.new("John", 42) }

      context 'when different type given' do
        let(:different) { String.new("i am a factory instance (nope)") }

        it 'returns false' do
          expect(instance == different).to be_falsey
        end
      end

      context 'when factory type given' do
        context 'with different variables' do
          let(:different_factory_instance) do
             Factory.new(:last_name, :salary).new("John", 42)
          end

          it 'returns false' do
            expect(instance == different_factory_instance).to be_falsey
          end
        end

        context 'with same variables' do
          let(:same_factory) { factory }

          context 'but different values' do
            let(:different_values_instance) { same_factory.new("Lisa",42) }

            it 'returns false' do
              expect(instance == different_values_instance).to be_falsey
            end
          end

          context 'and same values' do
            let(:same_values_instance) { same_factory.new("John",42) }

            it 'returns true' do
              expect(instance == same_values_instance).to be_truthy
            end
          end
        end
      end
    end

    describe '#[]' do
      context 'when String given' do
        context 'which matches the instance variable' do
          let(:index)  { 'name' }

          it 'returns variable value' do
            expect(instance[index]).to eq("John")
          end
        end

        context 'which doesnt match any instance varibale' do
          let(:index)  { 'kek' }

          it 'raises NameError' do
            expect{instance[index]}.to raise_error(NameError)
          end
        end
      end

      context 'when Symbol given' do
        context 'which matches the instance variable' do
          let(:index)  { :age }

          it 'returns variable value' do
            expect(instance[index]).to eq(42)
          end
        end

        context 'which doesnt match any instance varibale' do
          let(:index)  { :rank }

          it 'raises NameError' do
            expect{instance[index]}.to raise_error(NameError)
          end
        end
      end

      context 'when Fixnum given' do
        context 'which doesnt exceed instance size' do
          context 'and is positive' do
            let(:index) { 1 }

            it 'returns variable value' do
              expect(instance[index]).to eq(42)
            end
          end

          context 'and is negative' do
            let(:index) { -1 }

            it 'returns variable value' do
              expect(instance[index]).to eq(42)
            end
          end
        end

        context 'which exceeds instance size' do
          let(:index) { 3 }

          it 'raises IndexError' do
            expect{instance[index]}.to raise_error(IndexError)
          end
        end
      end

      context 'when different type given' do
        let(:index) { [1,2] }

        it 'raises TypeError' do
          expect{instance[index]}.to raise_error(TypeError)
        end
      end

      context 'when no arguments given' do
        it 'raises ArgumentError' do
          expect{instance[]}.to raise_error(ArgumentError)
        end
      end
    end

    describe '#[]=' do
      let(:value) { [1, "what", 'is', /love/] }

      context 'when index and value given' do
        context 'where index is String' do
          context 'which matches a variable' do
            let(:index) { 'age' }

            it 'changes variable value' do
              expect{instance[index] = value}.to change{instance[index]}.to(value)
            end
          end

          context 'which doesnt match any variable' do
            let(:index) { 'garage' }

            it 'raises NameError' do
              expect{instance[index] = value}.to raise_error(NameError)
            end
          end
        end

        context 'where index is Symbol' do
          context 'which matches a variable' do
            let(:index) { :name }

            it 'changes variable value' do
              expect{instance[index] = value}.to change{instance[index]}.to(value)
            end
          end

          context 'which doesnt match any variable' do
            let(:index) { :nope }

            it 'raises NameError' do
              expect{instance[index] = value}.to raise_error{NameError}
            end
          end
        end

        context 'where index is Fixnum' do
          context 'which doesnt exceed instance size' do
            context 'and is positive' do
              let(:index) { 1 }

              it 'changes variable value' do
                expect{instance[index] = value}.to change{instance[index]}.to(value)
              end
            end

            context 'and is negative' do
              let(:index) { -1 }

              it 'changes variable value' do
                expect{instance[index] = value}.to change{instance[index]}.to(value)
              end
            end
          end

          context 'which exceeds instance size' do
            let(:index) { -4 }

            it 'raises IndexError' do
              expect{instance[index] = value}.to raise_error(IndexError)
            end
          end
        end

        context 'when different type given' do
          let(:index) { {lol: 22, kek: :love} }

          it 'raises TypeError' do
            expect{instance[index] = value}.to raise_error(TypeError)
          end
        end
      end

      context 'when only index given' do
        let(:index) { 0 }

        it 'raises ArgumentError' do
          expect{instance.[]=(index) }.to raise_error(ArgumentError)
        end
      end

      context 'when no arguments given' do
        it 'raises ArgumentError' do
          expect{instance.[]= }.to raise_error(ArgumentError)
        end
      end
    end

    describe '#members' do
      it 'returns instance variables' do
        expect(instance.members).to eq([:@name,:@age])
      end
    end

    describe '#size, #length, #count' do
      it 'returns number of instance variables' do
        expect(instance.size).to eq(2)
        expect(instance.length).to eq(2)
        expect(instance.count).to eq(2)
      end
    end

    describe '#instance_values, #to_a, #values' do
      it 'returns array of instance values' do
        expect(instance.instance_values).to eq(["John",42])
        expect(instance.to_a).to            eq(["John",42])
        expect(instance.values).to          eq(["John",42])
      end
    end

    describe '#values_at' do
      it 'returns values by selector' do
        expect(instance.values_at(1)).to eq([42])
      end
    end

    describe '#instance_hash, #to_h' do
      it 'returns hash {variable => value}' do
        expect(instance.instance_hash).to  eq({:@name => "John", :@age => 42})
        expect(instance.to_h).to           eq({:@name => "John", :@age => 42})
      end
    end

    describe '#each' do
      context 'when no block given' do
        it 'returns Enumerable' do
          expect(instance.each).to be_an(Enumerable)
        end
      end

      context 'when block given' do
        before do
          @x = ''
          @block = proc { |v| @x << v.to_s }
        end

        it 'evaluates block on every instance value' do
          expect{instance.each &@block}.to change{@x}.to("John42")
        end
      end
    end

    describe '#each_pair' do
      context 'when no block given' do
        it 'returns Enumerable' do
          expect(instance.each_pair).to be_an(Enumerable)
        end
      end

      context 'when block given' do
        before do
          @x = ''
          @block = proc { |var, val| @x << var.to_s << val.to_s }
        end

        it 'evaluates block on every {variable => value} pair' do
          expect{instance.each_pair &@block}.to change{@x}
            .to("@nameJohn@age42")
        end
      end
    end

    describe '#inspect, #to_s' do
      it 'returns string representation of an instance' do
        expect(instance.inspect).to match(/name=\"John\", age=42/)
        expect(instance.to_s).to match(/name=\"John\", age=42/)
      end
    end
  end
end
