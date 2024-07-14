require 'rails_helper'

RSpec.describe SaveArtist do
  let(:artist) { create(:artist) }
  let(:params) { { name: 'New Name', bio: 'New Bio', tag_ids: %w[1 2] } }
  let(:service) { described_class.new(artist, params) }

  describe '#call' do
    it 'updates artist attributes' do
      service.call
      expect(artist.reload.name).to eq('New Name')
      expect(artist.reload.bio).to eq('New Bio')
    end

    it 'updates tags' do
      existing_tag = create(:tag)
      new_tag = create(:tag)
      artist.tags << existing_tag
      params[:tag_ids] = [existing_tag.id.to_s, new_tag.id.to_s]

      expect { service.call }.to change { artist.tags.count }.by(1)
      expect(artist.tags).to include(existing_tag, new_tag)
    end

    it 'removes tags not present in params' do
      tag_to_remove = create(:tag)
      tag_to_keep = create(:tag)
      artist.tags << [tag_to_remove, tag_to_keep]
      params[:tag_ids] = [tag_to_keep.id.to_s]

      expect { service.call }.to change { artist.tags.count }.by(-1)
      expect(artist.tags).to include(tag_to_keep)
      expect(artist.tags).not_to include(tag_to_remove)
    end

    it 'returns the updated artist' do
      result = service.call
      expect(result).to eq(artist)
    end

    it 'sets success to true' do
      service.call
      expect(service.success?).to be true
    end

    context 'when update fails' do
      before do
        allow(artist).to receive(:update!).and_raise(ActiveRecord::RecordInvalid)
      end

      it 'does not update the artist or tags' do
        expect do
          service.call
        rescue StandardError
          nil
        end.not_to(change { artist.reload.attributes })
        expect do
          service.call
        rescue StandardError
          nil
        end.not_to(change { artist.tags.count })
      end

      it 'sets success to false' do
        begin
          service.call
        rescue StandardError
          nil
        end
        expect(service.success?).to be false
      end

      it 'raises an exception' do
        expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when tag_ids are not provided' do
      let(:params) { { name: 'New Name', bio: 'New Bio' } }

      it 'does not modify tags' do
        expect { service.call }.not_to(change { artist.tags.count })
      end
    end
  end
end
