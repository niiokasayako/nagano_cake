class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end
  
  def update
    @customer = Customer.find(current_customer.id)  
   if  @customer.update(customer_params)
    redirect_to public_customers_my_page_path(@customer)
   else
    render :edit
   end
  end

  def unsubscribe
     @customer = Customer.find(current_customer.id)
  end
  
  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update
    redirect_to public_root_path(@customer)
  end
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :adress, :telephone_number)
  end
  
end
