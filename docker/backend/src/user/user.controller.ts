import { Controller, Put, Body, UseGuards, Request } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/jwt.guard';
import { UserService } from './user.service';
import { UpdateUserDto, UserResponse } from './user.dto';

@ApiTags('User')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('user')
export class UserController {
    constructor(private userService: UserService) { }

    @Put('profile')
    @ApiOperation({ summary: 'Update user profile' })
    @ApiResponse({ status: 200, type: UserResponse })
    @ApiResponse({ status: 401, description: 'Unauthorized' })
    updateProfile(@Request() req: any, @Body() dto: UpdateUserDto) {
        return this.userService.update(req.user.id, dto);
    }
}
