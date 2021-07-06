Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E06A3BC469
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jul 2021 02:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhGFArE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jul 2021 20:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhGFArD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jul 2021 20:47:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A33BC06175F
        for <linux-ext4@vger.kernel.org>; Mon,  5 Jul 2021 17:44:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso868209pjp.5
        for <linux-ext4@vger.kernel.org>; Mon, 05 Jul 2021 17:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=4QnzE3kyMXRrkFcOtiOIgZYQ40/OQAD6376//zZn8As=;
        b=ZwroQp4bTQqteBoaL5ebi0H817lduA9kANN1OxFpYt+Tm5kKd5F5aAwRU4//IYfB2M
         ZwY4fit1JDOR3cw1+Pu2S6xbkKF/R1IuJONEQrnOQmpU3UHB40L/m3CM8Xwrc9GFDneA
         VTQbVb/z8XwmWxG94q5VrxuASstN9rBd+gC05nvJBGU1h2IqSkNbhFw0BZm7KVzzU94+
         chjg59MhvuWX4e6DQzGH7KodjzZ1ufyxiOpTAH+uFtbXYW6jY0yyYxRATdsbx+Q7gMD8
         1X6meMg9kVl0oaY2GuKUJiMJvoF/0aTAwuQKwzKNF0pVGyUcx2/zzhnWOkCVTyEeHtIP
         7WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=4QnzE3kyMXRrkFcOtiOIgZYQ40/OQAD6376//zZn8As=;
        b=FtCvt5r0Lc2u72tT1SUudZ6Iys0AgYviAWqtWRcH9eamyxQOcURB1QxYXcaz7SuUEi
         ZNFBhuxv6s6O5aQlG+kEnINazdfR0kHNPhZpaewb8GoCopC6/oGcRHOCHVC4J4RetI3W
         C/CNgRacQt5WNFY7YB7N/ZXb/TU48O5m4Ba56/XteZGPZOqdBvoW6ORdOi4IhOlCneO6
         9zoWrx9xWWkk/L8PycDhvLo/K08tWQJKZDhxbpOWHbCi2tF8XItayIxcgAjAqbdjL/OH
         f9kCSSdjLWM4ewsfWASAp1l/FNvazNndzZUsCUp8RWcKGeiGLa0FFCYljBaDoR6nbOq1
         sjzA==
X-Gm-Message-State: AOAM531tMBkkr4F5tLchI6J7A0mBM5EQOeFRU4OQmWOn1FNVO9XMYWi9
        ZNYQ5Qau2ZOrflDEa61BNFA/ZA==
X-Google-Smtp-Source: ABdhPJwkIaWhqReRn7JoX0EF3d9qNhFERBmxc1u0RWGRZUdKGKCy2I0CHIV+sAKSJzwAtimWcUWCug==
X-Received: by 2002:a17:902:7c18:b029:117:e575:473e with SMTP id x24-20020a1709027c18b0290117e575473emr14438663pll.37.1625532264275;
        Mon, 05 Jul 2021 17:44:24 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id g17sm16627603pgh.61.2021.07.05.17.44.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jul 2021 17:44:23 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <85F4B44C-7AB8-4F3B-A443-454F3AC8C1B4@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B173C3B6-D9DC-46C2-8F6D-E63E4FA264A5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] ext4: Fix potential uas-after-free about
 sbi->s_mmp_tsk when kmmpd kthread exit before set sbi->s_mmp_tsk
Date:   Mon, 5 Jul 2021 18:44:20 -0600
In-Reply-To: <20210629143603.2166962-3-yebin10@huawei.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
References: <20210629143603.2166962-1-yebin10@huawei.com>
 <20210629143603.2166962-3-yebin10@huawei.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_B173C3B6-D9DC-46C2-8F6D-E63E4FA264A5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 29, 2021, at 8:36 AM, Ye Bin <yebin10@huawei.com> wrote:
