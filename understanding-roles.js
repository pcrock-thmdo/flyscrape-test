export const config = {
    // Specify the URL to start scraping from.
    url: "https://cloud.google.com/iam/docs/understanding-roles",
    browser: false,
    headless: true,

    // // Specify the HTTP request header.                    (default = none)
    // headers: {                       
    //     "Authorization": "Bearer ...",
    //     "User-Agent": "Mozilla ...",
    // },
};

export default function ({ doc, url, absoluteURL, scrape, follow }) {
    // doc
    // Contains the parsed HTML document.

    // url
    // Contains the scraped URL.

    // absoluteURL("/foo")
    // Transforms a relative URL into absolute URL.

    // scrape(url, function({ doc, url, absoluteURL, scrape }) {
    //     return { ... };
    // })
    // Scrapes a linked page and returns the scrape result.

    // follow("/foo")
    // Follows a link manually.
    // Disable automatic following with `follow: []` for best results.
    const table = doc.find("#predefined-roles table");
    const rows = table.find("tr")
        .map(row => {
            return {
                description: row.find(".role-description").text(),
                permissions: row.find(".role-permissions").text()
            };
        })
        .filter(row => row.description.length > 0 && row.permissions.length > 0);

    return {
        rows: rows
    };
}
