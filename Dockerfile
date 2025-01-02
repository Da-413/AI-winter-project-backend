FROM python:3.10-slim

# 필수 라이브러리 설치
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    libnss3 \
    libgconf-2-4 \
    libx11-xcb1 \
    libxcomposite1 \
    libxi6 \
    libxcursor1 \
    libxrandr2 \
    libasound2 \
    libpangocairo-1.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libxdamage1 \
    libxshmfence1 \
    libjpeg-dev \
    libpng-dev \
    chromium-driver \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# FastAPI와 의존성 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 앱 코드 복사
COPY . .

# uvicorn을 사용하여 FastAPI 실행
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
