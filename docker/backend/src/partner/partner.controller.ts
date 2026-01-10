import { Controller, Post, Get, Delete, Body, UseGuards, Request } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/jwt.guard';
import { PartnerService } from './partner.service';
import { JoinPartnerDto, InviteResponse, PartnerResponse } from './partner.dto';
import { CycleEntryResponse } from '../cycle/cycle.dto';

@ApiTags('Partner')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('partner')
export class PartnerController {
    constructor(private partnerService: PartnerService) { }

    @Post('invite')
    @ApiOperation({ summary: 'Create partner invite code' })
    @ApiResponse({ status: 201, type: InviteResponse })
    createInvite(@Request() req: any) {
        return this.partnerService.createInvite(req.user.id);
    }

    @Post('join')
    @ApiOperation({ summary: 'Join partner using invite code' })
    @ApiResponse({ status: 200, type: PartnerResponse })
    @ApiResponse({ status: 400, description: 'Invalid or expired code' })
    joinPartner(@Request() req: any, @Body() dto: JoinPartnerDto) {
        return this.partnerService.joinPartner(req.user.id, dto.code);
    }

    @Get('calendar')
    @ApiOperation({ summary: 'Get partner cycle calendar' })
    @ApiResponse({ status: 200, type: [CycleEntryResponse] })
    @ApiResponse({ status: 400, description: 'No partner linked' })
    getPartnerCalendar(@Request() req: any) {
        return this.partnerService.getPartnerCalendar(req.user.id);
    }

    @Delete('unlink')
    @ApiOperation({ summary: 'Unlink from partner' })
    @ApiResponse({ status: 200, description: 'Partner unlinked' })
    @ApiResponse({ status: 400, description: 'No partner linked' })
    unlinkPartner(@Request() req: any) {
        return this.partnerService.unlinkPartner(req.user.id);
    }
}
