SemanticLogger.add_appender(
  file_name: '/private/tmp/taco/log/delayed_job.log',
  filter:    -> log { log.name == 'Delayed' }
)

Delayed::Worker.logger = SemanticLogger[Delayed]
Delayed::Worker.delay_jobs = !Rails.env.test?
