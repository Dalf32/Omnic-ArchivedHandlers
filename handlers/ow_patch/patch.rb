# patch.rb
#
# AUTHOR::  Kyle Mullins

require_relative 'version_number'
require_relative 'patch_notes'

class Patch
  include Comparable

  attr_reader :title, :version

  def initialize(id:, url:, title:, publish_date:)
    @id = id
    @url = url
    @title = title
    @publish_date = publish_date
  end

  def version_number(version_str)
    @version = VersionNumber.from_str(version_str)
    self
  end

  def notes(notes_html)
    @notes_html = notes_html
    self
  end

  def search(search_terms)
    parsed_notes.search(search_terms)
  end

  def fill_embed(embed)
    embed.title = @title
    embed.url = @url
    embed.author = { name: parsed_notes.title, url: @url }

    parsed_notes.sections.each do |section|
      embed.add_field(name: section.format_title, value: section.format_str)
    end
  end

  def <=>(other)
    @version <=> other.version
  end

  private

  def parsed_notes
    @parsed_notes ||= PatchNotes.new(@notes_html)
  end
end
