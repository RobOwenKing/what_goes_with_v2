/**
  * Return the input string with the first letter capitalised
  * @param {string} str
  * @returns str
  * @usedin 'scripts/ajaxSearch'
*/
export const capitaliseFirstLetter = (str) => {
  if (typeof str !== 'string') { return str; }

  return str.charAt(0).toUpperCase() + str.slice(1);
};
