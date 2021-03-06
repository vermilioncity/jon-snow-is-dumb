function domReady(fn) {
    document.addEventListener('turbolinks:load', fn);
    if (document.readyState === "interactive" || document.readyState === "complete") {
        fn();
    }
}

function submitSmallImage() {
    const upload = document.querySelector('#user_avatar');

    if (upload) {
        upload.addEventListener('change', function () {
            const size_in_megabytes = this.files[0].size / 1024 / 1024;
            console.log(size_in_megabytes);
            if (size_in_megabytes > 1) {
                alert('Maximum file size is 5MB. Please choose a smaller file.');
            } else {
                this.form.submit();
            }
        });
    }
}

domReady(submitSmallImage);