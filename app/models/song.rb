class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name=(name)
    self.genre = Genre.find_by(name: name)
  end

  def genre_name
    self.genre ? self.genre.name : nil
  end

  def artist_name=(name)
    @artist = Artist.find_by(name: name)

    if @artist
      self.artist = @artist
    else
      self.artist = Artist.create(name: name)
    end
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def note_contents=(contents)
    contents.delete_if { |s| s == "" }

    @notes = contents.map do |c|
      Note.find_or_create_by(content: c)
    end

    @notes.each { |n| self.notes << n }
  end

  def note_contents
    @notes = self.notes
    @notes.map { |n| n.content }
  end
end
