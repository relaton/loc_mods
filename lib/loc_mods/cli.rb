# lib/loc_mods/cli.rb
require "thor"
require "loc_mods"

module LocMods
  class CLI < Thor
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
        if urls.any?
          urls.each do |url|
            records_by_url[url] ||= []
            records_by_url[url] << record
          end
        else
          puts "Warning: Record without URL found in file: #{record[:file]}"
        end
      end

      duplicate_count = 0
      records_by_url.each do |url, records|
        if records.size > 1
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
      differences.each do |key, value|
        current_path = path + [key]
        if value.is_a?(Hash) && value.keys.all? { |k| k.is_a?(Integer) }
          value.each do |index, sub_value|
            print_differences(sub_value, prefix, current_path + [index])
          end
        elsif value.is_a?(Hash) && (value[:self] || value[:other])
          puts "  #{format_path(current_path)}:"
          puts "  #{prefix}  Record 1: #{format_value(value[:self])}"
          puts "  #{prefix}  Record 2: #{format_value(value[:other])}"
          puts
        elsif value.is_a?(Hash)
          print_differences(value, prefix, current_path)
        end
      end
    end

    def format_path(path)
      path.map.with_index do |part, index|
        if index == 0
          part.to_s
        elsif part.is_a?(Integer)
          "[#{part}]"
        else
          ".#{part}"
        end
      end.join
    end

    def format_value(value)
      value.nil? ? "(nil)" : "\"#{value}\""
    end
  end
end
