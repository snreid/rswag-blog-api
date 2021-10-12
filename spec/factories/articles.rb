FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "Vulputate Mi Sit #{n}" }
    body { " Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut consequat semper viverra nam libero justo laoreet sit. Viverra suspendisse potenti nullam ac. Enim praesent elementum facilisis leo vel fringilla est ullamcorper eget. Ipsum dolor sit amet consectetur." }
    author { "Vulputate Ut" }
  end
end
