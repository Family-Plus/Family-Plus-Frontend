const { users } = require('../properties');
const { nanoid } = require('nanoid');

const addUserHandler = (request, h) => {
    const { name } = request.payload;
    const id = nanoid(16);
    const family = "";
    const point = 0;
    const notes = [];
    const newUser = {
        id,
        name,
        family,
        point,
        notes
    };

    const userNameCheck = () =>{
        if(name == undefined){
            return false;
        }
        return true;
    }

    if(!userNameCheck()){
        const response = h.response({
            status: 'fail',
            message: 'Gagal menambahkan user, mohon isi nama user!'
        });
        response.code(400);
        return response;
    }
    if(userNameCheck()){
        users.push(newUser);
        const response = h.response({
            status: 'success',
            message: 'Berhasil menambahkan User!'
        });
        response.code(201);
        return response;
    }

    const response = h.response({
        status : "error",
        message : "User gagal ditambahkan"
    });
    response.code(500);
    return response;
}

const getAllUserHandler = (request, h) => {
    const response = h.response({
        status: 'success',
        data: {
        users: users.map((user) => ({
            id: user.id,
            name: user.name,
            family: user.family,
          })),
        },
    });
    response.code(200);
    return response;
}

const getSpesificUserHandler = (request, h) => {
    const { id } = request.params;

    const selectedUser = users.filter((user) => user.id === id)[0];

    if(selectedUser !== undefined){
        const response = h.response({
            status: 'success',
            data: {
                user: selectedUser
            }
        });
        response.code(200);
        return response;
    }

    const response = h.response({
        status: 'fail',
        message: 'User tidak ditemukan!',
    });
    response.code(404);
    return response;
}

const updateUserDetail = (request, h) => {
    const { id } = request.params;
    const { family, point } = request.payload;

    const userIndex = users.findIndex((user) => user.id === id);

    if(userIndex !== -1){
        if(family == undefined){
            users[userIndex] = {
                ...users[userIndex],
                point
            }
        }else{
            users[userIndex] = {
                ...users[userIndex],
                family
            }
        }
        const response = h.response({
            status: 'success',
            message: 'Data User berhasil di perbarui!'
        });
        response.code(200);
        return response;
    }
    const response = h.response({
        status: 'fail',
        message: 'ID User tidak ditemukan!'
    });
    response.code(404);
    return response;
    
}

module.exports= {
    addUserHandler,
    getAllUserHandler,
    getSpesificUserHandler,
    updateUserDetail,
}