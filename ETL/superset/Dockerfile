FROM apache/superset:31e1b63bb3e9f5b3adc289c5580e53d4dcabf277

USER root

RUN pip install psycopg2

ENV ADMIN_USERNAME $ADMIN_USERNAME
ENV ADMIN_EMAIL $ADMIN_EMAIL
ENV ADMIN_PASSWORD $ADMIN_PASSWORD

COPY --chown=superset ./superset-init.sh /superset-init.sh
RUN chmod +x /superset-init.sh

COPY --chown=superset superset_config.py /app/
ENV SUPERSET_CONFIG_PATH /app/superset_config.py

USER superset
CMD [ "/superset-init.sh" ]
