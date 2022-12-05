const { 
    addFamilyHandler, 
    getAllFamilyHandler, 
    getSpesificFamilyHandler, 
    addFamilyMemberHandler,
    deleteFamilyMemberHandler,
    deleteFamilyHandler 
} = require('./handler/family');

const { 
    addRewardsHandler, deleteRewardsHandler 
} = require('./handler/rewards');

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
        path: "/family/{idFamily}",
        handler: getSpesificFamilyHandler
    },
    {
        method: "DELETE",
        path: "/family/{idFamily}",
        handler: deleteFamilyHandler
    },
    {
        method: "POST",
        path: "/family/{idFamily}/members",
        handler: addFamilyMemberHandler
    },
    {
        method: "DELETE",
        path: "/family/{idFamily}/members",
        handler: deleteFamilyMemberHandler
    },
    {
        method: "POST",
        path: "/family/{idFamily}/notes",
        handler: addNotesHandler
    },
    {
        method: "POST",
        path: "/family/{idFamily}/rewards",
        handler: addRewardsHandler
    },
    {
        method: "GET",
        path: "/family/{idFamily}/rewards",
        handler: getAllFamilyHandler
    },
    {
        method: "DELETE",
        path: "/family/{idFamily}/rewards/{idReward}",
        handler: deleteRewardsHandler
    },
    {
        method: "GET",
        path: "/family/{idFamily}/notes/{idNotes}",
        handler: getNotesHandler
    },
    {
        method: "POST",
        path: "/family/{idFamily}/notes/{idNotes}",
        handler: takeNotesHandler
    },
    {
        method: "PUT",
        path: "/family/{idFamily}/notes/{idNotes}",
        handler: doneNotesHandler
    },
];

module.exports = routes;