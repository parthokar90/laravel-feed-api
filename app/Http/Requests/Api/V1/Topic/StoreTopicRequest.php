<?php

namespace App\Http\Requests\Api\V1\Topic;

use Illuminate\Foundation\Http\FormRequest;

class StoreTopicRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'category_id' => 'required|exists:categories,id', 
            'title'       => 'required|string|max:255',
            'description'     => 'nullable|string',
        ];
    }
}
