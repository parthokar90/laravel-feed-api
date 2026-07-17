<?php

namespace App\Traits;

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;

trait FileUpload
{
    /**
     * Upload an asset to Supabase S3 bucket and return its full public URL.
     *
     * @param UploadedFile|null $file
     * @param string $folder
     * @return string|null
     */
    public function uploadToSupabase(?UploadedFile $file, string $folder = ''): ?string
    {
        // Return null if no file is provided
        if (!$file) {
            return null;
        }

        // Generate a clean unique filename
        $fileName = time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();
        
        // Define the full path inside the bucket
        $fullPath = $folder ? rtrim($folder, '/') . '/' . $fileName : $fileName;

        // Upload to Supabase using S3 driver
        $uploaded = Storage::disk('s3')->put($fullPath, file_get_contents($file));

        if ($uploaded) {
            // Retrieve configuration values safely
            $s3Url = config('filesystems.disks.s3.url');
            $bucket = config('filesystems.disks.s3.bucket');

            // Construct and return the absolute public URL
            return rtrim($s3Url, '/') . '/' . $bucket . '/' . $fullPath;
        }

        return null;
    }
}