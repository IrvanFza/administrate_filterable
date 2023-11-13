const navTrigger = document.getElementsByClassName('administrate-filterable__toggle-button')[0];
const body = document.getElementsByTagName('body')[0];

navTrigger.addEventListener('click', toggleNavigation);

function toggleNavigation(event) {
  event.preventDefault();
  body.classList.toggle('administrate-filterable__open');
}

const applyFilterButton = document.getElementsByClassName('administrate-filterable__apply-filter')[0];
const form = document.getElementsByClassName('administrate-filterable__form')[0];

applyFilterButton.addEventListener('click', function(event) {
  // Prevent form submission
  event.preventDefault();

  // Instantiate a new FormData object
  let formData = new FormData(form);

  // Create URLSearchParams from FormData
  let formDataParams = new URLSearchParams([...formData.entries()]);

  // get existing query params
  let existingParams = new URLSearchParams(window.location.search);

  // Get keys of existingParams
  let keys = [...existingParams.keys()];

  // delete keys from existingParams which don't exist in formDataParams
  keys.forEach((key) => {
    if (!formDataParams.has(key)) {
      existingParams.delete(key);
    }
  });

  // append or replace new formDataParams
  formDataParams.forEach((value, key) => {
    if (value.trim() !== '') {
      existingParams.set(key, value);
    } else {
      existingParams.delete(key);
    }
  });

  // Create query params string from existingParams
  let queryParamsString = '?' + existingParams.toString();

  // Get the URL without query params
  const currentUrl = window.location.href.split('?')[0];

  // Construct new URL with updated parameters
  const newUrl = currentUrl + queryParamsString;

  // Redirect to current url with new query params
  window.location.href = newUrl;
});

window.onload = function() {
  // Get form fields
  const form = document.getElementsByClassName('administrate-filterable__form')[0];
  let formData = new FormData(form);

  // Extract query params from URL
  const queryParams = new URLSearchParams(window.location.search);

  // Loop through the query parameters and set form field values
  for (let pair of queryParams.entries()) {
    const formFields = document.getElementsByName(pair[0]);
    const fieldValue = decodeURIComponent(pair[1]);
    for(let field of formFields) {
      if(field.type === "checkbox" || field.type === "radio") {
        field.checked = field.value === fieldValue;
      } else if(field.tagName === 'SELECT') {
        // Check for Selectize
        if (field.className.indexOf('selectized') != -1) {
          // Field uses Selectize
          field.selectize.setValue(fieldValue, true);
        } else {
          // Regular SELECT Field
          for(let option of field.options) {
            if(option.value === fieldValue) {
              option.selected = true;
              break;
            }
          }
        }
      } else {
        field.value = fieldValue;
      }
    }
  }
}

const clearFilterButton = document.getElementsByClassName('administrate-filterable__clear-filter')[0];
// Clear all query params on clear filter click
clearFilterButton.addEventListener('click', function(event) {
  // Prevent form submission
  event.preventDefault();
  window.location = removeQueryParams(window.location.href);
});

function removeQueryParams(url) {
  let parsedUrl = new URL(url);

  return parsedUrl.origin + parsedUrl.pathname;
}