class Expertise < Sequel::Model
  # --- Associations ---

  many_to_one :user

  # --- Hooks ---

  # --- Validation ---
  def validate
    super
    validates_presence [:statement, :source, :user_id]
  end

  # --- Class Methods ---

  # --- Instance Methods ---
end