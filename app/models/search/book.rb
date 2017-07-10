class Search::Book < Search::Base
  ATTRIBUTES = %i(
    book_name 
    author
  )
  attr_accessor(*ATTRIBUTES)

  def matches
    t = ::Book.arel_table
    results = ::Book.all
    results = results.where(contains(t[:book_name], book_name)) if book_name.present?
    results = results.where(contains(t[:author], author)) if author.present?
    results
  end
end