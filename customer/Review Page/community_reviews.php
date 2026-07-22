<?php
session_start();
$isLoggedIn = isset($_SESSION['user_id']);

require '../../config/db_connect.php';

$selectedRating = isset($_GET['rating']) ? (int)$_GET['rating'] : 0;
if ($selectedRating < 1 || $selectedRating > 5) {
    $selectedRating = 0;
}

$sql = "SELECT name, rating, review_text, created_at FROM reviews";
$params = [];

if ($selectedRating > 0) {
    $sql .= " WHERE rating = ?";
    $params[] = $selectedRating;
}

$sql .= " ORDER BY created_at DESC, id DESC";

$stmt = $conn->prepare($sql);

if ($selectedRating > 0) {
    $stmt->bind_param('i', $selectedRating);
}

$stmt->execute();
$result = $stmt->get_result();
$reviews = $result->fetch_all(MYSQLI_ASSOC);

function renderReviewRatings(int $rating): string {
    $safeRating = max(1, min(5, $rating));
    $icons = '';

    for ($i = 0; $i < 5; $i++) {
        $icon = $i < $safeRating ? 'poke-open.svg' : 'poke-close.svg';
        $icons .= '<img src="/tcgzone/assets/logos/review/' . $icon . '" alt="Pokeball" class="review-rating-icon">';
    }

    return $icons;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/tcgzone/bootstrap/bootstrap-5.3.8-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/tcgzone/assets/css/shared.css">
    <link rel="stylesheet" href="community_reviews.css">
    <link rel="icon" type="image/svg" href="/tcgzone/assets/logos/logo/transparent-image.png">
    <title>Community Reviews - TCGZONE</title>
</head>
<body class="community-reviews-page">
    <nav class="navbar">
        <div class="nav-top">
            <div class="logo col-auto">
                <h1><a href="/tcgzone/customer/Landing Page/index.php">tcgzone</a></h1>
            </div>
            <div class="search col-11 col-sm-6 col-md-5">
                <input class="search-input" type="text">
                <img src="/tcgzone/assets/logos/navbar/magnifying-glass.svg" alt="Search Icon">
            </div>
            <ul class="nav-links col-auto">
                <?php if (!$isLoggedIn): ?>
                <li><a href="/tcgzone/customer/Login Page/login.html">Sign In</a></li>
                <?php endif; ?>
                <div class="btn-logo">
                    <li><a href="<?= $isLoggedIn ? '/tcgzone/customer/Account/account.php' : '/tcgzone/customer/Login Page/login.html' ?>"><img src="/tcgzone/assets/logos/navbar/user.svg" alt="Account" class="nav-icon"></a></li>
                </div>
                <div class="btn-logo">
                    <li><a href="<?= $isLoggedIn ? '/tcgzone/customer/Shopping Cart Page/shopping-cart.php' : '/tcgzone/customer/Login Page/login.php' ?>"> <img src="/tcgzone/assets/logos/navbar/shopping-cart.svg" class="nav-icon" alt="Shopping Cart"></a></li>
                </div>
            </ul>
        </div>

        <div class="nav-bottom">
            <ul class="sub-links">
                <li><a href="/tcgzone/customer/Shop Page/shop.php">Shop</a></li>
                <li>|</li>
                <li><a href="#" class="category"><span>Pokémon</span></a></li>
                <li><a href="#" class="category"><span>Magic</span></a></li>
                <li><a href="#" class="category"><span>One Piece</span></a></li>
                <li><a href="#">My Orders</a></li>
            </ul>
        </div>
    </nav>

    <main class="reviews-shell">
        <div class="page-header">
            <div>
                <p class="eyebrow">Collector community</p>
                <h1>Community Reviews</h1>
                <p class="page-description">Thoughts from collectors who have shopped with TCGZONE.</p>
            </div>
            <a href="/tcgzone/customer/Review Page/review.php" class="btn-review">Leave a review!</a>
        </div>

        <div class="rating-filter-bar" aria-label="Filter reviews by rating">
            <span class="filter-label">Filter ratings</span>
            <div class="filter-actions">
                <a class="filter-chip<?= $selectedRating === 0 ? ' active' : '' ?>" href="community_reviews.php">All</a>
                <?php for ($rating = 5; $rating >= 1; $rating--): ?>
                    <a class="filter-chip<?= $selectedRating === $rating ? ' active' : '' ?>" href="community_reviews.php?rating=<?= $rating ?>" aria-label="Show <?= $rating ?> Pokéball reviews">
                        <?php for ($icon = 0; $icon < $rating; $icon++): ?>
                            <img src="/tcgzone/assets/logos/review/poke-open.svg" alt="Pokéball">
                        <?php endfor; ?>
                    </a>
                <?php endfor; ?>
            </div>
        </div>

        <?php if (empty($reviews)): ?>
            <div class="empty-state">
                <img src="/tcgzone/assets/images/landing page/image 17.png" alt="No reviews yet">
                <p>No reviews yet. Be the first to share your experience.</p>
            </div>
        <?php else: ?>
            <div class="review-grid">
                <?php foreach ($reviews as $review): ?>
                    <?php $reviewText = htmlspecialchars($review['review_text'], ENT_QUOTES, 'UTF-8'); ?>
                    <article class="review-card" data-name="<?= htmlspecialchars($review['name'] ?: 'Anonymous', ENT_QUOTES, 'UTF-8') ?>" data-rating="<?= (int)$review['rating'] ?>" data-text="<?= $reviewText ?>" data-date="<?= date('M j, Y', strtotime($review['created_at'])) ?>">
                        <div class="review-avatar-wrap">
                            <img src="/tcgzone/assets/images/landing page/image 17.png" alt="Reviewer avatar">
                        </div>
                        <h2 class="review-name">
                            <?= htmlspecialchars($review['name'] ?: 'Anonymous', ENT_QUOTES, 'UTF-8') ?>
                        </h2>
                        <div class="review-rating" aria-label="<?= (int)$review['rating'] ?> out of 5 pokeballs">
                            <?= renderReviewRatings((int)$review['rating']) ?>
                        </div>
                        <p class="review-text">“<?= $reviewText ?>”</p>
                        <p class="review-meta">
                            <?= date('M j, Y', strtotime($review['created_at'])) ?>
                        </p>
                    </article>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </main>

    <footer class="site-footer">
        <div class="footer-main">
            <div class="footer-col footer-brand">
                <h2 class="footer-logo"><a href="/tcgzone/customer/Landing Page/index.php">tcgzone</a></h2>
                <p class="footer-tagline">Elevate your collection.</p>
            </div>

            <div class="footer-col footer-links">
                <h3 class="footer-heading">Quick Links</h3>
                <ul>
                    <li><a href="/tcgzone/customer/Shop Page/shop.php">Buy Card</a></li>
                    <li><a href="/tcgzone/customer/Footer Additional Page/about_us.php">About us</a></li>
                    <li><a href="/tcgzone/customer/Footer Additional Page/contacts.html">Contact</a></li>
                </ul>
            </div>

            <div class="footer-col footer-links">
                <h3 class="footer-heading">Policy</h3>
                <ul>
                    <li><a href="/tcgzone/customer/Footer Additional Page/terms_condition.html">Terms &amp; Conditions</a></li>
                    <li><a href="/tcgzone/customer/Footer Additional Page/privacy.html">Privacy Policy</a></li>
                </ul>
            </div>

            <div class="footer-col footer-socials">
                <h3 class="footer-heading">Socials</h3>
                <div class="social-icons">
                    <div class="link-container">
                        <a href="https://www.x.com/"><img src="/tcgzone/assets/logos/footer/x-logo.svg" alt="X"></a>
                    </div>
                    <div class="link-container">
                        <a href="https://www.facebook.com/"><img src="/tcgzone/assets/logos/footer/facebook-logo.svg" alt="Facebook"></a>
                    </div>
                    <div class="link-container">
                        <a href="https://www.instagram.com/" target="_blank"><img src="/tcgzone/assets/logos/footer/instagram-logo.svg" alt="Instagram"></a>
                    </div>
                </div>
            </div>
        </div>

        <div class="footer-bottom">
            <p>&copy; 2026 tcgzone - All Rights Reserved</p>
        </div>
    </footer>

    <div class="review-modal" id="reviewModal" aria-hidden="true">
        <div class="review-modal-backdrop" data-close-modal></div>
        <div class="review-modal-dialog" role="dialog" aria-modal="true" aria-labelledby="reviewModalTitle">
            <button class="review-modal-close" type="button" aria-label="Close review" data-close-modal>&times;</button>
            <div class="review-modal-content">
                <div class="review-modal-avatar">
                    <img src="/tcgzone/assets/images/landing page/image 17.png" alt="Reviewer avatar">
                </div>
                <h3 id="reviewModalTitle" class="review-modal-title"></h3>
                <div id="reviewModalStars" class="review-modal-stars"></div>
                <p id="reviewModalText" class="review-modal-text"></p>
                <p id="reviewModalDate" class="review-modal-date"></p>
            </div>
        </div>
    </div>

    <script src="/tcgzone/bootstrap/bootstrap-5.3.8-dist/js/bootstrap.min.js"></script>
    <script src="/tcgzone/assets/js/shared/shared.js"></script>
    <script>
        const reviewCards = document.querySelectorAll('.review-card');
        const reviewModal = document.getElementById('reviewModal');
        const reviewModalTitle = document.getElementById('reviewModalTitle');
        const reviewModalStars = document.getElementById('reviewModalStars');
        const reviewModalText = document.getElementById('reviewModalText');
        const reviewModalDate = document.getElementById('reviewModalDate');

        function renderStars(rating) {
            const safeRating = Math.max(1, Math.min(5, Number(rating) || 0));
            return '★'.repeat(safeRating) + '☆'.repeat(5 - safeRating);
        }

        function openReviewModal(card) {
            if (!reviewModal) return;
            reviewModalTitle.textContent = card.dataset.name || 'Anonymous';
            reviewModalStars.textContent = renderStars(card.dataset.rating || 0);
            reviewModalText.textContent = card.dataset.text || '';
            reviewModalDate.textContent = card.dataset.date || '';
            reviewModal.classList.add('open');
            reviewModal.setAttribute('aria-hidden', 'false');
            document.body.classList.add('modal-open');
        }

        function closeReviewModal() {
            if (!reviewModal) return;
            reviewModal.classList.remove('open');
            reviewModal.setAttribute('aria-hidden', 'true');
            document.body.classList.remove('modal-open');
        }

        reviewCards.forEach((card) => {
            card.addEventListener('click', () => openReviewModal(card));
            card.addEventListener('keydown', (event) => {
                if (event.key === 'Enter' || event.key === ' ') {
                    event.preventDefault();
                    openReviewModal(card);
                }
            });
            card.setAttribute('tabindex', '0');
            card.style.cursor = 'pointer';
        });

        document.querySelectorAll('[data-close-modal]').forEach((element) => {
            element.addEventListener('click', closeReviewModal);
        });

        reviewModal?.addEventListener('click', (event) => {
            if (event.target === reviewModal) {
                closeReviewModal();
            }
        });

        document.addEventListener('keydown', (event) => {
            if (event.key === 'Escape') {
                closeReviewModal();
            }
        });
    </script>
</body>
</html>
