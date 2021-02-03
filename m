Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386D730E7E5
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Feb 2021 00:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhBCXwA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Feb 2021 18:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbhBCXwA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Feb 2021 18:52:00 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0DAC061573
        for <linux-ext4@vger.kernel.org>; Wed,  3 Feb 2021 15:51:19 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id m6so912305pfk.1
        for <linux-ext4@vger.kernel.org>; Wed, 03 Feb 2021 15:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:mime-version:from:in-reply-to:resent-from:date:cc
         :resent-date:message-id:resent-to:references:to;
        bh=Ayv/Jnf0pCDKFO3JRMJvhGl4evz3WI46lm6ZRrJOsJE=;
        b=sVQprz2eQhhqY+S3sRXdLqaiKTS29JsUsQQKN+nM/50Cor+NFrEGhwVaugyxEIOkI8
         A/HlP2PkcdwkpP02CzaSYe8ZIoTkJNxufOSoNv10LSSh3ZtxCOhCWnGRG+vugfcRrckt
         I05p0qtrUNHtCA7vbNcqGdixODOu4ISrV+zfMARCXojvE5yAsrzRl3mlpXPxSx/NIc8o
         hK4AbAb4xaDmednguEuzeQ8bJ7WaNWpfZ1vVxWPGQqoORvWvY3RRoneS8DVTYF8OBYfH
         xulyumTYEVj+nohxJZurfLQ1b3yCBqrTe8Ad5aLeaOPaf3xNFSV+r+utkNDcF2wNX6QB
         KJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:mime-version:from:in-reply-to
         :resent-from:date:cc:resent-date:message-id:resent-to:references:to;
        bh=Ayv/Jnf0pCDKFO3JRMJvhGl4evz3WI46lm6ZRrJOsJE=;
        b=QvY0Y8lmiT1bVMLKsh/jhCfQhuF+0yKdVKemfb2bBCKEnpRWyvmYgnT4cERByRU2cP
         sz8aDGvQsk2+f9xuJM+NGWcHBMCW+fzgwYiv03deyOjUvSwDiASV89O0qrR+cUz5+iWl
         8q+DvBphTmgolalpWz2TaL6Fp6nqt00zgI9yq0cNQ5//kioTjzJ0xiwF09y8odASXtdQ
         cDuQD+MECpRbQvGseOYgYqzkJlpMkR5dypJw1GAkjDMa4wjMjM4WzjjDs9QON1nY/ZYU
         ECi3Jb8HsM2haNmRKYQjA25VZ+3sht6p2qkBzCWvPyuzYtuUZ8Q2mzYni14f/iuYsTZi
         91Kw==
X-Gm-Message-State: AOAM5302HZdwgxiHvLHjeTH+FnDbilUbeS1e7aKlwe3q2NOc453Qxure
        vM5h+Ace/dQbQjlXmgovL+TNaVnCSn0AnT8k
X-Google-Smtp-Source: ABdhPJyRYHb1WBXe4SHq8uJo8ZYNefLzuSbRXwDJEO4VSu2rKif2w1HYtL9qR93VBRbcj8Mi1HzpHQ==
X-Received: by 2002:a63:e906:: with SMTP id i6mr6081320pgh.350.1612396279187;
        Wed, 03 Feb 2021 15:51:19 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id v31sm4209097pgl.76.2021.02.03.15.51.18
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 15:51:18 -0800 (PST)
Subject: Re: [ANNOUNCE] e2fsprogs v1.46.0
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3DE0C4EC-540F-472B-9AC1-A4E4381E53F5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
From:   Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <YBmMlwBaoC58CARb@mit.edu>
Date:   Wed, 3 Feb 2021 04:43:00 -0700
Cc:     linux-ext4@vger.kernel.org
Message-Id: <C19684EF-B868-4FDB-9145-F02844F8DB5C@dilger.ca>
References: <YBmMlwBaoC58CARb@mit.edu>
To:     Theodore Ts'o <tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_3DE0C4EC-540F-472B-9AC1-A4E4381E53F5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Feb 2, 2021, at 10:36, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> =EF=BB=BFI've released e2fsprogs 1.46.0 in all of the usual places;
>=20
> E2fsprogs now supports file systems which have both file system
> encryption and the casefold feature enabled.  This requires Linux
> version 5.10.

Gah!  I just noticed these patches being submitted to the kernel, but
they break the dirdata format in an incompatible manner. I hadn't been
paying close attention to casefold + encryption since I thought it was
only changing the hashing function and not the actual dirent format,
and I didn't see these patches to e2fsprogs being submitted to the
list (I couldn't find them in patchworks either).

Since this hasn't been landed to the kernel yet, and 1.46.0 was *just*
released, can we roll this back and instead make the extra hash stored
in a dirdata field? Preferably #3, since #1 is the Lustre FID, and #2 =
was
proposed for the high 32 bits of the 64-bit inode number (though it was
never landed and I don't think it is in use anywhere).

Having just looked at these patches for the first time, I can't say for =
sure,
but it looks like only a small on-disk format change would be needed to
make both features compatible with each other.

There would need to be a bit set in the dirent type field to indicate =
that
there is a hash stored after the name:

#define EXT2_DIRENT_HASH     0x40

and the length of the hash field would be stored as the first byte. =
Since the
hash is stored aligned on a 4-byte boundary, the length is variable
(8+alignment), but storing the length at the start would not add any =
more
space for 3/4 of the names due to the existing padding for alignment.

Cheers, Andreas

--Apple-Mail=_3DE0C4EC-540F-472B-9AC1-A4E4381E53F5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAbNvUACgkQcqXauRfM
H+DB7g//WAhclbE9fDifp2eOKRjm3KMU/mYaOH/KELAg7wkSAv0hD0E9PtVSRQ6M
5m2JQqhgloykO1iqC8uShcZdkqBHRfvBeZ8s+yvJCg43LNn+WLISFE60qq1Mee9Z
sZAwz497cs6BbEfgqKljdZcM+5lE2Ekv66vWCMY9us303ELXIAuGPsm9XN8VmIjm
84yzA0R5vQGSniJDervsq/1TGzf2YvbC8teP9EFUIzOOYLcvn1afpJlVztJn8rHe
ZZq1JFIpH13HiDMa4/Da+GEtqZ3X0/43blQNIWV3lpmLwlXf6bpl7B8xj4tqk33y
U6EQvq2vZR/rEv6DTVzMXuLsqgPSeWD05Wq/CRUh+wMUmY9/1KTakE9TGv+WbpJ8
fj3BNxh8fGZ5RLh/B9ZWoQvq/oxlerC4BLRY4REN9cifobmgm+kbi50CmKEPOycy
bv1Ch4RZLT21a6FMQgAUjiqCk7neSUEpRCyyE6U2TyUvZLQSoDnLnD//MUZKCcRl
lcAxVsyhDm6thLN2mdfRI38EcLg50GwRBukpFqWmRuEOrLSjCEVRz+p8QaPvIZXw
guZ2Ytx/8cti6L6oUbmauPqQWzLlbuULYVF84e2f4YrOt2X5od/v1vqHtLlMe+9R
6zetgs5GNMLzMBaArbp0m8btlmjFBhT5ulf4ATFyFYKGXQbMwGM=
=XjeG
-----END PGP SIGNATURE-----

--Apple-Mail=_3DE0C4EC-540F-472B-9AC1-A4E4381E53F5--
