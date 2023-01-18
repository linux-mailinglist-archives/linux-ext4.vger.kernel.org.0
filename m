Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543B4670ED1
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 01:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjARAjn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Jan 2023 19:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjARAjC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Jan 2023 19:39:02 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF8558289
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jan 2023 16:11:00 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso641621pjt.0
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jan 2023 16:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pzEdmN39Unq8aY/sGjFArgb3bCi8SP9Ib6NE2vIEiyI=;
        b=wXnzlkDCWr5+eyW1tQuaZhE+erFaeCBZyHwy+IOFdnpfJkrySosYe3OCoRrcuUEa38
         OQzA+SREBOrMEWvyEc1VDVI5v7M/MKGnsuGggiAuriZgzpPLnA4QkqQyBlYxiS0c28TR
         cJyFHnKavKKqndGBkiiXKD/gbw0vWGZq1X4qrC0gapU6ak6p7HQEWRSpo7luiO85vAwU
         NFJi6Niemhh+wPAE3WOSV0AtkihPGF/o+J28DZk6oJTDlwqFWvcjFfM5/vw3VdZmyyH1
         DLR18vKQd+Estm8pRJPbN4cyFQeE4ppAy4VRI/TRrC9Qi2Q1JiMtqfnmC303qoXuD3xS
         0HMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pzEdmN39Unq8aY/sGjFArgb3bCi8SP9Ib6NE2vIEiyI=;
        b=nvCj7KDXLcHs6I7QFFh2wey6beLzYeiv61ohhxExkdr5uzSymaPP2cIKPWd5aKiE7H
         2M4xH/8vF+FnCAh7zGjuYySmHqJqDv0osOHufzCmeI1+EjhaJjC5kH4BffHILKObrGVb
         f/y8gigCJjDRyAjfyzVUnxcTbu+tD70Uo3f39RlZghdrvDAMTV6fHwrnXqBl4Ywo5ixj
         kgrnRymJ0BmHN7TpeZF99s/Vcu/4L3336MsKCCCc7J/ZJ9P6Ot5SEDluszWG2/06060D
         hB8w/TkUhWMv0s76LD2el8ggWcqgm4KBSJ824+UiOBd+JoeHB0LCQeoAi2IGN+4POs4u
         XiAg==
X-Gm-Message-State: AFqh2kq0ZDdH5K6Av53lxHkH5SU8M5SUIGwlw6a+pKY4+rWeUM5yymgN
        qzt2gJDAgypFNG9AQsI1SUInwDC7DQEr9PQ9eRE=
X-Google-Smtp-Source: AMrXdXu4zz9OEdBwQxeeyHLknKFFk9HuQejLpxumR6ZOx6uxJGfcSi22Hqb+c9uo2eR+Vk2DPtRSog==
X-Received: by 2002:a17:902:848d:b0:192:fe4b:da3a with SMTP id c13-20020a170902848d00b00192fe4bda3amr5156149plo.10.1674000660271;
        Tue, 17 Jan 2023 16:11:00 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id k11-20020a63f00b000000b0047685ed724dsm18056048pgh.40.2023.01.17.16.10.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2023 16:10:59 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7DE6598D-B60D-466F-8771-5FEC0FDEC57F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E6AB58D9-A35D-4999-8357-C3D05FF9EC98";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: generic/454 regression in 6.2-rc1
Date:   Tue, 17 Jan 2023 17:10:55 -0700
In-Reply-To: <Y8bpkm3jA3bDm3eL@debian-BULLSEYE-live-builder-AMD64>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Eric Whitney <enwlinux@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <Y8bpkm3jA3bDm3eL@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_E6AB58D9-A35D-4999-8357-C3D05FF9EC98
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 17, 2023, at 11:31 AM, Eric Whitney <enwlinux@gmail.com> wrote:
>=20
> My 6.2-rc1 regression run on the current x86-64 test appliance =
revealed a new
> failure for generic/454 on the 4k file system configuration and all =
other
> configurations using a 4k block size.  This failure reproduces with =
100%
> reliability and continues to appear as of 6.2-rc4.
>=20
> The test output indicates that the file system under test is =
inconsistent.

There is actually support in the superblock for both signed and unsigned =
char
hash calculations, exactly because there was a bug like this in the =
past.
It looks like the ext4 code/build is still using the signed hash =
functions:


