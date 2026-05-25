// app/Models/PostImage.php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PostImage extends Model
{
    use HasFactory;

    protected $fillable = ['post_id','url','key','order'];

    public function post()
    {
        return $this->belongsTo(Post::class);
    }
}
