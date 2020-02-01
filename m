Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7ED314F90F
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Feb 2020 18:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgBARCG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 1 Feb 2020 12:02:06 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:47075 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgBARCF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 1 Feb 2020 12:02:05 -0500
Received: by mail-pl1-f171.google.com with SMTP id y8so4057885pll.13
        for <linux-ext4@vger.kernel.org>; Sat, 01 Feb 2020 09:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=oGZ8iGZvUdG+gfjP/X6tRcOmFIkQUB/THfGIQyUtX24=;
        b=1lz1pOJj8XWoyUFgmBvitJ0zBTqzYgYbQ9Urg7joEIwQpnRiw04lMz7pGb/eLS6TMb
         rkMwSoJ4FQVmdlIAfYDflSLiy7kfC5rXUzBF3B7Vo1cAMq09aWB+74btxTH3/QsmGgVV
         yDveVWgC+XEGVwBss9xIu/JYJjtQqZP3rUQmZscnc+dAmZRpdJfmYB7rUBjVgu3dUoTj
         qL7fFR1bYEimFKyM63rF/96fNQE8e+le1FwbOJESwJ+T7sJOsiVDeNv2rJsbIycGpsv/
         A3TXW/yKI1JqdrbMrV6KvvPtP7I96Q3jf1JN14uzTZ7TFh5c2i5xMdVKupYxTik+JPRE
         G9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=oGZ8iGZvUdG+gfjP/X6tRcOmFIkQUB/THfGIQyUtX24=;
        b=kvDABG7jfh2FjiJmizgCki7ifxKeuT3/umB5niFbUXLa2OCtA2Hihu0SgswiDdxTZk
         Y8VFkWeVTIxIkbd1qpmPfa2gxkZggqARsQ9IEUxMqnR7nlwakn4I/cD8GMn0t/+M0N/s
         2ydMNEJilDXXK/IOi7InmlRouq845nH8AriBsE1QCMtlD5zPctpOREwXAMmMaY3evG5K
         2Z4JPxywetMUEE/5Im6rCcQbqKPSMeEd2ITqXEZTY2s18MAXp4ggwaMCcNOcP4zvxxaC
         a0nzvCny9nLsiorNSMjXw6fKbaK34NAy4rSGfJwPnig1cUCw6HPCwnrku8o1Na1FbQgu
         au5A==
X-Gm-Message-State: APjAAAXBItX1Lr85VrnfU0eqyfgs3OfsB9JPLSVp/dccDrEkLkhM8gjB
        2qtQpLxlJyw8ICmI3jNzZy314XJ8rPwS2Q==
X-Google-Smtp-Source: APXvYqx7WgZ9OR45IzkyCjxBfPbQVqc2r4Qv+geG9wnBNAy/M9XTrVwtY6aMcIWN8kvZMZvpuZ5J9Q==
X-Received: by 2002:a17:902:9a09:: with SMTP id v9mr15264535plp.341.1580576523235;
        Sat, 01 Feb 2020 09:02:03 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id z30sm15550722pfq.154.2020.02.01.09.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Feb 2020 09:02:02 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <3BF3EA7F-196D-49DF-9C78-85F2BB1C1B49@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D165AFBB-E82E-469C-9915-76618D67FA68";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: e2fsck dir_info corruption
Date:   Sat, 1 Feb 2020 10:02:00 -0700
In-Reply-To: <00CED351-2128-4DF8-B286-7774CCC1FC0A@dilger.ca>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
References: <00CED351-2128-4DF8-B286-7774CCC1FC0A@dilger.ca>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_D165AFBB-E82E-469C-9915-76618D67FA68
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 31, 2020, at 9:07 PM, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> I've been trying to track down a failure with e2fsck on a large =
filesystem.  Running e2fsck-1.45.2 repeatedly and consistently reports =
an error in pass2:
>=20
> Internal error: couldn't find dir_info for <ino>

[snip]

> The dir_info array itself is over 4GB in size (not sure if this is =
relevant
> or not), with 380M directories, but the bad inode is only about half =
way
> through the array ($140 is the index of the problematic entry):

[snip]

> The watchpoint triggered, and saw that the entry was changed by =
qsort_r(),
> which at first I thought "OK, the dir_info array needs to be sorted, =
because
> a binary search is used on it", but in fact the array is *created* in =
order
> during the inode table scan and does not need to be sorted.  As can be =
seen
> from the stack, it is *another* array that is being sorted that =
overwrites
> the dir_info entry:

