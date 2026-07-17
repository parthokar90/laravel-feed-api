<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PostImage extends Model
{
    protected $fillable = ['post_id', 'url', 'key', 'order'];

    public function post()
    {
        return $this->belongsTo(Post::class);
    }
}