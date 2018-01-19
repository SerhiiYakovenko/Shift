class JacketPage < BasicPage
  include PageObject

  page_url BASIC_URL + '/wear/jacket'

  # Sections
  page_section :preview_section,     ItemPreview, xpath: '//*[@id="cdz-qsiframe"]/div[2]/div/div'
  page_section :footer_cart_section, FooterCart,  id: 'footer-cart'

  # Elements
  div :page_container, id: 'amshopby-page-container'
  divs :jackets, class: 'product-item-info'
  links :previews, class: %w(qs-button cdz-tooltip)

  # Methods
  def random_jacket
    @random_number = rand(0..jackets_elements.size)
    jackets_elements[@random_number]
  end

  def jacket_preview
    previews_elements[@random_number]
  end

  def preview_random_jacket
    random_jacket.hover
    jacket_preview.hover
    jacket_preview.click
  end

  def self.save_name=(str)
    @name = str
  end

  def self.save_name
    @name
  end

  def self.save_price=(str)
    @price = str
  end

  def self.save_price
    @price
  end

end