import React, { useState, useMemo } from 'react';
import { Modal, Button, Form } from 'react-bootstrap';

const ArtistCards = ({ artistData }) => {
  const [filterCategory, setFilterCategory] = useState('');
  const [filterValue, setFilterValue] = useState('');
  const [showModal, setShowModal] = useState(false);
  const [selectedArtist, setSelectedArtist] = useState(null);
  const [showGuestForm, setShowGuestForm] = useState(false);
  const [guestEmail, setGuestEmail] = useState('');
  const [successMessage, setSuccessMessage] = useState('');

  const [genreFilter, setGenreFilter] = useState('');
  const [stageFilter, setStageFilter] = useState('');
  const [dateFilter, setDateFilter] = useState('');

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
      
    if (category === 'genre') {
      setGenreFilter(value);
      setStageFilter('');
      setDateFilter('');
    } else if (category === 'stage') {
      setGenreFilter('');
      setStageFilter(value);
      setDateFilter('');
    } else if (category === 'date') {
      setGenreFilter('');
      setStageFilter('');
      setDateFilter(value);
    }
  };

  const handleArtistClick = (artist) => {
    setSelectedArtist(artist);
    setShowModal(true);
    setShowGuestForm(false);
    setSuccessMessage('');
  };

  const handleCloseModal = () => {
    setShowModal(false);
    setSelectedArtist(null);
    setShowGuestForm(false);
    setGuestEmail('');
    setSuccessMessage('');
  };

  const addToFavorites = async (artistId) => {
    // Replace this with your actual check for a logged-in user
    const isLoggedIn = false; // This should be dynamically determined

    if (isLoggedIn) {
      try {
        const response = await fetch('/favorites', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            item_type: 'Artist',
            item_id: artistId,
            user_id: 'current_user_id' // Replace with actual user ID
          })
        });
        const data = await response.json();
        console.log('Favorite added:', data);
        setSuccessMessage('Favorite added!');
      } catch (error) {
        console.error('Error adding favorite:', error);
      }
    } else {
      setShowGuestForm(true);
    }
  };

  const createAccountAndFavorite = async (artistId) => {
    if (!guestEmail) {
      alert('Please enter your email');
      return;
    }

    try {
      const response = await fetch('/favorites', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          item_type: 'Artist',
          item_id: artistId,
          email: guestEmail
        })
      });
      const data = await response.json();
      console.log('Account created and favorite added:', data);
      window.location = `/?welcome=true&id=${data.uuid}`;
    } catch (error) {
      console.error('Error creating account and adding favorite:', error);
    }
  };

  return (
    <div className="container">
      <h2 className="mb-4 display-2 text-center">Artist Search</h2>
      <h2 className="mb-4 text-center">
        {filterCategory && filterValue 
          ? `${filterCategory.charAt(0).toUpperCase() + filterCategory.slice(1)}: ${ filterCategory === 'date' ? new Date(filterValue).toLocaleDateString('en-US', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' }) : filterValue }`
          : 'All Artists'}
      </h2>
      <div className="row mb-4">
        <div className="col-md-4">
          <select 
            className="form-select" 
            value={genreFilter}
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
            value={stageFilter}
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
            value={dateFilter}
            onChange={(e) => handleFilterChange('date', e.target.value)}
          >
            <option value="">Select Date</option>
              {uniqueDates.map(date => {
                const formattedDate = new Date(date).toLocaleDateString('en-US', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
                return (
                  <option key={date} value={date}>
                    {formattedDate}
                  </option>
                );
              })}
          </select>
        </div>
      </div>

      <div className="row row-cols-lg-4 flex-nowrap flex-lg-wrap gy-lg-5 mx-n3">
        {filteredArtists.map(artist => (
          <div key={artist.id} className="col">
            <div
              className="d-block text-center text-decoration-none artist-link"
              onClick={() => handleArtistClick(artist)}
              style={{ minWidth: '210px', cursor: 'pointer' }}
            >
              <img 
                src={artist.image} 
                className="rounded border-shadow" 
                alt={artist.name}
              />
              <h3 className="h5 pt-4 mb-1">{artist.name}</h3>
            </div>
            <div className="row">
              <div className="d-flex flex-wrap gap-2 justify-content-center">
                {artist.genres.map((genre, index) => (
                  <Button key={index} variant="outline-primary" size="sm">
                    {genre}
                  </Button>
                ))}
              </div>
            </div>
          </div>
        ))}
      </div>

      <Modal show={showModal} onHide={handleCloseModal} centered>
        <Modal.Header closeButton>
          <Modal.Title>Artist Info</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          {selectedArtist && (
            <>
              <img src={selectedArtist.image} alt={selectedArtist.name} className="img-fluid rounded mb-3" />
              <h3>{selectedArtist.name}</h3>
              {successMessage && <p>{successMessage}</p>}
              <div className="d-grid gap-2">
                <Button variant="primary" href={`/artists/${selectedArtist.slug}`}>View Bio</Button>
                {!showGuestForm && (
                  <Button variant="success" onClick={() => addToFavorites(selectedArtist.id)}>
                    Add to Favorites
                  </Button>
                )}
                {showGuestForm && (
                  <Form>
                    <Form.Group className="mb-2">
                      <Form.Control
                        type="email"
                        placeholder="Enter your email"
                        value={guestEmail}
                        onChange={(e) => setGuestEmail(e.target.value)}
                      />
                    </Form.Group>
                    <Button
                      variant="success"
                      className="w-100"
                      onClick={() => createAccountAndFavorite(selectedArtist.id)}
                    >
                      Create Account & Save Favorite
                    </Button>
                  </Form>
                )}
              </div>
            </>
          )}
        </Modal.Body>
      </Modal>
    </div>
  );
};

export default ArtistCards;