Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C482614ABBE
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jan 2020 22:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgA0Vo2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jan 2020 16:44:28 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36809 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgA0Vo2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Jan 2020 16:44:28 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv17so63975pjb.1
        for <linux-ext4@vger.kernel.org>; Mon, 27 Jan 2020 13:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=NIYktGbQFRRrHfXcPb/QZqRl6NaKxGUuwfJVRc0d2vQ=;
        b=tQGNABCDpTdcpSb7COIrfXy3SP1WvpdXNEm5qNIYkV3FwkNcM5uGSjbWdlZLyWLvId
         4LkQFP3wal+Bw5WmqBbeqPD9wj+82xFrp9qzry0ClG8G23oSbPmYVUyqwwgWpN4uAH3w
         wSC5TObiadfadsW9V3ty9Aaxggymj/AMwRNXM+NJgNeRoQCLdb0/jyi3V6W6BX4ej3f8
         R9RLdo5knl0WNBtwUCJvtVkaEdb6ur2q44Xw2TSPoYpPWbcuzk2E09wQBTiOmoUd0IWH
         elUJeZYhwi/dUhwHmq3HXrS9KjYKqYIrbrRZiKX+/E5kNdVIzKpjnvbTRt7/yqjYSktk
         5+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=NIYktGbQFRRrHfXcPb/QZqRl6NaKxGUuwfJVRc0d2vQ=;
        b=p4+Z2Romy2kuYK1GUbrCHmKEuZ6W7i/O3sb9pPiTpYNLSI4dFT3pJKVPo0tV54jaAX
         zic3gNE6wBlSWxSAsfgENrfdhRmvYiPwHVO3JexnrkkxvDn+8/I7Q3odaYceOvDe/794
         SW6p8ILbtN/HKphrnMzGz+DNP1dJ0pLNm8GCosnYNXrMB4opaRHp6Okm9hVzjYrTsdvO
         qWOK8JNXX4Fh6zj51v6f/iv7E3C3aNPUJ7eRemPA5Y7uADeRw5VrEan4uqf9zWt9xe6/
         PQ+MNbJJJdb8Z9NoT7BUh8a6+yIVfxZ1QLLs0Wcvqp/ll1Jvu113kOSZdux0rTuy2wvy
         sUVg==
X-Gm-Message-State: APjAAAU7uNqHpyoenkEnLm+yb5Ihzbm8/iUVz9kH7OKJuM3MtbyO/xka
        pkU+zqawn9I9NoLVdAebr80kiA==
X-Google-Smtp-Source: APXvYqxPuBJV+fnhH+Z7hF6Rdg5We8tYNhEYi7c5NDIFGOliwTO1m2tdEiM/En0yIJVBjFW3eJQ9gw==
X-Received: by 2002:a17:902:b116:: with SMTP id q22mr12135698plr.255.1580161467716;
        Mon, 27 Jan 2020 13:44:27 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id c188sm17449401pga.83.2020.01.27.13.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jan 2020 13:44:26 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6A331F39-D25C-4970-9A6D-229B24E25D37@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_FC8648D5-C226-47DD-B87E-B1954A66C291";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH] ext4: remove code that does not perform much
 optimization in find_group_orlov
Date:   Mon, 27 Jan 2020 14:44:24 -0700
In-Reply-To: <20200127101352.35170-1-fishland@aliyun.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        liu.song11@zte.com.cn
To:     Liu Song <fishland@aliyun.com>
References: <20200127101352.35170-1-fishland@aliyun.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_FC8648D5-C226-47DD-B87E-B1954A66C291
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 27, 2020, at 3:13 AM, Liu Song <fishland@aliyun.com> wrote:
>=20
> From: Liu Song <liu.song11@zte.com.cn>
>=20
> Even if "best_ndir" has already taken the final value, it still
> needs to traverse all the block groups. It is better to simplify
> the code and increase readability.
>=20
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>
> ---
> fs/ext4/ialloc.c | 15 +++------------
> 1 file changed, 3 insertions(+), 12 deletions(-)
>=20
> @@ -447,17 +447,8 @@ static int find_group_orlov(struct super_block =
*sb, struct inode *parent,
> 		int best_ndir =3D inodes_per_group;
> 		int ret =3D -1;
>=20
> -		if (qstr) {
> -			hinfo.hash_version =3D DX_HASH_HALF_MD4;
> -			hinfo.seed =3D sbi->s_hash_seed;
> -			ext4fs_dirhash(parent, qstr->name, qstr->len, =
&hinfo);
> -			grp =3D hinfo.hash;
> -		} else
> -			grp =3D prandom_u32();
> -		parent_group =3D (unsigned)grp % ngroups;
> 		for (i =3D 0; i < ngroups; i++) {
> -			g =3D (parent_group + i) % ngroups;
> -			get_orlov_stats(sb, g, flex_size, &stats);
> +			get_orlov_stats(sb, i, flex_size, &stats);

It isn't clear to me that this is an improvement?  This means that *all*
new group allocations will start searching at group =3D 0, which will
increase contention on the early block groups.  With the current code,
the starting block group is distributed across the filesystem, as it
is possible that there are multiple groups that have the same score.

We might consider to improve the group selection for non-rotational =
storage,
since we don't care as much about groups on the inner vs. outer tracks.

Cheers, Andreas






--Apple-Mail=_FC8648D5-C226-47DD-B87E-B1954A66C291
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl4vWbkACgkQcqXauRfM
H+A93w/9HGfjLVk3r96fB42sDfdXa3phtxxvdhGJmAECpeSI8mOkakpEfa5QDuww
fqcduAtfmgZianO5uKBtsOgkC9TVlZyTmv0/wHAcf2spw52Mgo7Bh+U955KhU089
wNReXH8JvaFRTE/9/+iAKP4FZ5JV7ZKwAHyeLI+aUCf/MK02LvbpqxYZ6CkVt+Io
96k5C3iHO+yNAT2g6wHISUyOsp0EZ7NNHqdH42Ry1lJG3RugmAcYYxJCPIShBwoq
BRhUcdpXquCFRxXLkg6D3VrcKKdhd0qY59sRSIF9xgNDXo2AgGbKnDGEEz4QgSmw
6LDlTEHh+PKf5zRsk186Irq275uY1VeXqMm+as985123n+ZH8WdXmSWnFyG8+k8c
db3IOxR54Amjxe8vTh5xnEwEOGyxaxqN7Ggwy451KKW8tpUt8PnNhGVEcYwe5yqi
PZI/I69xfjJ+IpQgtuBD/AoaagVmT5cDm9fVfDY3BDjwKPYGHkWu95Uh5rN55+o+
1ABBktj6+oNuLYNh8t2hoLIXNTTq0xbumGV6nmcqcQ99zqGKHXMtfKPKa3MPQw/R
6fFRR/LN5ltO9XsfHFEBCgXcX3RfC+CecyPC6vOXslkOisoY94XUdgqQPOlBEdpc
mslgaYu015tvt04iYqa+NqTwv0YGxbfwgIQCzWliXT6RZJs9884=
=FPmG
-----END PGP SIGNATURE-----

--Apple-Mail=_FC8648D5-C226-47DD-B87E-B1954A66C291--
