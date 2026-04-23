# Run pending migrations automatically on boot (safe for single-server hobby apps)
if Rails.env.production?
  begin
    ActiveRecord::Migration.check_all_pending!
  rescue ActiveRecord::PendingMigrationError
    Rails.logger.info "Running pending migrations..."
    ActiveRecord::Tasks::DatabaseTasks.migrate
    Rails.logger.info "Migrations complete."
  end
end
