Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655DF4D8D86
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Mar 2022 20:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiCNT4z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Mar 2022 15:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244221AbiCNT4y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Mar 2022 15:56:54 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEEB1128
        for <linux-ext4@vger.kernel.org>; Mon, 14 Mar 2022 12:55:42 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z3so14451624plg.8
        for <linux-ext4@vger.kernel.org>; Mon, 14 Mar 2022 12:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=7bLvp+ukT3iqO06tE/tyfi4fUu3KplT1rVUr7ctp2A4=;
        b=gpO8xhUatT1AP4VxCiIscTZxr/t+ixsG+vYROifZEzp0yxdPNXTRZt+Q6eMMYf1ypD
         bzoolDUf8UA7DRu4ibKsFFxgyvtsIIMj39oM9Ph/2u25tFc3HEvvT2y7ZKF1m1O52y9P
         X7uT/dvDn5dHdgMESATHKJOhHGjGbC9np9NcrVqoMU/O2ibsRtBIeFYmavRizIcUSkiP
         3Y9hNHb9+GzAnBsR4dIl2u8rv4hkERWhW58dHwl0F6xj7KEQk+uSKTxrVhZhFqgAAwII
         uczOs2ZybGb5pHWjhyEpM0pTTXXWuRmA1lviU6o8raZWx4Y1ABQybS2QhcA+6c3DhW/7
         0njA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=7bLvp+ukT3iqO06tE/tyfi4fUu3KplT1rVUr7ctp2A4=;
        b=sZlfMkSgpZYNXv1yJx63lQ/49V6Ruvl8nuqmWkwzG9rl7SVtiamoDu5MFrXrJfgGqy
         dsoLl3Q+Tx0NtBSH906tq4wZsliG96FEGUpOo0ntW05OfJnwGUY4Rg/bpizz4NgZQDCW
         87mzbk9zWv6kg2q1yMn3fAmLGg1ZSVEdIiBQLpPWkWhRmrf/HI2XI9S/pxqJUR4kjhjN
         JNyj7MzJEQnI0X218heavFQj/QdVnd+I2vK6q/yY0+M1ZPXqHnAYfSqA6RLl4Wd/jEZL
         RTCO3hKLHb6Vrftw9DX4eFOGVNOFYOahSUeGZOdLoMKSzgQ3WzPmN/dBQHQu10KfFaUB
         C8AQ==
X-Gm-Message-State: AOAM530LtQ1NDZiQ4K3QoBT6kkLQHtI98PfcoZNHkzQ+uiqMtk4bTR/n
        OF5SCq7fZSpAd9PorUEF3yf02zuwWLZ9fg==
X-Google-Smtp-Source: ABdhPJxi6yYuDXKhW7zFqnuN5OGxPRUzriz7pXgNcZLeYYlgCu8mIOO1xaLUqJqeAw+3S5wPuaAM8A==
X-Received: by 2002:a17:902:8c81:b0:153:e42:670b with SMTP id t1-20020a1709028c8100b001530e42670bmr24911579plo.148.1647287741853;
        Mon, 14 Mar 2022 12:55:41 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id j22-20020a17090a7e9600b001bc67215a52sm265485pjl.56.2022.03.14.12.55.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Mar 2022 12:55:41 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <2B76632D-2642-4892-A721-8AC8DF48A8A4@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DAC9F445-948C-44DD-95A4-6631B74BDC1B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: truncate during setxattr leads to kernel panic
