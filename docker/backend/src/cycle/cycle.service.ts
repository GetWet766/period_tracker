import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateCycleEntryDto, UpdateCycleEntryDto } from './cycle.dto';

@Injectable()
export class CycleService {
    constructor(private prisma: PrismaService) { }

    async getEntries(userId: string, startDate: string, endDate: string) {
        return this.prisma.cycleEntry.findMany({
            where: {
                userId,
                date: { gte: new Date(startDate), lte: new Date(endDate) },
            },
            orderBy: { date: 'asc' },
        });
    }

    async create(userId: string, dto: CreateCycleEntryDto) {
        try {
            return await this.prisma.cycleEntry.create({
                data: {
                    userId,
                    date: new Date(dto.date),
                    isPeriodDay: dto.isPeriodDay,
                    flowIntensity: dto.flowIntensity,
                    symptoms: dto.symptoms || [],
                    mood: dto.mood,
                    notes: dto.notes,
                },
            });
        } catch {
            throw new ConflictException('Entry already exists for this date');
        }
    }

    async update(userId: string, id: string, dto: UpdateCycleEntryDto) {
        const entry = await this.prisma.cycleEntry.findFirst({ where: { id, userId } });
        if (!entry) throw new NotFoundException('Entry not found');
        return this.prisma.cycleEntry.update({ where: { id }, data: dto });
    }

    async delete(userId: string, id: string) {
        const entry = await this.prisma.cycleEntry.findFirst({ where: { id, userId } });
        if (!entry) throw new NotFoundException('Entry not found');
        await this.prisma.cycleEntry.delete({ where: { id } });
        return { ok: true };
    }
}