>=20
> Now sbi->s_mmp_tsk is created with kthread_run, then kmmpd maybe
> already running and even exit as exception. Even though we set
> sbi->s_mmp_tsk with NULL before kmmpd kthread exit, but
> "sbi->s_mmp_tsk=3Dkthread_run(XX)" may set after set with NULL.
>   mount                     kmmpd
>     |                         |
>     |-call kthread_run        |
>     |                         |-kmmpd runing
>     |                         |-kmmpd exit sbi->s_mmp_tsk=3DNULL
>     |                         |
>     |-kthread_run return      |
>     | and set sbi->s_mmp_tsk  |
>     |                         |
>     |-then we get wild ptr"sbi->s_mmp_tsk" and later trigger UAF
>=20
> This patch is base on previous "ext4: Fix use-after-free about =
sbi->s_mmp_tsk".
> Previous patch ensure kmmpd kthread exit by itself will set =
sbi->s_mmp_tsk with
> NULL. We can create kthread first, and then wakeup kmmpd kthread =
later.
>=20
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Please note minor typo in the patch subject, should be "use-after-free".

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/mmp.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index fc18a8c205c7..6ec1ea182cc0 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -394,16 +394,18 @@ int ext4_multi_mount_protect(struct super_block =
*sb,
> 	/*
> 	 * Start a kernel thread to update the MMP block periodically.
> 	 */
> -	EXT4_SB(sb)->s_mmp_tsk =3D kthread_run(kmmpd, sb, "kmmpd-%.*s",
> -					     =
(int)sizeof(mmp->mmp_bdevname),
> -					     bdevname(bh->b_bdev,
> -						      =
mmp->mmp_bdevname));
> +	EXT4_SB(sb)->s_mmp_tsk =3D kthread_create(kmmpd, sb, =
"kmmpd-%.*s",
> +						=
(int)sizeof(mmp->mmp_bdevname),
> +						bdevname(bh->b_bdev,
> +							 =
mmp->mmp_bdevname));
> +
> 	if (IS_ERR(EXT4_SB(sb)->s_mmp_tsk)) {
> 		EXT4_SB(sb)->s_mmp_tsk =3D NULL;
> 		ext4_warning(sb, "Unable to create kmmpd thread for =
%s.",
> 			     sb->s_id);
> 		goto failed;
> 	}
> +	wake_up_process(EXT4_SB(sb)->s_mmp_tsk);
>=20
> 	return 0;
>=20
> --
> 2.31.1
>=20


Cheers, Andreas






--Apple-Mail=_B173C3B6-D9DC-46C2-8F6D-E63E4FA264A5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmDjp2QACgkQcqXauRfM
H+DlvBAAqsWHiTOgpu9skxsy0vPawLmm+SzcXU/Hpk5x0V0wqCmgRtkCfXpFl/p+
buRa6HPJcTETe4kpC6TfvAypKkn7kdDIn0x5WoRm6sbwufHbQcTso2o9Rwwtuvm4
NUThYBX3WEG8lKwuiSM/mjjxwwc1IK8o/ed7cOxcED6G3B91AL1d0PobveyoCagN
WDI/JFQF4GZ14O+9IcrBWGbIP9y+mlj4XMqPeX6yOtqWvF5Qf9D7rl3fOOVxWHrb
BPR+sAemWB2a9ZSz4w4vY7wdhdal7LdDMXAt/HIF1mvyy4+SemKTn7QgP9ubi1Vo
tvMCmCYxS89ioJoGUoFIz+TY3kAfcLKMbHkCypKOdMfkGTQ/CNe15oXKutrdHk67
YwsgWnDV5/ywySh9aS5uRg9Bt3mKpPkDLzSWRbbnaqBHlTETViG6R+BwH7F2on61
cm4fU1UssNRcAHXb9aSIitF3QZWmvqhc2wd3/Ds3ZhopYtnZIrnCVxIFhE5Y9fsO
YHl/nNzw8ITxzKWQ2k5XdOoee0QURKxQQJlQEHsyyu7iTS8Wg6g1pdV62ryiKjo7
mjAEKLjDCc7wmpO7o7ztBrxI8cz4Yok8fCag6xQFI+owEMVhvieMNEkOwdkmUHDX
dK3ZBo/QVfTH8e1lAtKzpYjwI5aD2qcDobo6SDUcSbnksTOXBXE=
=ZXK6
-----END PGP SIGNATURE-----

--Apple-Mail=_B173C3B6-D9DC-46C2-8F6D-E63E4FA264A5--
