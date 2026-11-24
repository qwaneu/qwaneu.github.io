## Cloud Native Attitude (2025)

> "Cloud native is the name of a particular approach to designing, building and running applications based on the cloud 
(infrastructure as a service, IaaS) or platform as a service (PaaS)."

> "the overall objective of a cloud native approach is to improve speed, scalability and finally margin"

- **speed**:
  - innovate quickly; get ideas to market fast (months → days/hours)
  - big bang projects→ incremental improvements
  - " a cloud native approach is about de-risking as well as accelerating change"
  - TTV - time to value (value != revenue)
- **scale**:
  - increasing users, locations, devices, while maintaining responsiveness, costs, not falling over (stability)
- **margin**:
  - spending: from upfront capital expenditure to operational expenditure
  - "a cloud native strategy is about handling technical risk"
  - "the cloud native approach is about moving quickly by taking small, reversible and low-risk steps"
  - "it's easy to spend money in the cloud"

"Cloud nativeness" is a spectrum.

Cloud native is more of an attitude (move faster without breaking things): "Adopting a cloud native attitude seems to mean evolving into a flexible business that embraces new technology, trusts its employees’ judgement and is culturally able to move quickly, be experimental and grasp opportunities."

5 architectural principles

1. Use **IAAS** or **PAAS** (public cloud, in-house)
2. **Design systems using, or evolve them towards, a microservices architecture** - small, decoupled components; 
   independently deployable
   a. [so this is about managing coupling at systems landscape level]
   b. [microservices is an overloaded/dangerous term; it's not about 'small'/'micro']
3. **Automate & encode**
4. **Containerise** - package processes with their dependencies; making them easy to test/move/deploy
5. **Orchestrate** - abstract away individual servers

Cloud Native is ultimately about risk reduction
- "We believe that cloud native is a technique that marries application architecture and operational architecture"
- fast access to flexible, virtual resources → **lowering infrastructure planning risk** 
- **lower cost of entry and exit** for projects (CAPEX → OPEX); minimise sunk costs
- "access to cloud-hosted, managed services (...) makes it faster and easier to develop more sophisticated new 
  products, which can help identify opportunities more quickly and **reduce the risks of experimentation**."

Types of business
- the start-up
  - experimenting with business model; exploratory;
  - needs:
    - avoid risky upfront capital expenditure
    - speed of iteration
  - **assumption: being able to update software at will**
- the scale-up
  - needs:
    - grow fast, have systems grow alongside
    - size + resilience + response times
- the enterprise
  - needs:
    - grip on costs - grow customer base while remaining profitable

Containers/containerisation
- standardised application packaging
- lightweight isolation
- standardised application control interface
- immutable infrastructure

Orchestration / dynamic management
- "The basic idea of any orchestrator (VM or container) is that (...) we can just set high-level directives and let the 
orchestrator worry about what’s happening on any particular server."
- expect: many more containers than VMs
- purpose of dynamic management: automate data centres; container orchestrators leverage standardisation

Microservices
- motivation: easier to develop; more robust & scalable; cheaper to operate and support
- stateless vs stateful
  - stateful: have data in database; preferably no sharing of db
  - stateless: request → response;
- how do microservices support cloud native goals?
  - *speed* - reduce conflicts between teams; reduce inter-team communication (unless you change the API)
  - *scale* - self-contained nature of microservices support horizontal scaling; this can also provide resilience; 
    enabler for geographically dispersed users
  - *margin* - enable splitting out resource-intensive parts; more hosting options → helps cut costs
- disadvantages
  - not trivial to deliver
  - more & more interesting failure modes
  - needs careful consideration of boundaries (cohesion, coupling, information hiding)
- microservice/monolith
  - ability to start & stop fast is important
- size of microservice?
  - e.g. one service per team - reasonable way to start
  - "We like the model of gradually breaking down services further as needed to avoid development conflicts."
- how much freedom / constraints?
  - many microservices means diversity (e.g. different stacks); can lead to extra complexity; having some contraints 
    and commonality can help reduce this complexity
- security
  - splitting up in services allows for separation of highly sensitive/critical and less sensitive data & processes
  - increased attack surface
  - more commonality is easier to secure; more diversity reduces the impact of e.g. an exploit

Continuous Delivery [process]
- batching → (even more) delays
- slowness breeds slowness
- slowness → big gamble (increasing risk)
- needs:
  - automated tests (without manual intervention)
  - CI/CD tools can help

Moving to Cloud Native
- legacy monolith options:
  - wrap monolith in container
  - API first approach - spit in stateless frontend & stateful backend with clear API
  - break up monolith in components

Distributed systems
- Anything that can go wrong, will go wring
- two modes of message passing:
  - reliable & slow; involves latency and extra work; (at least once)
  - unreliable & fast; can be used e.g. for time sensitive messages or when later data overwrites earlier data - need 
    to design to cope with loss and duplication
- time - there is no global clock; usually no guaranteed order
- no global memory / no single version of the truth; service could het 'old'/inconsistent information
- message passing between services is slow (compared to in-process communication) - options: send fewer messages; 
  consider sending messages more efficiently
- testing to destruction

Sustainability
- building sustainable/green software:
  - software efficiency
  - hosting efficiency
  - carbon awareness
- public cloud handles these vastly better than on-premise data centres
- location (of DC) matters; consider sustainability information when considering a region
- scale matters; managed services / commoditisation helps;
  - increase in efficiency leads to increasing demand (leading to more rather than less usage) → Jevons paradox
- renewable power → supply & price fluctuates; does not play nicely with heavyweight always-on services; works well 
  with systems that can delay work - demand shifting

Some highlights from case studies
- FT:
  - infrastructure as code
  - moving to faster deployments reduced deployment rollback rate from 20% to 0,1%
  - used async queues heavily
  - "This strong ownership is tracked in the FT’s Biz Ops tool, an internal system that has allowed us to keep track of 
    a graph of information about our services. This includes teams, systems, repositories, AWS resources, incidents – any information that provides value can be added into the graph."
  - complex landscape, 1000s services, high variation in languages + tooling → set up engineering enablement group
- Skyscanner
  - heavy use of AWS spot instances → 70% cloud hosting bill reduction
  - CN/AWS: enabler for scalability
  - introduction of K8S took more than 2 years
  - now focus on FinOps - "FinOps is an evolving discipline focused on the financial management of operations, usually 
    cloud operations. It’s particularly important as a way to help the finance department with forecasting as compute and infrastructure moves from being a CAPEX purchase (servers in data centres) to per-minute variable OPEX costs."
    - alignment of cost, sustainability, resilience
- Cinch
  - "Observability doesn’t happen for free. Just because you use serverless doesn’t mean your systems will be easy to 
  monitor and review. That takes effort, enablement and leadership. From a cost perspective, it costs more to understand the system than to operate it."
