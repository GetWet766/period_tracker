import { Injectable, BadRequestException, NotFoundException } from '@nestjs/common';
import { randomBytes } from 'crypto';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class PartnerService {
    constructor(private prisma: PrismaService) { }

    async createInvite(userId: string) {
        const code = randomBytes(4).toString('hex').toUpperCase();
        const expiresAt = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000);
        await this.prisma.partnerInvite.create({ data: { code, inviterId: userId, expiresAt } });
        return { code, expiresAt };
    }

    async joinPartner(userId: string, code: string) {
        const invite = await this.prisma.partnerInvite.findFirst({
            where: { code: code.toUpperCase(), used: false, expiresAt: { gt: new Date() } },
        });
        if (!invite) throw new BadRequestException('Invalid or expired code');
        if (invite.inviterId === userId) throw new BadRequestException('Cannot join yourself');

        const partner = await this.prisma.user.findUnique({ where: { id: invite.inviterId } });
        if (!partner) throw new NotFoundException('Partner not found');

        await this.prisma.user.update({ where: { id: userId }, data: { partnerId: partner.id } });
        await this.prisma.partnerInvite.update({ where: { id: invite.id }, data: { used: true } });

        return { id: partner.id, name: partner.name, cycleLength: partner.cycleLength, periodDuration: partner.periodDuration };
    }

    async getPartnerCalendar(userId: string) {
        const user = await this.prisma.user.findUnique({ where: { id: userId } });
        if (!user?.partnerId) throw new BadRequestException('No partner linked');
        return this.prisma.cycleEntry.findMany({
            where: { userId: user.partnerId },
            orderBy: { date: 'desc' },
            take: 90,
        });
    }

    async unlinkPartner(userId: string) {
        const user = await this.prisma.user.findUnique({ where: { id: userId } });
        if (!user?.partnerId) throw new BadRequestException('No partner linked');
        await this.prisma.user.update({ where: { id: userId }, data: { partnerId: null } });
        return { ok: true };
    }
}
