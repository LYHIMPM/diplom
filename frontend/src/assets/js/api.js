var csrf_token = null;
var currentUser = null;

export function parsejson(el_id, warning = true) {
    let element = document.getElementById(el_id);
    if (element == null) {
        if (warning)
            console.warn("parsejson error: #"+el_id+" is null!");
        return {};
    }
    return JSON.parse(element.innerHTML);
}

export function getCSRFToken() {
    if (csrf_token == null)
        csrf_token = JSON.parse(document.getElementById("csrf_token").innerHTML);
    return csrf_token;
}

export async function register(username, first_name, last_name, second_name, email, password) {
    return await apiRequest("/api/register", {
        "username": username,
        "first_name": first_name,
        "last_name": last_name,
        "second_name": second_name,
        "email": email,
        "password": password,
    });
}

export async function apiRequest(url = '', data = {}, method='POST') {
    // Default options are marked with *
    const response = await fetch(url, {
        method: method, // *GET, POST, PUT, DELETE, etc.
        mode: 'same-origin', // no-cors, *cors, same-origin
        cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
        credentials: 'same-origin', // include, *same-origin, omit
        headers: {
            'Content-Type': 'application/json',
            'X-CSRFToken': getCSRFToken(),
            // 'Content-Type': 'application/x-www-form-urlencoded',
        },
        redirect: 'follow', // manual, *follow, error
        referrerPolicy: 'no-referrer', // no-referrer, *client
        body: JSON.stringify(data) // body data type must match "Content-Type" header
    });
    return await response.json(); // parses JSON response into native JavaScript objects
}

export async function makeOrder(entry_id, material_id, m_sq_count,
                                paymenttype, orderPlaceID, first_name,
                                last_name, email) {
    return await apiRequest("/api/makeOrder", {
        "entry_id": entry_id,
        "material_id": material_id,
        "first_name": first_name,
        "last_name": last_name,
        "email": email,
        "m_sq_count": m_sq_count,
        "paymenttype": paymenttype,
        "order_place_id": orderPlaceID,
    });
}

export async function getOrderPlaces() {
    return await apiRequest("/api/getOrderPlaces");
}

export async function getOrders() {
    return await apiRequest("/api/getOrders");
}

export async function login(email, password) {
    return await apiRequest("/api/login", {"email": email, "password": password});
}

export async function getReports() {
    return await apiRequest("/api/getReports");
}

export async function createReport() {
    return await apiRequest("/api/createReport");
}

export async function deleteReport(name) {
    return await apiRequest("/api/deleteReport", {"name": name});
}

export async function getPremade(page = 0, price_from = 0, price_to = 0,
                                 full_picture = false, search = "",
                                 tags = []) {
    console.log(tags);
    return await apiRequest(
        "/api/getPremade",
        {
            "page": page,
            "price_from": price_from,
            "price_to": price_to,
            "full_picture": full_picture,
            "search": search,
            "tags": tags,
        }
    )
}

export function getCurrentUser() {
    if (currentUser == null) {
        let userdata = parsejson("userdata");
        if (userdata != {} && userdata != null)
            currentUser = userdata;
    }
    return currentUser;
}