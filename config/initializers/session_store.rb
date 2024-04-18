RailsAuthentication::Application.config.session_store :active_record_store, key: 'user_id', expire_after: 1.minute
