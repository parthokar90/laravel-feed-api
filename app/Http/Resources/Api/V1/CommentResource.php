<?php
namespace App\Http\Resources\Api\V1;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CommentResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        $user = $request->user();
        return [
            'id'            => $this->id,
            'body'          => $this->body,
            'likes_count'   => $this->likes_count,
            'replies_count' => $this->replies_count,
            'created_at'    => $this->created_at->diffForHumans(),
            'is_liked'      => $this->isLikedBy($user),
            'is_owner'      => $user?->id === $this->user_id,
            'user'          => [
                'id'     => $this->user->id,
                'name'   => $this->user->full_name,
                'avatar' => $this->user->avatar ?? null,
            ],
            'replies' => ReplyResource::collection(
                $this->whenLoaded('replies')
            ),
        ];
    }
}