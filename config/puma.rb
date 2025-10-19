# config/puma.rb

# Number of Puma threads to use
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count

# Environment (Render sets RAILS_ENV=production automatically)
environment ENV.fetch("RAILS_ENV") { "development" }

# ✅ Render requirement — listen on all interfaces (not just localhost)
port ENV.fetch("PORT") { 3000 }
bind "tcp://0.0.0.0:#{ENV.fetch('PORT') { 3000 }}"

# ✅ Allow puma to restart via `bin/rails restart`
plugin :tmp_restart

# Optional — start Solid Queue supervisor if using it
plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"]

# Optional — PID file (Render doesn’t need it, but it’s safe)
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]

# ✅ Recommended for multi-core performance (safe default)
workers ENV.fetch("WEB_CONCURRENCY") { 2 }
preload_app!
