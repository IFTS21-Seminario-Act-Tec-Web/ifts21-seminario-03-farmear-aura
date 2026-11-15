from fastapi import APIRouter
from pydantic import BaseModel, Field

router = APIRouter()

class ContactIn(BaseModel):
    name: str = Field(min_length=3)
    email: str
    message: str = Field(min_length=10)
    
@router.get("/contact")
async def get_contacts():
    return {"message": "Contactos obtenidos exitosamente"}


# acá se guarda en la base de datos los: nombres, mail, consultas.
@router.post("/contact2")
async def post_contacts(contact: ContactIn):
    
    return {"message": "Contacto recibido", "data": contact}