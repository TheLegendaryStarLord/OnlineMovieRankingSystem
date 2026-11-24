class search extends HTMLElement{
    connectedCallback() {
         fetch('./search.html')
        .then(response => response.text())
        .then(html => this.innerHTMl = html);
    }
}

customElements.define('search', search);