import Rails from "@rails/ujs";

/**
  * Return <li></li> to display for given search result
  * @param {Object} result
  * @returns {string}
*/
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
  const resultsUL = document.querySelector('[data-search-results]');
  const resultsLIs = data.map(result => createResultsLI(result));

  resultsUL.innerHTML = resultsLIs.join('');
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
