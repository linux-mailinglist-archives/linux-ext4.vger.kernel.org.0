Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308DD36F141
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Apr 2021 22:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbhD2Us1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Apr 2021 16:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbhD2Us1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Apr 2021 16:48:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D4EC06138B
        for <linux-ext4@vger.kernel.org>; Thu, 29 Apr 2021 13:47:40 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s22so26889512pgk.6
        for <linux-ext4@vger.kernel.org>; Thu, 29 Apr 2021 13:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=DVvwpJGTx/3cDaj9oq7PFXlJfh36MugTc8ZMsgJLdDU=;
        b=U7bNFtWGxNfnIO28C6TuZ0KnCLADwhxdcJbsg7qhOA0kA+7eNGo0Szjcj3A7wzlORD
         VJhj1A0xrz+RzC1VQfJpQ28Gvb2ub4THJlCO/J6p39blpbJevcrhbswLUUX2e6b6zO03
         VF5buGT8q2PDbxvp5q5BGXKC3i+c8fT8IDY8wkFls36oRkp4fZaEs7Bg6OdmHbXL/MJm
         ysx0j1lUo8BwOYy+T8ThUwPk5wAUA6I3t9cjp9rv1TtKFtF4XU3AkVItVeYLe3Skrve6
         iYapYSPZvnggnGElqGnbEuDJzUnGGTROlKd8ftO1kCIayzj6E8btBeqhIyt9nGx2ocMr
         nMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=DVvwpJGTx/3cDaj9oq7PFXlJfh36MugTc8ZMsgJLdDU=;
        b=je+zHVY+YYL1Q3oaKmZLrn2bbd/B27Qv+nYLE2Jn+ngVMI8MQ5/anXtgah7vjYKYaZ
         3Gm6wukUD4Z3Ju1JVFIazy/SUIyXsgQatP6n9T8YGOY3Lg+DBs7xAMdMFqF5iPszuO0q
         bMVX4r1T8FDwmeF9kZxh4KgWfF2G9k6PfokFKicR2SQn+13lF4BKAYYVoYdy0lvyyDDg
         lWOkI79SR0WggWoPmDHDH23tcXF79ouXirIFOxOdIIiSdW/hta3iCxTZyuswQHSnO+x4
         bg3ott5gD12NvDH6ExwzL4nQiMD41e1q01VIoGa9XtWsW6x6tZhqY6vU4CUVrK+LlHlV
         hy3g==
X-Gm-Message-State: AOAM532tdMirmItOK7iX0gcFUm7HByAPiqH5QSSKmm/tdq7n5BWVqmMF
        YrpCxGC7gt5XN0FgggJYJtZyT6qY/WWYXX46
X-Google-Smtp-Source: ABdhPJxdAAJkWBE6kdZdfUqeXNYWfzpKBlVYd+JfsQsieAOX80ck5zDC/l1EMhJs4k5EuOh7YBNlng==
X-Received: by 2002:a63:b04:: with SMTP id 4mr1444362pgl.291.1619729259844;
        Thu, 29 Apr 2021 13:47:39 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id h6sm3371551pfb.157.2021.04.29.13.47.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Apr 2021 13:47:39 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A0C999DB-A6D5-4C95-A5B8-92E7002395A7@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_081B02CA-CF63-4E53-9C27-1E112BD24159";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: e4defrag seems too optimistic
Date:   Thu, 29 Apr 2021 14:47:36 -0600
In-Reply-To: <YIpFK3or2Creo1qg@vapier>
Cc:     linux-ext4@vger.kernel.org
To:     Mike Frysinger <vapier@gentoo.org>
References: <YIpFK3or2Creo1qg@vapier>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_081B02CA-CF63-4E53-9C27-1E112BD24159
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 28, 2021, at 11:33 PM, Mike Frysinger <vapier@gentoo.org> wrote:
>=20
> i started running e4defrag out of curiosity on some large files that =
i'm
> archiving long term.  its results seem exceedingly optimistic and i =
have
> a hard time agreeing with it.  am i pessimistic ?
>=20
> for example, i have a ~4GB archive:
> $ e4defrag -c ./foo.tar.xz
> <File>                                         now/best       size/ext
> ./foo.tar.xz
>                                             39442/2             93 KB
>=20
> Total/best extents				39442/2
> Average size per extent			93 KB
> Fragmentation score				34
> [0-30 no problem: 31-55 a little bit fragmented: 56- needs defrag]
> This file (./foo.tar.xz) does not need defragmentation.
> Done.
>=20
> i have a real hard time seeing this file as barely "a little bit =
fragmented".
> shouldn't the fragmentation score be higher ?

