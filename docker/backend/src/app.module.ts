import { Module } from '@nestjs/common';
import { PrismaModule } from './prisma/prisma.module';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import { CycleModule } from './cycle/cycle.module';
import { PartnerModule } from './partner/partner.module';

@Module({
    imports: [PrismaModule, AuthModule, UserModule, CycleModule, PartnerModule],
})
export class AppModule { }
