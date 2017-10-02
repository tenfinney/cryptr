require 'test_helper'
require 'securerandom'

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength

class CryptrTest < Minitest::Test
  def test_it_can_decrypt_encrypt_random_data
    1000.times do
      data = SecureRandom.base64
      key = 'some_key'
      assert data == Cryptr.decrypt(key, Cryptr.encrypt(key, data))
    end
  end

  def test_it_can_decrypt_encrypt_random_data_base64
    1000.times do
      data = SecureRandom.base64
      key = 'some_key'
      assert data == Cryptr.decrypt64(key, Cryptr.encrypt64(key, data))
    end
  end

  def test_it_can_decrypt_encrypt_with_multi_keys
    1000.times do
      data = SecureRandom.base64
      key1 = 'some_key_1'
      key2 = 'some_key_2'
      key3 = 'some_key_3'

      assert Cryptr.multi_decrypt(
        [key1, key2],
        Cryptr.encrypt(key1, data)
      ).include?(data)

      assert Cryptr.multi_decrypt(
        [key1, key2],
        Cryptr.encrypt(key2, data)
      ).include?(data)

      assert !Cryptr.multi_decrypt(
        [key1, key2],
        Cryptr.encrypt(key3, data)
      ).include?(data)
    end
  end

  def test_it_can_decrypt_encrypt_with_multi_keys_base64
    1000.times do
      data = SecureRandom.base64
      key1 = 'some_key_1'
      key2 = 'some_key_2'
      key3 = 'some_key_3'

      assert Cryptr.multi_decrypt64(
        [key1, key2],
        Cryptr.encrypt64(key1, data)
      ).include?(data)

      assert Cryptr.multi_decrypt64(
        [key1, key2],
        Cryptr.encrypt64(key2, data)
      ).include?(data)

      assert !Cryptr.multi_decrypt64(
        [key1, key2],
        Cryptr.encrypt64(key3, data)
      ).include?(data)
    end
  end
end
