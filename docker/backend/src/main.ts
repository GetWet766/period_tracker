import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { AppModule } from './app.module';

async function bootstrap() {
    const app = await NestFactory.create(AppModule);
    app.enableCors();
    app.useGlobalPipes(new ValidationPipe({ whitelist: true, transform: true }));

    const config = new DocumentBuilder()
        .setTitle('Period Tracker API')
        .setDescription('API для отслеживания менструального цикла')
        .setVersion('1.0')
        .addBearerAuth()
        .addTag('Auth', 'Регистрация и авторизация')
        .addTag('User', 'Управление профилем')
        .addTag('Cycle', 'Записи цикла')
        .addTag('Partner', 'Партнёрский доступ')
        .build();

    const document = SwaggerModule.createDocument(app, config);
    SwaggerModule.setup('docs', app, document);

    await app.listen(8080);
}
bootstrap();
