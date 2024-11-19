require 'telegram/bot'
class Telegram::Bot::MassageClubBot
  def push
    telegram_bot_token = '7094752420:AAFP5_dXlxSe0DCVuwChyrVECKRUXEV75xs'
    Telegram::Bot::Client.run(telegram_bot_token) do |bot|
      puts 'BOT is Running, plz select menu Coin'
      bot.listen do |message|
        bot_message = JSON.parse(message.to_json)['message']
        chat_id = bot_message['chat']['id']
        selected_option = bot_message['reply_markup']['inline_keyboard'].first.first['callback_data']
        puts "######################## Customer are selecting #{selected_option}"
        begin
          case selected_option
          when '/start'
            markdown_menu(bot, chat_id)
          when '/beso1'
            bot.api.send_message(chat_id:, text: '👋 Hi Anh trai - Đây là danh sách hình ảnh bé số 1')
            bot.api.send_media_group(
              chat_id:,
              media: be_so_1_content
            )
            markdown_menu(bot, chat_id)
          when '/beso2'
            bot.api.send_message(chat_id:,
                                 text: '👋 Hi Anh trai - Đây là danh sách hình ảnh bé số 2')
            bot.api.send_media_group(
              chat_id:,
              media: be_so_2_content
            )
            markdown_menu(bot, chat_id)
          when '/beso3'
            bot.api.send_message(chat_id:,
                                 text: '👋 Hi Anh trai - Đây là danh sách hình ảnh bé số 3')
            bot.api.send_media_group(
              chat_id:,
              media: be_so_3_content
            )
            markdown_menu(bot, chat_id)
          end
        rescue StandardError => e
          puts "Error #{e}"
        end
      end
    end
  end

  private

  def markdown_menu(bot, chat_id)
    bot.api.send_message(
      chat_id:,
      text: '🎉🎉 ** Massage Club xin chào, mời anh trai chọn bé ạ ** 🎉🎉',
      parse_mode: 'Markdown',
      reply_markup: markdown_buttons
    )
  end

  def markdown_buttons
    kb = [
      [
        Telegram::Bot::Types::InlineKeyboardButton.new(text: '💔 Hình bé số 1', callback_data: '/beso1'),
        Telegram::Bot::Types::InlineKeyboardButton.new(text: '💔 Hình bé số 2', callback_data: '/beso2')
      ],
      [
        Telegram::Bot::Types::InlineKeyboardButton.new(text: '💔 Hình bé số 3', callback_data: '/beso3'),
        Telegram::Bot::Types::InlineKeyboardButton.new(text: '🏡 Book Bé', url: 'https://t.me/massagetesting')
      ],
      [
        Telegram::Bot::Types::InlineKeyboardButton.new(text: '🏡 Quay lại nhóm', url: 'https://t.me/massagetesting')
      ]
    ]
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
  end

  def be_so_1_content
    [
      {
        type: 'photo', media: 'https://i.ibb.co/2MTRvrZ/be-so-1.png', caption: 'Bé số 1'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/2MTRvrZ/be-so-1.png', caption: 'Bé số 1'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/2MTRvrZ/be-so-1.png', caption: 'Bé số 1'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/2MTRvrZ/be-so-1.png', caption: 'Bé số 1'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/2MTRvrZ/be-so-1.png', caption: 'Bé số 1'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/2MTRvrZ/be-so-1.png', caption: 'Bé số 1'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/2MTRvrZ/be-so-1.png', caption: 'Bé số 1'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/2MTRvrZ/be-so-1.png', caption: 'Bé số 1'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/2MTRvrZ/be-so-1.png', caption: 'Bé số 1'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/2MTRvrZ/be-so-1.png', caption: 'Bé số 1'
      }
    ].to_json
  end

  def be_so_2_content
    [
      {
        type: 'photo', media: 'https://i.ibb.co/mRf21D6/be-so-2.png', caption: 'Bé số 2'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/mRf21D6/be-so-2.png', caption: 'Bé số 2'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/mRf21D6/be-so-2.png', caption: 'Bé số 2'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/mRf21D6/be-so-2.png', caption: 'Bé số 2'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/mRf21D6/be-so-2.png', caption: 'Bé số 2'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/mRf21D6/be-so-2.png', caption: 'Bé số 2'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/mRf21D6/be-so-2.png', caption: 'Bé số 2'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/mRf21D6/be-so-2.png', caption: 'Bé số 2'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/mRf21D6/be-so-2.png', caption: 'Bé số 2'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/mRf21D6/be-so-2.png', caption: 'Bé số 2'
      }
    ].to_json
  end

  def be_so_3_content
    [
      {
        type: 'photo', media: 'https://i.ibb.co/f2GTyPH/be-so-3.png', caption: 'Bé số 3'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/f2GTyPH/be-so-3.png', caption: 'Bé số 3'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/f2GTyPH/be-so-3.png', caption: 'Bé số 3'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/f2GTyPH/be-so-3.png', caption: 'Bé số 3'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/f2GTyPH/be-so-3.png', caption: 'Bé số 3'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/f2GTyPH/be-so-3.png', caption: 'Bé số 3'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/f2GTyPH/be-so-3.png', caption: 'Bé số 3'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/f2GTyPH/be-so-3.png', caption: 'Bé số 3'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/f2GTyPH/be-so-3.png', caption: 'Bé số 3'
      },
      {
        type: 'photo', media: 'https://i.ibb.co/f2GTyPH/be-so-3.png', caption: 'Bé số 3'
      }
    ].to_json
  end
end

# bundle exec sidekiq -d -L log/sidekiq.log -C config/sidekiq.yml -e production & rails runner Telegram::Bot::MassageClubBot.new.push;
# get chat_id: https://api.telegram.org/bot7094752420:AAFP5_dXlxSe0DCVuwChyrVECKRUXEV75xs/getUpdates
