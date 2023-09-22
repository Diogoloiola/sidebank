json.meta do
  json.current_page pagy.page
  json.next_page pagy.next
  json.previous_page pagy.prev
  json.total_pages pagy.pages
  json.total_entries pagy.count
end