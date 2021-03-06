class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :auth_to_sign_up, only: :new
  before_filter :authenticate_user!
  respond_to :html

  def sales
    @orders = Order.all.where(seller: current_user.profile).order("created_at DESC")
  end

  def purchases
    @orders = Order.all.where(buyer: current_user.profile).order("created_at DESC")
  end

  def index
    @orders = Order.all
    respond_with(@orders)
  end

  def show
    respond_with(@order)
  end

  def new
    @order = Order.new
    @lesson = Lesson.find(params[:lesson_id])

    respond_with(@order)
  end

  def edit
  end

  def create
    @order = Order.new
    @lesson = Lesson.find(params[:lesson_id])

    @order.lesson_id = @lesson.id
    @order.buyer_id = current_user.profile.id # Student
    @order.seller_id = @lesson.tutor.id
    @order.price = @lesson.price

    begin
      Stripe::Charge.create(
          :amount => (@lesson.price * 100).floor,
          :currency => "usd",
          :card => params[:stripeToken],
          :description => "Tutor's PayPal Address: #{@lesson.tutor.paypal_account}"
      )
    rescue Stripe::CardError => e
      flash[:danger] = e.message
    end
    
    respond_to do |format|
      if @order.save
        @lesson.student_id = current_user.profile.id
        @lesson.status = 'reserved'
        @lesson.save

        NotificationMailer.lesson_confirmation_to_student(@order).deliver
        NotificationMailer.lesson_confirmation_to_tutor(@order).deliver
        format.html { redirect_to lesson_confirmation_path }
      else
        render :new
      end
    end
  end

  def update
    @order.update(order_params)
    respond_with(@order)
  end

  def destroy
    @order.destroy
    respond_with(@order)
  end

  private
  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:buyer_id, :seller_id, :lesson_id)
  end

  def auth_to_sign_up
    redirect_to new_registration_path('student') unless user_signed_in?
  end
end
