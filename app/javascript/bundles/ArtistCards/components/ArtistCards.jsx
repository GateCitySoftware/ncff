import React, { useState, useMemo } from 'react';

const ArtistCards = ({ artistData }) => {
  const [filterCategory, setFilterCategory] = useState('');
  const [filterValue, setFilterValue] = useState('');


  const artists = useMemo(() => Object.values(artistData), [artistData]);

  const uniqueGenres = useMemo(() => {
    const genres = new Set();
    artists.forEach(artist => artist.genres.forEach(genre => genres.add(genre)));
    return Array.from(genres).sort();
  }, [artists]);

  const uniqueStages = useMemo(() => {
    const stages = new Set();
    artists.forEach(artist => 
      artist.performances.forEach(performance => stages.add(performance.stage))
    );
    return Array.from(stages).sort();
  }, [artists]);

  const uniqueDates = useMemo(() => {
    const dates = new Set();
    artists.forEach(artist => 
      artist.performances.forEach(performance => dates.add(performance.date))
    );
    return Array.from(dates).sort();
  }, [artists]);

  const filteredArtists = useMemo(() => {
    if (!filterCategory || !filterValue) {
      return artists.sort(() => Math.random() - 0.5);
    }

    return artists.filter(artist => {
      switch (filterCategory) {
        case 'genre':
          return artist.genres.includes(filterValue);
        case 'stage':
          return artist.performances.some(perf => perf.stage === filterValue);
        case 'date':
          return artist.performances.some(perf => perf.date === filterValue);
        default:
          return true;
      }
    });
  }, [artists, filterCategory, filterValue]);

  const handleFilterChange = (category, value) => {
    setFilterCategory(category);
    setFilterValue(value);
  };

  return (
    <div className="container">
      <h2 className="mb-4  display-2 text-center">Artist Search</h2>
      <h2 className="mb-4 text-center">
        {filterCategory && filterValue 
          ? `${filterCategory.charAt(0).toUpperCase() + filterCategory.slice(1)}: ${filterValue}`
          : 'All Artists'}
      </h2>
      <div className="row mb-4">
        <div className="col-md-4">
          <select 
            className="form-select" 
            onChange={(e) => handleFilterChange('genre', e.target.value)}
          >
            <option value="">Select Genre</option>
            {uniqueGenres.map(genre => (
              <option key={genre} value={genre}>{genre}</option>
            ))}
          </select>
        </div>
        <div className="col-md-4">
          <select 
            className="form-select" 
            onChange={(e) => handleFilterChange('stage', e.target.value)}
          >
            <option value="">Select Stage</option>
            {uniqueStages.map(stage => (
              <option key={stage} value={stage}>{stage}</option>
            ))}
          </select>
        </div>
        <div className="col-md-4">
          <select 
            className="form-select" 
            onChange={(e) => handleFilterChange('date', e.target.value)}
          >
            <option value="">Select Date</option>
            {uniqueDates.map(date => (
              <option key={date} value={date}>{date}</option>
            ))}
          </select>
        </div>
      </div>


      <div className="row row-cols-lg-4 flex-nowrap flex-lg-wrap gy-lg-5 mx-n3">

        {filteredArtists.map(artist => (
          <div key={artist.id} className="col">
            <a 
              className="d-block text-center text-decoration-none artist-link" 
              data-bs-toggle="modal"
              data-bs-target="#artistModal"
              data-artist-slug={artist.slug}
              data-artist-id={artist.id}
              data-artist-name={artist.name}
              data-artist-image={artist.image}
              data-artist-genres={artist.genres.join(', ')}
              style={{ minWidth: '210px' }}
            >
              <img 
                src={artist.image} 
                className="rounded border-shadow" 
                alt={artist.name}
              />
              <h3 className="h5 pt-4 mb-1">{artist.name}</h3>
            </a>
            <div className="row">
              <div className="d-flex flex-wrap gap-2 justify-content-center">
                {artist.genres.map((genre, index) => (
                  <a key={index} href="#" className="btn btn-outline-primary btn-sm">
                    {genre}
                  </a>
                ))}
              </div>
            </div>
          </div>
        ))}

      </div>
    </div>
  );
};

export default ArtistCards;