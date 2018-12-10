import { Controller } from 'stimulus';
import Uploader from 'libs/uploader';

export default class extends Controller {
  start(event) {
    const { target } = event;
    const _this = this;
    [...target.files].forEach(file => {
      // 準備 image 容器與 progress bar
      let wrapper = document.createElement('div');
      wrapper.classList.add('img-wrapper');
      wrapper.insertAdjacentHTML('afterbegin', `
        <div class="progress">
          <div class="progress-bar" style="width: 0%;"></div>
        </div>
      `);
      const insertTarget = _this.element.querySelector('input[type=file]');
      _this.element.insertBefore(wrapper, insertTarget);
      // 開始上傳
      const uploader = new Uploader(file, _this.directUploadUrl, wrapper);
      uploader.upload()
        .then(blob => {
          console.log(blob, _this.model);
          // 更新資料庫
          fetch(`/account/products/${_this.model.id}.json`, {
            headers: {
              'X-CSRF-Token': _this.csrf,
              'Content-Type': 'application/json',
              'X-Requested-With': 'XMLHttpRequest'
            },
            method: 'PUT',
            body: JSON.stringify({
              product: {
                pictures: [blob.signed_id]
              }
            }),
            credentials: 'same-origin'
          })
          .then(res => res.json())
          .then(data => {
            wrapper.innerHTML = `
              <div class="lds-dual-ring"></div>
            `;
            let img = document.createElement('img');
            img.src = data.url;
            img.onload = () => {
              wrapper.innerHTML = '';
              wrapper.appendChild(img);
              wrapper.insertAdjacentHTML('beforeend', `
                <a href="/posts/${_this.model.id}/images/${data.id}"
                  data-action="click->uploads#destroy">
                  刪除
                </a>
              `);
            };
          });
        });
    });
    target.value = '';
  }

  destroy(e) {
    e.preventDefault();
    const url = e.target.href;
    fetch(url, {
      headers: {
        'X-CSRF-Token': this.csrf,
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      },
      method: 'DELETE',
      credentials: 'same-origin'
    })
    .then(res => res.json())
    .then(data => {
      e.target.parentElement.remove();
    });
  }

  get model() {
    return JSON.parse(this.data.get('model'));
  }

  get directUploadUrl() {
    return this.data.get('directUploadUrl')
  }

  get csrf() {
    return document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  }
}
