class BooksController < ApplicationController
  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully"
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def show
    @booka = Book.find(params[:id])
    #@user = User.find(@booka.user.id)
    @book = Book.new
  end

  def edit
    @edit_book = Book.find(params[:id])
    user_id = @edit_book.user_id.to_i
    login_user_id = current_user.id
    if (user_id != login_user_id)
      redirect_to books_path
    end
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    #@book.user_id = current_user.id
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
