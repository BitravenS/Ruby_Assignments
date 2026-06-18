class MoveError < StandardError
  def initialize(msg = 'Invalid move')
    super(msg)
  end
end
