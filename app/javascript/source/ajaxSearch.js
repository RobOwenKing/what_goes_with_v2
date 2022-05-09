import Rails from "@rails/ujs";

/**
  * Sanitise all strings to be rendered into the HTML just in case
  * @returns {string}
*/
const sanitiseString = (str) => {
  // Delete everything that's not 0-9, A-Z, a-z, a space, a comma or a hyphen
  return str.replace(/[^\w\s,-]/g, "");
};

/**
  * Return <li></li> to display for given search result
  * @param {Object} result
  * @returns {string}
*/
const createResultsLI = (result) => {
  return `<li>
    <a href="/ingredients/${result.slug}.html">
      ${result.name}
    </a>
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
  const searchTerm = event.target.value;

  // If the search term is the empty string, clear the results list
  if (searchTerm.length < 1) { searchResultsHandler([]); }

  Rails.ajax({
    type: 'GET',
    url: '/ingredients',
    data: `q=${searchTerm}`,
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