[snip]

> AFAIK, the ext2fs_dblist_sort2() is for the directory *blocks*, and =
should
> not be changing the dir_info at all.  Is this a bug in qsort or glibc?
>=20
> What I just noticed writing this email is that the fs->dblist.list =
address
> is right in the middle of the dir_info array address range:
>=20
>    (gdb) p *fs->dblist
>    $210 =3D {magic =3D 2133571340, fs =3D 0x6c4460,
>      size =3D 763079922, count =3D 388821313, sorted =3D 0,
>      list =3D 0x7ffad011e010}
>    (gdb) p &ctx->dir_info->array[0]
>    $211 =3D (struct dir_info *) 0x7ffabf2bd010
>    (gdb) p &ctx->dir_info->array[$140]
>    $212 =3D (struct dir_info *) 0x7ffb3d327f54
>=20
> which might explain why sorting dblist is messing with dir_info?  I =
don't
> _think_ it is a problem with my build or swap, which is different from
> the system that this was originally reproduced on.

Just like any good mystery, the information I needed was there all =
along.

After abandoning the previous e2fsck-under-gdb run (which took me a =
couple
of days to get into the right state, so wasn't done lightly), I =
restarted
and was tracking the dblist and dir_info allocations, thinking that I =
might
catch when they became "bad" to due realloc() or similar.  In fact, =
these
allocations were bad from the beginning (similar to what was shown =
above,
with dblist in the middle of what should be the dir_info array).  This =
is
due to calls to e2fsck_allocate_memory() overflowing 4GB from the use of
"unsigned int size" as the argument.  That dooms the allocations from =
the
beginning, though it is very surprising that there wasn't massive =
corruption
visible earlier in the test run...

I think there are two options to fix this:
- change the e2fsck_allocate_memory() argument to "unsigned long size", =
and
  fix all of the callers to typecast to unsigned long before calling, =
but
  this is error prone if something is missed or a new allocation is =
added
- add a new e2fsck_allocate_array() function that takes size an count as
  arguments and does the calculation internally, which I think is more =
robust

Patches forthcoming, after I have verified that they are working (this =
may
take a few days due to the lengthy runtime for this filesystem).


Cheers, Andreas






--Apple-Mail=_D165AFBB-E82E-469C-9915-76618D67FA68
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl41rwgACgkQcqXauRfM
H+BaoQ//fw9s7Sc5pUw8R1HlbI4JvFamwiyev84CFHOyWW7+sDUMnHKutLy0tB+T
rOvz6u7mMf5Okt9uMsdIZzvC2qwx1aOd76y/x6yFDli1Nx7upQzdxIVo2udS4jMa
Z7mJhdtq+MnQC1MPQDFY4W66D1eMudTrPuagwnlGeExV0SQtmQSmGXXBAjSaK+7b
VvjO9r+QpxbyAUL7fnVhMWxOz/kuXD8FIN1Ywp367W6kZNrHE1UGZB22X5tIvc63
dtnH2v64A3nlRfKI1V1HQn4nrhSC44+vNRkqBQA2vRuG0vcVJSdMzHGlDjpM06hr
xY5rK6PX142Jwpuqlt16xpTVoXyVtaJg6Oi+9jud06IvkKLuos9IvPIpQr1BOKcn
BJ3ku36sQDk4d76YcngSrlAyACbbEh7bI2ZpJZ6ECUcyz+sEX3gek72VW5aSsKaN
FjfbZnvLPBlf5Ej/rlAqVh0dLwVA0p5ayDqZzHlRVRaD5ix0qC0dYC4abn9C+GQr
uS8+9Kk0ilbHzONbKPR2kJLuwEB96777oTcudiDepBIGxrUJz9wosuaTWTZEndOo
mu3/LwXNiy+MHieHaCjEh93/U7DDJb29Pg/l8K6LpYGtHIuzVzSgswDLsqjWh7Lk
qZG2o/5GJAJk20n4DWS4g6HjnwaDkKpel26xGHE1sxzDX1vOsGg=
=KYlk
-----END PGP SIGNATURE-----

--Apple-Mail=_D165AFBB-E82E-469C-9915-76618D67FA68--