I would tend to agree.  A 4GB file with 39k 100KB extents is not great.
On an HDD with 125 IOPS (not counting track buffers and such) this would
take about 300s to read at a whopping 13MB/s.  On flash, small writes do
lead to increased wear, but the seeks are free and you may not care.

IMHO, anything below 1MB/extent is sub-optimal in terms of IO =
performance,
and a sign of filesystem fragmentation (or a very poor IO pattern), =
since
mballoc should try to do allocation in 8MB chunks for large writes.

In many respects, if the extents are large enough, the "cost" of a seek
hidden by the device bandwidth (e.g. 250 MB/s / 125 seeks/sec =3D 2MB =
for
a good HDD today, scale linearly for RAID-5/6), so any extent larger =
than
this is not limited by seeks. Should 1024 x 4MB extents in a 4GB file be
considered fragmented or not?  Definitely 108KB/extent should be.

However, the "ideal =3D 2" case is bogus, since extents are max size =
128MB,
so you would need at least 32 for a perfect 4GB file.  In that respect,
e4defrag is at best a "working prototype" but I don't think many people
use it, and has not gotten many improvements since it was first landed.
If you have a better idea for a "fragmentation score" I would be open
to looking at it, doubly so if it comes in the form of a patch.

You could check the actual file layout using "fallocate -v" before/after
running e4defrag to see how the allocation was changed.  This would tell
you if it is actually helping or not.  I've thought for a while that it
would be useful to add the same "fragmentation score" to filefrag, but
that would be contingent on the score actually making sense.

You can also use "e2freefrag" to check the filesystem as a whole to see
whether the free space is badly fragmented (i.e. most free chunks < =
8MB).
In that case, running e4defrag _may_ help you, but it is not "smart" =
like
the old DOS defrag utilities, since it just rewrites each file =
separately
instead of having a "plan" for how to defrag the whole filesystem.

> as a measure of "how fragmented is it really", if i copy the file and =
then
> delete the original, there's a noticeable delay before `rm` finishes.

Yes, that would be totally clear if you ran filefrag on the file first.

Cheers, Andreas






--Apple-Mail=_081B02CA-CF63-4E53-9C27-1E112BD24159
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmCLG2kACgkQcqXauRfM
H+DYahAAtYliCbrm7xQGyBDRKOnnvJY/4guIHa2IyzU8dETuGXtnaj8gHuBN9Ven
WDQXyAeCGlj29onP89bY4ujvpPtFMboLcjeImm31TgV4oZJvzyeE0mjoHrO1SQPw
bGgVbPIQJPbps1uMHTiWVWpFdih7us+lJFwL248N5SbHoiL+zYE3/rgyWUQ1FR/L
Kv4UMKAW00mZjeHqpwNbhWt6hfnyl2q+0dOInKhvWYsRHK5Ccc9mqhq8jGZhvsKq
hrs4AeV4VQH8xD45nxFaS3OS0XS6wPrVg5D/HEgB8kjqsvVbZK3kBfk0c0IRa4Qb
6Wr50lbupJQ3bSHI4Ah5ouSQ7twQpbao5uEF+hdoWY9gUVFTHIOEZt9TZVNEUchY
9wO2VfM+EPYiLVV4/RH1NF4jLDzpaB5Isd8dCXv1t1EIdzH1tG4Ernjj3veeaBE6
b7IdQX7Q7Bad+eKIWz8zdwc3X2dvNbrcx1ENLT6eCYgPX7I5RC5e3NEuXRqlyIAk
aeX43jBVt+lgVsgE+g3dS6jHme4n9tNRbPOHPH7ZPulQqge1QBFgxdpT9i8mFAZO
8WXlq31zYBUEyuOwfoqTPva9EF+AHxzIjrBnd6yVGnRCifkRaUPCgymDSYI6/5ib
p8TBXi4v1WTW4zc+KBcqcIz00ZoKVUtqHLzeLYaFGfYlB+IBSCo=
=LyN4
-----END PGP SIGNATURE-----

--Apple-Mail=_081B02CA-CF63-4E53-9C27-1E112BD24159--
