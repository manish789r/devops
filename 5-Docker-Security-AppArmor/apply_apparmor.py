import docker

def main():
    client = docker.from_env()

    # Build the Docker image from the current directory
    print("Building Docker image from Dockerfile...")
    client.images.build(path=".", tag="secure-flask")
    print("[INFO] Image 'secure-flask' built successfully.\n")

    # Launch the container with the AppArmor security profile attached
    print("Starting container with AppArmor profile applied...")
    container = client.containers.run(
        "secure-flask",
        ports={'5000/tcp': 5000},
        security_opt=["apparmor=my-apparmor-profile"],
        detach=True
    )
    print(f"Container running with ID: {container.short_id}\n")

    # Inspect the container and confirm AppArmor configuration
    print("Inspecting container security options...")
    container_info = client.api.inspect_container(container.id)
    security_opts = container_info['HostConfig']['SecurityOpt']
    print(f"AppArmor profile applied: {security_opts}\n")

    # Stop and remove the container after verification
    print("Stopping and removing the container...")
    container.stop()
    container.remove()
    print("Container stopped and cleaned up.")

if __name__ == '__main__':
    main()
