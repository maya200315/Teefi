<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use App\Models\Article;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ArticleController extends Controller
{
    // GET /api/articles
    public function index()
    {
        $articles = Article::with('user')
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json([
            'status' => true,
            'data' => $articles
        ], 200);
    }

    // GET /api/articles/{id}
    public function show(int $id)
    {
        $article = Article::with('user')->find($id);

        if (!$article) {
            return response()->json([
                'status' => false,
                'message' => 'Article not found'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'data' => $article
        ], 200);
    }
    
    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'content' => 'required|string',
            'datetime' => 'required|date',
        ]);

        $article = Article::create([
            'title' => $validated['title'],
            'content' => $validated['content'],
            'datetime' => $validated['datetime'],
            'Userid' => Auth::id(),
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Article created successfully',
            'data' => $article
        ], 201);
    }
    
    // PUT /api/articles/{id}
    public function update(Request $request, int $id)
    {
        $article = Article::find($id);

        if (!$article) {
            return response()->json([
                'status' => false,
                'message' => 'Article not found'
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'title'    => 'sometimes|string|max:255',
            'content'  => 'sometimes|string',
            'datetime' => 'sometimes|date',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $article->update($request->only(['title', 'content', 'datetime']));

        return response()->json([
            'status'  => true,
            'message' => 'Article updated successfully',
            'data'    => $article
        ], 200);
    }

    // DELETE /api/articles/{id}
    public function destroy(int $id)
    {
        $article = Article::find($id);

        if (!$article) {
            return response()->json([
                'status' => false,
                'message' => 'Article not found'
            ], 404);
        }

        $article->delete();

        return response()->json([
            'status'  => true,
            'message' => 'Article deleted successfully'
        ], 200);
    }
}
