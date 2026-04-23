# Load schema on first boot if tables don't exist yet
if Rails.env.production?
  begin
    tables = ActiveRecord::Base.connection.tables
    unless tables.include?("users")
      Rails.logger.info "Loading database schema..."
      load Rails.root.join("db", "schema.rb")
      Rails.logger.info "Schema loaded."
    end
  rescue => e
    Rails.logger.error "Schema load error: #{e.message}"
  end
end
