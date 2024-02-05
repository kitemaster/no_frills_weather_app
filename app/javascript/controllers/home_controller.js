import { Controller } from "@hotwired/stimulus";

const debounce = (callback, wait) => {
    let timeoutId = null;
    return (...args) => {
        window.clearTimeout(timeoutId);
        timeoutId = window.setTimeout(() => {
            callback.apply(null, args);
        }, wait);
    };
}

// Connects to data-controller="home"
export default class extends Controller {
    initialize() {
        this.submit = debounce(this.submit.bind(this), 300);
    }

    submit() {
        this.element.requestSubmit();
    }
}