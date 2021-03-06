class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    #@books = Book.all
    #@book = Search::Book.new
    @book = Book.search
    strSql = "select book_id,count(book_id) as yoyaku_su from tickets
              group by book_id
              order by count(book_id) desc,book_id asc
              limit 5"
    @popularbooks = Book.find_by_sql([strSql])
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    #@book = Search::Book.new(search_params)
    #@books = @book
    #  .matches
    #  .order(book_name: :desc, author: :asc)
    #  .decorate

    @book = Book.search(search_params)
    @books = @book
      .result
      .order(book_name: :desc, author: :asc)
      .decorate

    strSql = "select book_id,count(book_id) as yoyaku_su from tickets
              group by book_id
              order by count(book_id) desc,book_id asc
              limit 5"
    @popularbooks = Book.find_by_sql([strSql])


  end

  
  def edit_ticket
    
    #render :layout => "modal"
    
  end

  def update_comment
    
    #@d_audit_etc = DAuditEtc.find(params[:id])
    #@d_audit_etc[:comment] = params[:comment]
    #@d_audit_etc.save!
    
    #head :ok
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:book_id, :book_name, :author, :kbn1)
    end

    def search_params
      #params
      #  .require(:search_book)
      #  .permit(Search::Product::ATTRIBUTES)

      search_conditions = %i(
        book_name_cont author_cont
      )
      #search_conditions = [:book_name_cont,:author_cont]
      params.require(:q).permit(search_conditions)
    end

end
