class Movie < ApplicationRecord
  belongs_to :director

  # # METHOD 1: no need to write anything in the model

  # # METHOD 2: PG search (1 table)
  # include PgSearch::Model
  # # search_by_title_and_synopsis is the method we call
  # pg_search_scope :search_by_title_and_synopsis,
  #   against: [ :title, :synopsis ],
  #   associated_against: {
  #     director: [ :first_name, :last_name]
  #   },
  #   using: {
  #     tsearch: { prefix: true } # <-- now `superman batm` will return something!
  #   }

  # METHOD 3: PG Search (multi-models)
  include PgSearch::Model
  multisearchable against: [:title, :synopsis]
end
