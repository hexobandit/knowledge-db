# Example Mermaid Threat Model
## Simple Mermaid Threat Model for Web Apps with IdP, WAF, API, and DB

This threat model should serve as a starting point for any security review for applications using Identity Provider (IdP) authentication, Web Application Firewall (WAF), an API backend, and a database. It ensures secure authentication, protected API communications, and controlled data access. This model serves as a starting point for designing similar architectures.

🛠 Architecture Overview
- User → Client (Browser): End-user interacts with the frontend application.
- Client → IdP (Auth0): OAuth2 with PKCE secures authentication.
- Client → WAF (Cloudflare): Protects against common web threats.
- WAF → Reverse Proxy: Handles API traffic filtering.
- Reverse Proxy → API (Flask): Processes business logic and connects to the database.
- API → Database (SQL): Stores and retrieves application data.

## Tools Used
- [SimpleMermaid.com](https://SimpleMermaid.com)
- [ThreatBandit.com](https://ThreatBandit.com)

## Mermaid Diagram
```mermaid
flowchart LR
    user(user)
    client((client/browser))
    idp((IdP Auth0))
    waf((WAF Cloudlfare))
    proxy((reverse proxy))
    api((Flask App))
    db[|borders:tb|SQL database]
    user--personal data-->client
    client--HTTPS/Oath2+PKCE-->idp
    idp--HTTP/JWT-->client
    client--HTTPS/JWT-->waf
    subgraph external [Internet]
        waf
        idp
    end
    subgraph internal [Internal Network]
        waf--HTTPS/JWT-->proxy
        proxy--HTTPS/JWT-->api
        subgraph k8s [Kubernetes]
            api
        end
        db--TCP/IP-->api
        api--TCP/IP-->db
    end
    classDef boundary fill:none,stroke-dasharray: 5 5
    external:::boundary
    internal:::boundary
    k8s:::boundary
    
```

## Next Steps
- Think of logging
- Think of weak OAuth2 flows
- Think of input validations and parameterized queries
- Think of rate-limitting 
- Think of kubernetes infra threats
- TLS 1.2 or 1.3 everywhere
- Think of least privilege access for API to DB interactions
- And many many more... 👀

