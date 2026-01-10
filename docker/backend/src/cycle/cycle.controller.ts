import { Controller, Get, Post, Put, Delete, Body, Param, Query, UseGuards, Request } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiQuery } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/jwt.guard';
import { CycleService } from './cycle.service';
import { CreateCycleEntryDto, UpdateCycleEntryDto, CycleEntryResponse } from './cycle.dto';

@ApiTags('Cycle')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('cycle')
export class CycleController {
    constructor(private cycleService: CycleService) { }

    @Get('entries')
    @ApiOperation({ summary: 'Get cycle entries for date range' })
    @ApiQuery({ name: 'start_date', example: '2024-01-01' })
    @ApiQuery({ name: 'end_date', example: '2024-01-31' })
    @ApiResponse({ status: 200, type: [CycleEntryResponse] })
    getEntries(@Request() req: any, @Query('start_date') start: string, @Query('end_date') end: string) {
        return this.cycleService.getEntries(req.user.id, start, end);
    }

    @Post('entries')
    @ApiOperation({ summary: 'Create new cycle entry' })
    @ApiResponse({ status: 201, type: CycleEntryResponse })
    @ApiResponse({ status: 409, description: 'Entry already exists for this date' })
    create(@Request() req: any, @Body() dto: CreateCycleEntryDto) {
        return this.cycleService.create(req.user.id, dto);
    }

    @Put('entries/:id')
    @ApiOperation({ summary: 'Update cycle entry' })
    @ApiResponse({ status: 200, type: CycleEntryResponse })
    @ApiResponse({ status: 404, description: 'Entry not found' })
    update(@Request() req: any, @Param('id') id: string, @Body() dto: UpdateCycleEntryDto) {
        return this.cycleService.update(req.user.id, id, dto);
    }

    @Delete('entries/:id')
    @ApiOperation({ summary: 'Delete cycle entry' })
    @ApiResponse({ status: 200, description: 'Entry deleted' })
    @ApiResponse({ status: 404, description: 'Entry not found' })
    delete(@Request() req: any, @Param('id') id: string) {
        return this.cycleService.delete(req.user.id, id);
    }
}
