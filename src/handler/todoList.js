const { families, users } = require('../properties');
const { nanoid } = require('nanoid');

const addNotesHandler = (request, h) => {
    const { id } = request.params;
    const { title, description, points, idUser } = request.payload;
    const idNote = nanoid(16);
    const status = 'assigned';
    const assigner = [];

    const newNotes = {
        id: idNote,
        idUser,
        title,
        description,
        points,
        status,
        assigner
    }

    const checkTitle = () => {
        if(title !== undefined){
            if(title.length != 0){
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

    const checkPoints = () =>{
        if(points !== undefined){
            if(points >= 0){
                return true;
            }else {
                return false;
            }
        }else{
            return false;
        }
    }

    const indexFamily = families.findIndex((family) => family.id === id);

    if (indexFamily !== -1){
        if(checkTitle() && checkDesc() && checkPoints()){
            
            families.at(indexFamily).notes.push(newNotes);

            const response = h.response({
                status: 'success',
                message: 'Notes berhasil dibuat!'
            });
            response.code(201);
            return response;
        }
        if(!checkTitle()){
            const response = h.response({
                status: 'fail',
                message: 'Notes gagal dibuat! Mohon masukkan title dengan benar!'
            });
            response.code(400);
            return response;
        }
        if(!checkDesc()){
            const response = h.response({
                status: 'fail',
                message: 'Notes gagal dibuat! Mohon masukkan Deskripsi dengan benar!'
            });
            response.code(400);
            return response;
        }
        if(!checkPoints()){
            const response = h.response({
                status: 'fail',
                message: 'Notes gagal dibuat! Mohon masukkan Points dengan benar!'
            });
            response.code(400);
            return response;
        }
    }

    const response = h.response({
        status: 'error',
        message: 'Gagal membuat notes!'
    });
    response.code(500);
    return response;
}

const takeNotesHandler = (request, h) => {
    const { id, idNotes } = request.params;
    const { idMember } = request.payload;

    const newAssigner = {
        id: idMember
    }

    const newTakeNote = {
        idNotes
    }

    const indexFamily = families.findIndex((family) => family.id === id);

    const indexUser = users.findIndex((user) => user.id === idMember);

    const selectedNote = families.at(indexFamily).notes.findIndex((note) => note.id === idNotes);

    if(indexFamily !== -1 && selectedNote !== -1){
        families.at(indexFamily).notes.at(selectedNote).assigner.push(newAssigner);
        users.at(indexUser).notes.push(newTakeNote);

        const response = h.response({
            status: 'success',
            message: 'Berhasil mengambil kegiatan!'
        });
        response.code(201);
        return response;
    }

    if(indexFamily === -1){
        const response = h.response({
            status: 'error',
            message: 'Gagal mengambil kegiatan! ID Family tidak ditemukan!'
        });
        response.code(404);
        return response;
    }

    if(selectedNote === -1){
        const response = h.response({
            status: 'error',
            message: 'Gagal mengambil kegiatan! ID Kegiatan tidak ditemukan!'
        });
        response.code(404);
        return response;
    }

    const response = h.response({
        status: 'error',
        message: 'Gagal mengambil kegiatan!'
    });
    response.code(500);
    return response;
}

const doneNotesHandler = (request, h)=> {
    const { id, idNotes } = request.params;
    const { idUser } = request.payload;

    const indexFamily = families.findIndex((family) => family.id === id);

    const selectedNote = families.at(indexFamily).notes.findIndex((note) => note.id === idNotes && note.idUser === idUser);

    const theNote = families.at(indexFamily).notes;

    const status = "done";

    if (selectedNote !== -1){
        theNote[selectedNote] = {
            ...theNote[selectedNote],
            status
        }
    
        theNote.map((note) => note.assigner.map((assign) => {
            users.map((user) =>{
                if(user.id === assign.id){
                    user.point += note.points;
                }
            })
        }));
        
        const response = h.response({
            status: 'success',
            message: 'Berhasil menyelesaikan kegiatan!'
        });
        response.code(200);
        return response;
    }

    const response = h.response({
        status: 'error',
        message: 'Gagal menyelesaikan kegiatan!'
    });
    response.code(500);
    return response;
}

const getNotesHandler = (request, h) => {
    const { id } = request.params;
    const { status } = request.query;

    const indexFamily = families.findIndex((family) => family.id === id);
    

    if(status !== undefined){
        const notesByStatus = families.at(indexFamily).notes.filter((note) => note.status === status);
        const response = h.response({
            status: 'success',
            data: {
                notes: notesByStatus.map((note) => ({
                    id: note.id,
                    idUser: note.idUser,
                    title: note.title,
                    description: note.description,
                    points: note.points
                }))
            }
        });
        response.code(200);
        return response;
    }
    const allNotes = families.at(indexFamily).notes;
    const response = h.response({
        status: 'success',
        data: {
            notes: allNotes.map((note) => ({
                id: note.id,
                idUser: note.idUser,
                title: note.title,
                description: note.description,
                points: note.points
            }))
        }
    });
    response.code(200);
    return response;
}

module.exports = {
    addNotesHandler,
    takeNotesHandler,
    doneNotesHandler,
    getNotesHandler
}