-- CreateEnum
CREATE TYPE "status" AS ENUM ('lesser', 'greater', 'supreme');

-- CreateTable
CREATE TABLE "layer" (
    "numerical_order" SERIAL NOT NULL,
    "amount_of_souls_inside" BIGINT NOT NULL,

    CONSTRAINT "layer_pkey" PRIMARY KEY ("numerical_order")
);

-- CreateTable
CREATE TABLE "demon" (
    "id" SERIAL NOT NULL,
    "full_name" VARCHAR(32) NOT NULL,
    "age" INTEGER NOT NULL,
    "status_a" "status" NOT NULL,

    CONSTRAINT "demon_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "soul" (
    "id" BIGINT NOT NULL,
    "full_name" VARCHAR(32) NOT NULL,

    CONSTRAINT "soul_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sin" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(32) NOT NULL,

    CONSTRAINT "sin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "soul_sin" (
    "soul_id" BIGINT NOT NULL,
    "sin_id" INTEGER NOT NULL,

    CONSTRAINT "soul_sin_pkey" PRIMARY KEY ("soul_id","sin_id")
);

-- CreateTable
CREATE TABLE "punishment" (
    "id" SERIAL NOT NULL,
    "name_of_punishment" VARCHAR(50) NOT NULL,
    "sin_id" INTEGER,
    "is_active" BOOLEAN NOT NULL,
    "performing_demon" INTEGER,

    CONSTRAINT "punishment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "artifact" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "power_level" INTEGER NOT NULL,
    "demon_id" INTEGER,

    CONSTRAINT "artifact_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "sin_name_key" ON "sin"("name");

-- AddForeignKey
ALTER TABLE "soul_sin" ADD CONSTRAINT "soul_sin_sin_id_fkey" FOREIGN KEY ("sin_id") REFERENCES "sin"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "soul_sin" ADD CONSTRAINT "soul_sin_soul_id_fkey" FOREIGN KEY ("soul_id") REFERENCES "soul"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "punishment" ADD CONSTRAINT "punishment_performing_demon_fkey" FOREIGN KEY ("performing_demon") REFERENCES "demon"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "punishment" ADD CONSTRAINT "punishment_sin_id_fkey" FOREIGN KEY ("sin_id") REFERENCES "sin"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "artifact" ADD CONSTRAINT "artifact_demon_id_fkey" FOREIGN KEY ("demon_id") REFERENCES "demon"("id") ON DELETE SET NULL ON UPDATE CASCADE;
