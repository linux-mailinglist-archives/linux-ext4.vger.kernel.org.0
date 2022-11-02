Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580F56172F8
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Nov 2022 00:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiKBXog (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Nov 2022 19:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiKBXoW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Nov 2022 19:44:22 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F0313E9A
        for <linux-ext4@vger.kernel.org>; Wed,  2 Nov 2022 16:41:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so225870pjl.3
        for <linux-ext4@vger.kernel.org>; Wed, 02 Nov 2022 16:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=to:date:message-id:subject:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rJxlbqXdP+CrIusjDzh/oVjx3yFbw3NsPbbPFnIK7Ko=;
        b=BZJwKaY9UrF9O4vqb/ByVAl+NkWMYB6PeluEkmiNNV2Wt4iddeihODNKbdbLENc/D1
         40MDp6Fnmch/3D7uG4npogA1/WY0qP7pkZC0uACG+E6WaMdFwYdwLpOytp+qYg27sWT5
         5egSvbFegciebOLrsdmHiKpGQLejJy3zoePNAPFERNpa91FhGNYeTOiJ6j6G7ZKk9MzE
         piXKolijv/JpZTm8pY5FCzq2ariNahdLgzl2Jb2Q94s+cTNYx3XkAOcyvP1WCNHlrQn3
         lxZ/QS+rnY3tgsJVcdwoo2pJIplAuclsLumBCnwck1+TiVAqaGWTyhRQJzzmRM6+1DSd
         PNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:date:message-id:subject:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJxlbqXdP+CrIusjDzh/oVjx3yFbw3NsPbbPFnIK7Ko=;
        b=7XB+eu08rPMbQmSIaUeI8QLBf5JlG8T3LYe7feWd3+v1Bq6tn3ZayHEtLsvkQXU+bE
         5GUqR6obpfRe4EvwkYJktZHuU+rDN6IwexHm+q1CWaS5F6qrSO9oaohNOIe/HSGoPVyT
         jifQUzTHdfOo3XsDgE1nAOC1n2inAS3hEdYzyTuUmVJJJOqHpc5Z4HFiMpdY+4m7M2yq
         bZRcm3viJW5RCPbWE98rWWkYHyJp6gRvTVoA3KziftCSIdM61AxWXxB1V8sRlerdBsTZ
         9TwFSaqIlKneNSpSlL0YO7lxnND3lgNViFi/l3q5+Ej6wESu62U+lg7XE6RSnr/trKR5
         uuQQ==
X-Gm-Message-State: ACrzQf2cqOq2pCiZ6v1yW+ZAuYav+NAZXgWMmsx+a5JxqMtFJDuI1/DZ
        TqGN3Z81qvfBi7yC3YL9SugVGYbrV3+eIQ==
X-Google-Smtp-Source: AMsMyM4ygGjPQYDdWXm4GcNkePUWDZs1fWzFMt8eyglX4aHs3aXw8v5f59h710/Pq4l/7VPJADk90g==
X-Received: by 2002:a17:90b:33d0:b0:213:137b:1343 with SMTP id lk16-20020a17090b33d000b00213137b1343mr28374828pjb.128.1667432469961;
        Wed, 02 Nov 2022 16:41:09 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id n16-20020a635910000000b0046f6d7dcd1dsm8083291pgb.25.2022.11.02.16.41.09
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Nov 2022 16:41:09 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_17EEC37C-A0E2-44C3-AAA9-050078F7CDDA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: periodic lifetime_write_kbytes updates?
Message-Id: <92BC4EEA-69A6-4AE0-ABA8-304E9DE2D4A9@dilger.ca>
Date:   Wed, 2 Nov 2022 17:41:07 -0600
To:     linux-ext4@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_17EEC37C-A0E2-44C3-AAA9-050078F7CDDA
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

I was looking at the /sys/fs/ext4/*/lifetime_write_kbytes counters on
my home server and wondering about how accurate they are.  That is most
interesting in the case of flash devices, to get a good idea of the
lifetime writes vs. actual rated drive writes per day.

It looks like s_kbytes_written is only updated on clean unmount
via ext4_commit_super->ext4_update_super() and in a few error handling
codepaths.  This means any in-memory updates are typically lost if the
server crashes or loses power (which is typical for long-running servers,
rather than a clean shutdown).

It would be useful to periodically update the superblock with the current
value, maybe once an hour if the value has changed more than some small
margin (to take into account the *previous* update).  The superblock used
to be written frequently via ->write_super(), but this has not been the
case since commit v3.5-rc5-19-g4d47603d9703.

Any thoughts/objections to a periodic task calling ext4_update_super()
every hour if there have been any noticeable writes since the last time
it was called?  This could potentially be more clever so that it only
writes if the disk is not asleep, and do the writes the next time it wakes,
but I'm not sure how easy/hard that is to detect at the filesystem level.

Cheers, Andreas

PS: there is *also* a function resize.c::ext4_update_super() for added
confusion, but that does something completely different...





--Apple-Mail=_17EEC37C-A0E2-44C3-AAA9-050078F7CDDA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmNjABMACgkQcqXauRfM
H+BkbRAAuif5gEFSb4hycovccbB+JKCr6tVBj/w+b4MVFnMKx6NKXtyU83qaDCFC
HNQY0U9BYd+Z6FPT3nU/Zud8XRvMybFACBky4rfKyMyEG0GWQ2yaLV1ObLfR83I0
JLVBPIzz+F54sEhQiPhFuny8wqh4x+HOUrKpmz8sqh1J7V4zFD2CUcoHslLTP9zZ
L0ycn9nqi3JkelEQkh+tA6vfiZ4JGw2hICQwO7iY/pPAtplFK5jKO1U9DrquIfuG
NFtP7r5jRxzpWSSL8Xx223BjXU3PnZ08+hF3PBWqhn0cXIaxDivfUYeHkVX6lGY8
6X3kWtndq2wOAVm0qw2/OFxA1FQ4xJotWkqfxYHRpyXpwp89K99fOo7ME5rvQJdK
pRRtLnAsJ/dG5eMDUB1uSD6TJa3QDK6WeiUPs1qF1cLbs4EZALJtkL0lZ90bqdnJ
h44QfyvDPCVFs2cZQlcYbF8T1oLParZ0QvRKfpkrjkfvVqhiYSYLiiiSQZveestY
fkdMJpV7polzbwkYwfsw3EPrryBmLWHa8TtpRFxEhLNVzz3bKjRWg3IVdhLAv0Br
po36Np8++bQHtLIPTzKmx/u+D1QoeVzKkKemyG4OM7D7KlXr2T9c/a/3WbYabG5Y
/6C6JNpbLOdyqUVRaJLooJkuXyGg5UvEx/s5rcq7dOSxA9Loxk0=
=Jnm9
-----END PGP SIGNATURE-----

--Apple-Mail=_17EEC37C-A0E2-44C3-AAA9-050078F7CDDA--
