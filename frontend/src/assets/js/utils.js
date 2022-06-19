export function parsejson(el_id, warning = true) {
    let element = document.getElementById(el_id);
    if (element == null) {
        if (warning)
            console.warn("parsejson error: #"+el_id+" is null!");
        return {};
    }
    return JSON.parse(element.innerHTML);
}