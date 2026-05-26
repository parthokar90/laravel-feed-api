<?php

namespace App\Http\Resources\Api\V1;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class LikeUserResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'     => $this->user->id,
            'name'   => $this->user->first_name,
            'avatar' => $this->user->avatar ?? null,
        ];
    }
}
