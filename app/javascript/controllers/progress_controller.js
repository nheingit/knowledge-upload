import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="progress"
export default class extends Controller {
    static targets = ["status"]
  connect() {
      this.jobId = this.data.get('job-id')
      this.pollProgress()
  }
    pollProgress() {
        setInterval(() => {
            fetch(`/jobs/progress?job_id=${this.jobId}`)
                .then(response => response.json())
                .then(data => {
                    if (data.status === "complete") {
                      this.statusTarget.textContent = "Processing complete!"
                    } else {
                      this.statusTarget.textContent = data.message
                    }
                })
        }, 1000) // Poll every second
    }
}
