require 'rest-client'

class Post < ApplicationRecord
  # Relationships
  has_many :post_categories
  has_many :categories, through: :post_categories

  def embed_info(embed_url)
    page = Nokogiri::HTML(RestClient.get(embed_url))

    if embed_url.include?("xhamster")

      title = page.css('div.head h1')[0].text
      image = page.css('div.noFlash img')[0]['src']
      embed = page.css("link[itemprop='embedUrl']")[0]["href"]

    elsif embed_url.include?("pornhub")

      title = page.css('h1.title span.inlineFree')[0].text
      image = page.css("meta[property='og:image']")[0].attributes["content"].text
      embed = page.css("meta[name ='twitter:player']")[0].attributes['content'].text

    elsif embed_url.include?("xvideos")

      title = page.css('div#main h2')[0].text
      image = page.css('div[id=html5video] img')[0].attributes['src'].text
      embed_iframe = embed = page.css('div#tabEmbed input')[0].attributes['value'].text

      embed = embed.match('(?<=src=").*?(?=[\?"])')

    end
    self.description = image
    self.title = title ##This works.
    self.embed = embed

    save!
  end


  accepts_nested_attributes_for :categories

end
