class CheckoutPage < BasicPage
  include PageObject

  # Elements
  text_field :first_name,               id: 'billing:firstname'
  text_field :last_name,                id: 'billing:lastname'
  text_field :email,                    id: 'billing:email'
  text_field :phone_number,             id: 'billing:telephone'
  h2 :product_name,                     class: 'product-name'
  span :product_price,                  css: 'td.a-right.last > span > span'
  button :purchase_btn,                 id:'onestepcheckout-button-place-order'
  div :validation_advice_first_name,    id: 'advice-required-entry-billing:firstname'
  div :validation_advice_last_name,     id: 'advice-required-entry-billing:lastname'
  div :validation_advice_email,         id: 'advice-required-entry-billing:email'
  div :validation_advice_phone_number,  id: 'advice-required-entry-billing:telephone'
  radio_button :shop_address,           id: 's_method_freeshipping_freeshipping'
  div :success_title,                   class: 'page-title'
  h2 :success_msg,                      class: 'sub-title'

  # Methods
  def fill_personal_data(first_name, last_name, email, phone)
    self.first_name = first_name
    self.last_name = last_name
    self.email = email
    self.phone_number = phone
  end
end
