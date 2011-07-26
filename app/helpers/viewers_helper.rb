module ViewersHelper

   def food_tag_select
    @food_tag_options = [
    nil,
    'BBQ, grill',
    'Beef',
    'Cakes',
    'Chicken',
    'Cookies',
    'Family',
    'Healthy',
    'Holidays',
    'Italian',
    'Kids',
    'Lifestyle',
    'Mexican',
    'Ethnic',
    'Pasta',
    'Pork',
    'Quick',
    'Restaurant',
    'Seafood',
    'Seasonal',
    'Slow Cooker',
    'Vegetarian'
  ]
  end

  def story_tag_select
    @story_tag_options = [
    nil,
    'work',
    'school',
    'love',
    'spouse',
    'kids',
    'parents',
    'friends',
    'birth',
    'death',
    'marriage',
    'divorce',
    'money',
    'health',
    'travel',
    'justice',
    'moving on',
    'dedication',
    'thoughts'
  ]
  end


end
