const { 
    addFamilyHandler, 
    getAllFamilyHandler, 
    getSpesificFamilyHandler, 
    addFamilyMemberHandler,
    deleteFamilyMemberHandler,
    deleteFamilyHandler 
} = require('./handler/family');

const { 
    addNotesHandler, 
    takeNotesHandler, 
    doneNotesHandler,
    getNotesHandler
} = require('./handler/todoList');

const {
    addUserHandler, 
    getAllUserHandler, 
    updateUserDetail, 
    getSpesificUserHandler, 
} = require('./handler/user');

const routes = [
    {
        method: "POST",
        path: "/users",
        handler: addUserHandler
    },
    {
        method: "GET",
        path: "/users",
        handler: getAllUserHandler
    },
    {
        method: "GET",
        path: "/users/{id}",
        handler: getSpesificUserHandler
    },
    {
        method: "PUT",
        path: "/users/{id}",
        handler: updateUserDetail
    },
    {
        method: "POST",
        path: "/family",
        handler: addFamilyHandler
    },
    {
        method: "GET",
        path: "/family",
        handler: getAllFamilyHandler
    },
    {
        method: "GET",
        path: "/family/{id}",
        handler: getSpesificFamilyHandler
    },
    {
        method: "DELETE",
        path: "/family/{id}",
        handler: deleteFamilyHandler
    },
    {
        method: "POST",
        path: "/family/{id}/members",
        handler: addFamilyMemberHandler
    },
    {
        method: "DELETE",
        path: "/family/{id}/members",
        handler: deleteFamilyMemberHandler
    },
    {
        method: "POST",
        path: "/family/{id}/notes",
        handler: addNotesHandler
    },
    {
        method: "POST",
        path: "/family/{id}/rewards",
        handler: 
    },
    {
        method: "GET",
        path: "/family/{id}/notes/{idNotes}",
        handler: getNotesHandler
    },
    {
        method: "POST",
        path: "/family/{id}/notes/{idNotes}",
        handler: takeNotesHandler
    },
    {
        method: "PUT",
        path: "/family/{id}/notes/{idNotes}",
        handler: doneNotesHandler
    },
];

module.exports = routes;