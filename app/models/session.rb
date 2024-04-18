class Session < ApplicationRecord
  def self.sweep(time = 30.seconds)
    where(updated_at: ...time.ago).or(where(created_at: ...2.days.ago)).delete_all
  end
end
