cat << 'EOF' > db/schema.sql
CREATE DATABASE IF NOT EXISTS toeic_learning_system;
USE toeic_learning_system;

-- 1. 親文章テーブル
CREATE TABLE IF NOT EXISTS passages (
    passage_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    part_type INT NOT NULL,
    passage_body TEXT NOT NULL
);

-- 2. 設問テーブル
CREATE TABLE IF NOT EXISTS questions (
    question_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    passage_id BIGINT,
    part_type INT NOT NULL,
    question_text TEXT NOT NULL,
    option_a VARCHAR(255) NOT NULL,
    option_b VARCHAR(255) NOT NULL,
    option_c VARCHAR(255) NOT NULL,
    option_d VARCHAR(255) NOT NULL,
    correct_answer CHAR(1) NOT NULL,
    explanation TEXT,
    FOREIGN KEY (passage_id) REFERENCES passages(passage_id)
);

-- 3. 練習履歴テーブル
CREATE TABLE IF NOT EXISTS learning_history (
    history_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    question_id BIGINT NOT NULL,
    user_answer CHAR(1) NOT NULL,
    is_correct BOOLEAN DEFAULT NULL, -- true,false,NULLで正誤と未回答判定
    answered_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    answer_time_seconds INT,
    FOREIGN KEY (question_id) REFERENCES questions(question_id)
);

-- 4. 模試結果テーブル
CREATE TABLE IF NOT EXISTS mock_exam_results (
    mock_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    total_questions INT NOT NULL DEFAULT 100,
    answered_count INT NOT NULL,
    correct_count INT NOT NULL,
    incorrect_count INT NOT NULL,
    unanswered_count INT NOT NULL
);
EOF
