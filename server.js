const express = require("express");
const mongoose = require("mongoose");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const cors = require("cors");

const app = express();
app.use(express.json());
app.use(cors());

// ✅ MongoDB Connection
mongoose.connect("mongodb://127.0.0.1:27017/swiftride", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// ✅ User Schema
const userSchema = new mongoose.Schema({
  email: { type: String, unique: true },
  password: String,
  role: String, // "driver" or "passenger"
});

const User = mongoose.model("User", userSchema);

// ================= SIGNUP =================
app.post("/signup", async (req, res) => {
  try {
    const { email, password, role } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) return res.status(400).json({ message: "User already exists" });

    const hashedPassword = await bcrypt.hash(password, 10);

    const newUser = new User({ email, password: hashedPassword, role });
    await newUser.save();

    res.json({ message: "User registered successfully" });
  } catch (err) {
    res.status(500).json({ message: "Error: " + err.message });
  }
});

// ================= LOGIN =================
app.post("/login", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) return res.status(400).json({ message: "User not found" });

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ message: "Invalid credentials" });

    const token = jwt.sign({ id: user._id, role: user.role }, "mySecretKey", {
      expiresIn: "1h",
    });

    res.json({ token, role: user.role });
  } catch (err) {
    res.status(500).json({ message: "Error: " + err.message });
  }
});

// ================= PROTECTED TEST API =================
app.get("/profile", (req, res) => {
  const token = req.headers["authorization"];
  if (!token) return res.status(401).json({ message: "No token provided" });

  try {
    const decoded = jwt.verify(token, "mySecretKey");
    res.json({ message: "Profile data access granted", user: decoded });
  } catch (err) {
    res.status(401).json({ message: "Invalid token" });
  }
});

// ================= SERVER RUN =================
app.listen(5000, () => {
  console.log("🚀 Server running on http://localhost:5000");
});
