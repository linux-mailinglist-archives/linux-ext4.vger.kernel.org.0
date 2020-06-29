Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984B620D6A0
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jun 2020 22:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbgF2TWL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Jun 2020 15:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbgF2TWL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Jun 2020 15:22:11 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04775C061755
        for <linux-ext4@vger.kernel.org>; Mon, 29 Jun 2020 12:22:11 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l6so5365069pjq.1
        for <linux-ext4@vger.kernel.org>; Mon, 29 Jun 2020 12:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=wHDDuPWoKbW77VtBjLqgObYArL7GNI0MYb4LF+pv7qA=;
        b=e8JlbyaNdgXdOrqFkELe3f2DId8707lzivZEM155LJhzSbEC4bh3a5xHKV2WVGoBIP
         u8GkUCFUiv0RJh1AwzYj0u0UngRdF/FbiwhMR2Bi2LWPGxGZIv6Gb6P/FgeCStJgf6Rr
         eOYC2Rox8EQzvcyGlgEqILeUxP9VEMfDTJbNbGTqotbIJ9jOhSHE8wIm7/tjaurwIjaV
         8V8q/EpxKimz8JWuI5mJ4dxvDb1RagnZ3fpU3VjX177mkZu2x9JGKi5qi65vIy/p73l1
         CVOZpI4Uwtzk+PQ+4iN2PZ6JprWBfqI4N5LxZCMwtS8ffwPdgjmWEpu70kP9hgRPNDfX
         OoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=wHDDuPWoKbW77VtBjLqgObYArL7GNI0MYb4LF+pv7qA=;
        b=J1Hi2WnCQWYuUI6Nd1mUd41cyM6lGYKQ8mbT8XeYbJuoKDk3EBBhqxWZQOid8Coapg
         YEedSsy8BB8irh0cGBThVLPydG5p86/6Wjh0kB1F7PH21puPhRHXRwLhxXwQfVQJhq0L
         jmkl2rFBn6rf8v8IvzuS5Sv3dIlDmxLGMfTQSAfnj4Gl1+qRarORJ3RVGg8btOTSeveJ
         2ya2PCC+4VX7W3gpuV0hjlC4xGuklG0WR3xwKcZSiXHfsfvJlnkYaRbhZX9QQixIKujF
         uqaYtFkcS9rQC1sNyT1MeapOkt5vNpLm7tHt1hNMgzTAgVs2AqytZ93W8Pq/wyGTlCri
         3rVQ==
X-Gm-Message-State: AOAM533WKHDfzGCvkT9oaK2naIg6ZkoSs4Sb1waBh1DpgyhXW/tCTOK+
        BoZENGz8rFKCbYpO0DGUCPEJIw==
X-Google-Smtp-Source: ABdhPJx1K/SvzJHNbKCgGdqYA3ul83masC+taMtcq5MdR/Q7spKWL9r5kvXp5C/2BGFYw6+KplTR7A==
X-Received: by 2002:a17:90b:11c7:: with SMTP id gv7mr5856122pjb.175.1593458530479;
        Mon, 29 Jun 2020 12:22:10 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id k14sm427453pfk.97.2020.06.29.12.22.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 12:22:09 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <8006B9E6-D1BD-4F13-AB0F-E060AA3915B8@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2A947A22-325D-4882-8814-2544006FC92A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: lost matching-pair of trace in ext4_unlink
