class ArtistFilter
  def initialize(params)
    @genre = params[:genre]
    @stage = params[:stage]
    @date = params[:date]
  end

  def call
    File.open('tmp/requests.txt', 'a') { |f| f.write("#{Time.now} - #{@genre} - #{@stage} - #{@date}\n") }
    Artist.all
  end
end
