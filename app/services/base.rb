class Base
  attr_reader :errors

  def initialize
    @errors = []
  end

  def success?
    !error?
  end

  def error?
    @errors.any?
  end
end
