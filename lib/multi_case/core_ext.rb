require 'multi_case'

#
# Makes multi_case a global method available at main:Object
# as well as inside any other class. BEWARE, this might make
# some modules behave unexpectedly because of name collision.
#
module Kernel
  include MultiCase::API
  alias_method :_multi_case, :multi_case

  def multi_case(x, y, &block)
    _multi_case(x, y, &block)
  end
end
