class FooterCart
  include PageObject

  # Elements
  span :amount_loaded,  xpath: '//*[@id="cart-footer-inner"]/a/span[2]'
  button :order_btn,    xpath: '//*[@id="cart-footer-inner"]/div/div[3]/div[2]/button'
  image :product_image, xpath: '//*[@id="cart-footer-inner"]/div/div[2]/ul/li/div[1]/span/img'
end