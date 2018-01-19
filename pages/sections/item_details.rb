class ItemPreview
  include PageObject

  # Elements
  image :item_img,        class: %w(rsImg rsMainSlideImage)
  h1 :name,               class: 'product-name-h1'
  link :s_size,           id: 'swatch427'
  link :m_size,           id: 'swatch425'
  link :l_size,           id: 'swatch423'
  links :all_sizes,             class: %w(swatch-link swatch-link-191)
  text_field :quantity,   id: 'qty'
  button :submit_btn,     id: 'product-addtocart-button'
  div :validation_advice, class: 'validation-advice'
  element :sku,           css: 'div.col-sm-8 > h3 > strong'
  span :availability,     css: 'div.product-shop-stock-avai > p > span'
  button :close_preview,  xpath: '//*[@id="cdz-qsiframe"]/div[2]/div/div/div[1]/button'
  link :compare,          class: 'link-compare'

  # Methods
  def get_current_price
    wrong_sku = {'861750-332':'10176'}
    if wrong_sku.has_key?(self.sku.to_sym)
      span_elements(id: "product-price-#{wrong_sku[self.sku.to_sym]}").first.text
    else
      span_elements(id: "product-price-#{self.sku}").first.text
    end
  end

  def select_size
    all_sizes_elements.sample.click
  end

end