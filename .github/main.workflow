workflow "build" {
  on = "push"
  push:
    branches:
    - master
  jobs:
    my_first_job:
      name: My first job
      runs-on: macOS-10.14
      steps:
        - name: My first step
            uses: 
            env:
              GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        - name: Install Dependencies
            run: brew install hugo
}
