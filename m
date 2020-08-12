Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A585243110
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 00:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgHLWpF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Aug 2020 18:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgHLWpF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Aug 2020 18:45:05 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B82C061383
        for <linux-ext4@vger.kernel.org>; Wed, 12 Aug 2020 15:45:05 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l60so1843290pjb.3
        for <linux-ext4@vger.kernel.org>; Wed, 12 Aug 2020 15:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=CVi9oFtp73qqgofpyJAOv/UMr48knikotgzEOgytzVA=;
        b=CqZNIiw+vMii5NwD/+ZusT+d3VkaxYiKCMj09LKf4tiEzDvHC/Gt3PXMcv4p9+O2/h
         AQ/bqaLPGR48VpVMOvBixATgtvzTaxj1xhnv4KDidc+rSBXqmVnbs+TmHwXxkIFxpeU4
         tvn3Gfl4failRK+rX+LJdj1MLFDJLva3DrmqRnQQrxjdwl/SwdMIUW3mSg7qLOq8CAso
         LDDYwhx0XNxKdrzTsZ3zNkdoUzLNaDAqYU3DZDmfqzxUJ86FeoW1o955KjbLxPak80yh
         ngM7Fwf59JODn3mxGKOuhlT7wSpfb1sKMrpM+12N8K/CoLU4bzUAd+UyN6lykdvyetUk
         M9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=CVi9oFtp73qqgofpyJAOv/UMr48knikotgzEOgytzVA=;
        b=giBDb9VAHY74L4SM0YnRQBaPA+8ufNuyswRVzaDtl34sOw95PKp7MOzjKRWudnMyZd
         57l1l54w6YI7JTzVdU5n5o7IOPaeS4VcZPeQO1FVd3hzng/baDcvpEtLFb37yrA0F8lM
         yUHHkQM6Hh8kgwHHSPxjMC9GZZPE7w/lJg5KR/aIlB+/Ag7j5yAEloHx2u6Rczk57LwP
         ZTZdsglG7kbbKagjDorbDkRIPbudIoIJyXdb+F9y9+lGEykrBYwBCKyrVOeMEDTjOgdP
         UZRH8QRaDLMU4vlisp5Is39elEygR6eR3lU/SoFGQzk/8gnKs1FiACRK/nP2r7u4keem
         irSw==
X-Gm-Message-State: AOAM5331pMqepcI62oAQH0OhRY2+0AXsGaeGvdNF/JXtGRPhs44hju9n
        Ihau2JnDxPhdvS9NqXIPwOGk+w==
X-Google-Smtp-Source: ABdhPJzr7PSLohw92pt/csbli1LJ0lnBSRWBSzXAE/x9iG9JkLT1FW8nd64KxP0EaMCpneeqIOORdw==
X-Received: by 2002:a17:902:8643:: with SMTP id y3mr1405358plt.199.1597272304532;
        Wed, 12 Aug 2020 15:45:04 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id a2sm3092403pgf.53.2020.08.12.15.45.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 15:45:03 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <4D72360F-7836-4C4F-920D-4D1BC1DE704E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_FF3BEE4F-DE16-4E0A-A5B1-FE6312B325F0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: libext2fs: mkfs.ext3 really slow on centos 8.2
Date:   Wed, 12 Aug 2020 16:45:00 -0600
In-Reply-To: <CAPQccj7XwunXerNYxPBTpBa0JVX7vzC=7aBoE8m35ttFHYNOPg@mail.gmail.com>
Cc:     linux-ext4@vger.kernel.org
To:     Maciej Jablonski <mafjmafj@gmail.com>
References: <CAPQccj4_Tz-11AfXaSiPj4aRWYU2mX9eJuJyGNR68Mini0PZjw@mail.gmail.com>
 <CAPQccj7XwunXerNYxPBTpBa0JVX7vzC=7aBoE8m35ttFHYNOPg@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_FF3BEE4F-DE16-4E0A-A5B1-FE6312B325F0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 10, 2020, at 6:37 AM, Maciej Jablonski <mafjmafj@gmail.com> =
wrote:
>=20
> Hi,
>=20
> On upgrading from centos 7.6 to centos 8.2 mkfs slowed down by orders
> of magnitude.
>=20
> e.g. 35GB partition from under 8s to 4m+ on the same host.
>=20
> Most time is spent on writing the journal to the disk.
>=20
> strace shows the following:
>=20
> We have got strace which shows that each each block is zeroed with
> fallocate and each
> invocation of fallocate takes 10ms, this accumulates of course.

Do you really need to use mkfs.ext3, or can you use mkfs.ext4 and
mount the filesystem as type ext4?  Then you can use the "flexbg"
feature and it will not only speed up mkfs but also many other
normal operations (e.g. mount, e2fsck, allocation, etc).

Cheers, Andreas

