import Rails from "@rails/ujs";

const searchInputHandler = (event) => {
  console.log(event.target.value);

  Rails.ajax({
    type: 'GET',
    url: '/ingredients',
    data: `q=${event.target.value}`,
    success: () => { console.log('Success!') },
    failure: () => { console.log('Fail!') }
  });
};

export const initSearch = () => {
  document.querySelectorAll('[data-search="ingredients"]')
      .forEach(ele => {
        ele.addEventListener('input', searchInputHandler);
      })
};