static int __ext4_fill_super(struct fs_context *fc, struct super_block =
*sb)
{
	:
	:
                if (i & EXT2_FLAGS_UNSIGNED_HASH)
                        sbi->s_hash_unsigned =3D 3;
                else if ((i & EXT2_FLAGS_SIGNED_HASH) =3D=3D 0) {
#ifdef __CHAR_UNSIGNED__
                        if (!sb_rdonly(sb))
                                es->s_flags |=3D
                                        =
cpu_to_le32(EXT2_FLAGS_UNSIGNED_HASH);
                        sbi->s_hash_unsigned =3D 3;
#else
                        if (!sb_rdonly(sb))
                                es->s_flags |=3D
                                        =
cpu_to_le32(EXT2_FLAGS_SIGNED_HASH);
#endif
                }

It looks like this *should* be detecting the unsigned/signed char type
automatically based on __CHAR_UNSIGNED__, but that isn't working =
properly
in this case.  I have no idea whether this is a compiler or kernel =
issue,
just thought I'd point out the background of what ext4 is doing here.

Cheers, Andreas

> e2fsck reports:
>=20
> *** fsck.ext4 output ***
> fsck from util-linux 2.36.1
> e2fsck 1.46.2 (28-Feb-2021)
> Pass 1: Checking inodes, blocks, and sizes
> Extended attribute in inode 131074 has a hash (857950233) which is =
invalid
> Clear? no
>=20
> Extended attribute in inode 131074 has a hash (736302368) which is =
invalid
> Clear? no
>=20
> Extended attribute in inode 131074 has a hash (674453032) which is =
invalid
> Clear? no
>=20
> Extended attribute in inode 131074 has a hash (2299266654) which is =
invalid
> Clear? no
>=20
> Extended attribute in inode 131074 has a hash (3503002490) which is =
invalid
> Clear? no
>=20
> < and continues with more of the same >
>=20
> The failure bisects to the following commit in -rc1:
>=20
> 3bc753c06dd0 ("kbuild: treat char as always unsigned")
>=20
> The comment for this commit suggests that it's likely to cause things =
to
> break where there has been type misuse for char;  presumably, that's =
what's
> happened here.
>=20
> Eric
>=20


Cheers, Andreas






--Apple-Mail=_E6AB58D9-A35D-4999-8357-C3D05FF9EC98
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmPHOQ8ACgkQcqXauRfM
H+A7ww/+KX8Ony4/A0QAS178SGdXM0nVqsMK0fahR+SWCiFNh/Q/2se6sJGgyEPf
8rEP2VRzvFuWRM8vF91QYSPRzuVHpm/pLqT9/yFb6+vvaqX5gyFhL9m9lq+bpKBI
cYiRgeC0lVujw7aYpPeTZwP0owmLkFxyVaBdOapAaNoqJMxcmxnJRlCzHAiCDyEU
q9KNzJk8q2NwVNu8GPDV3ivl5VOHoY+J3k8G/dcV1wbQVxBf6Ym2IOk6kNZQACuH
IflaXhwBPtg9PmUVPTY4dbkbC2/D0VudxMT+9KQkZ/5OkV1jJeuFF8GnfhG/1Z7W
YVJs02fphAT1jKjTXNdy4zEH/qDQT7QQdos4dQBqplmOhwfqHuruxS9sMb5H6ykg
dsQh2Me4Y6wzx/pMZRJbX5q82c6cb5o5l74RsFnG4AqHspeqMtRs37vvgsDh8Fwe
4D6SUxM/uIQ2aCTTN1RdUScuIG3zu43LIgLGrCAc7ptvMO7s2GxlhGc21e49edIf
WnLmvBjDnNiLGdAjnWbXaN70Y10xn2fzVX6VmaHQFVlsJk1vml1g7R4dg6gA1jgA
fSG4DedLhpu1yil5z+npo3ryd2Jua1KnYuHOGUaqs+1cnlgjQSpckNhidp3g5gm2
6tAkNtmCAIbXv4+TipA4XeNiLX7qxmSJcRR8NWYUeITSzT6Cfqg=
=ecss
-----END PGP SIGNATURE-----

--Apple-Mail=_E6AB58D9-A35D-4999-8357-C3D05FF9EC98--
