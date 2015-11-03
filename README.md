# RUBY FACTORY CLASS
```
ruby example.rb
```
https://repl.it/BUvh/20


```
Factory
  creates a new class
  when first argument is a String
    sets a class constant
  when block given
    evals block (PENDING: Temporarily skipped with xit)
    can define custom public methods
  class instances
    #==, #eql?
      when different type given
        returns false
      when factory type given
        with different variables
          returns false
        with same variables
          but different values
            returns false
          and same values
            returns true
    #[]
      when String given
        which matches the instance variable
          returns variable value
        which doesnt match any instance varibale
          raises NameError
      when Symbol given
        which matches the instance variable
          returns variable value
        which doesnt match any instance varibale
          raises NameError
      when Fixnum given
        which doesnt exceed instance size
          and is positive
            returns variable value
          and is negative
            returns variable value
        which exceeds instance size
          raises IndexError
      when different type given
        raises TypeError
      when no arguments given
        raises ArgumentError
    #[]=
      when index and value given
        where index is String
          which matches a variable
            changes variable value
          which doesnt match any variable
            raises NameError
        where index is Symbol
          which matches a variable
            changes variable value
          which doesnt match any variable
            raises NameError
        where index is Fixnum
          which doesnt exceed instance size
            and is positive
              changes variable value
            and is negative
              changes variable value
          which exceeds instance size
            raises IndexError
        when different type given
          raises TypeError
      when only index given
        raises ArgumentError
      when no arguments given
        raises ArgumentError
    #members
      returns instance variables
    #size, #length, #count
      returns number of instance variables
    #instance_values, #to_a, #values
      returns array of instance values
    #values_at
      returns values by selector
    #instance_hash, #to_h
      returns hash {variable => value}
    #each
      when no block given
        returns Enumerable
      when block given
        evaluates block on every instance value
    #each_pair
      when no block given
        returns Enumerable
      when block given
        evaluates block on every {variable => value} pair
    #inspect, #to_s
      returns string representation of an instance
```
