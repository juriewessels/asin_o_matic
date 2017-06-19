# A helper module for creating callable service objects
module Callable

  def call(*args, &block)
    new(*args).call(&block)
  end

end
