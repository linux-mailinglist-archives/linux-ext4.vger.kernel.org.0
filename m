Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323D42DEB66
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Dec 2020 23:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgLRWES (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Dec 2020 17:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgLRWES (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Dec 2020 17:04:18 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F832C0617B0
        for <linux-ext4@vger.kernel.org>; Fri, 18 Dec 2020 14:03:38 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id g18so2185421pgk.1
        for <linux-ext4@vger.kernel.org>; Fri, 18 Dec 2020 14:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=JlWtRFR6EWxztDw/b7ci4EqE9b9JoqJIOlNp8QmYyZc=;
        b=Kh0Tojk2Bp4y2VHf5O459376NvItFwucvuKoYTcnkY+T0/duSaMVlcbIKJ9FY9G08R
         Qq62AgMEQwjvYpMownBGRA8asnvBfvNAK7AQb1Nc1ngD/5GQwqbw0yD5JyhSnL1wszSR
         4JxSc3azUvDwCy4DxPRsqyfDZbNyz5WMXUKkDiZ6lHp/qvkNlE7/xiT7YaV8pH9FomhO
         /sP09G0izUelmedJi1bKonLAudlVieBUGPxLxuu4DUhvbtwB/LmRDJw93wvXRiciGH7y
         3vclNjiSr4eobmyLxBd3oySBm1jKtWzhQWhTuuB7dO3ReJMBtGEc2CTVIUuR1zqf6YBF
         pg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=JlWtRFR6EWxztDw/b7ci4EqE9b9JoqJIOlNp8QmYyZc=;
        b=bKAXs6X36NO02NR8eu5TDdFZQ0ayJcaT2t4BBUl20EMBvfVAVRvbvmf1pF3asMUo86
         tllr4lifNwMQTbWaadtVhRlMknqyx9LENrHJSRsJQQHVrp38RERDMKJn+rliZYIWj1Mu
         hfuTEStMw1FSL0aL/H8WHisrvuBYygyVP0AEORyffFeEuARQishQ12ZkCJsyhXFkBMX1
         XP/GszxBfK04VzaPloK9c5ieGtPgxNhv20z1lYdsA+8s5JM9GIOLaExsyeHf1e+y3Los
         E5itYcxtPvoL0OS2jx91QeaGCWKm1g6CLmlBTaTG12Rj25d2dlSzZceIUnDiDZLrYX9m
         hKQw==
X-Gm-Message-State: AOAM530gI6Skx5pOePg/w8FNoTrHhf1EUprg8TuYt+UR7MrLVsi0z6Or
        1FkeRr9j5hLxmmHfg1A3x7ViqA==
X-Google-Smtp-Source: ABdhPJwc1LfkX6j/m6bMEPzpio32OgcOcOVcUDzG4LQkxZomOIgaFMgtXvlE23tVmoCTAEzUTALzjg==
X-Received: by 2002:a63:4b22:: with SMTP id y34mr5922876pga.214.1608329017407;
        Fri, 18 Dec 2020 14:03:37 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 3sm10544968pgk.81.2020.12.18.14.03.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2020 14:03:36 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <08322694-9793-437D-8CD3-B8A7C5DEACFA@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_25CBB429-1392-4265-9532-9E10BDA746A1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] libfs: Fix DIO mode aligment
Date:   Fri, 18 Dec 2020 15:03:33 -0700
In-Reply-To: <B8DE3834-1B3F-4E1E-B342-51E04E4FD278@hpe.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
To:     "Lyashkov, Alexey" <alexey.lyashkov@hpe.com>
References: <20201023112659.1559-1-artem.blagodarenko@gmail.com>
 <19A3D721-93C0-42F3-ACBA-DE15B4685F9F@gmail.com>
 <20201117191918.GB529216@mit.edu>
 <B8DE3834-1B3F-4E1E-B342-51E04E4FD278@hpe.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_25CBB429-1392-4265-9532-9E10BDA746A1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Nov 19, 2020, at 5:26 AM, Lyashkov, Alexey <alexey.lyashkov@hpe.com> =
wrote:
>=20
> Tso,
>=20
> This situation hit with modern hdd with 4k block size and e2image =
changed to use DIRECT IO instead of buffered.

It would be useful to include this patch for e2image as part of this =
submission,
so that this can be tested.  I suspect that O_DIRECT would be useful for =
other
tools (e.g. e2fsck, debugfs, etc.) since the IO manager would avoid =
double
buffering the data in both the kernel and userspace.

> e2fsprogs tries to read a super lock on offset 1k and it caused to set =
FS block size to 1k and second block reading.
> (many other places exist, but it simplest).

Are there actually other places where it is doing sub-block-size reads =
from disk?

It seems simpler to fix the superblock read at open to always read the =
first 4KB
into a buffer (and to make it easy to extend to 16KB or 64KB if sector =
sizes get
even larger), then find the superblock within the buffer to decide the =
blocksize.

That avoids the short/unaligned read from disk when opening the =
filesystem, without
the need to add complexity to the reading code to buffer all unaligned =
reads, for
a case that doesn't seem likely otherwise.  The only other possibility I =
can think
that would need this is a small-block filesystem image (e.g. 1KB) copied =
to a
large-sector device?  It isn't clear if the kernel would be able to =
mount that...

Cheers, Andreas

>        if (superblock) {
>                if (!block_size) {
>                        retval =3D EXT2_ET_INVALID_ARGUMENT;
>                        goto cleanup;
>                }
>                io_channel_set_blksize(fs->io, block_size);
>                group_block =3D superblock;
>                fs->orig_super =3D 0;
>        } else {
>                io_channel_set_blksize(fs->io, SUPERBLOCK_OFFSET); =
<<<<< this is problem
>                superblock =3D 1;
>                group_block =3D 0;
>                retval =3D ext2fs_get_mem(SUPERBLOCK_SIZE, =
&fs->orig_super);
>                if (retval)
>                        goto cleanup;
>        }
>        retval =3D io_channel_read_blk(fs->io, superblock, =
-SUPERBLOCK_SIZE,
>                                     fs->super);
>=20
> It caused errors like
> # e2image -Q /dev/md65 /tmp/node05_image_out
> e2image 1.45.6.cr1 (14-Aug-2020)
> e2image: Attempt to read block from filesystem resulted in short read =
while trying to open /dev/md65
> Couldn=E2=80=99t find valid filesystem superblock.
>=20
> It looks like I don't first person to found a bug, as someone was add
>=20
> Alex
>=20
> =EF=BB=BFOn 17/11/2020, 22:19, "Theodore Y. Ts'o" <tytso@mit.edu> =
wrote:
>=20
>    On Tue, Nov 17, 2020 at 06:30:11PM +0300, =D0=91=D0=BB=D0=B0=D0=B3=D0=
=BE=D0=B4=D0=B0=D1=80=D0=B5=D0=BD=D0=BA=D0=BE =D0=90=D1=80=D1=82=D1=91=D0=BC=
 wrote:
>> Hello,
>>=20
>> Any thoughts about this change? Thanks.
>=20
>    I'm trying to think of situations where this could actually trigger =
in
>    real life.  The only one I can think of is if a file system with a =
1k
>    block file system is located on an an Advanced FormatDrive with a =
4k
>    sector size.
>=20
>    What was the use case where this was actually an issue?
>=20
>         	     	      	    	     - Ted
>=20


Cheers, Andreas






--Apple-Mail=_25CBB429-1392-4265-9532-9E10BDA746A1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/dJzYACgkQcqXauRfM
H+Dnvg/+Io/IB5kS+vZRxU1+D8TSndVMwn3foT1tVUKd+555KswI+SFhSXQ9yXUn
qzyY93fljfe31Z/Ib6O58aoPDNYNHqe7WozFelql+a+MvCcfbYUnyOVyJLphwJ+k
ouGmmEgaQrooYzrtpB/rHslFpuRtkp1iS6PKaDlRadVpRFMRa0OEhGtu+dkkaD6k
7PopCtNzHqNAnZDn0B5ExRgd05Vp/fE430jiFqRsAIXV/VZ5rz0nv/T+f6YHl7lb
UyoB8j8Mu47MU3VVzMrKRKILPYX4c8zbIFm5/yZkrWA4H1Boik096NbYB2Se0aqm
MccLZzMfTmHJO3IqyrFDNVB5FvvYnjmunTYYwXO726qrZVN0fKYkYEtLj49QDCpQ
ODIOVpvoDCNoLyd7Fbgv1Ks5/Sqk79up7O7oaCkANvyUR9Bam0VIvnbN851kStIo
A2B+0X10I6SDi6SmQhvqfRGhB5vOBiOiBmRiFTI60nul9vBAvF/wjTI5iod7vVHp
WsuLMWz8k73aRPw3463gzv2ch5cpZh8LSqkPI74zH5o8q8wlUgg4+z58hwXY9Tpo
CRssixIh2oUAKb3Vdt2i520YH9KfxygH9zJAbgFpLOAah/5exEkLZDCDa/0iTkTJ
iLIhY+TMLcDunyYmYCmIhacicdZwF+MBLaxEw+9hhuHXwBFi2Jc=
=6hB0
-----END PGP SIGNATURE-----

--Apple-Mail=_25CBB429-1392-4265-9532-9E10BDA746A1--
