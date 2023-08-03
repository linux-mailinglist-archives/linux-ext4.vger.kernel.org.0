Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF9A76F5BD
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Aug 2023 00:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjHCWcI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 18:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjHCWcG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 18:32:06 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3A41BF1
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 15:32:04 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686d8c8fc65so1110994b3a.0
        for <linux-ext4@vger.kernel.org>; Thu, 03 Aug 2023 15:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1691101924; x=1691706724;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Vh3g/mZtI3P1AmGgsxIxFG74hBV29vr537qpKGiHak=;
        b=gNEM/ltA0euuymKSdIvCKIkP6UgUJRtDNP2HqgF1t1HxW2ALKCSOv7n63q5n50f0Uw
         MyD0d4KaRpZ+KuvhSnNSLJ2ofwiw5AUN0NW6wZhnW2ReYa6J20Dp9/vaS8nYCCv1mWB/
         JdZeeOmT2vJF0OmqXwCFTTP4b+9+Vi2I0ACvBhp3NkzBmOqGBuDPjU+o0kguKS2ykQP9
         i03Q3IAeNYw9jxqFDMRI/klunfocjz1yUg5A53On50FFGdwOkoHHxF/ldS7EHc8Co+u5
         ToZO/mzM+BCOtKUTMFEdcmlvIIBk3BcdriMEdhgewmhbrXVM25hWbpFxHb8HNxhBSTQq
         29xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691101924; x=1691706724;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Vh3g/mZtI3P1AmGgsxIxFG74hBV29vr537qpKGiHak=;
        b=EQl6I4Ocz24epvUKrXML1qPp+jE9ERnPJfQXyimwBCxJEdpyrpfRCGcmdN6QoMM6gB
         5+UoGzUMgbUe4suDlUUkym5ljRukm2aJwMYfZk01972phNEJZZ5lwrSYnpd3ehpuGuqr
         yxjCt9sJ5vkL0xe8WuLxl/WFJxCk5FIl49sGtadz/ESN0akAF0afP3LPjjK5pIzFHa5J
         nf0TKoiReaNocDAj+rTqZeKbNuORic187QuUboGrJvzbNT+oAR/eqp4Yxl3ixOLqwEdx
         HHBPhlig6w6ztkPo1liJ/ZxS/ljKF5Ep17vFGPHhc/eCEmfVwYFkIQP7eLP2dcPjRxsm
         yIgA==
X-Gm-Message-State: AOJu0YxR4oLsz4bsqGfwkLIySaFfiTR+xDDqS3c5uQC18DHN7NG+DHrg
        KYfG8aCeMpTBgkagUocu+PNs7Q==
X-Google-Smtp-Source: AGHT+IGvzapL6JLmHfFYYHTjobQEbdAi1vvRGb1dzCFmAwECGd7FxU8kYpHz2Sk1ijMY6MleJiYl/A==
X-Received: by 2002:a05:6a00:2d13:b0:67e:e019:3a28 with SMTP id fa19-20020a056a002d1300b0067ee0193a28mr16108pfb.16.1691101924077;
        Thu, 03 Aug 2023 15:32:04 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id ey14-20020a056a0038ce00b0067738f65039sm322821pfb.83.2023.08.03.15.32.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Aug 2023 15:32:03 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <30B88888-4652-45B9-974F-C06468D30AD5@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_BCBD2BCA-DFEC-4788-AC3F-A884CD878BEB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4] ext4: Fix rec_len verify error
