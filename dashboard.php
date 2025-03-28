<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Dashboard</title>

    <!-- Open Sans Font -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <!-- Material Icons -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="grid-container">

        <!-- Header -->
        <header class="header">
            <div class="header-right">
                <div class="dropdown">
                    <button class="btn btn-light dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-person-circle"></i> Username
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                    <li><a class="dropdown-item" href="#" onclick="showContent('profile')"><i class="bi bi-person"></i> My Profile</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="logout.php"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
                    </ul>
                </div>
            </div>
        </header>
        <!-- End Header -->



        <!-- Sidebar -->
        <aside id="sidebar">
            <div class="sidebar-title">
                <div class="sidebar-brand">
                    <span class="material-icons-outlined">mood</span> iBlogger
                </div>
            </div>

            <ul class="sidebar-list">
                <li class="sidebar-list-item active" onclick="showContent('dashboard')">
                    <span class="material-icons-outlined">dashboard</span> Dashboard
                </li>
                <li class="sidebar-list-item" onclick="showContent('blogs')">
                    <span class="material-icons-outlined">article</span> Blogs
                </li>
                <li class="sidebar-list-item" onclick="showContent('category')">
                    <span class="material-icons-outlined">category</span> Category
                </li>
                <li class="sidebar-list-item" onclick="showContent('settings')">
                    <span class="material-icons-outlined">settings</span> Settings
                </li>
            </ul>
        </aside>
        <!-- End Sidebar -->

        <!-- Breadcrumbs (Now Global) -->
        <nav id="breadcrumb-nav" aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="#" onclick="showContent('dashboard')">Dashboard</a>
                </li>
                <li class="breadcrumb-item active" id="breadcrumb-item" aria-current="page">
                    Dashboard
                </li>
            </ol>
        </nav>

        <!-- Main Content -->
        <main class="main-container">
          
            <!-- Dashboard Content -->
            <div id="dashboard-content">
                <div class="main-title"><h3>DASHBOARD</h3></div>

                    <div class="main-cards">

                        <div class="card">
                            <div class="card-inner">
                                <h3>Total Blogs</h3>
                                <span class="material-icons-outlined">article</span> 
                            </div>
                            <h1>4,021</h1>
                        </div>

                        <div class="card">
                            <div class="card-inner">
                                <h3>Active Blogs</h3>
                                <span class="material-icons-outlined">check_circle</span> 
                            </div>
                            <h1>8,731</h1>
                        </div>

                        <div class="card">
                            <div class="card-inner">
                                <h3>Comments</h3>
                                <span class="material-icons-outlined">comment</span>
                            </div>
                            <h1>3,841</h1>
                        </div>

                    </div>

            </div>

            <!-- Blog Management Content -->
            <div id="blogs-content" style="display: none;">
                <div class="main-title"><h3>BLOGS</h3></div>
                <button class="btn-add" onclick="addNewBlog()">Add New Blog</button>
                <table class="blog-table">
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>My First Blog</td>
                            <td>Active</td>
                            <td>
                                <button class="btn-edit">Edit</button>
                                <button class="btn-delete">Delete</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Hidden Add Blog Form -->
            <div id="addBlogForm" style="display: none;">
                <h3>Add New Blog</h3>
                <form id="blogForm">
                    <div class="mb-3">
                        <label for="blogTitle" class="form-label">Blog Title</label>
                        <input type="text" id="blogTitle" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="blogStatus" class="form-label">Status</label>
                        <select id="blogStatus" class="form-control">
                            <option value="Active">Active</option>
                            <option value="Draft">Draft</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-success">Submit</button>
                    <button type="button" class="btn btn-secondary" onclick="cancelAddBlog()">Cancel</button>
                </form>
            </div>

            <!-- Profile Content -->
            <div id="profile-content" style="display: none;">
                <div class="main-title"><h3>MY PROFILE</h3></div>

                <div class="profile-cards">
                    <!-- Profile Overview Card -->
                    <div class="profile-card">
                        <div class="profile-img">
                            <img src="profile.jpg" alt="Profile Image">
                        </div>
                        <div class="profile-info">
                            <h3>Maryam Gul</h3>
                            <p>Email: maryam@example.com</p>
                        </div>
                    </div>

                    <!-- Profile Update Card -->
                    <div class="profile-card">
                        <h3>Update Profile</h3>
                        <form>
                            <div class="form-group">
                                <label for="profileImage">Profile Image</label>
                                <input type="file" id="profileImage" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="updateName">Name</label>
                                <input type="text" id="updateName" class="form-control" value="Maryam Gul">
                            </div>
                            <div class="form-group">
                                <label for="updateEmail">Email</label>
                                <input type="email" id="updateEmail" class="form-control" value="maryam@example.com">
                            </div>
                            <button type="submit" class="btn btn-success">Update</button>
                            <button type="button" class="btn btn-secondary">Cancel</button>
                        </form>
                    </div>

                    <!-- Change Password Card -->
                    <div class="profile-card">
                        <h3>Change Password</h3>
                        <form>
                            <div class="form-group">
                                <label for="currentPassword">Current Password</label>
                                <input type="password" id="currentPassword" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="newPassword">New Password</label>
                                <input type="password" id="newPassword" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="confirmPassword">Confirm New Password</label>
                                <input type="password" id="confirmPassword" class="form-control">
                            </div>
                            <button type="submit" class="btn btn-primary">Save</button>
                            <button type="button" class="btn btn-secondary">Cancel</button>
                        </form>
                    </div>
                </div>
            </div>

        </main>
    </div>

    <script>
        
        function showContent(section) {
            // Hide all sections
            document.getElementById('dashboard-content').style.display = 'none';
            document.getElementById('blogs-content').style.display = 'none';
            document.getElementById('profile-content').style.display = 'none';

            // Show the selected section
            document.getElementById(section + '-content').style.display = 'block';

            // Remove active class from all sidebar items
            let sidebarItems = document.querySelectorAll('.sidebar-list-item');
            sidebarItems.forEach(item => item.classList.remove('active'));

            // Add active class to the selected sidebar item
            let activeItem = document.querySelector(`.sidebar-list-item[onclick="showContent('${section}')"]`);
            if (activeItem) {
                activeItem.classList.add('active');
            }

            // Update breadcrumb dynamically
            let breadcrumbItem = document.getElementById('breadcrumb-item');
            if (section === 'dashboard') {
                breadcrumbItem.innerText = 'Dashboard';
            } else if (section === 'blogs') {
                breadcrumbItem.innerText = 'Blogs';
            } else if (section === 'category') {
                breadcrumbItem.innerText = 'Category';
            } else if (section === 'settings') {
                breadcrumbItem.innerText = 'Settings';
            } else if (section === 'profile') {
                breadcrumbItem.innerText = 'My Profile';
            }
        }



        // SIDEBAR TOGGLE

        let sidebarOpen = false;
        const sidebar = document.getElementById('sidebar');

        function openSidebar() {
            if (!sidebarOpen) {
                sidebar.classList.add('sidebar-responsive');
                sidebarOpen = true;
            }
        }

        function closeSidebar() {
            if (sidebarOpen) {
                sidebar.classList.remove('sidebar-responsive');
                sidebarOpen = false;
            }
        }

        function addNewBlog() {
            // Hide only the "BLOGS" title inside the blogs-content section
            document.querySelector('#blogs-content .main-title').style.display = 'none';

            // Hide "Add New Blog" button and blog table
            document.querySelector('.btn-add').style.display = 'none';
            document.querySelector('.blog-table').style.display = 'none';

            // Show the "Add Blog" form
            document.getElementById('addBlogForm').style.display = 'block';

            // Update breadcrumb
            document.getElementById('breadcrumb-item').innerText = 'Add New Blog';
        }

        function cancelAddBlog() {
            // Show the "BLOGS" title inside the blogs-content section again
            document.querySelector('#blogs-content .main-title').style.display = 'block';

            // Show "Add New Blog" button and blog table again
            document.querySelector('.btn-add').style.display = 'block';
            document.querySelector('.blog-table').style.display = 'table';

            // Hide the "Add Blog" form
            document.getElementById('addBlogForm').style.display = 'none';

            // Reset breadcrumb to "Blogs"
            document.getElementById('breadcrumb-item').innerText = 'Blogs';
        }


    </script>

    <script src="scripts.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