Date:   Mon, 14 Mar 2022 13:55:34 -0600
In-Reply-To: <20220312231830.103920-1-artem.blagodarenko@gmail.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Andrew Perepechko <andrew.perepechko@hpe.com>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
References: <20220312231830.103920-1-artem.blagodarenko@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_DAC9F445-948C-44DD-95A4-6631B74BDC1B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 12, 2022, at 4:18 PM, Artem Blagodarenko =
<artem.blagodarenko@gmail.com> wrote:
>=20
> From: Andrew Perepechko <andrew.perepechko@hpe.com>
>=20
> When changing a large xattr value to a different large xattr value,
> the old xattr inode is freed. Truncate during the final iput causes
> current transaction restart. Eventually, parent inode bh is marked
> dirty and kernel panic happens when jbd2 figures out that this bh
> belongs to the committed transaction.
>=20
> A possible fix is to call this final iput in a separate thread.
> This way, setxattr transactions will never be split into two.
> Since the setxattr code adds xattr inodes with nlink=3D0 into the
> orphan list, old xattr inodes will be properly cleaned up in
> any case.
>=20
> Signed-off-by: Andrew Perepechko <andrew.perepechko@hpe.com>


Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> HPE-bug-id: LUS-10534
>=20
> Changes since v1:
> - fixed bug added during the porting
>=20
> ---
> fs/ext4/super.c |  1 +
> fs/ext4/xattr.c | 34 ++++++++++++++++++++++++++++++++--
> 2 files changed, 33 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c5021ca0a28a..8c04c19fa4b8 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1199,6 +1199,7 @@ static void ext4_put_super(struct super_block =
*sb)
> 	int aborted =3D 0;
> 	int i, err;
>=20
> +	flush_scheduled_work();
> 	ext4_unregister_li_request(sb);
> 	ext4_quota_off_umount(sb);
>=20
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 042325349098..13c396e354c8 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1544,6 +1544,31 @@ static int =
ext4_xattr_inode_lookup_create(handle_t *handle, struct inode *inode,
> 	return 0;
> }
>=20
> +struct delayed_iput_work {
> +	struct work_struct work;
> +	struct inode *inode;
> +};
> +
> +static void delayed_iput_fn(struct work_struct *work)
> +{
> +	struct delayed_iput_work *diwork;
> +
> +	diwork =3D container_of(work, struct delayed_iput_work, work);
> +	iput(diwork->inode);
> +	kfree(diwork);
> +}
> +
> +static void delayed_iput(struct inode *inode, struct =
delayed_iput_work *work)
> +{
> +	if (!work) {
> +		iput(inode);
> +	} else {
> +		INIT_WORK(&work->work, delayed_iput_fn);
> +		work->inode =3D inode;
> +		schedule_work(&work->work);
> +	}
> +}
> +
> /*
>  * Reserve min(block_size/8, 1024) bytes for xattr entries/names if =
ea_inode
>  * feature is enabled.
> @@ -1561,6 +1586,7 @@ static int ext4_xattr_set_entry(struct =
ext4_xattr_info *i,
> 	int in_inode =3D i->in_inode;
> 	struct inode *old_ea_inode =3D NULL;
> 	struct inode *new_ea_inode =3D NULL;
> +	struct delayed_iput_work *diwork =3D NULL;
> 	size_t old_size, new_size;
> 	int ret;
>=20
> @@ -1637,7 +1663,11 @@ static int ext4_xattr_set_entry(struct =
ext4_xattr_info *i,
> 	 * Finish that work before doing any modifications to the xattr =
data.
> 	 */
> 	if (!s->not_found && here->e_value_inum) {
> -		ret =3D ext4_xattr_inode_iget(inode,
> +		diwork =3D kmalloc(sizeof(*diwork), GFP_NOFS);
> +		if (!diwork)
> +			ret =3D -ENOMEM;
> +		else
> +			ret =3D ext4_xattr_inode_iget(inode,
> 					    =
le32_to_cpu(here->e_value_inum),
> 					    le32_to_cpu(here->e_hash),
> 					    &old_ea_inode);
> @@ -1790,7 +1820,7 @@ static int ext4_xattr_set_entry(struct =
ext4_xattr_info *i,
>=20
> 	ret =3D 0;
> out:
> -	iput(old_ea_inode);
> +	delayed_iput(old_ea_inode, diwork);
> 	iput(new_ea_inode);
> 	return ret;
> }
> --
> 2.31.1
>=20


Cheers, Andreas






--Apple-Mail=_DAC9F445-948C-44DD-95A4-6631B74BDC1B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmIvnbgACgkQcqXauRfM
H+B4Ag//eYfardhQDTuFewI0G5JTGSkR3aAuR11SO1N87rBHo2d1P7UQXGx8UeTc
epvStM5ZysGeyWuHsyRcIjhbco/XewcnU+XOvZUWbMaW+jWoogs+fTh1Sf9tyiqr
dCrdjOqmi3yj/8g5m0biL2MlR8+se+AxUl0Lr9YFTwhmU3dEwpP8Il4WlhbmaXkN
XSdbduIq4hGdaJ07z6YpfJY7FYPWyweMEC/l6osKZUh+MnYt1WD6+9wqTuEF/ZbL
i9+UVwu9iE0kgk291/wCRWq5k5UtRpr096mTNvrBmFM54zoD5lwUy601zy2xzdaZ
gH2b757N43pjswXD2qKV7hvGPPuoomtRWnAUaVyuxeEnc42Uwhg7nVT1JsSW6GhQ
dm+c2wlivCSNxsITqkdD46R87E8jgS6T/EufTiBE+esoGI9W4yyrbTqDpTL387pA
I7eTLD8CMkv89A28Nt+ep+hIvhEC0yWz6MQHfAJlR3z7BUtZSnswAAbSEXXXgrho
Uf/kOkAeNQ17+/dEC+0X87pjcJqAHEAzHnwHgdfND4kiqWbW4uRhqIYb7IRBcXi7
YThaWZPkb1QU5Tv1uHTyL9Uic3i2wfNy4fOHq3d7tFB1G1KpGf7Oiz4y20eYeukB
tw39QLAUy+OxX02eLt+/xgMGlmx6UxWP13gUvKavTCj7EkWzXXM=
=LzfW
-----END PGP SIGNATURE-----

--Apple-Mail=_DAC9F445-948C-44DD-95A4-6631B74BDC1B--
