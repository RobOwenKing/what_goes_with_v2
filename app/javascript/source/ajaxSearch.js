import Rails from "@rails/ujs";

/**
  * Sanitise all strings to be rendered into the HTML just in case
  * @returns {string}
*/
const sanitiseString = (str) => {
  // Delete everything that's not 0-9, A-Z, a-z, a space, a comma or a hyphen
  return str.replace(/[^\w\s,-]/g, "");
};

const highlightMatch = (str, searchTerm) => {
  const regex = new RegExp(searchTerm, 'gi')

  return sanitiseString(str).replace(regex, '<mark>$&</mark>');
};

const formatPotentialMatches = (str, searchTerm) => {
  const regex = new RegExp(searchTerm, 'i');

  return str.match(regex) ? `<p>${highlightMatch(str, searchTerm)}</p>` : '';
};

/**
  * Return <li></li> to display for given search result
  * @param {Object} result
  * @returns {string}
*/
const createResultsLI = (result, searchTerm) => {
  return `<li>
    <a href="/ingredients/${sanitiseString(result.slug)}.html">
      ${highlightMatch(result.name, searchTerm)}
    </a>
    ${result.aka ? formatPotentialMatches(result.aka, searchTerm) : ''}
    ${result.eg ? formatPotentialMatches(result.eg, searchTerm) : ''}
  </li>`;
};

/**
  * Update autocomplete suggestions of ingredient links with given data
  * @param {JSON} data - Data from the server
  * @param {string} searchTerm - The search value that returned the given data
*/
const searchResultsHandler = (data, searchTerm) => {
  const resultsUL = document.querySelector('[data-search-results]');
  const resultsLIs = data.map(result => createResultsLI(result, searchTerm));

  resultsUL.innerHTML = resultsLIs.join('');
};

/**
  * Submits search via AJAX and calls function to update page if request successful
  * @param {InputEvent} event
*/
const searchInputHandler = (event) => {
  const searchTerm = event.target.value;

  // If the search term is the empty string, clear the results list
  if (searchTerm.length < 1) { searchResultsHandler([], searchTerm); }

  Rails.ajax({
    type: 'GET',
    url: '/ingredients',
    data: `q=${searchTerm}`,
    success: (data) => { searchResultsHandler(data, searchTerm); },
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
