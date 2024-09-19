WORKDIR /app
EXPOSE 8080
EXPOSE 8081
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["Dockerfile.csproj", "."]
RUN dotnet restore "./Dockerfile.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "./Dockerfile.csproj" -c ${BUILD_CONFIGURATION} -o /app/build
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./Dockerfile.csproj" -c ${BUILD_CONFIGURATION} -o /app/publish /p:UseAppHost=false# Final image with application files
FROM build AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "dotnet-repo.dll"]", "."]
RUN dotnet restore "./Dockerfile.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "./Dockerfile.csproj" -c ${BUILD_CONFIGURATION} -o /app/build
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./Dockerfile.csproj" -c ${BUILD_CONFIGURATION} -o /app/publish /p:UseAppHost=false# Final image with application files
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "dotnet-repo.dll"]
