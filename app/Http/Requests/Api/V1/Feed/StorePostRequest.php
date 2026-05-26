<?php

namespace App\Http\Requests\Api\V1\Feed;

use Illuminate\Foundation\Http\FormRequest;

class StorePostRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true; 
    }

    public function rules(): array
    {
        return [
            'title'      => ['required', 'string', 'max:5000'],
            'visibility' => ['sometimes', 'in:public,private'],
            'images'     => ['required', 'array', 'max:10'],      
            'images.*'   => ['image', 'mimes:jpeg,png,jpg,webp', 'max:5120'], 
        ];
    }

    public function messages(): array
    {
        return [
            'title.required'    => 'Post content is required.',
            'title.max'         => 'Post content cannot exceed 5000 characters.',
            'images.max'        => 'You can upload a maximum of 10 images.',
            'images.*.image'    => 'Each file must be an image.',
            'images.*.mimes'    => 'Images must be jpeg, png, jpg or webp.',
            'images.*.max'      => 'Each image must not exceed 5MB.',
        ];
    }
}