TestJob = Struct.new(:some_text)

class TestJob
  include SemanticLogger::Loggable

  def perform
    puts some_text
    logger.warn 'this is a warning from the test job'
  end
end
