require 'telegram/bot'
class Telegram::Bot::MassageClubBot
  def initialize
    @current_selected_option = ""
  end

  def get_admins(bot, chat_id)
    response = bot.api.get_chat_administrators(chat_id:)
    users = JSON.parse(response.to_json)
    administrator = []
    creators = []
    users.each do |user|
      if user["status"] == "administrator" && !user["user"]["is_bot"]
        administrator.push(user["user"]["username"])
      end

      if user["status"] == "creator" && !user["user"]["is_bot"]
        creators.push(user["user"]["username"])
      end
    end
    admin = [administrator, creators].flatten
    @admin = admin&.last
  rescue StandardError => e
    "Failed to fetch admins: #{e.message}"
  end

  def push
    chat_id = nil
    selected_option = nil
    telegram_bot_token = ENV["MESSAGE_BOT_TOKEN"] || "7239485937:AAGznbziI5AY_Q9GMMyiv1kPoskqDg1Y5QU"
    Telegram::Bot::Client.run(telegram_bot_token) do |bot|
      puts 'BOT is Running, plz select menu Coin'
      bot.listen do |message|
        case message
        when Telegram::Bot::Types::Message
          chat_id         = JSON.parse(message.to_json)['chat']['id']
          selected_option = JSON.parse(message.to_json)['text']
        when Telegram::Bot::Types::CallbackQuery
          chat_id         = JSON.parse(message.to_json)['message']['chat']['id']
          selected_option = JSON.parse(message.to_json)['data']
        end
        begin
          case selected_option
          when '/start'
            markdown_menu(bot, chat_id, true)
          else
            if selected_option == '/be_so_1' || selected_option == '/be_so_2' || selected_option == '/be_so_3'
              @current_selected_option = selected_option
              from = JSON.parse(message.to_json)['from']
              full_name = from['first_name'].to_s + " " + from['last_name'].to_s
              bot.api.send_message(chat_id:, text: "👋 Hi Anh trai #{full_name} - Đây là danh sách hình ảnh #{format_callback_data(@current_selected_option)}")
              selected_option_formatted = selected_option[1..-1]
              bot.api.send_media_group(
                chat_id:,
                media: send("#{selected_option_formatted}_content")
              )
              markdown_menu(bot, chat_id)
            else
              puts "Invalid data with #{selected_option}"
              # markdown_menu(bot, chat_id)
            end
          end
        rescue StandardError => e
          puts "Error #{e}"
        end
      end
    end
  end

  private

  def markdown_menu(bot, chat_id, start = false)
    text = '🎉🎉 ** Massage Club mời anh trai chọn bé khác nếu chưa hài lòng ạ ** 🎉🎉'
    text = '🎉🎉 ** Massage Club xin chào, mời anh trai chọn bé ạ ** 🎉🎉' if start
    bot.api.send_message(
      chat_id:,
      text: text,
      parse_mode: 'Markdown',
      reply_markup: markdown_buttons
    )
  end

  def format_callback_data(text)
    {
      "/be_so_1" => "bé số 1",
      "/be_so_2" => "bé số 2",
      "/be_so_3" => "bé số 3"
    }[text]
  end

  def markdown_buttons
    current_selected_option = format_callback_data(@current_selected_option)
    kb = []
    if current_selected_option.present?
      kb = [
        [
          Telegram::Bot::Types::InlineKeyboardButton.new(text: '💔 Hình bé số 1', callback_data: '/be_so_1'),
          Telegram::Bot::Types::InlineKeyboardButton.new(text: '💔 Hình bé số 2', callback_data: '/be_so_2')
        ],
        [
          Telegram::Bot::Types::InlineKeyboardButton.new(text: '💔 Hình bé số 3', callback_data: '/be_so_3'),
          Telegram::Bot::Types::InlineKeyboardButton.new(text: '🆗 Book (Nhắn admin)', url: "https://t.me/huancapital")
          # Telegram::Bot::Types::InlineKeyboardButton.new(text: '🆗 Book Bé (Nhắn Admin)', switch_inline_query: "Chào admin, mình muốn book #{current_selected_option}")
        ],
        [
          Telegram::Bot::Types::InlineKeyboardButton.new(text: '🏡 Quay lại nhóm', url: 'https://t.me/massagetesting')
        ]
      ]
    else
      kb = [
        [
          Telegram::Bot::Types::InlineKeyboardButton.new(text: '💔 Hình bé số 1', callback_data: '/be_so_1'),
          Telegram::Bot::Types::InlineKeyboardButton.new(text: '💔 Hình bé số 2', callback_data: '/be_so_2')
        ],
        [
          Telegram::Bot::Types::InlineKeyboardButton.new(text: '💔 Hình bé số 3', callback_data: '/be_so_3'),
          Telegram::Bot::Types::InlineKeyboardButton.new(text: '🏡 Quay lại nhóm', url: 'https://t.me/massagetesting')
        ]
      ]
    end
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
  end

  def generate_content(base_url, caption)
    Array.new(10) { { type: 'photo', media: base_url, caption: caption } }
  end

  def be_so_1_content
    generate_content('https://i.ibb.co/2MTRvrZ/be-so-1.png', 'Bé số 1').to_json
  end

  def be_so_2_content
    generate_content('https://i.ibb.co/mRf21D6/be-so-2.png', 'Bé số 2').to_json
  end

  def be_so_3_content
    generate_content('https://i.ibb.co/f2GTyPH/be-so-3.png', 'Bé số 3').to_json
  end

end
