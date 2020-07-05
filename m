Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AF9214A79
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Jul 2020 07:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgGEFuJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Jul 2020 01:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgGEFuI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Jul 2020 01:50:08 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AABC061794
        for <linux-ext4@vger.kernel.org>; Sat,  4 Jul 2020 22:50:07 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u18so325718pfk.10
        for <linux-ext4@vger.kernel.org>; Sat, 04 Jul 2020 22:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=htLKFp766hcMQzfOOpV/QMYraFr7AiP3Zje1XapkJFk=;
        b=KC/tCTMZ50IH1zMEQ8e9Y/7tIDEzSJEkQrkUyzVgIKTZ5cvtcckV6+qLo02M/rB/Y/
         Jhz6fN3rjnxxpBSi3QbXYrYcE3NsWutiFGbJpFo0yyNBjTPvTv7RJHQ/xli71RmUbhNx
         THo08uePIRLJspQo+HvkINFaJIYIsqKYDQrOBDEdrve15zIenY6Gl2nWTzTuhGh+16RT
         RMOepts6O01ngIYImEusG2zJwDkulXbDOI/NfnXdo5432gJ4RY72u/W2xYLwawsRah+/
         A8wxdFT9a3izbcpDIobLBYoynZJReQAB0zxNVj01axT9w6cLQ2Bq928T6dKzCL56jWv+
         A54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=htLKFp766hcMQzfOOpV/QMYraFr7AiP3Zje1XapkJFk=;
        b=BHRTofexpmXDRA77xt6JlvEMYn2ZgiqXS6n6Tb4EKGo+uPb7juzWHoh+y2HDLSFTTm
         J+BE1gIa/BmTwV3o/z2c0rNwNU7Rwl4wwxONr/gUQZug25fvmjJLpjvxlXLLTeL21TXX
         mu81PoyYgHyBnhigAlR8ZeMnJkeXtwD6pd1SFipd5yZQ3YNgOKG7NVZPYa4Esn03Shzd
         oxjWeSXjzLcYG9khMEaq6lBFoHZPL++yqkFxRXG1Hv+lPiZ2CkXCaNH0n2JVyKNj1rzo
         ctjk8CD09ZAseG3J8VVSD4DIsmciKKMhgBT9zigPyMpuORwoQBNvsi4tSYDoqBLOr9+N
         ciHA==
X-Gm-Message-State: AOAM530rRBNWac23jXaIfbxAaQup9J7l5idle6D8mMC6RGcyytqG4lSO
        edxgfqoK99uzFtqhcCExAF+NPQ==
X-Google-Smtp-Source: ABdhPJxJ9NL7AGcNCJo3R+0ONQr/D6w0lvevVOoMAapw07yM0dG8TPGQN2LdTqUclYTQkxBrfbyfUA==
X-Received: by 2002:a63:e045:: with SMTP id n5mr37353614pgj.274.1593928206852;
        Sat, 04 Jul 2020 22:50:06 -0700 (PDT)
Received: from cabot.hitronhub.home (S0106bc4dfb596de3.ek.shawcable.net. [174.0.67.248])
        by smtp.gmail.com with ESMTPSA id n19sm15896098pgb.0.2020.07.04.22.50.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jul 2020 22:50:05 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <96C68654-9923-4994-A191-D40678EB30CD@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_988368CF-FEEF-4474-94CB-9F153E424D74";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: lost matching-pair of trace in ext4_truncate
Date:   Sat, 4 Jul 2020 23:50:03 -0600
In-Reply-To: <20200701083027.45996-1-zhengliang6@huawei.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     zhengliang <zhengliang6@huawei.com>
References: <20200701083027.45996-1-zhengliang6@huawei.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_988368CF-FEEF-4474-94CB-9F153E424D74
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 1, 2020, at 2:30 AM, zhengliang <zhengliang6@huawei.com> wrote:
>=20
> It should call trace exit in all return path for ext4_truncate.
>=20
> v2:
> It shoule call trace exit in all return path, and add "out_trace" =
label to avoid the
> multiple copies of the cleanup code in each error case.
>=20
> Signed-off-by: zhengliang <zhengliang6@huawei.com>

