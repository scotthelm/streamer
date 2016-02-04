module Streamer
  module Functors
    # Divide divides two terms
    class Divide < Functor
      def call
        divide
      end

      def divide
        terms = numerify(options.fetch(:terms))
        fail 'Streamer::Functor# divide: too many terms' if terms.size > 2
        return 0.0 if terms.any? { |t| t.to_f == 0.0 }
        terms[0].to_f / terms[1].to_f
      end
    end
  end
end
