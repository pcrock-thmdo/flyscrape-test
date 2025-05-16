export const config = {
    url: "https://cloud.google.com/iam/docs/understanding-roles",
    browser: false,
    headless: true
};

export default function ({ doc }) {
    const table = doc.find("#predefined-roles table");
    const roles = table.find("tr")
        .map(row => {
            return {
                title: row.find("td.role-description > .role-title").text().trim()
                    .replace(/\nBeta$/g, ""),  // delete "Beta" at end. is_beta below will handle that for us
                id: row.find("td.role-description > .iamperm-marginless").text().trim()
                    .replace(/^\(|\)$/g, ""),  // delete parens at begin and end of text
                description: row.find("td.role-description > span.role-description > p").text().trim()
                    .replace(/\n/g, " "),
                permissions: row.find("td.role-permissions code").map(x => x.text()),
                is_beta: row.find("td.role-description .launch-stage-pre-ga").text().trim() != ""
            };
        })
        .filter(row => row.description.length > 0 && row.permissions.length > 0);

    return {
        roles: roles
    };
}
