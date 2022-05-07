import Rails from "@rails/ujs";

/**/
const createResultsLI = (result) => {
  const li = document.createElement('li');

  li.textContent = result.name;

  return li;
};

/**
  * Update autocomplete suggestions of ingredient links with given data
  * @param {JSON} data - Data from the server
*/
const searchResultsHandler = (data) => {
  console.log(data);
  const resultsUL = document.querySelector('[data-search-results]');

  /* Delete and recreate everything. React-style selective updating will gain us little with so few elements */
  resultsUL.innerHTML = '';

  const fragment = document.createDocumentFragment();
  data.forEach(result => fragment.appendChild(createResultsLI(result)));

  resultsUL.appendChild(fragment);
};

/**
  * Submits search via AJAX and calls function to update page if request successful
  * @param {InputEvent} event
*/
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

/**
  * Attach input event listeners to all search boxes on the page for live updates
*/
export const initSearch = () => {
  document.querySelectorAll('[data-search="ingredients"]')
          .forEach(ele => {
            ele.addEventListener('input', searchInputHandler);
          });
};
