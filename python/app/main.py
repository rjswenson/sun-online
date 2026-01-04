"""
Sun Online AI/ML API
FastAPI server for content processing and transcription.
"""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(
    title="Sun Online AI API",
    description="AI-powered content server for educational archives",
    version="0.1.0"
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Configure appropriately for production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root():
    """API root endpoint."""
    return {
        "service": "Sun Online AI API",
        "version": "0.1.0",
        "status": "running"
    }


@app.get("/health")
async def health():
    """Health check endpoint."""
    return {"status": "healthy"}


@app.post("/api/v1/transcribe")
async def transcribe_content():
    """Transcribe content from archives."""
    return {
        "message": "Transcription endpoint - to be implemented",
        "status": "not_implemented"
    }


@app.post("/api/v1/process")
async def process_content():
    """Process and analyze content."""
    return {
        "message": "Processing endpoint - to be implemented",
        "status": "not_implemented"
    }


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
