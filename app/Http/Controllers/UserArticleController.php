<?php

namespace App\Http\Controllers;

use App\Models\Article;
use Illuminate\Http\Request;

class UserArticleController extends Controller
{
    public function index()
    {
        $articles = Article::orderBy('datetime', 'desc')
            ->get(['id', 'title', 'content', 'datetime']);

        return response()->json([
            'status' => true,
            'data'   => $articles
        ]);
    }

    public function show(int $id)
    {
        $article = Article::find($id, ['id', 'title', 'content', 'datetime']);

        if (!$article) {
            return response()->json([
                'status'  => false,
                'message' => 'Article not found'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'data'   => $article
        ]);
    }
} 