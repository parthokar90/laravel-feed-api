<?php

namespace App\Http\Resources\Api\V1;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PostResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'             => $this->id,
            'title'          => $this->title,
            'visibility'     => $this->visibility,
            'likes_count'    => $this->likes_count,
            'comments_count' => $this->comments_count,
            'created_at'     => $this->created_at->diffForHumans(),
            'user'           => [
                'id'     => $this->user->id,
                'name'   => $this->user->first_name,
                'avatar' => $this->user->avatar ?? null,
            ],
            'images' => $this->images->map(fn($img) => [
                'id'    => $img->id,
                'url'   => $img->url,
                'order' => $img->order,
            ]),
            'is_liked' => $this->isLikedBy($request->user()),
            'comments' => CommentResource::collection(
                $this->whenLoaded('comments')
            ),
        ];
    }
}
