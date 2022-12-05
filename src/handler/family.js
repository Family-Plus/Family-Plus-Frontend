const { families, users } = require('../properties')
const { nanoid } = require('nanoid');



const addFamilyHandler = (request, h) => {
    const { idLeader, name } = request.payload;
    const members = [];
    const notes = [];
    const id = nanoid(16);

    const newFamily = {
        id,
        idLeader,
        name,
        members,
        notes
    }

    const propertyCheck = () => {
        if (id == undefined && name == undefined){
            return false;
        }
        return true;
    }

    if(!propertyCheck()){
        const response = h.response({
            status: 'fail',
            message: 'Gagal menambahkan family, mohon lengkapi id ketua dan nama family!'
        });
        response.code(400);
        return response;
    }

    if(propertyCheck()){
        families.push(newFamily);

        const thisUser = users.findIndex((user) => user.id === idLeader);
        users[thisUser] = {
            ...users[thisUser],
            family: id
        }
        
        const response = h.response({
            status: 'success',
            message: 'Berhasil menambahkan family!'
        });
        response.code(201);
        return response;
    }
    const response = h.response({
        status: 'error',
        message: 'Gagal menambahkan family!'
    });
    response.code(500);
    return response;
}

const getAllFamilyHandler = (request, h) => {
    const response = h.response({
        status: 'success',
        data: {
        families: families.map((family) => ({
            id: family.id,
            name: family.name,
            leader: family.idLeader,
          })),
        },
    });
    response.code(200);
    return response;
}

const getSpesificFamilyHandler = (request, h) => {
    const { id } = request.params;

    const selectedFamily = families.filter((family) => family.id === id)[0];

    if(selectedFamily !== undefined){
        const response = h.response({
            status: 'success',
            family: selectedFamily 
        });
        response.code(200);
        return response;
    }

    const response = h.response({
        status: 'fail',
        message: 'Family tidak ditemukan!',
    });
    response.code(404);
    return response;
}

const addFamilyMemberHandler = (request, h) => {
    const { id } = request.params;
    const { idMember } = request.payload;

    const newMember = {
        id: idMember
    }

    const indexFamily = families.findIndex((family) => family.id === id);
    const indexUser = users.findIndex((user) => user.id === idMember);

    if(indexFamily !== -1){
        const checkMember = families.at(indexFamily).members.filter((member) => member.id === idMember)[0];

        if(indexUser !== -1){
            users[indexUser] = {
                ...users[indexUser],
                family: id
            }
        }else{
            const response = h.response({
                status: 'fail',
                message: 'Member tidak ditemukan!'
            });
            response.code(404);
            return response;
        }

        if (checkMember !== undefined){
            const response = h.response({
                status: 'fail',
                message: 'Member sudah terdaftar di family!'
            });
            response.code(400);
            return response;
        }else {
            families.at(indexFamily).members.push(newMember);
            const response = h.response({
                status: 'success',
                message: 'Member berhasil didaftarkan di family!'
            });
            response.code(200);
            return response;
        }
    }
    
    const response = h.response({
        status: 'fail',
        message: 'ID family tidak ditemukan!'
    });
    response.code(404);
    return response;
}

const deleteFamilyMemberHandler = (request, h) => {
    const { id } = request.params;
    const { idMember } = request.payload;

    const indexFamily = families.findIndex((family) => family.id === id);

    if(indexFamily !== -1){
        const indexMember = families.at(indexFamily).members.findIndex((member) => member.id === idMember);
        if(indexMember !== -1){
            families.at(indexFamily).members.splice(indexMember, 1);

            const response = h.response({
                status: 'success',
                message: 'Member berhasil dihapus dari family!'
            });
            response.code(200);
            return response;
        }
        const response = h.response({
            status: 'fail',
            message: 'ID member tidak ditemukan!'
        });
        response.code(404);
        return response;
    }
    const response = h.response({
        status: 'fail',
        message: 'ID family tidak ditemukan!'
    });
    response.code(404);
    return response;
}

const deleteFamilyHandler = (request, h) => {
    const { id } = request.params;

    const indexFamily = families.findIndex((family) => family.id === id);

    if(indexFamily !== -1){
        families.splice(indexFamily, 1);

        const response = h.response({
            status: 'success',
            message: 'Family berhasil dihapus!'
        });
        response.code(200);
        return response;
    }
    const response = h.response({
        status: 'fail',
        message: 'ID family tidak ditemukan!'
    });
    response.code(404);
    return response;
}

module.exports = {
    addFamilyHandler,
    getAllFamilyHandler,
    getSpesificFamilyHandler,
    addFamilyMemberHandler,
    deleteFamilyMemberHandler,
    deleteFamilyHandler
}