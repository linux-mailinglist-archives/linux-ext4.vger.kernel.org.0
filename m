Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FCB309341
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Jan 2021 10:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhA3JXb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 Jan 2021 04:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhA3JWL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 30 Jan 2021 04:22:11 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA22C061355
        for <linux-ext4@vger.kernel.org>; Sat, 30 Jan 2021 00:38:45 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id a20so7015602pjs.1
        for <linux-ext4@vger.kernel.org>; Sat, 30 Jan 2021 00:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=nh5RdJNjFGH9FqSrz0AT0ZPufc7LimEZl5NMVAlceO0=;
        b=iVuCnmHjK0fsqbrHNKuQIYhOBXpNQd5BqUScpBtEY9kQmTcqDAPVdVWG1PkxRL3aKr
         Ob8AHaIL2ZwTQFe055AuM3q6Xv8alTljokkt8/RV4Tl9sSr3xMHFxqcZWsbZBT9mp/Em
         bKLc1PWrhJydD3pkGn7yRBK6XgOds0ox8QXkFsJioTtpzVaAstOxq2QP9mmuKKy5/wI0
         KifuFOSX0rKSSAwK6yWNkaIUcgGMgaKjSRVV6M1djx6K1ICC2zf5PJcYM53kkNaGrgX9
         Yi1BZZqrsOt8Ao80f3OsX611x0sGgt5U+hJz3MosfTVdOuchnxEZo26uWACQlgfZ7FGQ
         Y3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=nh5RdJNjFGH9FqSrz0AT0ZPufc7LimEZl5NMVAlceO0=;
        b=dhS9KKbKTROrqFoIZloEeTjcgqdjr7IY82qwF6DcubUjRHx94e9481hzNUtyO19908
         C5jR6O6ApjKHB7lY6oE+/62CwRdldKsy2AgSab8tY1SMvfDlKPm4jMGLwxuJwPY1T7LF
         uiezJQSz5/GyRluU41a0jpZCS5pSEnu9Qg3NSggcN0pj9XYeNZ16xRqwGq2H6R0zCeSJ
         69Yey8KepeQH2XHKaHdjbWelsxJwnX0aFnn19/zvNDzdFRM5rnsM71pEwzOu6GskV9Lb
         xpDTjIcwvwlIKsHohKE4TjQQSSiDSP13NUEbAaXuwLuZm7SoUjhQDJ5yL8Q3Uyu1MvQ3
         6EHg==
X-Gm-Message-State: AOAM533gZdXMskkc9p3QkQCB4szBURZWHYidaT1Ar9N53H0kMNrhAY/R
        yxXmd8YkXTqEh3rd35fKBi1wiRbZS6npX1X+
X-Google-Smtp-Source: ABdhPJzzlnZp4828LYpQJ+2NtreUh517wI1fV6Y+YQKBduZEX56rKyHg2DxvgcR0YvCaZNzVuOx8NQ==
X-Received: by 2002:a17:902:9a4a:b029:dc:435c:70ad with SMTP id x10-20020a1709029a4ab02900dc435c70admr8640459plv.77.1611995924569;
        Sat, 30 Jan 2021 00:38:44 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id s24sm10803495pfd.118.2021.01.30.00.38.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jan 2021 00:38:44 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C5458E63-DE2F-456D-9182-B7190A07C62C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_7AE094B0-8A17-431F-8BA7-31B985467E3E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/4] ext4: drop s_mb_bal_lock and convert protected fields
 to atomic
Date:   Sat, 30 Jan 2021 01:38:41 -0700
In-Reply-To: <20210129222931.623008-3-harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20210129222931.623008-1-harshadshirwadkar@gmail.com>
 <20210129222931.623008-3-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_7AE094B0-8A17-431F-8BA7-31B985467E3E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 29, 2021, at 3:29 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> s_mb_buddies_generated gets used later in this patch series to
