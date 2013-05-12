require 'multi_case/dsl'

module MultiCase::API
  protected

  #
  # Matches two parameters agains specified causes returning the result
  # of user specified functions
  # @param  lhs [#===] Matched against left-hand side
  # @param  rhs [#===] Matches against right-hand side
  # @param  &block [Object] A function which contains number of `multi` clauses
  #
  # @return [Object] Value returned by first matching matching specified by user
  def multi_case(lhs, rhs, &block)
    dsl = MultiCase::DSL.new(lhs, rhs)
    dsl.instance_eval(&block)

    dsl.result
  end
end
