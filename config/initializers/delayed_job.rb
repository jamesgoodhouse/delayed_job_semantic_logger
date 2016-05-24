Delayed::Worker.logger = SemanticLogger[Delayed]
Delayed::Worker.delay_jobs = !Rails.env.test?
