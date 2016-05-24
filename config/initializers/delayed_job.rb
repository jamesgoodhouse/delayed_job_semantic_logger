Delayed::Worker.logger = SemanticLogger::Logger.new(Delayed)
Delayed::Worker.delay_jobs = !Rails.env.test?
