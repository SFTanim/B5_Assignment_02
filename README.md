## 01. What is PostgreSQL?
PostgreSQL হচ্ছে অবজেক্ট রিলেশনাল ডাটাবেজ ম্যানেজমেন্ট সিস্টেম (ORDBMS)  যেখানে ডাটা relational + object oriented সিস্টেমে থাকে এবং সেগুলোকে নিয়ে query লিখার মাধ্যমে বিভিন্ন কাজ করা যায়। অবজেক্ট রেলেশনাল ডাটাবেজে একাধিক ডাটাবেজ আর টেবিলের মধ্যে রিলেশন গঠন করা যায় এবং object oriented concept প্রয়োগ করা যায়। এই সিস্টেমটি file based management system - DBMS এবং relational database management system - RDBMS থেকে উন্নত।

## 02. What is the purpose of a database schema in PostgreSQL?
Database schema এর মাধ্যমে ডাটাবেজ এর সকল ডাটা অর্গানাইজ করে রাখা হয় যেমন টেবল, ভিউ, ফাংশন ইত্যাদির মাধ্যমে ডাটাগুলোকে অর্গানাইজ করে রাখা হয় এবং data গুলোর টাইপও সিলেক্ট করে দেয় যাতে efficient হয়, যাতে ডাটাগুলো দিয়ে সহজে রিলেশন তৈরি এবং বিভিন্ন অপারেশন করা যায়। এছাড়াও একই নামের এলিমেন্ট যাতে না থাকতে পারে অর্থাৎ Naming Conflict যাতে না হয় সেটাও ডিফাইন করে।


## 03. Explain the Primary Key and Foreign Key concepts in PostgreSQL.
#### Primary Key:
একটি টেবিলের প্রত্যেকটি row কে আলাদা আলাদাভাবে চিহিন্ত করার জন্য যে unique values  ব্যবহার করা হয়ে সেটাই Primary Key.

Example: (student_id = Primary Key)
| **student\_id** (PK) | name  | major |
| -------------------- | ----- | ----- |
| 1                    | Alice | CS    |
| 2                    | Bob   | Math  |


Example: (course_id = Primary Key)
| **course\_id** (PK) | course\_name |
| ------------------- | ------------ |
| CS101               | Intro to CS  |
| MATH201             | Calculus     |



#### Foreign Key:
যেসব Unique values অন্য টেবিলের Primary Key হয়ে থাকে হয়ে থাকে তাদেরকে Foreign Key বলে। এর মাধ্যমে একটা টেবিলের সাথে আরেকটা টেবিলের রিলেশন তৈরি করা হয়।

Example: (student_id and course_id = Foreign Key)
| **student\_id** (FK) | **course\_id** (FK) | (PK = student\_id + course\_id) |
| -------------------- | ------------------- | ------------------------------- |
| 1                    | CS101               | ✔                               |
| 2                    | MATH201             | ✔                               |



## 04. What is the difference between the VARCHAR and CHAR data types?
VARCHAR, CHAR দুইটাই প্রায় একই ধরনের ডাটা টাইপ কিন্তু প্রয়োগের ক্ষেত্রে বিশেষ করে large scale database এর ক্ষেত্রে দুইটার ব্যবহারই স্থানভেদে গুরুত্বপূর্ণ।

#### VAERCHAR(TotalCharacter) -
এর ক্ষেত্রে Total Character যত দেওয়া হবে সেটাকে maximum ধরে ডাটা ইনপুট নেয়। ইনপুট করা ডাটা এর থেকে বড় হলে ইনপুট হবে না error আসবে কিন্তু ছোট হলে যত character এর ডাটা ততটুকুর জন্যই স্পেস নিবে। তাই আমরা এটা বেশি ব্যবহার করে থাকি name, email, contact, address etc ইনপুট নিতে।

#### CHAR(TotalCharacter) - 
Total Character কে সর্বোচ্চ ধরে রাখে ইনপুট নেয়, ইনপুট করা ডাটা বড় হলে তখন সেটা ইরর নিবে আর ছোট হলে ডাটার character অনুসারে জায়গা নিবে সাথে বাকি খালি জায়গা গুলোতে ব্লাঙ্ক স্পেস দিয়ে রাখে, অর্থাৎ পুরো জায়গাটাই নিয়ে রাখে।
```bash
///// VARCHAR
CREATE TABLE Users (
    name VARCHAR(20)
);
INSERT INTO Users (name) VALUES ('Alice');
// VARCHAR stored value is : 'Alice'


///// CHAR
CREATE TABLE Users (
    code CHAR(8)
);
INSERT INTO Users (code) VALUES ('Fahim');
// Stored value: 'Fahim' +  3 block space
```


## 05. Explain the purpose of the WHERE clause in a SELECT statement.
Where clause দিয়ে আমরা specific রোকে সহজেই identify করতে পারি কন্ডিশন দেওয়ার মাধ্যমে। Where এর পরে অবশ্যই কন্ডিশন বসবে আর কন্ডিশনের উপর ভিত্তি করে output দেখাবে।
```bash
SELECT * FROM person WHERE gender = 'Male';  // gerdger = 'Male' is a condition.
SELECT * FROM users WHERE NOT id = 10; // id = 10 is a condition.
```
```bash
```