import Rails from "@rails/ujs";

/**/
const createResultsLI = (result) => {
  return `<li>
    <a href="/ingredients/${result.slug}.html">${result.name}</a>
  </li>`;
};

/**
  * Update autocomplete suggestions of ingredient links with given data
  * @param {JSON} data - Data from the server
*/
const searchResultsHandler = (data) => {
  console.log(data);
  const resultsUL = document.querySelector('[data-search-results]');

  const newList = data.map(result => createResultsLI(result)).join('');

  resultsUL.innerHTML = newList;
};

/**
  * Submits search via AJAX and calls function to update page if request successful
  * @param {InputEvent} event
*/
const searchInputHandler = (event) => {
  if (event.target.value.length < 1) { searchResultsHandler([]); }

  Rails.ajax({
    type: 'GET',
    url: '/ingredients',
    data: `q=${event.target.value}`,
    success: (data) => { searchResultsHandler(data); },
    failure: () => { return; }
  });
};

/**
  * Attach input event listeners to all search boxes on the page for live updates
*/
export const initSearch = () => {
  document.querySelectorAll('[data-search="ingredients"]')
          .forEach(ele => {
            ele.addEventListener('input', searchInputHandler);
          });
};
