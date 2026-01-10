import { IsDateString, IsBoolean, IsString, IsArray, IsOptional, IsIn } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateCycleEntryDto {
    @ApiProperty({ example: '2024-01-15' })
    @IsDateString()
    date: string;

    @ApiPropertyOptional({ example: true })
    @IsBoolean()
    @IsOptional()
    isPeriodDay?: boolean;

    @ApiPropertyOptional({ example: 'medium', enum: ['light', 'medium', 'heavy'] })
    @IsString()
    @IsIn(['light', 'medium', 'heavy'])
    @IsOptional()
    flowIntensity?: string;

    @ApiPropertyOptional({ example: ['cramps', 'headache'], type: [String] })
    @IsArray()
    @IsOptional()
    symptoms?: string[];

    @ApiPropertyOptional({ example: 'happy' })
    @IsString()
    @IsOptional()
    mood?: string;

    @ApiPropertyOptional({ example: 'Feeling good today' })
    @IsString()
    @IsOptional()
    notes?: string;
}

export class UpdateCycleEntryDto {
    @ApiPropertyOptional({ example: true })
    @IsBoolean()
    @IsOptional()
    isPeriodDay?: boolean;

    @ApiPropertyOptional({ example: 'heavy', enum: ['light', 'medium', 'heavy'] })
    @IsString()
    @IsIn(['light', 'medium', 'heavy'])
    @IsOptional()
    flowIntensity?: string;

    @ApiPropertyOptional({ example: ['fatigue'], type: [String] })
    @IsArray()
    @IsOptional()
    symptoms?: string[];

    @ApiPropertyOptional({ example: 'tired' })
    @IsString()
    @IsOptional()
    mood?: string;

    @ApiPropertyOptional({ example: 'Updated notes' })
    @IsString()
    @IsOptional()
    notes?: string;
}

export class CycleEntryResponse {
    @ApiProperty()
    id: string;

    @ApiProperty()
    userId: string;

    @ApiProperty()
    date: Date;

    @ApiProperty()
    isPeriodDay: boolean;

    @ApiPropertyOptional()
    flowIntensity?: string;

    @ApiProperty({ type: [String] })
    symptoms: string[];

    @ApiPropertyOptional()
    mood?: string;

    @ApiPropertyOptional()
    notes?: string;

    @ApiProperty()
    createdAt: Date;

    @ApiProperty()
    updatedAt: Date;
}
