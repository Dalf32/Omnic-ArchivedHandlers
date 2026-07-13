# patch_notes.rb
#
# AUTHOR::  Kyle Mullins

require 'oga'

class PatchNotes
  attr_reader :title, :sections

  def initialize(patch_html)
    @sections = []
    parse_notes(patch_html)
  end

  def search(search_terms)
    @sections.map { |section| section.search(search_terms) }.flatten.compact
  end

  private

  def parse_notes(patch_html)
    notes_document = Oga.parse_html(patch_html)
    @title = notes_document.at_xpath('h1')&.text

    parse_patch_sections(notes_document)
  end

  def parse_patch_sections(notes_document)
    notes_document.each_node do |node|
      next unless node.is_a?(Oga::XML::Element)

      if node.name == 'h2'
        add_section(node.text)
      elsif node.name == 'p' && !node.at_xpath('u').nil?
        add_section(node.text)
      elsif node.name == 'p' && !node.at_xpath('strong').nil?
        add_heading(node.text)
      elsif node.name == 'p'
        add_subheading(node.text)
      elsif node.name == 'ul'
        # Process the list of notes
        node.children.find_all { |n| n.is_a?(Oga::XML::Element) }
            .each { |e| add_note(e.text) }
      end

      throw :skip_children
    end
  end

  def add_section(section_text)
    @sections << PatchSection.new(section_text)
  end

  def add_heading(heading_text)
    return if heading_text.empty?

    @sections.last&.add_child(PatchSectionHeading.new(heading_text))
  end

  def add_subheading(subheading_text)
    return if subheading_text.empty?

    @sections.last&.add_child(PatchSectionSubheading.new(subheading_text))
  end

  def add_note(note_text)
    return if note_text.empty?

    @sections.last&.add_child(PatchNote.new(note_text))
  end
end

class PatchElement
  def initialize(text)
    @text = text.gsub(/[\r\n\t]/, '')
    @children = []
  end

  def add_child(element)
    return if rank >= element.rank

    if rank.succ == element.rank || @children.empty?
      @children << element
    else
      @children.last.add_child(element)
    end
  end

  def search(search_terms)
    return self if matches?(search_terms)

    @children.map { |child| child.search(search_terms) }
  end

  def format_str
    "#{format_self}\n#{@children.map(&:format_str).join("\n")}".chomp
  end

  private

  def matches?(search_terms)
    @text.casecmp(search_terms).zero? || @text.include?(search_terms)
  end
end

class PatchSection < PatchElement
  def rank
    1
  end

  def format_title
    "__#{@text}__"
  end

  def format_self
    ''
  end
end

class PatchSectionHeading < PatchElement
  def rank
    2
  end

  def format_self
    "\n**#{@text}**"
  end
end

class PatchSectionSubheading < PatchElement
  def rank
    3
  end

  def format_self
    "*#{@text}*"
  end
end

class PatchNote < PatchElement
  BULLET_POINT = '•'.freeze

  def rank
    4
  end

  def format_self
    "#{BULLET_POINT} #{@text}"
  end
end
