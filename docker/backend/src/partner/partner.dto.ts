import { IsString, Length } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class JoinPartnerDto {
    @ApiProperty({ example: 'A1B2C3D4', description: 'Partner invite code' })
    @IsString()
    @Length(8, 8)
    code: string;
}

export class InviteResponse {
    @ApiProperty({ example: 'A1B2C3D4' })
    code: string;

    @ApiProperty({ example: '2024-01-22T12:00:00.000Z' })
    expiresAt: Date;
}

export class PartnerResponse {
    @ApiProperty()
    id: string;

    @ApiPropertyOptional()
    name?: string;

    @ApiProperty({ example: 28 })
    cycleLength: number;

    @ApiProperty({ example: 5 })
    periodDuration: number;
}
