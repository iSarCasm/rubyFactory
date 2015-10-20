require_relative 'factory'

# Should be no errors
SomeCustomer = Factory.new(:name, :address) do
  def greeting
    "Hello #{name}!"
  end
end
p SomeCustomer.new("Dave", "123 Main").greeting  # => "Hello Dave!"

p "struct == other → true or false"
  Customer = Factory.new(:name, :address, :zip)
  p joe   = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
  p joejr = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
  p jane  = Customer.new("Jane Doe", "456 Elm, Anytown NC", 12345)
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

  p joe["name"] = "Luke"
  p joe[1]      = "some st."
  p joe[:zip]   = "90210"

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
