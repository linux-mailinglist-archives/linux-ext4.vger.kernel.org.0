Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A51714AE9A
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2020 05:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgA1EQw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jan 2020 23:16:52 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:50772 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA1EQw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Jan 2020 23:16:52 -0500
Received: by mail-pj1-f42.google.com with SMTP id r67so427472pjb.0
        for <linux-ext4@vger.kernel.org>; Mon, 27 Jan 2020 20:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=W6ZiF1080WHg0wmuFxMLAHBp3rcVULCRLSKVdfH+9Mw=;
        b=IBEgd1HSCcDbzpdygJxfw0TRSubXyQDDT2HniPqhdVzs0pWP3a8sQccitrCTmE7RfQ
         1c1IYf3hSKF9n4iEZzrn0l3XQn8r1UZ4qDg/ty35mftOzsUAOKZFqzjeZZG6+bEI8jf8
         ZW8AA1RHAjclfVork2fb3vKX+J4RJq4O+n11nRMsEfssoEf/6DkFa9GGszY1SYvBwJwZ
         7EkiElhEjpHXW809ylTYzZvsxUBYpz44E+uXh+PAhcnocUyfell7OFhOWesz1IKQPHMu
         LdkhLPxB7FQdblm/6d/3BhFvOGgQW1ohspx+ViBVKC6AehG0Xc/EjoidlLw1hGDMRTnp
         lvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=W6ZiF1080WHg0wmuFxMLAHBp3rcVULCRLSKVdfH+9Mw=;
        b=OTdxVAXuNG0dZJa0qus07o+RZ/ROclewoswm9yTx939sH/NeRzB4itC8NQq6n/5VJY
         e6Zb+OUE4l7KRiRnwNJU2iiQ8IUe4TkHuOaY1/9VUnYUtXbBOONkn1TNuIOIRMZRl1r5
         jbohvw1gvQ7RzpuYGEQdRwLLzJY6zNF/N9ca7VcEnYzfNfQCm9t3xOVTHZQzgHt/IWHU
         vYm1aW1QtteNCvFuTD/gUWcD7l1ROzocKNfLkNYI+ugquK6dlQ5OLvnVdE1NhwpSDaiJ
         Bh5k2rn+tBccgTYAxJiW7HDRfzGulBfF0z7Nwhx74Sv3saP1Z84z+6AchrJcouqC6the
         YF2Q==
X-Gm-Message-State: APjAAAWVFjElWe35W5F7QO/aD6Sy+sKxKxLaUX7jIOrGSlMDIjYKB0Tz
        0tWCctwhJdyRJniVNJBWmR1As5CqC6o=
X-Google-Smtp-Source: APXvYqwUGJEmr3Srq3MyBy9hqRFdDlv8Jt98dd0ZpWp5/Ptzh2AnBAVdZl7hz/Jn8oTTQMzuINUzig==
X-Received: by 2002:a17:902:6a84:: with SMTP id n4mr20725644plk.294.1580185011084;
        Mon, 27 Jan 2020 20:16:51 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id u11sm613566pjn.2.2020.01.27.20.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jan 2020 20:16:50 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <429478D9-4FF1-449D-B65E-134CD8710D4E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A343A017-7CB0-4887-960A-49429F66CFC9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: EXT4 Filesystem Limits
Date:   Mon, 27 Jan 2020 21:16:47 -0700
In-Reply-To: <6c4b5e1b-c7d4-7b77-f7f1-f320163b1045@nathanshearer.ca>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
To:     Nathan Shearer <mail@nathanshearer.ca>
References: <6c4b5e1b-c7d4-7b77-f7f1-f320163b1045@nathanshearer.ca>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_A343A017-7CB0-4887-960A-49429F66CFC9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 17, 2020, at 1:49 PM, Nathan Shearer <mail@nathanshearer.ca> =
wrote:
>=20
> Many years ago (about 1 or 2 years after ext4 was considered stable) I =
needed to perform data recovery on a 16TB volume so I attempted to =
create an raw image. I couldn't complete that process with EXT4 because =
of the 16TB file size limit back then. I had to use XFS instead.
>=20
> Also many years ago I had a dataset on a 16TB raid 6 array that =
consisted of 10 years of daily backups, hardlinked to save space. I ran =
into the 65000 hardlinks per file limit. Without hardlinks the dataset =
would grow to over 400TB. This was about 10 years ago. I was forced to =
use btrfs instead. I regret using btrfs because it is very unstable. So =
I had to choose between XFS and ZFS.
>=20
> Today, the largest single rotation hard drive you can buy is actually =
16TB, and they are beginning to sample 18TB and 20TB disks. It is not =
uncommon to have 10s of TB in a single volume, and single files are =
starting to get quite large now.
>=20
> I would like to request increasing some (all?) of the limits in EXT4 =
such that they use 64-bit integers at minimum. Yes, I understand it =
might slow down, but I would prefer a usable slow filesystem over one =
that simply can't store the data and is therefore useless. It's not like =
the algorithmic complexity for basic filesystem operations is going up =
exponentially by doubling the number of bits for hardlinks or address =
space.

