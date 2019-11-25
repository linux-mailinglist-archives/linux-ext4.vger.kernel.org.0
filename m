Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9D06109533
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Nov 2019 22:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfKYVkE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Nov 2019 16:40:04 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43911 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYVkE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Nov 2019 16:40:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id q16so2904848plr.10
        for <linux-ext4@vger.kernel.org>; Mon, 25 Nov 2019 13:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=y+IhGar7jJTqUjwKHxr5so+mDc7a+WYT1U4bOcNJYVQ=;
        b=Dt3faSKzCwKEiP6AU2QFFL7DVRrHH0ocqWPUcQ4FSLAn/KIdxE8I/HM6Y1L5T/ePWe
         GyYCpqx8wPslKB/K+bJm79RUy5/xw8VzcaSXW7j0HEyxZq7NoVQfZH87OerV4nKQRMa1
         7lVycK3kC7yGIlOQ3WKYr7e257siJzCyZE5mWnEag5tFJgffYUPn+CFd9kIGv2MolHsd
         ZM7bTi1nw/VJsp9gjqY8c4RQp/mMyGhKdnFxMb1o3meUp11jRwOrguMCW+wQGnrQk7Pj
         jcAyW94K/BCgomFkTHbBKqwwj4AZKqPxDNKg1e3AFa9yOgcSKr7iE3XpAVgRmSu7b5VF
         HcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=y+IhGar7jJTqUjwKHxr5so+mDc7a+WYT1U4bOcNJYVQ=;
        b=lBxjlpEt32M4r6sKGucAkpw1RgtvstxhYxvV0DUPwxMtYFy7qNRknEWd6HbcBJ7B/k
         9rXwpSajSbenANbZz8cdC1++YdkzZ3ZAyKpY3vLfo9qeU75olEELRUzR8XI7WRWKOejv
         0raw43CeMDRoBRrqRZBpOMWbWKQ6ETIQBFq9Afrns4JCfdfGKnvvhCSWu46mRXcO2T8k
         rYA3YLEkXHBMRW+OhSMs+8nCt5RiHlUvzx4zvGD5Q6BOBu3OM1G0WUx/6IVDFFJLXxzy
         UfHvJRiSSIuGlUVLrCZWZEmNOm/BiDVsa7WEOnZGROxf/5YqHbg2wo/TZIS9B4eQ8amI
         wJ6g==
X-Gm-Message-State: APjAAAXlHgdaetpTWke4jIivQ+QXp3P5z+raKXpLZXAwqUCqLtRfMcKT
        NF8144W5uqvoVTqfGWm0eV3A2A==
X-Google-Smtp-Source: APXvYqymFJvktXPKHr5TkfFWBlXs9+dIcedTdEYqCr8/dXYWOOYGlKxc7aUMRAsM0XxC1KL/AWTN1w==
X-Received: by 2002:a17:90a:86c2:: with SMTP id y2mr1677072pjv.72.1574718003124;
        Mon, 25 Nov 2019 13:40:03 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id d11sm10363817pfq.72.2019.11.25.13.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 13:40:02 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E02E44A9-6206-4B73-B52F-C3A1BC4C7D1E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8B0EEE79-E2B0-48DD-B6D5-D659ABF991D0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] improve malloc for large filesystems
Date:   Mon, 25 Nov 2019 14:39:59 -0700
In-Reply-To: <BCFC8274-0A4E-42E7-9D11-647D47316BD2@whamcloud.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
To:     Alex Zhuravlev <azhuravlev@whamcloud.com>,
        =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
References: <8738E8FF-820F-48A5-9150-7FF64219ED42@whamcloud.com>
 <20191120181353.GG4262@mit.edu>
 <9E04C147-D878-45CE-8473-EF8C67FE4E86@whamcloud.com>
 <4EB2303A-01A3-49AC-B713-195126DB621B@gmail.com>
 <9114E776-B44E-4CA5-BD49-C432A688C24E@whamcloud.com>
 <43DA6456-AAF9-4225-A79F-CF632AC5241B@gmail.com>
 <BCFC8274-0A4E-42E7-9D11-647D47316BD2@whamcloud.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_8B0EEE79-E2B0-48DD-B6D5-D659ABF991D0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Nov 21, 2019, at 7:41 AM, Alex Zhuravlev <azhuravlev@whamcloud.com> =
