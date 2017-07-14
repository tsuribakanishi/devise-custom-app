class TicketsController < ApplicationController
  

  # GET /tickets
  # GET /tickets.json
  def index
    #@tickets = Ticket.all
    #@tickets.where(user_id: "1")
    #@tickets = Ticket.find_by(user_id: '1').all
    #@tickets = Ticket.find_by(:all,user_id: "1")
    #current_user.id
    #@tickets = Ticket.find(:all, :conditions => ["user_id = ?",1])
    @tickets = Ticket.where(:user_id => current_user.id).all
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @ticket = Ticket.find(params[:id])

    #@books = Book.where(:user_id => current_user.id).all
    strSql = "select book_id,count(book_id) as yoyaku_su from tickets
              where user_id in(
                               select user_id from tickets
                               where book_id = ? and user_id <> ?
                               group by user_id
                               )
              and book_id <> ?
              group by book_id
              order by count(book_id) desc"

    @books = Book.find_by_sql([strSql,@ticket.book_id,@ticket.user_id,@ticket.book_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    #@book_id = params(:book_id)
    #@user_id = params(:user_id)
    #@user_email = params(:user_email)
    #@user_email = params[:ticket][:user_email]
    @ticket.book_id = params[:book_id]
    @ticket.user_id = params[:user_id]
    @user_email = params[:user_email]
    
    #ticket
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    @ticket.return_date = Date.today
    @ticket.return_flg = true

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: '予約を受け付けました。' }
        format.json { render :show, status: :created, location: @ticket }
        
        #format.html { redirect_to controller: 'books', action: 'index', notice: 'Ticket was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:tiket_id, :book_id, :user_id, :book_name, :return_date, :return_flg)
    end

end