It's true that the current ext4 file size limit is 16TB, which can be =
limiting
at times.  There is some potential for increasing the maximum size of a =
single
file, but it would likely require a fair amount of changes to the ext4 =
code,
and I don't think anyone has started on that work.

Is this something you are interested in working on, and you wanted to =
start a
discussion on the topic, or mostly a feature request that you will be =
happy to
see when it is finished?

> Call it EXT5 if you have too, but please consider removing all these =
arbitrary limits. There are real world instances where I need to do it. =
And it needs to work -- even if it is slow. I very much prefer slow and =
stable over fast and incomplete/broken.

Few of the limits in ext4 are "arbitrary" - they were imposed by some =
part of
the implementation in the past, usually because of what fit into an =
existing
data structure at the time, often for compatibility reasons.  At the =
time that
ext4 extents were developed, it was assumed that 2^32 blocks would =
remain a
reasonable upper limit for a single file, given that this was the =
maximum size
of an entire filesystem at the time.  Also, 64KB PAGE_SIZE was assumed =
to be
around the corner, but x86 and 4KB PAGE_SIZE has stuck around another 20 =
years.

There are once again murmurs of allowing blocksize > PAGE_SIZE to exist =
in the
kernel, and since ext4 already supports blocksize =3D 64KB this would =
allow an
upper limit of 256TB for a single file, which would be usable for some =
time.

Cheers, Andreas






--Apple-Mail=_A343A017-7CB0-4887-960A-49429F66CFC9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl4vta8ACgkQcqXauRfM
H+A8wA//Ta8baTov0Cef9oX9f2V15IitGpqXakhBAlpqDkE0RUortjRaCnBVKFPm
sksWfJCcsrDZ2aKC9i1BTfrJ7kW2YZMycTGJ6NleU/ZWJNuO/VxxTpR/gYQgFQba
IVTd4B+bO3jGh5qmIl7G3aX9T3US1uBjPmGLMaeQVVVEvFDRfen9M1sgI9s9khxr
V2QZzIFxmHKnFxLd0Xu7dPN4LatWIUY1r5e3EUudDhP1zCJ1N3zZsd3LPHqwttIN
OQfI3tQ0ix0+8nfaKIGSYxEOkkfelcVX5Q9zL0MNC2AEia/2D7LtUxsUqlhyzU07
VSZ2NSa6+cqg2NISpnFge9Ck/ZziOsHyVyo39KlR9XorGPNwPJJh9vCygXmuHRqr
pEaB6f1bCuTbTuUMAXDxE2uXS7NoFpr5aBc/0bSEOWU2rDHy4fHlRiG2sMmMcSsW
WaY9QrsY3UN7/apmjKHB3uzNlDO7udmCl6gSNbyYsKHc3QHW+57zd5ih/+Tocm5V
KPJfLM3YfDodX1qjFZiE/ucE4FYyV3PFzuAbKhkepcZgeAV+aCOJMYjojg3kSua0
QodguuJTHzD83vresVC6epIKnZzx0U6jSSIMhKCozayFHT1MpOThYtIIpteAlARF
p+S2rhr62kMPPN5Rv4/PCGLxRnsGn3TIEnqRB2TWtfK10M542lU=
=xn6l
-----END PGP SIGNATURE-----

--Apple-Mail=_A343A017-7CB0-4887-960A-49429F66CFC9--
