import Rails from "@rails/ujs";

import { capitaliseFirstLetter } from '../helpers/capitaliseFirstLetter.js';

/**
  * Sanitise all strings to be rendered into the HTML just in case
  * @returns {string}
*/
const sanitiseString = (str) => {
  // Delete everything that's not 0-9, A-Z, a-z, a space, a comma or a hyphen
  return str.replace(/[^\w\s,-]/g, "");
};

/**
  * Return the first term in the str that matches the regexp
  * @param {str} string
  * @param {RegExp} regexp
  * @returns {string}
*/
const findMatch = (str, regexp) => {
  const match = sanitiseString(str).split(', ')
                                   .find(ele => regexp.test(ele));
  return capitaliseFirstLetter(match);
};

/**
  * Return the value to be used for the result's <option>
  * @param {Object} result
  * @param {string} searchTerm - The search value that returned the given data
  * @returns {string}
*/
const formatValue = (result, searchTerm) => {
  const regexp = new RegExp(searchTerm, 'i');
  const name = sanitiseString(result.name);

  if (regexp.test(name)) { return name; }
  // If there's a match in an alternative name, return that in () after the name
  if (regexp.test(result.aka)) { return `${name} (${findMatch(result.aka, regexp)})`; }
  // If there's a match in an example, return that in () after the name
  if (regexp.test(result.eg)) { return `${name} (eg: ${findMatch(result.eg, regexp)})`; }
};

/**
  * Return <option>s to display for given search result
  * @param {Object} result
  * @param {string} searchTerm - The search value that returned the given data
  * @returns {string}
*/
const createResultsLI = (result, searchTerm) => {
  return `<option value=\"${formatValue(result, searchTerm)}\" data-slug=\"${sanitiseString(result.slug)}\" />`;
};

/**
  * Update autocomplete suggestions of ingredient links with given data
  * @param {JSON} data - Data from the server
  * @param {string} searchTerm - The search value that returned the given data
*/
const searchResultsHandler = (data, searchTerm) => {
  const resultsUL = document.querySelector('datalist#search-results');
  const resultsLIs = data.map(result => createResultsLI(result, searchTerm));

  resultsUL.innerHTML = resultsLIs.join('');
};

/**
  * Submit search via AJAX and call function to update page if request successful
  * @param {InputEvent} event
*/
const searchInputHandler = (event) => {
  const searchTerm = event.target.value;

  // If the search term is the empty string, clear the results list
  if (searchTerm.length < 1) { return searchResultsHandler([], searchTerm); }

  Rails.ajax({
    type: 'GET',
    url: '/ingredients',
    data: `q=${searchTerm}`,
    success: (data) => { searchResultsHandler(data, searchTerm); },
    failure: () => { return; }
  });
};

/**
  * Navigate to selected ingredient's page
  * @param {InputEvent} event
*/
const searchChangeHandler = (event) => {
  const value = event.target.value;
  const option = document.querySelector(`[value="${value}"]`);

  if (!option) { return; }

  const url = `/ingredients/${option.dataset.slug}.html`;
  window.open(url, '_self');
};

/**
  * Attach input & change event listeners to all search boxes on the page for live updates
*/
export const initSearch = () => {
  document.querySelectorAll('[list="search-results"]')
          .forEach(ele => { ele.addEventListener('input', searchInputHandler); });
  document.querySelectorAll('[list="search-results"]')
          .forEach(ele => { ele.addEventListener('change', searchChangeHandler); });
};
