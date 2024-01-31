# frozen_string_literal: true

# Module to handle resource connections.
module Resource
  INVALID_VERB_MESSAGE = "Invalid verb %s. Please enter 'GET', 'POST', 'PUT', 'DELETE', or 'q' to exit."

  def connection(routes)
    return puts "No route matches for #{self}" if routes.nil?

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp
      break if verb == 'q'

      action = nil

      if verb == 'GET'
        print 'Choose action (index/show) / q to exit: '
        action = gets.chomp
        break if action == 'q'
      end

      process_input(verb, action, routes)
    end
  end

  private

  def process_input(verb, action, routes)
    if routes.key?(verb)
      process_verb(verb, action, routes)
    else
      puts format(INVALID_VERB_MESSAGE, verb)
    end
  end

  def process_verb(verb, action, routes)
    if action.nil?
      routes[verb].call
    elsif routes[verb].key?(action)
      routes[verb][action].call
    else
      puts "Invalid action #{action}. Please enter 'index' or 'show'."
    end
  end
end

# Controller for handling posts.
class PostsController
  extend Resource

  NO_POSTS_MESSAGE = 'No posts available.'
  INVALID_INDEX_MESSAGE = 'Invalid index.'

  def initialize
    @posts = []
  end

  def index
    return puts NO_POSTS_MESSAGE if @posts.empty?

    puts 'All Posts:'
    @posts.each_with_index { |post, index| puts "#{index + 1}. #{post}" }
  end

  def show
    return puts NO_POSTS_MESSAGE if @posts.empty?

    index = input_index('Enter the index of the post you want to show:')
    return if index.nil?

    if valid_index?(index)
      puts "Post #{index + 1}: #{@posts[index]}"
    else
      puts INVALID_INDEX_MESSAGE
    end
  end

  def create
    print 'Enter the text of the new post: '
    new_post = gets.chomp
    @posts << new_post
    puts "New post created: #{new_post}"
  end

  def update
    return puts NO_POSTS_MESSAGE if @posts.empty?

    index = input_index('Enter the index of the post you want to update:')
    return if index.nil?

    if valid_index?(index)
      print 'Enter the new text for the post: '
      new_text = gets.chomp
      @posts[index] = new_text
      puts "Post #{index + 1} updated: #{new_text}"
    else
      puts INVALID_INDEX_MESSAGE
    end
  end

  def destroy
    return puts NO_POSTS_MESSAGE if @posts.empty?

    index = input_index('Enter the index of the post you want to delete:')
    return if index.nil?

    if valid_index?(index)
      deleted_post = @posts.delete_at(index)
      puts "Post #{index + 1} deleted: #{deleted_post}"
    else
      puts INVALID_INDEX_MESSAGE
    end
  end

  private

  def input_index(prompt)
    print "#{prompt} "
    gets.chomp.to_i - 1
  end

  def valid_index?(index)
    index >= 0 && index < @posts.length
  end
end

# Router class for handling resources.
class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choice = gets.chomp

      PostsController.connection(@routes['posts']) if choice == '1'
      break if choice == 'q'
    end

    puts 'Goodbye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new
router.init