>=20
> We have found that using
>=20
> UNIX_IO_NOZEROOUT=3D1 to affect libext2fs
>=20
> Brings the timings back in line down to seconds.
>=20
> If this is not a known bug I can send more details,
>=20
> Looks that calling fallocate for each block is very inefficient on =
some system.
> In our case this is dellr640 (skylake) with a mechanical disk.
>=20
> Kind Regards,
>=20
> Maciej
>=20
>=20
> On Mon, 10 Aug 2020 at 13:35, Maciej Jablonski <mafjmafj@gmail.com> =
wrote:
>>=20
>> Hi,
>>=20
>> On upgrading from centos 7.6 to centos 8.2 mkfs slowed down by orders =
of magnitude.
>>=20
>> e.g. 35GB partition from under 8s to 4m+ on the same host.
>>=20
>> Most time is spent on writing the journal to the disk.
>>=20
>> strace shows the following:
>>=20
>> 16:19:49.827056 prctl(PR_GET_DUMPABLE)  =3D 1 (SUID_DUMP_USER)
>> 16:19:49.827112 fallocate(3, FALLOC_FL_ZERO_RANGE, 3383296, 4096) =3D =
0
>> 16:19:49.835203 pwrite64(3, =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., =
4096, 3362816) =3D 4096
>> 16:19:49.835321 getuid()                =3D 0
>> 16:19:49.835403 geteuid()               =3D 0
>> 16:19:49.835463 getgid()                =3D 0
>> 16:19:49.835513 getegid()               =3D 0
>> 16:19:49.835582 prctl(PR_GET_DUMPABLE)  =3D 1 (SUID_DUMP_USER)
>> 16:19:49.835657 fallocate(3, FALLOC_FL_ZERO_RANGE, 3387392, 4096) =3D =
0
>> 16:19:49.843471 pwrite64(3, =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., =
4096, 3366912) =3D 4096
>> 16:19:49.843562 getuid()                =3D 0
>> 16:19:49.843619 geteuid()               =3D 0
>> 16:19:49.843669 getgid()                =3D 0
>> 16:19:49.843715 getegid()               =3D 0
>> 16:19:49.843785 prctl(PR_GET_DUMPABLE)  =3D 1 (SUID_DUMP_USER)
>> 16:19:49.843836 fallocate(3, FALLOC_FL_ZERO_RANGE, 3391488, 4096) =3D =
0
>> 16:19:49.851885 pwrite64(3, =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., =
4096, 3371008) =3D 4096
>>=20
>>=20
>> Each invocation of fallocate takes 10ms, this accumulates of course.
>> We have found that using
>>=20
>> UNIX_IO_NOZEROOUT=3D1 to affect libext2fs
>>=20
>> Brings the timings back in line down to seconds.
>>=20
>> If this is not a known bug I can send more details,
>>=20
>> Looks that calling fallocate for each block is very inefficient on =
some system.
>> In our case this is dellr640 (skylake) with a mechanical disk.
>>=20
>> Kind Regards,
>>=20
>> Maciej
>>=20
>>=20


Cheers, Andreas






--Apple-Mail=_FF3BEE4F-DE16-4E0A-A5B1-FE6312B325F0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl80cOwACgkQcqXauRfM
H+DltQ/+JQCRpXqp15M18K2nn80ABG/3QPxAyZ5grqMkya/WmprMT0zqW3IJxmc5
dU4/+cMY4gMomseTvWQh/iFiidb0Ic6z0nl8sXNKqP8T/GqOrhNwh+zcdyfLwX40
c5XSSbIDp6cGg0J7wzjztJdDRL/ol3EIVwQbLdpX6hy2EDvvh6MmwIK6m7w+fstW
rB0q/oPpBcuBueUeWiZhmqLbxj0TGPPGrRGx4sCj8oi9eo02h3sWU1FfeGqMYRb6
kH89iPSzXQ3WnsV6Rbt6OA9CzdkI9XmEvDXXVMKGlEY/G/wWVKZJAdwndFl7kaRq
/BdvP5ox1ge/EbmCLJ+pQy/82VZPppDt9C3GllDhNYZY8gRLhU3tlprQliamdaRT
WWGb34RdIwJkyZs1CNegFcXUCkCVCCrscb/CfJtUuUof6lfjPUUb+5wzjBCM/iG8
9Tq3UeltvXrZUXCJiXzeUL++OSi1GRVdCaCTL+E6TWxyzOOKaCqOAaRpWHiekn6+
oOZW2zGXJhgsJGW9JL6MKb5bNI1MlxlU80C4MAEl6sQuS0lrttGoSYFhqNcXuX6j
xxaGBWGdUatv6P/ccJKavsY3ifHO1jTvQvtpdUaSPEHvSrU4ttCEaQTGxD1lI3MS
bDEVifU0Chas2CLFLHssoKYxa2WUaLFpbkx6dqOszmoj/t54+4s=
=cSaP
-----END PGP SIGNATURE-----

--Apple-Mail=_FF3BEE4F-DE16-4E0A-A5B1-FE6312B325F0--
