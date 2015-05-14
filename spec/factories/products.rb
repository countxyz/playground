FactoryGirl.define do
  factory :product do
    title 'aa'
    price 0.01
    user

    factory :product_line_items do

      transient do
        line_items_count 2
      end

      after :create do |product, evaluator|
        create_list :line_item, evaluator.line_items_count, product: product
      end
    end
  end
end
