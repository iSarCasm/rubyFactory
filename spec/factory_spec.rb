require 'rspec'

require_relative '../factory'

describe Factory do
  it 'creates new class'

  context 'when first argument is a String' do
    it 'sets a class constant'
  end

  context 'when block given' do
    it 'evals block'

    it 'defines custom public methods'
  end

  describe 'class instances' do
    describe '#==, #eql?' do
      context 'when different factory class given' do
        it 'returns false'
      end
      context 'when same factory class given' do
        context 'with different variables' do
          it 'returns false'
        end
        context 'with same variables' do
          context 'but different values' do
            it 'returns false'
          end

          context 'and same values' do
            it 'returns true'
          end
        end
      end
    end

    describe '#[]' do
      context 'when String or Symbol given' do
        context 'which matches the instance variable' do
          it 'returns variable value'
        end

        context 'which doesnt match any instance varibale' do
          it 'raises NameError'
        end
      end

      context 'when Fixnum given' do
        context 'which doesnt exceed instance size' do
          context 'and is positive' do
            it 'returns variable value'
          end

          context 'and is negative' do
            it 'returns variable value'
          end
        end

        context 'which exceeds instance size' do
          it 'raises IndexError'
        end
      end

      context 'when different type given' do
        it 'raises TypeError'
      end

      context 'when no arguments given' do
        it 'raises ArgumentError'
      end
    end

    describe '#[]=' do
      context 'when index and value given' do
        context 'where index is String or Symbol' do
          context 'which matches a variable' do
            it 'changes variable value'
          end

          context 'which doesnt match any variable' do
            it 'raises NameError'
          end
        end

        context 'where index is Fixnum' do
          context 'which doesnt exceed instance size' do
            context 'and is positive' do
              it 'changes variable value'
            end

            context 'and is negative' do
              it 'changes variable value'
            end
          end

          context 'which exceeds instance size' do
            it 'raises IndexError'
          end
        end

        context 'when different type given' do
          it 'raises TypeError'
        end
      end

      context 'when only index given' do
        it 'raises ArgumentError'
      end

      context 'when no arguments given' do
        it 'raises ArgumentError'
      end
    end

    describe '#members' do
      it 'returns instancle variables'
    end

    describe '#size, #length, #count' do
      it 'returns number of instance variables'
    end

    describe '#instance_values, #to_a, #values' do
      it 'returns array of instance values'
    end

    describe '#values_at' do
      it 'returns values by selector'
    end

    describe '#instance_hash, #to_h' do
      it 'returns hash {variable => value}'
    end

    describe '#each' do
      context 'when no block given' do
        it 'returns Enumerable'
      end

      context 'when block given' do
        it 'evaluates block on every instance variable'
      end
    end

    describe '#each_pair' do
      context 'when no block given' do
        it 'returns Enumerable'
      end

      context 'when block given' do
        it 'evaluates block on every {variable => value} pair'
      end
    end

    describe '#inspect, #to_s' do
      it 'returns string representation of an instance'
    end
  end
end
