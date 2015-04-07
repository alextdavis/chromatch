class User < Sequel::Model
  plugin :validation_helpers
  # --- Associations ---

  one_to_many :expertises
  one_to_many :labellings
  many_to_many :bookmarks,
               :left_key   => :bookmarker_id,
               :right_key  => :bookmarked_id,
               :join_table => :bookmarkings,
               :class      => self

  # --- Hooks ---

  # --- Validation ---
  def validate
    super

    validates_presence [:uid, :email, :name]
    validates_unique [:uid, :email]
    validates_format /^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$/, :phone, :allow_blank => true
    validates_format /^\w*@(students.)?westport.k12.ct.us$/,:email
  end

  # --- Class Methods ---

  # --- Instance Methods ---

  def generate_token
    self.update({:token => SecureRandom.hex})
  end

  def has_bookmarked(bookmarked_id)
    puts bookmarked_id            #not working
    return self.bookmarks_dataset.where(:bookmarked_id => bookmarked_id).exists
  end

end