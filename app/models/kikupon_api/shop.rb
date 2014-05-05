module KikuponAPI
  class Shop
    attr_accessor :name, :latitude, :longtitude, :category, :url, :image_url, :address, :tel, :opentime, :holiday, :budget, :access
    def initialize(data)
      @name      = data['name'] ? data['name'] : '名無し店舗さん'
      @lat       = data['latitude'] ? data['latitude'] : nil
      @lng       = data['longtitude'] ? data['longtitude'] : nil
      @category  = data['category'] ? data['category'] : 'カテゴリーなし'
      @url       = data['url'] ? data['url'] : nil
      @image_url = data['image_url'][0]['shop_image1'] ? data['image_url'][0]['shop_image1'] : nil
      @address   = data['address'] ? data['address'] : nil
      @tel       = data['tel'] ? data['tel'] : nil
      @opentime  = data['opentime'] ? data['opentime'] : '不明'
      @holiday   = data['holiday'] ? data['holiday'] : '不明'
      @budget    = data['budget'] ? data['budget'] : '不明'
      @access    = data['access'] ? data['access'] : nil
    end
  end
end
