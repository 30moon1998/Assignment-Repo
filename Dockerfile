# Use .NET SDK image for building the app
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /app

# Copy .csproj and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the remaining files and build the application
COPY . ./
RUN dotnet publish -c Release -o out

# Use a runtime image for running the app
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build-env /app/out .

# Expose the port app listens on (e.g., 80)
EXPOSE 80

# Run the application
ENTRYPOINT ["dotnet", "dotnet-hello-world.dll"]
