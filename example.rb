require_relative 'factory'
require_relative 'dont_look_here'
#      ______           __
#     / ____/___ ______/ /_____  _______  __
#    / /_  / __ `/ ___/ __/ __ \/ ___/ / / /
#   / __/ / /_/ / /__/ /_/ /_/ / /  / /_/ /
#  /_/    \__,_/\___/\__/\____/_/   \__, /
#                                  /____/

# Should be no errors
puts Factory.new("Customer", :name, :address)
#=> Factory::Customer
puts Factory::Customer.new("Dave", "123 Main")
#=> #<Factory::Customer:0x00000001bfbc50 name="Dave", address="123 Main">

SomeCustomer = Factory.new(:name, :address) do
  def greeting
    "Hello #{name}!"
  end
end
puts SomeCustomer.new("Dave", "123 Main").greeting  # => "Hello Dave!"

puts "struct == other → true or false"
  Customer = Factory.new(:name, :address, :zip)
    joe   = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
    joejr = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
    jane  = Customer.new("Jane Doe", "456 Elm, Anytown NC", 12345)
  p joe == joejr   #=> true
  p joe == jane    #=> false

puts "struct[member] → anObject"
puts "struct[index] → anObject"
  p joe["name"]   #=> "Joe Smith"
  p joe[:name]    #=> "Joe Smith"
  p joe[0]        #=> "Joe Smith"


puts "struct[name] = obj → obj"
puts "struct[index] = obj → obj"
  joe["name"] = "Luke"
  joe[1]      = "some st."
  joe[:zip]   = "90210"

  p joe.name      #=> "Luke"
  p joe.address   #=> "some st."
  p joe.zip       #=> "90210"


puts "each {|obj| block } → struct"
puts "each → an_enumerator"
  joe   = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
  joe.each {|x| p(x) }
  # Produces:
  # Joe Smith
  # 123 Maple, Anytown NC
  # 12345


puts "each_pair {|sym, obj| block } → struct"
puts "each_pair → an_enumerator"
  joe.each_pair {|name, value| p("#{name} => #{value}") }
  # Produces:
  # @name => Joe Smith
  # @address => 123 Maple, Anytown NC
  # @zip => 12345

puts "select {|i| block } → array"
puts "select → an_enumerator"
  Lots = Struct.new(:a, :b, :c, :d, :e, :f)
  l = Lots.new(11, 22, 33, 44, 55, 66)
  p l.select {|v| (v % 2).zero? }   #=> [22, 44, 66]


puts "all? {|i| block } → true or false"
puts "all? → an_enumerator"
  p l.all? {|v| v>15 }        # => false

puts "any? {|i| block } → true or false"
puts "any? → an_enumerator"
  p l.any? {|v| v.eql? 11 }   # => true

puts "size → fixnum"
  p joe.length   #=> 3


puts "Array#uniq → #hash works"
  z   = [Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345),
         Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)]
  p z.uniq
