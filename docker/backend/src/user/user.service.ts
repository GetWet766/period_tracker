import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { UpdateUserDto } from './user.dto';

@Injectable()
export class UserService {
    constructor(private prisma: PrismaService) { }

    async update(userId: string, dto: UpdateUserDto) {
        return this.prisma.user.update({
            where: { id: userId },
            data: {
                name: dto.name,
                birthDate: dto.birthDate ? new Date(dto.birthDate) : undefined,
                cycleLength: dto.cycleLength,
                periodDuration: dto.periodDuration,
            },
        });
    }

    findById(id: string) {
        return this.prisma.user.findUnique({ where: { id } });
    }
}
