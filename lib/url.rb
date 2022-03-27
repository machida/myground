# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

class URL
  def initialize
    # ToDo
    # 試合がない日は?
    # 25:00までを今日とする

    schedule_url = 'https://baseball-freak.com/game/'

    schedule_html = URI.parse(schedule_url).open.read
    schedule_doc = Nokogiri::HTML.parse(schedule_html)

    @schedule = []
    # 今シーズンの全日程を取得(配列)
    schedule_doc.css('.schedule tr').each do |date|
      @schedule << date.css('td').text
    end
  end

  def today_cards
    today_element = @schedule.grep(/#{DateTime.now.month}月#{DateTime.now.day}日*/)

    today_cards = []
    today_element.to_s.gsub(/\d+?月+\d+?日\(.\)|\d+?|京セラD大阪|楽天生命パーク/, '').scan(/巨|ヤ|D|中|阪|広|日|楽|西|ロ|オ|ソ/).each_slice(2) do |g|
      path = DateTime.now.strftime('%y%m%d') + g.join('-')
      url = "https://baseball-freak.com/game/#{path}.html"
      today_cards << url.gsub(/巨|ヤ|D|中|阪|広|日|楽|西|ロ|オ|ソ/,
                              '巨' => 'g',
                              'ヤ' => 's',
                              'D' => 'yb',
                              '中' => 'd',
                              '阪' => 't',
                              '広' => 'c',
                              '日' => 'f',
                              '楽' => 'e',
                              '西' => 'l',
                              'ロ' => 'm',
                              'オ' => 'bs',
                              'ソ' => 'h')
    end
    today_cards
  end
end
