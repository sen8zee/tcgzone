<?php
$pageTitle = "Procurement";
$currentPage = "procurement";

session_start();

if (!isset($_SESSION['admin']) || $_SESSION['admin'] !== true) {
    header("Location: /tcgzone/customer/Login Page/login.html");
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= htmlspecialchars($pageTitle) ?></title>
    <link rel="stylesheet" href="admin-shared.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body>
    <div class="container">
        <?php include 'includes/sidebar.php'; ?>
        <main class="main">
            <?php include 'includes/header.php'; ?>
            <section class="chart-card">
                <h3>Procurement</h3>
                <p>This page is under construction. Procurement workflows will be added here.</p>
            </section>
        </main>
    </div>
</body>
</html>
