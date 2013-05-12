class MultiCase::DSL
  #
  # @param  lhs [#===]
  # @param  rhs [#===]
  #
  def initialize(lhs, rhs)
    @lhs = lhs
    @rhs = rhs

    @result = nil
  end

  attr_reader :result

  #
  # A single case to which @lhs & @rhs are matched against
  # @param  from_to [Hash] @lhs is matched against keys, @rhs against values,
  #                        they both can be arrays
  # @param  &block [Object] User-specified result if both of parameters match
  #
  # @return [Object] Return-value of user-specified function
  def multi(from_to, &block)
    from = from_to.keys.flatten(1)
    from = [@lhs]  if from.empty?  # catch-all on empty array

    to = from_to.values.flatten(1)
    to = [@rhs]  if to.empty?

    if from.product(to).map(&method(:param_equal)).any?
      @result ||= block.call
    end
  end

  private

  #
  # Case-compares tuple against @lhs and @rhs
  # @param  arr [Array] Tuple to match against
  #
  # @return [Boolean]
  def param_equal(arr)
    f, t = arr
    (f === @lhs) && (t === @rhs)
  end
end
