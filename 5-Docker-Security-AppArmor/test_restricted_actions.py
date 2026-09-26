import docker

def main():
    client = docker.from_env()

    # Start a container using the secure-flask image with AppArmor profile
    print("Launching container with AppArmor profile for restriction testing...")
    container = client.containers.run(
        "secure-flask",
        ports={'5000/tcp': 5000},
        security_opt=["apparmor=my-apparmor-profile"],
        detach=True
    )
    print(f"Container started: {container.short_id}\n")

    # Test 1: Attempt to read a sensitive file that should be blocked
    print("Test 1 – Attempting to read /etc/passwd (should be denied)...")
    exit_code, output = container.exec_run("cat /etc/passwd")
    print(f"  Result: Exit Code={exit_code}, Output='{output.decode().strip()}'")

    # Test 2: Attempt to execute a system binary that should be blocked
    print("\nTest 2 – Attempting to execute /bin/bash (should be denied)...")
    exit_code, output = container.exec_run("/bin/bash")
    print(f"  Result: Exit Code={exit_code}, Output='{output.decode().strip()}'\n")

    # Clean up
    print("Stopping and removing the test container...")
    container.stop()
    container.remove()
    print("Done.")

if __name__ == '__main__':
    main()
