const { families } = require('../properties');
const { nanoid } = require('nanoid');

const addRewardsHandler = (request, h) =>{
    const { idFamily } = request.params;
    const { name, description, cost } = request.payload;
    const id = nanoid(16);

    const newRewards = {
        id,
        name,
        description,
        cost
    }

    const checkName = () => {
        if(name !== undefined){
            if(name.length != 0){
                return true;
            }else {
                return false;
            }
        }else{
            return false;
        }
    }

    const checkDesc = () => {
        if(description !== undefined){
            if(description.length != 0){
                return true;
            }else {
                return false;
            }
        }else{
            return false;
        }
    }

    const checkCosts = () =>{
        if(cost !== undefined){
            if(cost >= 0){
                return true;
            }else {
                return false;
            }
        }else{
            return false;
        }
    }

    const selectedFamily = families.filter((family) => family.id === idFamily)[0];

    if(selectedFamily !== undefined){
        if(checkName() && checkDesc() && checkCosts()){
            selectedFamily.rewards.push(newRewards);

            const response = h.response({
                status: 'success',
                message: 'Rewards berhasil dibuat!'
            });
            response.code(201);
            return response;
        }
        if(!checkName()){
            const response = h.response({
                status: 'fail',
                message: 'Rewards gagal dibuat! Mohon masukkan nama dengan benar!'
            });
            response.code(400);
            return response;
        }
        if(!checkDesc()){
            const response = h.response({
                status: 'fail',
                message: 'Rewards gagal dibuat! Mohon masukkan deskripsi dengan benar!'
            });
            response.code(400);
            return response;
        }
        if(!checkCosts()){
            const response = h.response({
                status: 'fail',
                message: 'Rewards gagal dibuat! Mohon masukkan harga dengan benar!'
            });
            response.code(400);
            return response;
        }
        
    }else{
        const response = h.response({
            status: 'fail',
            message: 'Family tidak ditemukan!'
        });
        response.code(404);
        return response;
    }

    const response = h.response({
        status: 'fail',
        message: 'Rewards gagal dibuat!'
    });
    response.code(500);
    return response;
}

const getAllRewardsHandler = (request, h) =>{
    const { idFamily } = request.params;

    const selectedFamily = families.filter((family) => family.id === idFamily)[0];
    if(selectedFamily !== undefined){
        const response = h.response({
            status: 'success',
            data: {
                rewards: selectedFamily.rewards,
            },
        });
        response.code(200);
        return response;
    }else{
        const response = h.response({
            status: 'fail',
            message: 'Family tidak ditemukan!'
        });
        response.code(404);
        return response;
    }
}

const deleteRewardsHandler = (request, h) =>{
    const { idFamily, idReward } = request.params;
    
    const selectedFamily = families.filter((family) => family.id === idFamily)[0];

    if(selectedFamily !== undefined){
        const indexReward = selectedFamily.rewards.findIndex((reward) => reward.id === idReward);
        if(indexReward !== -1){
            selectedFamily.rewards.splice(indexReward, 1);
            const response = h.response({
                status: 'success',
                message: 'Rewards berhasil dihapus!'
            });
            response.code(200);
            return response;
        }else{
            const response = h.response({
                status: 'fail',
                message: 'Rewards tidak ditemukan!'
            });
            response.code(404);
            return response;
        }
    }else{
        const response = h.response({
            status: 'fail',
            message: 'family tidak ditemukan!'
        });
        response.code(404);
        return response;
    }
}

module.exports = {
    addRewardsHandler,
    getAllRewardsHandler,
    deleteRewardsHandler
}