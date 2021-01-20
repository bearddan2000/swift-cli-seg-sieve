FROM swift:latest

COPY bin/ ./

RUN chmod +x ./main.swift

CMD ["swift", "./main.swift"]
