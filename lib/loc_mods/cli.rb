# frozen_string_literal: true

# lib/loc_mods/cli.rb
require "thor"
require "loc_mods"

module LocMods
  class Cli < Thor
    desc "detect-duplicates PATH...", "Detect duplicate records in MODS XML files or directories"

    def detect_duplicates(*paths)
      all_records = []
      paths.each do |path|
        if File.directory?(path)
          Dir.glob(File.join(path, "*.xml")).each do |file|
            process_file(file, all_records)
          end
        elsif File.file?(path) && path.end_with?(".xml")
          process_file(path, all_records)
        else
          puts "Warning: Skipping invalid path: #{path}"
        end
      end

      records_by_url = {}
      all_records.each do |record|
        urls = record[:record].location.flat_map { |loc| loc.url.map(&:content) }.compact
        unless urls.any?
          puts "Warning: Record without URL found in file: #{record[:file]}"
          next
        end

        urls.each do |url|
          records_by_url[url] ||= []
          records_by_url[url] << record
        end
      end

      duplicate_count = 0
      records_by_url.each do |url, records|
        next unless records.size > 1

        duplicate_count += 1
        puts "Duplicate set ##{duplicate_count} found for URL: #{url}"
        records.combination(2).each_with_index do |(record1, record2), index|
          puts "  Comparison #{index + 1}:"
          puts "  File 1: #{record1[:file]}"
          puts "  File 2: #{record2[:file]}"
          differences = record1[:record].compare(record2[:record])
          if differences
            puts "  ----"
            print_differences(differences)
            puts "  ----"
          end
          puts "\n"
        end
      end
    end

    private

    def process_file(file, all_records)
      xml_content = File.read(file)
      collection = LocMods::Collection.from_xml(xml_content)
      collection.mods.each do |record|
        all_records << { record: record, file: file }
      end
    end

    def print_differences(differences, prefix = "", path = [])
      if differences.is_a?(Comparison)
        print_difference(differences, path)
        return
      end

      # Differences is a Hash here
      differences.each do |key, value|
        # puts "key #{key}, value #{value}"
        current_path = path + [key]
        # This is a comparison
        if value.is_a?(Comparison)
          print_difference(value, path)
          next
        end

        raise "Differences must be in form of a Hash" unless value.is_a?(Hash)

        # This is not array, end here
        next unless value.keys.any? do |k|
          k.is_a?(Integer) || k == :_array_size_difference
        end

        # if value[:_array_size_difference]
        #   puts "  #{format_path(current_path)} [_array_size_difference]:"
        #   puts "    Record 1: #{format_value(value[:_array_size_difference].original)}"
        #   puts "    Record 2: #{format_value(value[:_array_size_difference].updated)}"
        #   puts
        # end

        value.each do |subkey, subvalue|
          # if [:self, :other].include?(subkey)
          #   raise "Subkey is self or other"
          # end
          # puts "subkey (#{subkey})"
          # puts "subvalue #{subvalue}, prefix #{prefix}, current_path + [subkey] #{current_path + [subkey]}"

          if subkey.is_a?(Integer)
            print_differences(subvalue, prefix, current_path + [subkey])
          else
            if subvalue.is_a?(Comparison)
              print_difference(subvalue, current_path + [subkey])
              next
            end

            raise "In an array diff but not an Integer!"
          end
        end
      end
    end

    def print_difference(value, current_path)
      return unless value.original || value.updated

      puts "  #{format_path(current_path)}:"
      puts "    Record 1: #{format_value(value.original)}"
      puts "    Record 2: #{format_value(value.updated)}"
      puts
    end

    def format_path(path)
      path.map.with_index do |part, index|
        if index.zero?
          part.to_s
        elsif part.is_a?(Integer)
          "[#{part}]"
        else
          ".#{part}"
        end
      end.join
    end

    def format_value(value)
      case value
      when nil, ComparableNil
        "(nil)"
      when String
        "\"#{value}\""
      else
        value.to_s
      end
    end
  end
end
