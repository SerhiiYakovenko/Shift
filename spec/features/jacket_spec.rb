describe 'Jacket purchase' do
  context 'Choosing jacket and putting it to cart' do
    before(:all) { visit(JacketPage) }

    it 'opens jackets page' do
      expect(@current_page.page_container).to include DEFAULTS['Shift']['Jackets']['description']
    end

    it 'unable to order jacket without size' do
      @current_page.preview_random_jacket
      while @current_page.preview_section.availability.include? DEFAULTS['Shift']['Errors']['out of stock']
        sleep 2
        @current_page.preview_section.close_preview
        @current_page.preview_random_jacket
      end
      @current_page.wait_until { sleep 1; @current_page.preview_section.submit_btn_element.enabled? }
      @current_page.preview_section.submit_btn
      expect(@current_page.preview_section.validation_advice).to include DEFAULTS['Shift']['Errors']['standard']
    end

    it 'jacket was added to cart on order' do
      JacketPage::save_name = @current_page.preview_section.name
      JacketPage::save_price = @current_page.preview_section.get_current_price
      @current_page.preview_section.select_size
      expect{ @current_page.preview_section.submit_btn; sleep 17 }.to change{ @current_page.footer_cart_section.amount_loaded }.
        from(match(/0/)).to(match(/1/))
      @current_page.footer_cart_section.order_btn
    end
  end

  context 'Jacket cart checkout' do
    before(:all) { on(CheckoutPage) }

    it 'checkout page have correct items' do
      @current_page.wait_until { @current_page.shop_address_selected? }
      expect(@current_page.product_name).to eq JacketPage::save_name
      expect(@current_page.product_price).to eq JacketPage::save_price
    end

    it 'unable to purchase jacket without personal data' do
      @current_page.purchase_btn
      validations = %w[first_name last_name email phone_number]
      validations.each { |field| expect(@current_page.send("validation_advice_#{field}")).to include DEFAULTS['Shift']['Errors']['standard']}
    end

    #using xit as This is real order, so maybe lets skip it until test env is present
    xit 'fill data and purchase jacket' do
      @current_page.fill_personal_data('Test', 'Sorry', '123@gmail.com', '445566')
      # Don't really like this rescue, but site was SOOOOOOOOO slow. Sorry.
      @current_page.purchase_btn rescue Net::ReadTimeout
      @current_page.wait_until(240) { @current_page.success_title_element.visible? }
      expect(@current_page.success_title).to include DEFAULTS['Shift']['Success purchase']['title']
      expect(@current_page.success_msg).to include DEFAULTS['Shift']['Success purchase']['msg']
    end
  end
end