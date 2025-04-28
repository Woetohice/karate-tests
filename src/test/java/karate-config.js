function fn() {
    // Helper function to get environment variables with optional default value
    function env(key, defaultValue) {
        var value = java.lang.System.getenv(key);
        return value !== null ? value : defaultValue;
    }

    var envName = karate.env; // get system property 'karate.env'
    karate.log('karate.env system property was:', envName);
    if (!envName) {
        envName = 'local'; // default environment
    }

    // Read environment variables using the helper function
    var baseUrl = env('BASE_URL');
    var apiKey = env('API_KEY');
    var apiSecret = env('API_SECRET');

    var config = {
        env: envName,
        baseUrl: baseUrl || 'http://localhost:3030',
        timeout: 5000
    };

    // Environment specific configurations
    if (envName === 'dev') {
        config.baseUrl = baseUrl || 'https://dev-api.example.com';
    } else if (envName === 'qa') {
        config.baseUrl = baseUrl || 'https://qa-api.example.com';
    } else if (envName === 'prod') {
        config.baseUrl = baseUrl || 'https://api.example.com';
    }

    // Common headers for all requests
    config.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
    };

    // Add API key and secret if they exist
    if (apiKey && apiSecret) {
        config.headers['X-API-Key'] = apiKey;
        config.headers['X-API-Secret'] = apiSecret;
    }

    // Timeout configurations
    karate.configure('connectTimeout', config.timeout);
    karate.configure('readTimeout', config.timeout);

    return config;
} 