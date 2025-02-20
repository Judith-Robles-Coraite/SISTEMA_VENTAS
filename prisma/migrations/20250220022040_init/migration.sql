-- CreateTable
CREATE TABLE "Rol" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nombre" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Usuario" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nombre" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "rol_id" INTEGER NOT NULL,
    CONSTRAINT "Usuario_rol_id_fkey" FOREIGN KEY ("rol_id") REFERENCES "Rol" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Mesa" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "numero" INTEGER NOT NULL,
    "estado" TEXT NOT NULL DEFAULT 'LIBRE'
);

-- CreateTable
CREATE TABLE "CategoriaProducto" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nombre" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Producto" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nombre" TEXT NOT NULL,
    "precio" DECIMAL NOT NULL,
    "imagen_url" TEXT,
    "categoria_id" INTEGER NOT NULL,
    "maneja_stock" BOOLEAN NOT NULL DEFAULT false,
    "stock" INTEGER NOT NULL DEFAULT 0,
    "fecha_creacion" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Producto_categoria_id_fkey" FOREIGN KEY ("categoria_id") REFERENCES "CategoriaProducto" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Pedido" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "pedido_padre_id" INTEGER,
    "mesa_id" INTEGER,
    "mesera_id" INTEGER NOT NULL,
    "cajero_id" INTEGER NOT NULL,
    "estado" TEXT,
    "fecha_creacion" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fecha_concluido" DATETIME,
    "total" DECIMAL DEFAULT 0,
    CONSTRAINT "Pedido_pedido_padre_id_fkey" FOREIGN KEY ("pedido_padre_id") REFERENCES "Pedido" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Pedido_mesa_id_fkey" FOREIGN KEY ("mesa_id") REFERENCES "Mesa" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Pedido_mesera_id_fkey" FOREIGN KEY ("mesera_id") REFERENCES "Usuario" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Pedido_cajero_id_fkey" FOREIGN KEY ("cajero_id") REFERENCES "Usuario" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "DetallePedido" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "pedido_id" INTEGER NOT NULL,
    "producto_id" INTEGER NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "precio_unitario" DECIMAL NOT NULL,
    CONSTRAINT "DetallePedido_pedido_id_fkey" FOREIGN KEY ("pedido_id") REFERENCES "Pedido" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "DetallePedido_producto_id_fkey" FOREIGN KEY ("producto_id") REFERENCES "Producto" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Ingreso" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "producto_id" INTEGER NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "fecha_ingreso" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "usuario_id" INTEGER NOT NULL,
    CONSTRAINT "Ingreso_producto_id_fkey" FOREIGN KEY ("producto_id") REFERENCES "Producto" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Ingreso_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "Usuario" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Rol_nombre_key" ON "Rol"("nombre");

-- CreateIndex
CREATE UNIQUE INDEX "Mesa_numero_key" ON "Mesa"("numero");

-- CreateIndex
CREATE UNIQUE INDEX "CategoriaProducto_nombre_key" ON "CategoriaProducto"("nombre");