Date:   Mon, 29 Jun 2020 13:22:13 -0600
In-Reply-To: <20200629122621.129953-1-zhuangyi1@huawei.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Yi Zhuang <zhuangyi1@huawei.com>
References: <20200629122621.129953-1-zhuangyi1@huawei.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_2A947A22-325D-4882-8814-2544006FC92A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jun 29, 2020, at 6:26 AM, Yi Zhuang <zhuangyi1@huawei.com> wrote:
>=20
> If dquot_initialize() return non-zero and trace of =
ext4_unlink_enter/exit
> enabled then the matching-pair of trace_exit will lost in log.
>=20
> v2:
> Change the new label to be "out_trace:", which makes it more clear =
that
> it is undoing the "trace" part of the code. At the same time, fix =
other
> similar problems in this function:
>=20
> 	bh =3D ext4_find_entry(dir, &dentry->d_name, &de, NULL);
> 	if (IS_ERR(bh))
> 		return PTR_ERR(bh);
> 	if (!bh)
> 		goto end_unlink;
>=20
> According to Andreas' suggestion, split up the "end_unlink:" label =
becomes
> two separate labels, and then remove the "if (handle)" check, and then
> use out_bh: before the handle is started.
>=20
> Signed-off-by: Yi Zhuang <zhuangyi1@huawei.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/namei.c | 38 +++++++++++++++++++++-----------------
> 1 file changed, 21 insertions(+), 17 deletions(-)
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 56738b538ddf..941f66f417f0 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3193,30 +3193,33 @@ static int ext4_unlink(struct inode *dir, =
struct dentry *dentry)
> 	 * in separate transaction */
> 	retval =3D dquot_initialize(dir);
> 	if (retval)
> -		return retval;
> +		goto out_trace;
> 	retval =3D dquot_initialize(d_inode(dentry));
> 	if (retval)
> -		return retval;
> +		goto out_trace;
>=20
> -	retval =3D -ENOENT;
> 	bh =3D ext4_find_entry(dir, &dentry->d_name, &de, NULL);
> -	if (IS_ERR(bh))
> -		return PTR_ERR(bh);
> -	if (!bh)
> -		goto end_unlink;
> +	if (IS_ERR(bh)) {
> +		retval =3D PTR_ERR(bh);
> +		goto out_trace;
> +	}
> +	if (!bh) {
> +		retval =3D -ENOENT;
> +		goto out_trace;
> +	}
>=20
> 	inode =3D d_inode(dentry);
>=20
> -	retval =3D -EFSCORRUPTED;
> -	if (le32_to_cpu(de->inode) !=3D inode->i_ino)
> -		goto end_unlink;
> +	if (le32_to_cpu(de->inode) !=3D inode->i_ino) {
> +		retval =3D -EFSCORRUPTED;
> +		goto out_bh;
> +	}
>=20
> 	handle =3D ext4_journal_start(dir, EXT4_HT_DIR,
> 				    EXT4_DATA_TRANS_BLOCKS(dir->i_sb));
> 	if (IS_ERR(handle)) {
> 		retval =3D PTR_ERR(handle);
> -		handle =3D NULL;
> -		goto end_unlink;
> +		goto out_bh;
> 	}
>=20
> 	if (IS_DIRSYNC(dir))
> @@ -3224,12 +3227,12 @@ static int ext4_unlink(struct inode *dir, =
struct dentry *dentry)
>=20
> 	retval =3D ext4_delete_entry(handle, dir, de, bh);
> 	if (retval)
> -		goto end_unlink;
> +		goto out_handle;
> 	dir->i_ctime =3D dir->i_mtime =3D current_time(dir);
> 	ext4_update_dx_flag(dir);
> 	retval =3D ext4_mark_inode_dirty(handle, dir);
> 	if (retval)
> -		goto end_unlink;
> +		goto out_handle;
> 	if (inode->i_nlink =3D=3D 0)
> 		ext4_warning_inode(inode, "Deleting file '%.*s' with no =
links",
> 				   dentry->d_name.len, =
dentry->d_name.name);
> @@ -3251,10 +3254,11 @@ static int ext4_unlink(struct inode *dir, =
struct dentry *dentry)
> 		d_invalidate(dentry);
> #endif
>=20
> -end_unlink:
> +out_handle:
> +	ext4_journal_stop(handle);
> +out_bh:
> 	brelse(bh);
> -	if (handle)
> -		ext4_journal_stop(handle);
> +out_trace:
> 	trace_ext4_unlink_exit(dentry, retval);
> 	return retval;
> }
> --
> 2.26.0.106.g9fadedd
>=20


Cheers, Andreas






--Apple-Mail=_2A947A22-325D-4882-8814-2544006FC92A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl76P3EACgkQcqXauRfM
H+BOwQ/9FrqypDx9+xZsNs9UscvEmBAY1AlY2IzNofk2mvZh99YDHNDXo8/PGkNe
4PbVnIVroucqAiHUoEtjux4PZVuKVWOznq/76b49fkaoe/YPdfMne73XHaHUm1io
mvN+g8s2YCOef7YJ4YbvlO3RVJHmmlvSdnjm1kSAndoZ8iaZx8c7QZ9Uxg0TLsh3
zrWvaEqQ3eOs8Q6zHe5EHlP2wP4+VQN9Mmt+rki7CWJQ7q2NEtVDlAwAcIkUsLVv
bVThl3vyrSZUlGL1UHSCFxMIIBRy9FIbN2RafO+leTKrVQAeCY1YXcij7DcChYb9
FcB6aF07LwacjMZ79xJdV+vOX/SOcF7oocu7HGDIjdcdoBYxHID18nqIjb01Qjj6
JCNmQKG/nJfNBdXMWbP9A+2au8VSTvp2P9qzajvDcv7E7QWD0ZDqL5GI/gIxX6AK
ouyWQbQQDJz/23h78lb/9S0zkkUz5ONJuKii56EFK4XkSncJ3J6Xj1OtR9vI/vje
5AXL7yHAbWwdL//2aTSbXXGrXuPdLek5v950R2/3xPOtmuq0Fh2HHqtIIaU2wTpf
ccnlDhK4Tpk5FSbu9t7i2rbZDRireMBPBx9UMy7/uY3RHyftf8deoMPdFjxoKZ7X
F5jBoXrNusRf7hoiHfO6p0pyepac9ZyRqjIngbHmRog+7Y5YRvQ=
=WMeL
-----END PGP SIGNATURE-----

--Apple-Mail=_2A947A22-325D-4882-8814-2544006FC92A--
