import { IsString, IsOptional, IsInt, IsDateString, Min, Max } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class UpdateUserDto {
    @ApiPropertyOptional({ example: 'Анна' })
    @IsString()
    @IsOptional()
    name?: string;

    @ApiPropertyOptional({ example: '1995-05-15' })
    @IsDateString()
    @IsOptional()
    birthDate?: string;

    @ApiPropertyOptional({ example: 28, minimum: 21, maximum: 35 })
    @IsInt()
    @Min(21)
    @Max(35)
    @IsOptional()
    cycleLength?: number;

    @ApiPropertyOptional({ example: 5, minimum: 3, maximum: 7 })
    @IsInt()
    @Min(3)
    @Max(7)
    @IsOptional()
    periodDuration?: number;
}

export class UserResponse {
    @ApiProperty()
    id: string;

    @ApiProperty()
    email: string;

    @ApiPropertyOptional()
    name?: string;

    @ApiPropertyOptional()
    birthDate?: Date;

    @ApiProperty()
    cycleLength: number;

    @ApiProperty()
    periodDuration: number;

    @ApiPropertyOptional()
    partnerId?: string;

    @ApiProperty()
    createdAt: Date;
}
