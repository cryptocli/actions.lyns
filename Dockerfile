# a distroless lynslang image that is fully encrypted
FROM encryptimage/lyns.ce:0.9.90.00082


# these path actions have already occurred I'm just thinking out loud.
ENV PATH $corekit/lyns
RUN source $core/etc/lyns/bashp_entrypoint

# trustmint via gist
ENV trustmint gist://file-location

# gpg decrypt
# saltblock decrypt

# github secrets

ENTRYPOINT ["/entrypoint.sh"]
