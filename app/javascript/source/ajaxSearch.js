import Rails from "@rails/ujs";

const searchResultsHandler = (data) => {
  console.log(data);
};


const searchInputHandler = (event) => {
  if (event.target.value.length < 1) { return; }

  Rails.ajax({
    type: 'GET',
    url: '/ingredients',
    data: `q=${event.target.value}`,
    success: (data) => { searchResultsHandler(data); },
    failure: () => { return; }
  });
};

export const initSearch = () => {
  document.querySelectorAll('[data-search="ingredients"]')
      .forEach(ele => {
        ele.addEventListener('input', searchInputHandler);
      })
};
