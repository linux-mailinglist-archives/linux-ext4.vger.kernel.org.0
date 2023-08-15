Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF6977C6E4
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 07:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbjHOFEq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 01:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjHOFEU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 01:04:20 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F6D10D4
        for <linux-ext4@vger.kernel.org>; Mon, 14 Aug 2023 22:04:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bdb801c667so30422605ad.1
        for <linux-ext4@vger.kernel.org>; Mon, 14 Aug 2023 22:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1692075857; x=1692680657;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=A7KYfRBVBqWm/1dvovKNMCr+3jU6Gz4i1ljH3tWKIoc=;
        b=FGgG04JuJiG9Ylgl2ipd8fDbrgSL3EQzCnFQ4cMOisUgbdfIZ6Kodu2qGvowfKNWA8
         VWxAcQ2mwILTSVAkZgVi2wexFZ9z76+FVR6nCSJRTFgCTtN87lwb+fUDTJs8a1Jb68zH
         CQj7WmpS+ORXENyKTLzkLzZqQXz9wRmH16seDKO0ydd2FQYfN/KdMxO724QEfvDnGZTN
         wTXgNgNQWuDNQkRiGfAsiJ3lCpdr9ssPTxquMzU7jjsV6vv+rJcjmqpnt1kBOVcsnH8F
         NQYsc21RRTJPzjhLmlwrAw7bd0Sz17Oi9xJVMiHqevrADzLFRT7kSrjSN2zTRm0RvXMQ
         fG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692075857; x=1692680657;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7KYfRBVBqWm/1dvovKNMCr+3jU6Gz4i1ljH3tWKIoc=;
        b=f59GobIgTM+8FLPyUJgu+RhbaRXQXJj/bW0wgnzTFjv7kNIWG1zMo7BuE7YPhoywRI
         NKZaP+hUScgC+JYoTsGdy1mvFBrmeUkLisDvlOgtT4nHYhsqkowAQfoe22Sqvp7Sk5rn
         rPv9mfcYA1Fetylg7eRrdWnR7WJf47vvV66ZttEcmk/4MghaFBpevKhOi9jMf0h9/ZAv
         dQ/rX4nDa+W0H49FQLAJpyattTLNq+QdBmm/XrFeUbMwGhIKJPx3V724ufiu8/fGC8hq
         nSpMaa9s4G60Mj3XgJYpBepVyDx0KniaX0t7suS1MpFHhlQFIpWBW4ady8J/+OV0OB+r
         TS8w==
X-Gm-Message-State: AOJu0YxYsTKZTE8cPOaxNwgv2l6RDcW24sA6Nws3N6lP8R1qc7AZBti/
        quEICay57Qgx2BYKqyPJWTnvwQ==
X-Google-Smtp-Source: AGHT+IHr0unMs9ECODZSyAjCjYMt+AmDln8qvzSrpt8fmEuKO1dZbZY6zXx/rFGGodpYLPAZuj0zCQ==
X-Received: by 2002:a17:902:be08:b0:1b8:8af0:416f with SMTP id r8-20020a170902be0800b001b88af0416fmr11136621pls.1.1692075857200;
        Mon, 14 Aug 2023 22:04:17 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902b58b00b001b83e624eecsm10381752pls.81.2023.08.14.22.04.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Aug 2023 22:04:16 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <EA9B393E-D7BF-4D47-96EA-661EB96E9F14@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A15D9A76-36CD-4BFF-B0A2-67C01911250C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ext4: introduce EXT4_BG_TRIMMED to optimize fstrim
Date:   Mon, 14 Aug 2023 23:04:14 -0600
In-Reply-To: <20230811061905.301124-1-dongyangli@ddn.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Shuichi Ihara <sihara@ddn.com>,
        Wang Shilong <wangshilong1991@gmail.com>
To:     Li Dongyang <dongyangli@ddn.com>
References: <20230811061905.301124-1-dongyangli@ddn.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_A15D9A76-36CD-4BFF-B0A2-67C01911250C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 11, 2023, at 12:19 AM, Li Dongyang <dongyangli@ddn.com> wrote:
>=20
> Currently the flag indicating block group has done fstrim is not
> persistent, and trim status will be lost after remount, as
> a result fstrim can not skip the already trimmed groups, which
> could be slow on very large devices.
>=20
> This patch introduces a new block group flag EXT4_BG_TRIMMED,
> we need 1 extra block group descriptor write after trimming each
> block group.
> When clearing the flag, the block group descriptor is journalled
> already so no extra overhead.
>=20
> Add a new super block flag EXT2_FLAGS_TRACK_TRIM, to indicate if
> we should honour EXT4_BG_TRIMMED when doing fstrim.
> The new super block flag can be turned on/off via tune2fs.

Dongyang,
I think this is not *quite* correct in the case where the TRACK_TRIM =
flag
is not set.  I agree we want the BG_TRIMMED flag to always be cleared in
that case when blocks are freed in a group (this has no added cost, and
will maintain correctness even if the feature is disabled).

However, it doesn't look like the patch will skip *writing* the flag if
the TRACK_TRIM flag is unset, which would also add needless overhead in
that case.  I think it is OK to set the flag in memory to maintain the
same behavior as today, and writing it to disk is fine (it will be =
ignored
anyway), but it shouldn't trigger an extra transaction.

> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 21b903fe546e..80283be01363 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6995,10 +6993,19 @@ ext4_trim_all_free(struct super_block *sb, =
ext4_group_t group,
> 		   ext4_grpblk_t minblocks, bool set_trimmed)
> {
> 	struct ext4_buddy e4b;
> +	struct ext4_super_block *es =3D EXT4_SB(sb)->s_es;
> +	struct ext4_group_desc *gdp;
> +	struct buffer_head *gd_bh;
> 	int ret;
>=20
> 	trace_ext4_trim_all_free(sb, group, start, max);
>=20
> +	gdp =3D ext4_get_group_desc(sb, group, &gd_bh);
> +	if (!gdp) {
> +		ret =3D -EIO;
> +		return ret;
> +	}
> +
> 	ret =3D ext4_mb_load_buddy(sb, group, &e4b);
> 	if (ret) {
> 		ext4_warning(sb, "Error %d loading buddy information for =
%u",
> @@ -7008,11 +7015,10 @@ ext4_trim_all_free(struct super_block *sb, =
ext4_group_t group,
>=20
> 	ext4_lock_group(sb, group);
>=20
> -	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
> +	if (!(es->s_flags & cpu_to_le16(EXT2_FLAGS_TRACK_TRIM) &&
> +	      gdp->bg_flags & cpu_to_le16(EXT4_BG_TRIMMED)) ||
> 	    minblocks < EXT4_SB(sb)->s_last_trim_minblks) {

I think this should still *send* the TRIM request if BG_TRIMMED is not
set, regardless of whether TRACK_TRIM is set or not, it should just
not save the flag to disk below.

> 		ret =3D ext4_try_to_trim_range(sb, &e4b, start, max, =
minblocks);
> -		if (ret >=3D 0 && set_trimmed)
> -			EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);

This should clear the "set_trimmed" flag if there was an error, so the
flag is not set below.

> 	} else {
> 		ret =3D 0;
> 	}
> @@ -7020,6 +7026,34 @@ ext4_trim_all_free(struct super_block *sb, =
ext4_group_t group,
> 	ext4_unlock_group(sb, group);
> 	ext4_mb_unload_buddy(&e4b);
>=20
> +	if (ret > 0 && set_trimmed) {

Here, this should check the TRACK_TRIM flag and not force the GDT write
if the feature is disabled.  *Not* writing the flag to disk is fine, at
worst it means that another TRIM would be sent in case of a crash, which
is what happened before this patch.  Only the BG_TRIMMED flag should be
set in the group descriptor in that case, based on the flag saved above.

Cheers, Andreas

> +		int err;
> +		handle_t *handle;
> +
> +		handle =3D ext4_journal_start_sb(sb, EXT4_HT_FS_TRIM, =
1);
> +		if (IS_ERR(handle)) {
> +			ret =3D PTR_ERR(handle);
> +			goto out_return;
> +		}
> +		err =3D ext4_journal_get_write_access(handle, sb, gd_bh,
> +						    EXT4_JTR_NONE);
> +		if (err) {
> +			ret =3D err;
> +			goto out_journal;
> +		}
> +		ext4_lock_group(sb, group);
> +		gdp->bg_flags |=3D cpu_to_le16(EXT4_BG_TRIMMED);
> +		ext4_group_desc_csum_set(sb, group, gdp);
> +		ext4_unlock_group(sb, group);
> +		err =3D ext4_handle_dirty_metadata(handle, NULL, gd_bh);
> +		if (err)
> +			ret =3D err;
> +out_journal:
> +		err =3D ext4_journal_stop(handle);
> +		if (err)
> +			ret =3D err;
> +	}
> +out_return:
> 	ext4_debug("trimmed %d blocks in the group %d\n",
> 		ret, group);
>=20
> --
> 2.41.0
>=20


Cheers, Andreas






--Apple-Mail=_A15D9A76-36CD-4BFF-B0A2-67C01911250C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmTbB04ACgkQcqXauRfM
H+CBYQ/+K9wA0uK1/a/j8kYi0Was84d1qJmaph86v/QvTDJwHROMSdYOcTWm77Z2
Tnjhsndd3jptVQlFZoyVFOxy85yJCt6yjgc+SfJYDLLYw8N3DI9xTY6kmND+HJ6K
ap14YtOI6M9Dzc5kjN2hC1im6lMVRytEA1OJq3ssCkfgYseQ9iD4MDXR37H3lzZg
ovLvSo4tef1uwpoFlQFg20I/GXRdVQ3L1uMe/LeCOUOvbK43KLBoCI5JVuLMl2RQ
2YCIbCUs49peq9uc1sGwa9RG6eaO3jZ/fJhsgqAoCC9pxSsidoIX2ddE+71XBjLg
gd5RYpg4J6vzxijgu4pc+sBBLKtZsQQHW2wVupm82tsnufbVFzkcUuU8NE2rGx5h
rtLXwGPmDHpdieq/kWPRsjpxdVMYrZ2icmxQMKHobjH/9s6gbYRj4avDgcyQ6Nyh
lMQHhgJmZw0iWRDKdV7cGWbWYvSVFXG2l/TbXdeEoQzgrAn3djbm3yyUBmHddf7l
YhNHrOu6q4T1QNaLmad4loNbn+o84c+n1o+6B5f55NojRiaLms0pU+vVR+DYeaxB
vFmIIt8vOhoScGCdC6fPNdqSRODLSt7g8SsD9kSqtf68RgDNKcQkvcOp013aPnS4
8CnR2yFuB/NRhDanhmkuqTp/dAlk3i7sIqjG/euJ/nYjFiI3xJM=
=hBHS
-----END PGP SIGNATURE-----

--Apple-Mail=_A15D9A76-36CD-4BFF-B0A2-67C01911250C--