wrote:
>=20
> On 21 Nov 2019, at 12:18, Artem Blagodarenko =
<artem.blagodarenko@gmail.com> wrote:
>> Assume we have one fragmented part of disk and all other parts are =
quite free.
>> Allocator will spend a lot of time to go through this fragmented =
part, because
>> will brake cr0 and cr1 and get range that satisfy c3.
>=20
> Even at cr=3D3 we still search for the goal size.
>=20
> Thus we shouldn=E2=80=99t really allocate bad chunks because we break =
cr=3D0 and cr=3D1,
> we just stop to look for nicely looking groups and fallback to regular =
(more
> expensive) search for free extents.

I think it is important to understand what the actual goal size is at =
this
point.  The filesystems where we are seeing problems are _huge_ (650TiB =
and
larger) and are relatively full (70% or more) but take tens of minutes =
to
finish mounting.  Lustre does some small writes at mount time, but it =
shouldn't
take so long to find some small allocations for the config log update.

The filesystems are automatically getting "s_stripe_size =3D 512" from =
mke2fs
(presumably from the underlying RAID), and I _think_ this is causing =
mballoc
to inflate the IO request to 8-16MB prealloc chunks, which would be much
harder to find, and unnecessary for a small allocation.

>> c3 requirement is quite simple =E2=80=9Cget first group that have =
enough free
>> blocks to allocate requested range=E2=80=9D.
>=20
> This is only group selection, then we try to find that extent within =
that
> group, can fail and move to the next group.
> EXT4_MB_HINT_FIRST is set outside of the main cr=3D0..3 loop.
>=20
>> With hight probability allocator find such group at the start of c3 =
loop,
>> so goal (allocator starts its searching from goal) will not =
significantly
>> changed. Thus allocator go through this fragmented range using small =
steps.
>>=20
>> Without suggested optimisation, allocator skips this fragmented range =
at
>> moment and continue to allocate blocks.
>=20
> 1000 groups * 5ms avg.time =3D 5 seconds to skip 1000 bad =
uninitialized groups. This is the real problem. You mentioned 4M =
groups...

Yes, these filesystems have 5M or more groups, which is a real problem.
Alex is working on a patch to do prefetch of the bitmaps, and to read =
them
in chunks of flex_bg size (256 blocks =3D 1MB) to cut down on the number =
of
seeks needed to fetch them from disk.

Using bigalloc would also help, and getting the number of block groups =
lower
will avoid the need for meta_bg (which puts each group descriptor into a
separate group, rather than packed contiguously)  but we've had to fix a =
few
performance issues with bigalloc as well, and have not deployed it yet =
in
production.

Cheers, Andreas






--Apple-Mail=_8B0EEE79-E2B0-48DD-B6D5-D659ABF991D0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl3cSi8ACgkQcqXauRfM
H+A0fA//a4LOcDF3Nva6VDbKoBv0X0tSp9c3rrfR6TW4IiT3AxVivcwXnrKeYnc1
LuP3glPgkGRLJnthfuzhO7WuuVXdor27gdMqQqix3RhFOajWwR8Vtx5OEiHBMIfX
uf4jx9DWOHskCFdbBcL6p3q/yXGc0YcMhAVs0lLs05dGIQxnJjNfSTAHoDts3TOm
4G8pQVeipL3u4JK+v+omgzVCDEkZsstb2OydMa81nEqnx5etb7rkPBxcVB59yQNh
MVowNVuFk3OhK7DY9WgcpwmtyvXScaylqcl5RBVUnW3Euqe/RArhy5+H0iIhtd8v
BSchWvrHmOXBITRDTJOv1s+RyRVPL2JDdM2J47vS0gpsB0URwZ7ATXDeCD5sZoUr
yfgMv/BhGXz0o6EO5BYdZpPPbNt79xUAPgxIwAhnmGly6ACyLXPCXqFCEx27+77O
nikfAwEIJzjVmtX9YOlqUKSabTlRyDD2BFI/iV8owgKtossgeEZD3ydsgAQjoV7m
7pMuySO6y8Rfj/VI1JWtPsX3JDskB+m/gJ33yQslRTTkntRpaRwbooIKGGgQOn8d
b6nINYvnfWYwMEbJi9LMHtRtkSvfkunCzqXooZj2L2i3xhPCRP68nIIkKb6xVaI0
mmSeYjmQlkGTB22se6cGk1lpUbmJSUMFSI/916SuJ/XoExSr7cY=
=1Q9d
-----END PGP SIGNATURE-----

--Apple-Mail=_8B0EEE79-E2B0-48DD-B6D5-D659ABF991D0--
