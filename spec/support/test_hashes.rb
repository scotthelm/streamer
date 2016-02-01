class TestHashes
  def self.streamer_hash # rubocop:disable MethodLength
    {
      'addresses' => [
        {
          'city' => 'De Moines',
          'state_province' => 'IA',
          'us_fips_code' => '22333'
        }
      ],
      'this' => 'that',
      'scores' => [
        { 'month' => 'jan', 'score' => 1 },
        { 'month' => 'feb', 'score' => 2 },
        { 'month' => 'mar', 'score' => 3 }
      ],
      'sales' => [
        { 'product' => 'product1', 'units' => 100, 'amount' => 280 },
        { 'product' => 'product2', 'units' => 300, 'amount' => 2800 },
        { 'product' => 'product3', 'units' => 200, 'amount' => 1700 }
      ]
    }
  end

  def self.fact_hash
    {
      'products' => {
        'product1' => { 'rate' => 0.1, 'group' => 'category 3' },
        'product2' => { 'rate' => 0.2, 'group' => 'category 1' },
        'product3' => { 'rate' => 0.3, 'group' => 'category 2' }
      }
    }
  end

  def self.sb_config
    YAML.load(File.read('./spec/support/sb_config.yml'))
  end
end
