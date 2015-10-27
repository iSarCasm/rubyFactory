require_relative 'factory'

#      ______           __
#     / ____/___ ______/ /_____  _______  __
#    / /_  / __ `/ ___/ __/ __ \/ ___/ / / /
#   / __/ / /_/ / /__/ /_/ /_/ / /  / /_/ /
#  /_/    \__,_/\___/\__/\____/_/   \__, /
#                                  /____/

# Should be no errors
Factory.new("Customer", :name, :address)
#=> Factory::Customer
Factory::Customer.new("Dave", "123 Main")
#=> #<Factory::Customer:0x00000001bfbc50 "name="Dave", "address="123 Main">


SomeCustomer = Factory.new(:name, :address) do
  def greeting
    "Hello #{name}!"
  end
end
p SomeCustomer.new("Dave", "123 Main").greeting  # => "Hello Dave!"

p "struct == other → true or false"
  Customer = Factory.new(:name, :address, :zip)
    joe   = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
    joejr = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
    jane  = Customer.new("Jane Doe", "456 Elm, Anytown NC", 12345)
  p joe == joejr   #=> true
  p joe == jane    #=> false

p "struct[member] → anObject"
p "struct[index] → anObject"
  joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)

  p joe["name"]   #=> "Joe Smith"
  p joe[:name]    #=> "Joe Smith"
  p joe[0]        #=> "Joe Smith"

p "struct[name] = obj → obj"
p "struct[index] = obj → obj"
  joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)

    joe["name"] = "Luke"
    joe[1]      = "some st."
    joe[:zip]   = "90210"

  p joe.name      #=> "Luke"
  p joe.address   #=> "some st."
  p joe.zip       #=> "90210"


p "each {|obj| block } → struct"
p "each → an_enumerator"
  joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
  joe.each {|x| puts(x) }
  # Produces:
  # Joe Smith
  # 123 Maple, Anytown NC
  # 12345


p "each_pair {|sym, obj| block } → struct"
p "each_pair → an_enumerator"
  joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
  joe.each_pair {|name, value| puts("#{name} => #{value}") }
  # Produces:
  # name => Joe Smith
  # address => 123 Maple, Anytown NC
  # zip => 12345

p "select {|i| block } → array"
p "select → an_enumerator"
  Lots = Struct.new(:a, :b, :c, :d, :e, :f)
  l = Lots.new(11, 22, 33, 44, 55, 66)
  p l.select {|v| (v % 2).zero? }   #=> [22, 44, 66]
p "all? {|i| block } → boolean"
p "all? → an_enumerator"
  p l.all? {|v| v>10 }  # => true


p "size → fixnum"
  joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
  p joe.length   #=> 3
