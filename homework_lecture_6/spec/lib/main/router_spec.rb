RSpec.describe PostsController do
  let(:posts_controller) { described_class.new }

  describe '#index' do
    it 'displays no posts message when posts are empty' do
      expect { posts_controller.index }.to output(/No posts available/).to_stdout
    end

    it 'displays all posts with their indices' do
      posts_controller.instance_variable_set(:@posts, ['Post 1', 'Post 2'])
      expect { posts_controller.index }.to output(/1. Post 1\n2. Post 2/).to_stdout
    end
  end

  describe '#show' do
    it 'displays no posts message when posts are empty' do
      expect { posts_controller.show }.to output(/No posts available/).to_stdout
    end

    it 'displays the correct post when a valid index is provided' do
      posts_controller.instance_variable_set(:@posts, ['Post 1', 'Post 2'])
      allow(posts_controller).to receive(:input_index).and_return(1)
      expect { posts_controller.show }.to output(/Post 2/).to_stdout
    end

    it 'displays an invalid index message when an invalid index is provided' do
      posts_controller.instance_variable_set(:@posts, ['Post 1', 'Post 2'])
      allow(posts_controller).to receive(:input_index).and_return(3)
      expect { posts_controller.show }.to output(/Invalid index/).to_stdout
    end
  end

  describe '#create' do
    it 'adds a new post to the posts array' do
      allow(posts_controller).to receive(:gets).and_return("New Post\n")
      expect { posts_controller.create }.to change { posts_controller.instance_variable_get(:@posts).size }.by(1)
    end
  end

  describe '#update' do
    it 'updates the post with the new text when a valid index is provided' do
      posts_controller.instance_variable_set(:@posts, ['Post 1', 'Post 2'])
      allow(posts_controller).to receive(:input_index).and_return(0)
      allow(posts_controller).to receive(:gets).and_return("Updated Post\n")
      expect { posts_controller.update }.to output(/Post 1 updated: Updated Post/).to_stdout
    end

    it 'displays an invalid index message when an invalid index is provided' do
      posts_controller.instance_variable_set(:@posts, ['Post 1', 'Post 2'])
      allow(posts_controller).to receive(:input_index).and_return(3)
      expect { posts_controller.update }.to output(/Invalid index/).to_stdout
    end
  end

  describe '#destroy' do
    it 'deletes the post at the specified index when a valid index is provided' do
      posts_controller.instance_variable_set(:@posts, ['Post 1', 'Post 2'])
      allow(posts_controller).to receive(:input_index).and_return(0)
      expect { posts_controller.destroy }.to output(/Post 1 deleted: Post 1/).to_stdout
      expect(posts_controller.instance_variable_get(:@posts)).to eq(['Post 2'])
    end

    it 'displays an invalid index message when an invalid index is provided' do
      posts_controller.instance_variable_set(:@posts, ['Post 1', 'Post 2'])
      allow(posts_controller).to receive(:input_index).and_return(3)
      expect { posts_controller.destroy }.to output(/Invalid index/).to_stdout
    end
  end
end
