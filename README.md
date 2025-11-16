# Team Availability Tracker

A web-based application for tracking team member availability across multiple weeks. This application allows you to manage and view team schedules with different status options (Office, Remote, Vacation, etc.) for each day of the week.

## Features

- 📅 **Weekly Schedule Management**: Track availability for up to 52 weeks
- 👥 **Team Member Management**: Manage multiple team members
- 📊 **Status Tracking**: Track various statuses (Office, Remote, Casual, Annual, Sick, Weekend, Vacation)
- 💾 **Data Persistence**: Save and load schedule history
- 🎨 **Color-Coded Interface**: Visual status indicators for easy viewing
- 🐳 **Docker Support**: Containerized for easy deployment
- 🔄 **CI/CD Ready**: Jenkins pipeline included

## Tech Stack

- **Backend**: Node.js, Express.js
- **Frontend**: HTML, CSS, JavaScript (Vanilla)
- **Containerization**: Docker, Docker Compose
- **CI/CD**: Jenkins
- **Data Storage**: JSON files (file-based)

## Prerequisites

- Node.js (v14 or higher) - Optional (if running without Docker)
- Docker and Docker Compose
- Git

## Project Structure

```
TeamavailTest/
├── input/              # Configuration files
│   ├── names.json      # Team member names
│   ├── selection.json  # Available weeks (Week 1-52)
│   └── status.json     # Available status options
├── output/             # Generated data
│   └── history.json    # Saved schedule history
├── public/             # Frontend files
│   ├── index.html
│   ├── script.js
│   └── styles.css
├── scripts/            # Utility scripts
│   ├── run.sh          # Start the application
│   └── stop.sh         # Stop the application
├── Dockerfile          # Docker image definition
├── docker-compose.yml  # Docker Compose configuration
├── Jenkinsfile         # Jenkins CI/CD pipeline
├── package.json        # Node.js dependencies
└── server.js           # Express server
```

## Quick Start

### Option 1: Using Docker Compose (Recommended)

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd TeamavailTest/TeamavailTest
   ```

2. **Start the application**
   ```bash
   ./scripts/run.sh
   ```
   Or manually:
   ```bash
   docker-compose up -d --build
   ```

3. **Access the application**
   Open your browser and navigate to: `http://localhost:3000`

4. **Stop the application**
   ```bash
   ./scripts/stop.sh
   ```
   Or manually:
   ```bash
   docker-compose down
   ```


## Usage

1. **View Schedule**: The application displays a table with all team members and their weekly availability.

2. **Select Week**: Use the dropdown in the "Week" column to select which week you want to view/edit.

3. **Update Status**: Click on any day's dropdown to change the status:
   - **Empty**: No status set
   - **Office**: Working from office
   - **Remote**: Working remotely
   - **Casual**: Casual leave
   - **Annual**: Annual leave
   - **Sick**: Sick leave
   - **Weekend**: Weekend
   - **Vacation**: Vacation

4. **Save Changes**: Click the "Save" button after making changes to persist them to `output/history.json`.

5. **View History**: Previously saved schedules are automatically loaded when you select the corresponding week.

## Configuration

### Adding Team Members

Edit `input/names.json`:
```json
[
  {
    "id": "emp_1",
    "name": "John Doe"
  },
  {
    "id": "emp_2",
    "name": "Jane Smith"
  }
]
```

### Modifying Available Weeks

Edit `input/selection.json`:
```json
[
  "Week 1",
  "Week 2",
  "Week 3"
]
```

### Modifying Status Options

Edit `input/status.json`:
```json
[
  "Empty",
  "Office",
  "Remote",
  "Vacation"
]
```

## Docker Commands

### Build the image
```bash
docker-compose build
```

### Start containers
```bash
docker-compose up -d
```

### Stop containers
```bash
docker-compose down
```

### View logs
```bash
docker-compose logs -f
```

### Rebuild and restart
```bash
docker-compose up -d --build
```

## CI/CD with Jenkins

The project includes a Jenkins pipeline that:
1. Checks out the code
2. Stops existing containers
3. Rebuilds the Docker image (with `--no-cache` for fresh builds)
4. Starts the containers

### Setting up Jenkins

1. **Install Jenkins** (if not already installed)
   ```bash
   # Ubuntu/Debian
   sudo apt update
   sudo apt install jenkins -y
   sudo systemctl start jenkins
   ```

2. **Install required plugins**:
   - Pipeline (usually included by default)
   - Docker Pipeline (optional)

3. **Configure Jenkins job**:
   - Create a new Pipeline job
   - Set "Pipeline script from SCM"
   - Point to your Git repository
   - Set Script Path to: `Jenkinsfile`

4. **Ensure Docker access**:
   ```bash
   sudo usermod -aG docker jenkins
   sudo systemctl restart jenkins
   ```

5. **Run the pipeline**: Click "Build Now" in Jenkins

### Jenkins Pipeline Stages

- **Checkout**: Gets code from Git repository
- **Stop Container**: Stops any running containers
- **Build Image**: Rebuilds Docker image from scratch
- **Run Container**: Starts containers in detached mode

## API Endpoints

- `GET /` - Serves the main application
- `GET /input/*` - Serves input configuration files
- `GET /output/history.json` - Retrieves saved schedule history
- `POST /save-history` - Saves schedule data to `output/history.json`

## Data Storage

The application uses JSON files for data storage:
- **Input data**: Stored in `input/` directory (read-only in container)
- **Output data**: Stored in `output/history.json` (persisted via Docker volumes)

The `history.json` structure:
```json
{
  "emp_1": {
    "Week 1": {
      "Mon": "Office",
      "Tue": "Remote",
      "Wed": "Office",
      "Thu": "Office",
      "Fri": "Remote",
      "Sat": "Weekend",
      "Sun": "Weekend"
    }
  }
}
```

## Environment Variables

- `NODE_ENV`: Set to `production` in docker-compose.yml

## Troubleshooting

### Port 3000 already in use
```bash
# Stop existing containers
docker-compose down

# Or change the port in docker-compose.yml
ports:
  - "3001:3000"  # Use port 3001 instead
```

### Docker permission denied
```bash
sudo usermod -aG docker $USER
# Log out and log back in
```

### Application not loading
- Check if containers are running: `docker-compose ps`
- View logs: `docker-compose logs`
- Verify `input/` directory exists with required JSON files

### Data not persisting
- Ensure `output/` directory exists
- Check Docker volume mounts in `docker-compose.yml`
- Verify write permissions on `output/` directory

### Scripts not executable
```bash
chmod +x scripts/run.sh scripts/stop.sh
```

## Development

### Running in development mode

1. Install dependencies:
   ```bash
   npm install
   ```

2. Start the server:
   ```bash
   npm start
   ```

3. Make changes to files in `public/` or `server.js`

4. Restart the server to see changes

### Project Dependencies

- **express**: ^5.1.0 - Web framework
- **body-parser**: Included with Express - Request body parsing

## Scripts

### run.sh
Starts the application using Docker Compose. Automatically detects whether to use `docker compose` or `docker-compose`.

### stop.sh
Stops all running containers gracefully.

## License

ISC

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## Support

For issues or questions, please open an issue in the repository.

---

**Note**: This application uses file-based storage (JSON files). For production use with multiple users or high availability, consider migrating to a database solution (PostgreSQL, MongoDB, etc.).

