module Lita
  module Handlers
    class Sushiyuki < Handler
      SUSHI_MAP = {
        # filename: aliases
        '01' => ["yes"],
        '02' => ["no"],
        '03' => ["ok"],
        '04' => ["thanks", "thank you", "gyoku"],
        '05' => ["sorry"],
        '06' => ["sigh"],
        '07' => ["angry"],
        '08' => ["no comment"],
        '09' => ["cool"],
        '10' => ["kappa"],
        '11' => ["help"],
        '12' => ["what", "question", "?"],
        '13' => ["sleep", "sleepy"],
        '14' => ["oh no"],
        '15' => ["love"],
        '16' => ["grin"],
        '17' => ["bye"],
        '18' => ["sneak"],
        '19' => ["hide"],
        '20' => ["peel"],
        '21' => ["hot"],
        '22' => ["fail", "dip"],
        '23' => ["too much", "ikura"],
        '24' => ["happy"],
        '25' => ["smile"],
        '26' => ["wat", "anago"],
        '27' => ["tea", "content", "agari"],
        '28' => ["gari", "don't forget"],
        '29' => ["wasabi", "sabi"],
        '30' => ["come on", "c'mon"],
        '31' => ["sparkles"],
        '32' => ["sweat"],
        '33' => ["cry"],
        '34' => ["surprised"],
        '35' => ["idea"],
        '36' => ["sad", "sob"],
        '37' => ["chat"],
        '38' => ["phone", "call"],
        '39' => ["hello"],
        '40' => ["see you"],
      }

      def find_sushi(query)
        sushi = SUSHI_MAP.find{ |name, aliases| aliases.include?(query) }
        return nil unless sushi
        sushi[0]
      end

      def random_sushi
        sushi = SUSHI_MAP.to_a.sample
        sushi[0]
      end

      def sushi_url(filename)
        "https://d1zd1v0cxnbx2w.cloudfront.net/images/sets/sushiyuki/#{filename}.png"
      end

      route /\A(?:sushi)(?:\s+me)? (.+)\Z/, :query_sushiyuki, command: false,
        help: { "sushi [neta]" => "reply sushiyuki for you." }
      def query_sushiyuki(response)
        query    = response.matches[0][0].downcase
        return if query == 'list'
        filename = find_sushi(query)
        response.reply sushi_url(filename) if filename
      end

      route /^(?:sushi)(?:\s+me)? list/, :list_sushiyuki, command: false,
        help: { "sushi list" => "list sushi" }
      def list_sushiyuki(response)
        unless Lita.config.robot.adapter == :twitter
          return response.reply SUSHI_MAP.values.flatten.join(', ')
        end

        batch = []
        SUSHI_MAP.values.flatten.each do |name|
          batch << name
          next if batch.join(', ').length < 110
          response.reply batch.join(', ')
          batch = []
        end
        response.reply batch.join(', ') unless batch.empty?
      end

      route /🍣|寿司|すし|スシ|ｽｼ/, :hear_sushi, command: false
      def hear_sushi(response)
        response.reply sushi_url(random_sushi) if rand(10) == 0
      end
    end
    Lita.register_handler(Sushiyuki)
  end
end
