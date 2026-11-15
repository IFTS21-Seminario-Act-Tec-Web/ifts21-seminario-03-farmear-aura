import pymysql
from fastapi import APIRouter          

router = APIRouter()  

def conectar():
    return pymysql.connect(
        host="127.0.0.1", port=3306,
        user="root", password="",
        database="farmear_aura", charset="utf8mb4",
        cursorclass= pymysql.cursors.DictCursor,
    )
    

@router.get("/salas")                 
def listar_salas():
    conexion = conectar()                           # 1. abrir la conexión
    try:
        with conexion.cursor() as cursor:           # 2. crear el cursor
            cursor.execute("SELECT * FROM salas")   # 3. ejecutar el SQL
            salas = cursor.fetchall()               # 4. traer todas las filas
        return salas                                # 5. FastAPI lo convierte a JSON
    finally:
        conexion.close()                            # 6. cerrar siempre