Thanks for the patch.  It looks good.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/inode.c | 17 +++++++++--------
> 1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 10dd470876b3..6187c8880c02 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4163,7 +4163,7 @@ int ext4_truncate(struct inode *inode)
> 	trace_ext4_truncate_enter(inode);
>=20
> 	if (!ext4_can_truncate(inode))
> -		return 0;
> +		goto out_trace;
>=20
> 	if (inode->i_size =3D=3D 0 && !test_opt(inode->i_sb, =
NO_AUTO_DA_ALLOC))
> 		ext4_set_inode_state(inode, EXT4_STATE_DA_ALLOC_CLOSE);
> @@ -4172,16 +4172,14 @@ int ext4_truncate(struct inode *inode)
> 		int has_inline =3D 1;
>=20
> 		err =3D ext4_inline_data_truncate(inode, &has_inline);
> -		if (err)
> -			return err;
> -		if (has_inline)
> -			return 0;
> +		if (err || has_inline)
> +			goto out_trace;
> 	}
>=20
> 	/* If we zero-out tail of the page, we have to create jinode for =
jbd2 */
> 	if (inode->i_size & (inode->i_sb->s_blocksize - 1)) {
> 		if (ext4_inode_attach_jinode(inode) < 0)
> -			return 0;
> +			goto out_trace;
> 	}
>=20
> 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> @@ -4190,8 +4188,10 @@ int ext4_truncate(struct inode *inode)
> 		credits =3D ext4_blocks_for_truncate(inode);
>=20
> 	handle =3D ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
> -	if (IS_ERR(handle))
> -		return PTR_ERR(handle);
> +	if (IS_ERR(handle)) {
> +		err =3D PTR_ERR(handle);
> +		goto out_trace;
> +	}
>=20
> 	if (inode->i_size & (inode->i_sb->s_blocksize - 1))
> 		ext4_block_truncate_page(handle, mapping, =
inode->i_size);
> @@ -4242,6 +4242,7 @@ int ext4_truncate(struct inode *inode)
> 		err =3D err2;
> 	ext4_journal_stop(handle);
>=20
> +out_trace:
> 	trace_ext4_truncate_exit(inode);
> 	return err;
> }
> --
> 2.17.1
>=20


Cheers, Andreas






--Apple-Mail=_988368CF-FEEF-4474-94CB-9F153E424D74
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8BagsACgkQcqXauRfM
H+C8aw//Yi5NvSHTLXdxPMSLUs6Jc+Wn7ir/SJOsoCFbsS2/ING0TCk9WyvqXcKC
sn0f2XX33lsIDk9y2Qhn/s04AQBEYaAX1HFlpHTrTluB89LVjPSFaqZb4TtoD3qF
yw0okT5LjrwJDVOVS86AW6geFgHs30RJMiyej/aZB3miUVZQmsHZuWNYrMJS/HWZ
uRlhtDjTzfXg2qDwM+eopjhQsgHi1+mKMDSrmg8iLtn0AoRK3in6+Onzk6Tzs+hr
HMnvNJ0bbpNr544LTmJb4UEuwe86MmRnspZ2GczD6fF9urVbwYKSAkSpWXe2upSA
OaYNLlK2Rg8Fz1ut7hTKfCWh82Qd7EsL68TW7cgtWmcKvdHCwmLIYYtNA2XUhVLN
SJ3VDD8gJ8WJzuXlrwjiMR8Rg8Evru22RS2fPjWv4U9BA7ZaHeRnPPzdYTL9l3ah
Rv9qQrfTOEceT8x8dq4rN+joGbWECA1JWLBgExSuA3zMkoRxcWfU8NTiPGo1VU7p
Ev8NCYiRj21auKp6/igQoZetX7jGEDZYYycohDaLNV1S3AGE6N9GOvxZQd1atC+p
xxMM2G4zzn+U7j+q8jg1J4/3PR3jVsH55zfVEVd3pKSMLmm8MZKeW1TvV5RAX5sV
4ULOZSGXW02c2obi36pA8RrgUahL6mGx8E4BRoObJM/PBOgJbrY=
=5nZR
-----END PGP SIGNATURE-----

--Apple-Mail=_988368CF-FEEF-4474-94CB-9F153E424D74--