Date:   Thu, 3 Aug 2023 16:31:59 -0600
In-Reply-To: <20230803060938.1929759-1-zhangshida@kylinos.cn>
Cc:     Theodore Ts'o <tytso@mit.edu>, Zhang Yi <yi.zhang@huawei.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhangshida@kylinos.cn, stable@kernel.org
To:     zhangshida <starzhangzsd@gmail.com>
References: <20230803060938.1929759-1-zhangshida@kylinos.cn>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_BCBD2BCA-DFEC-4788-AC3F-A884CD878BEB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 3, 2023, at 12:09 AM, zhangshida <starzhangzsd@gmail.com> wrote:
>=20
> From: Shida Zhang <zhangshida@kylinos.cn>
>=20
> With the configuration PAGE_SIZE 64k and filesystem blocksize 64k,
> a problem occurred when more than 13 million files were directly =
created
> under a directory:
>=20
> EXT4-fs error (device xx): ext4_dx_csum_set:492: inode #xxxx: comm =
xxxxx: dir seems corrupt?  Run e2fsck -D.
> EXT4-fs error (device xx): ext4_dx_csum_verify:463: inode #xxxx: comm =
xxxxx: dir seems corrupt?  Run e2fsck -D.
> EXT4-fs error (device xx): dx_probe:856: inode #xxxx: block 8188: comm =
xxxxx: Directory index failed checksum
>=20
> When enough files are created, the fake_dirent->reclen will be 0xffff.
> it doesn't equal to the blocksize 65536, i.e. 0x10000.
>=20
> But it is not the same condition when blocksize equals to 4k.
> when enough files are created, the fake_dirent->reclen will be 0x1000.
> it equals to the blocksize 4k, i.e. 0x1000.
>=20
> The problem seems to be related to the limitation of the 16-bit field
> when the blocksize is set to 64k.
> To address this, helpers like ext4_rec_len_{from,to}_disk has already
> been introduced to complete the conversion between the encoded and the
> plain form of rec_len.
>=20
> So fix this one by using the helper, and all the other in this file =
too.
>=20
> Cc: stable@kernel.org
> Fixes: dbe89444042a ("ext4: Calculate and verify checksums for htree =
nodes")
> Suggested-by: Andreas Dilger <adilger@dilger.ca>
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>

Thanks for the updated patch.  You can add:

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> v3->v4:
> 1,Convert all the other rec_len, litrerally.
> 2,Lift a helper output to a local variable.
> --Suggested by Darrick.
> v2->v3:
> 1,Convert all the other rec_len if necessary, as suggested by Darrick.
> 2,Rephrase the commit message.
> v1->v2:
> Use the existing helper to covert the rec_len, as suggested by =
Andreas.
>=20
> fs/ext4/namei.c | 26 +++++++++++++++-----------
> 1 file changed, 15 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 0caf6c730ce3..34fb2d1e66aa 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -343,17 +343,17 @@ static struct ext4_dir_entry_tail =
*get_dirent_tail(struct inode *inode,
> 						   struct buffer_head =
*bh)
> {
> 	struct ext4_dir_entry_tail *t;
> +	int blocksize =3D EXT4_BLOCK_SIZE(inode->i_sb);
>=20
> #ifdef PARANOID
> 	struct ext4_dir_entry *d, *top;
>=20
> 	d =3D (struct ext4_dir_entry *)bh->b_data;
> 	top =3D (struct ext4_dir_entry *)(bh->b_data +
> -		(EXT4_BLOCK_SIZE(inode->i_sb) -
> -		 sizeof(struct ext4_dir_entry_tail)));
> -	while (d < top && d->rec_len)
> +		(blocksize - sizeof(struct ext4_dir_entry_tail)));
> +	while (d < top && ext4_rec_len_from_disk(d->rec_len, blocksize))
> 		d =3D (struct ext4_dir_entry *)(((void *)d) +
> -		    le16_to_cpu(d->rec_len));
> +		    ext4_rec_len_from_disk(d->rec_len, blocksize));
>=20
> 	if (d !=3D top)
> 		return NULL;
> @@ -364,7 +364,8 @@ static struct ext4_dir_entry_tail =
*get_dirent_tail(struct inode *inode,
> #endif
>=20
> 	if (t->det_reserved_zero1 ||
> -	    le16_to_cpu(t->det_rec_len) !=3D sizeof(struct =
ext4_dir_entry_tail) ||
> +	    (ext4_rec_len_from_disk(t->det_rec_len, blocksize) !=3D
> +	     sizeof(struct ext4_dir_entry_tail)) ||
> 	    t->det_reserved_zero2 ||
> 	    t->det_reserved_ft !=3D EXT4_FT_DIR_CSUM)
> 		return NULL;
> @@ -445,13 +446,14 @@ static struct dx_countlimit =
*get_dx_countlimit(struct inode *inode,
> 	struct ext4_dir_entry *dp;
> 	struct dx_root_info *root;
> 	int count_offset;
> +	int blocksize =3D EXT4_BLOCK_SIZE(inode->i_sb);
> +	unsigned int rlen =3D ext4_rec_len_from_disk(dirent->rec_len, =
blocksize);
>=20
> -	if (le16_to_cpu(dirent->rec_len) =3D=3D =
EXT4_BLOCK_SIZE(inode->i_sb))
> +	if (rlen =3D=3D blocksize)
> 		count_offset =3D 8;
> -	else if (le16_to_cpu(dirent->rec_len) =3D=3D 12) {
> +	else if (rlen =3D=3D 12) {
> 		dp =3D (struct ext4_dir_entry *)(((void *)dirent) + 12);
> -		if (le16_to_cpu(dp->rec_len) !=3D
> -		    EXT4_BLOCK_SIZE(inode->i_sb) - 12)
> +		if (ext4_rec_len_from_disk(dp->rec_len, blocksize) !=3D =
blocksize - 12)
> 			return NULL;
> 		root =3D (struct dx_root_info *)(((void *)dp + 12));
> 		if (root->reserved_zero ||
> @@ -1315,6 +1317,7 @@ static int dx_make_map(struct inode *dir, struct =
buffer_head *bh,
> 	unsigned int buflen =3D bh->b_size;
> 	char *base =3D bh->b_data;
> 	struct dx_hash_info h =3D *hinfo;
> +	int blocksize =3D EXT4_BLOCK_SIZE(dir->i_sb);
>=20
> 	if (ext4_has_metadata_csum(dir->i_sb))
> 		buflen -=3D sizeof(struct ext4_dir_entry_tail);
> @@ -1335,11 +1338,12 @@ static int dx_make_map(struct inode *dir, =
struct buffer_head *bh,
> 			map_tail--;
> 			map_tail->hash =3D h.hash;
> 			map_tail->offs =3D ((char *) de - base)>>2;
> -			map_tail->size =3D le16_to_cpu(de->rec_len);
> +			map_tail->size =3D =
ext4_rec_len_from_disk(de->rec_len,
> +								=
blocksize);
> 			count++;
> 			cond_resched();
> 		}
> -		de =3D ext4_next_entry(de, dir->i_sb->s_blocksize);
> +		de =3D ext4_next_entry(de, blocksize);
> 	}
> 	return count;
> }
> --
> 2.27.0
>=20


Cheers, Andreas






--Apple-Mail=_BCBD2BCA-DFEC-4788-AC3F-A884CD878BEB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmTMKuAACgkQcqXauRfM
H+A/SQ/+NrsBmjmaav/mrEZNilO98NLuMfQBUAi7CKfDeOR5uQQ7Xj4upzEoqEf6
Wcb2p41ImLBAAKxqRnJurCkPcmOXQlHDFs7m7xQ4thqHeQo1aTIFnyUuosxmJ2SO
LK9fQfn/7lexTiI6zVNbRTfkIE+sAPnHJFd1A3gzvSGbiiJhyNoUNmY1jKsV5jvp
zQdUVijPfhYLZyBCrIHFgMtNPkhsFSVuyj0FH74MKQhC48XLSzAxlbje1Js7jwSJ
srLxvk4t6jFw5H/T9fqh3S2Mz+QNCBLBEzwkuc4EVXMwrNiky0TwsbW6P9COp5U5
MosmyKe7hrf/TyZPh3fOJItKJ3KF1XIMCAR1zx+e8hNUHubxNtmRVXkgDEFNTZAs
/oPDOjEk5cJB83jRyCx3vdVOwMjpFtaw8Gf9SZNh/cibSVgShebIwP/UPh95U3Cl
dWi9YYTDoRurUTDpIbGvLQRukomh/Bs/qAPg564sjGpRrL3SL/A8/pJHlIUCj/xE
eIjN7SKB+kxG/jCQPwxNrFI+W3Vc90RG3s/QwpXUDzxcelSXS6EA6bE3bIxUwjJC
OjGr9qRE3D4qv/xnZYOtvgdFD/QRNH9/hYAQPfcm0IeRXWp4agnVVf1TYiqe0upX
e8kpsbqMtB76UbNJ8gIwjjuHEUE//ImllyIFeP/dcv/zYGJAwew=
=ynvs
-----END PGP SIGNATURE-----

--Apple-Mail=_BCBD2BCA-DFEC-4788-AC3F-A884CD878BEB--
