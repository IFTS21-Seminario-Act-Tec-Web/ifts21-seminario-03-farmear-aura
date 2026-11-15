"""
Servidor base del proyecto.

En los primeros sprints el sitio puede publicarse como frontend estático.
Cuando se incorpore backend, FastAPI servirá los mismos archivos de /public
y se agregarán routers en /src/routes.

IMPORTANTE PARA CLASE:
StaticFiles se monta al final para no interceptar futuras rutas /api/*.
"""

from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles


<<<<<<< HEAD
from public.assets.fast_api.conexion import router as conexion_router   # ← router

=======
from src.routes.contact import router as contact_router
>>>>>>> feature/prueba

app = FastAPI(
    title="Farmear Aura",
    version="0.1.0",
)


<<<<<<< HEAD

app.include_router(conexion_router, prefix="/api")

=======
app.include_router(contact_router, prefix="/api")


>>>>>>> feature/prueba
# ------------------------------------------------------------
# PRÓXIMO PASO
# Importar aquí los routers creados por el equipo:
#
# from src.routes.reservas import router as reservas_router
# app.include_router(reservas_router, prefix="/api")
#
# Más adelante esos endpoints se conectarán a la base de datos.
# ------------------------------------------------------------

# El frontend se monta ÚLTIMO.
app.mount("/", StaticFiles(directory="public", html=True), name="frontend")