> determine if the cr 0 and cr 1 optimziations should be performed or
> not. Currently, s_mb_buddies_generated is protected under a
> spin_lock. In the allocation path, it is better if we don't depend on
> the lock and instead read the value atomically. In order to do that,
> we drop s_bal_lock altogether and we convert the only two protected
> fields by it s_mb_buddies_generated and s_mb_generation_time to atomic
> type.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/ext4.h    |  5 ++---
> fs/ext4/mballoc.c | 13 +++++--------
> 2 files changed, 7 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 64f25ea2fa7a..6dd127942208 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1552,9 +1552,8 @@ struct ext4_sb_info {
> 	atomic_t s_bal_goals;	/* goal hits */
> 	atomic_t s_bal_breaks;	/* too long searches */
> 	atomic_t s_bal_2orders;	/* 2^order hits */
> -	spinlock_t s_bal_lock;
> -	unsigned long s_mb_buddies_generated;
> -	unsigned long long s_mb_generation_time;
> +	atomic_t s_mb_buddies_generated;	/* number of buddies =
generated */
> +	atomic64_t s_mb_generation_time;
> 	atomic_t s_mb_lost_chunks;
> 	atomic_t s_mb_preallocated;
> 	atomic_t s_mb_discarded;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 625242e5c683..11c56b0e6f35 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -816,10 +816,8 @@ void ext4_mb_generate_buddy(struct super_block =
*sb,
> 	clear_bit(EXT4_GROUP_INFO_NEED_INIT_BIT, &(grp->bb_state));
>=20
> 	period =3D get_cycles() - period;
> -	spin_lock(&sbi->s_bal_lock);
> -	sbi->s_mb_buddies_generated++;
> -	sbi->s_mb_generation_time +=3D period;
> -	spin_unlock(&sbi->s_bal_lock);
> +	atomic_inc(&sbi->s_mb_buddies_generated);
> +	atomic64_add(period, &sbi->s_mb_generation_time);
> }
>=20
> /* The buddy information is attached the buddy cache inode
> @@ -2844,7 +2842,6 @@ int ext4_mb_init(struct super_block *sb)
>=20
>=20
> 	spin_lock_init(&sbi->s_md_lock);
> -	spin_lock_init(&sbi->s_bal_lock);
> 	sbi->s_mb_free_pending =3D 0;
> 	INIT_LIST_HEAD(&sbi->s_freed_data_list);
>=20
> @@ -2980,9 +2977,9 @@ int ext4_mb_release(struct super_block *sb)
> 				atomic_read(&sbi->s_bal_breaks),
> 				atomic_read(&sbi->s_mb_lost_chunks));
> 		ext4_msg(sb, KERN_INFO,
> -		       "mballoc: %lu generated and it took %Lu",
> -				sbi->s_mb_buddies_generated,
> -				sbi->s_mb_generation_time);
> +		       "mballoc: %u generated and it took %llu",
> +				=
atomic_read(&sbi->s_mb_buddies_generated),
> +				=
atomic64_read(&sbi->s_mb_generation_time));
> 		ext4_msg(sb, KERN_INFO,
> 		       "mballoc: %u preallocated, %u discarded",
> 				atomic_read(&sbi->s_mb_preallocated),
> --
> 2.30.0.365.g02bc693789-goog
>=20


Cheers, Andreas






--Apple-Mail=_7AE094B0-8A17-431F-8BA7-31B985467E3E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAVGxEACgkQcqXauRfM
H+D61hAAresarU7wOkSnTwxUED3wZO5Q/Yq+4wBEUasN0X3g5Zxv50vXhbs1O4p6
L6/7pe9sNIdsIoJuVgjmFFVUqrnLVaYMsPl2niWoRdngBa46vuukXt3JOWthkPrn
hdDg5jcb1Ydd/nJKZ44znBku2lLZ6ArUZFzPSa4UYaWdgXgOFVRHEfk2mguoX/GJ
wq2ZmO2yHxTlXJwJYCX9aFTG7naqe3dZY7MeYHIDzscSEhYbkQuGpfHDlo3cM5GV
ZwWnrv4PQIpeH4PPeQ+FRHzQ8lUGvf9YYL2Zmlb9nvqKs6p96IEnsFXNqhW343z6
hs9N7xv0mzqdUEAAZlX0+wf5RE8DCfM465kZdKOsWprag3wKQBY5KJhqh9tSehqO
M5XPGi430ImVPqHVXFAxSUb2hC2+IoRLtrDrgY8dn7eCQGgIaKkcRz/iIka1LVRr
aAATIJe8bbumIEO8vCVvifYUFd+2/g83xqvDm3vtUjqjQHra9XMABQUraQptSh3u
ap5TzDUhicyUPbR8RBMEZli9ql/iJ+h8WK0o1X+w5PqD7FduDqwT9n8mGK9wbvcI
/yJ8dNgCOucznm+n/AdlUtfIpVybsQ3chS5M2pAYhzJov8Cp1KTn7kcYY587JOwL
nw+xu3OX6iW7i0rSL6Wob2R9ck/hbjieJM7jZWcVkgUEfqiQKGE=
=U6HF
-----END PGP SIGNATURE-----

--Apple-Mail=_7AE094B0-8A17-431F-8BA7-31B985467E3E--
