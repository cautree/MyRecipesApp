require 'test_helper'

class ChefTest <ActiveSupport::TestCase
  def setup
    @chef=Chef.new(chefname: "John", email: "john@example.com")
  end
  
  test "chef should be valid" do
    assert @chef.valid? 
  end
  
  test "chef name should be present" do
    @chef.chefname=" "
    assert_not @chef.valid?
  end
  
  test "chef name should not be too long" do
    @chef.chefname="a"*41
    assert_not @chef.valid?
  end
  
  test "chef name should not be too short" do
    @chef.chefname="a"*2
    assert_not @chef.valid?
  end
  
  test "chef email should be present" do
    @chef.email=" "
    assert_not @chef.valid?
  end
  
  test "chef email should not be too long" do
    @chef.email="a"*106
    assert_not @chef.valid?
  end
  
  test "chef email should be unique" do
    dup_chef=@chef.dup
    dup_chef.email=@chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email address should accepte vaild email address" do
    valid_addresses=%w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura.joe@monk.com]
    valid_addresses.each do |va|
      @chef.email=va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end
  
  test "email address should reject invalid email address" do
    invalid_addresses=%w[user@eee,com R_TDD-DSateee.hello.org user@example first.last@e_em__.com laura.joe@ee+aar.cm]
    invalid_addresses.each do |iv|
      @chef.email=iv
      assert_not @chef.valid?, '#{iv.inspect} should be invalid'
    end
  end
 
end
