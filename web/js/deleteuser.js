
function deleteuser(id) {
    if (confirm("Are you sure delete this user?This action cannot be undone.")) {
        window.location = "deleteuser?id=" + id;
    }
}


