module RecipesHelper

  def course_select
    @course_options = [
    [nil],
    ['appetizer'],
    ['soup, stew'],
    ['salad'],
    ['sauce'],
    ['side'],
    ['main'],
    ['sweet'],
    ['breakfast'],
    ['bread'],
    ['beverage'],
    ['preserves']
  ]
  end

  def main_select
    @main_options = [
    [nil],
    ['pizza'],
    ['fish, seafood'],
    ['veggie'],
    ['egg'],
    ['sammies'],
    ['pie'],
    ['chili'],
    ['casserole'],
    ['chicken'],
    ['lamb'],
    ['beef'],
    ['pork'],
    ['turkey']
  ]
  end

  def dessert_select
    @dessert_options = [
    [nil],
    ['candy'],
    ['cakes'],
    ['cookies'],
    ['custard'],
    ['fruit'],
    ['ice cream'],
    ['muffins'],
    ['pies & tarts']
  ]
  end

  def method_select
    @method_options = [
    [nil],
    ['raw'],
    ['bake'],
    ['steam'],
    ['grill'],
    ['roast'],
    ['microwave'],
    ['boil'],
    ['stew'],
    ['fry'],
    ['shallow fry'],
    ['deep fry'],
    ['baste'],
    ['saute'],
    ['stir fry'],
    ['blanch'],
    ['poach']
  ]
  end

 
end
