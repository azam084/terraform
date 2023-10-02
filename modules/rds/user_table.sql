-- Create the users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Insert sample user data
INSERT INTO users (username, password) VALUES
    ('azam', 'password1'),
    ('john', 'password2'),
    ('mona', 'password3');
