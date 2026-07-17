<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Post extends Model
{
    use HasFactory, SoftDeletes;

    // Fields that can be mass-assigned
    protected $fillable = [
        'user_id',
        'title',
        'attachment',
        'visibility',
    ];

    // Establish relation with User model
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}