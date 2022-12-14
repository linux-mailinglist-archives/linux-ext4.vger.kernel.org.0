Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDCE64D1B6
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Dec 2022 22:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiLNVZK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Dec 2022 16:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiLNVYz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Dec 2022 16:24:55 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737D836D5E
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 13:24:53 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id fy4so8391340pjb.0
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 13:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=38MlAxyPONVuvbS3bF0WGgUXHpVNxeLmf/dWtxiNfTw=;
        b=wzTLzg9pqIgKsi7S0q73XKuHFznAHX9nZHEINWgBIDCUc3N+GGnmbzkJ2bR2QNYElk
         FlujEA50TAqLsBzAqhISQ1gyoWb0ZvLWgjiCN2/2Ys1YyKhD1YP7LSv69eJCklhHEWpE
         yhp9tKK6ZNsuO7wJt93uCoAVqXPbzE2uX+9jwo3Pw82jmJqBKCqtoQbrXdgITIbKxxN2
         QPLpJdW1EL90oopAv4n832b6xsHeqi/ln25qirk9P7rW/FLKUWnzpq66eJLQjLTljDaT
         POLbCXed9tZWG7HNVh9frenD1dT5maXUP054IR7XU0GFwN9DGgAc4FF65xoBNmukFdJv
         zCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38MlAxyPONVuvbS3bF0WGgUXHpVNxeLmf/dWtxiNfTw=;
        b=73qKRPU0GaEEnDgXIxjSLHOJaIalWHgdr/LgdmkNjdoqb3+zHEz3wIHeJVcNyZcOE8
         qBAPXU0LU7W7DxPzKxTsxJeOq/zmd0rrw1qVDU55znDTWZcrgcunD/9yqQPziho25t0x
         d6smwmr7g2t8nM4xjuBG1ivkiwLVk/zT9b8WSNaZ51DgKEyQ2qSHCm7halJ6If7gj51i
         s78CkPxjk/qVJ+HfQNdIIUQO3hjlNS073cnnZgkRY7rEGWbF+5NtHckVQqPP1SiOovsr
         UWg/QTc1F0B4hxCxNMBmn6y2bW7rK9KyDIESor3bk9YXskDlk2wYSMKeGNFBSDhjj9UM
         t0yg==
X-Gm-Message-State: ANoB5pnTSHEXSBjMqhzSYV5an7RTD7D08fUKHWqyo3XxMlMfUWkssP7w
        UytvlI5yei7aVjQx2gmJiWE85Q==
X-Google-Smtp-Source: AA0mqf7maufn0R88+Zbmd9cEhor9PYbyN/GvF9HynuHw4shr+kz+iDQfxGTYJocZrEBQS9tW406dSg==
X-Received: by 2002:a17:902:e851:b0:189:a6b4:91ed with SMTP id t17-20020a170902e85100b00189a6b491edmr35942867plg.17.1671053092976;
        Wed, 14 Dec 2022 13:24:52 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b00186748fe6ccsm2294064plh.214.2022.12.14.13.24.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Dec 2022 13:24:52 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <83D3872A-E269-477D-8D2E-CA2AF80D658A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_353F2A8B-789B-4AAB-95B5-AA663F50BB99";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFCv1 18/72] libext2fs: Add support to get average group count
Date:   Wed, 14 Dec 2022 14:24:50 -0700
In-Reply-To: <7e4f563719aee1970dd1058ca45b0609ae4c7c5f.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wangshilong1991@gmail.com>, Li Xi <lixi@ddn.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
 <7e4f563719aee1970dd1058ca45b0609ae4c7c5f.1667822611.git.ritesh.list@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_353F2A8B-789B-4AAB-95B5-AA663F50BB99
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 7, 2022, at 5:21 AM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> =
wrote:
>=20
> From: Wang Shilong <wshilong@ddn.com>
>=20
> number of threads in pfsck should not exceed flex bg numbers.
> This patch adds the support in libext2fs to calculate
> ext2fs_get_avg_group() which returns an average group
> count which each thread has to scan.
>=20
> fs->fs_num_threads will be set by the client, in this case e2fsck.
> No. of threads will be passed along with -m option while running =
e2fsck.
> That will also set fs->fs_num_threads, which will help in controlling
> the amount of memory consumed to maintain in memory data structures =
(per
> thread) in case of multiple parallel threads (pfsck) to avoid oom.
>=20
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
> lib/ext2fs/ext2fs.h | 32 +++++++++++++++++++++++++++++++-
> 1 file changed, 31 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index b1505f95..6b4926ce 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -279,10 +279,11 @@ struct struct_ext2_filsys {
> 	int				cluster_ratio_bits;
> 	__u16				default_bitmap_type;
> 	__u16				pad;
> +	__u32				fs_num_threads;

=46rom later cleanup patch, fs_num_threads should just use "__u16 pad" =
field.

Otherwise, looks OK.


> 	/*
> 	 * Reserved for future expansion
> 	 */
> -	__u32				reserved[5];
> +	__u32				reserved[4];
>=20
> 	/*
> 	 * Reserved for the use of the calling application.
> @@ -2231,6 +2232,35 @@ ext2fs_orphan_block_tail(ext2_filsys fs, char =
*buf)
> 		sizeof(struct ext4_orphan_block_tail));
> }
>=20
> +static dgrp_t ext2fs_get_avg_group(ext2_filsys fs)
> +{
> +#ifdef HAVE_PTHREAD
> +	dgrp_t average_group;
> +	unsigned flexbg_size;
> +
> +	if (fs->fs_num_threads <=3D 1)
> +		return fs->group_desc_count;
> +
> +	average_group =3D fs->group_desc_count / fs->fs_num_threads;
> +	if (average_group <=3D 1)
> +		return 1;
> +
> +	if (ext2fs_has_feature_flex_bg(fs->super)) {
> +		int times =3D 1;
> +
> +		flexbg_size =3D 1 << fs->super->s_log_groups_per_flex;
> +		if (average_group % flexbg_size) {
> +			times =3D average_group / flexbg_size;
> +			average_group =3D times * flexbg_size;
> +		}
> +	}
> +
> +	return average_group;
> +#else
> +	return fs->group_desc_count;
> +#endif
> +}
> +
> #undef _INLINE_
> #endif
>=20
> --
> 2.37.3
>=20


Cheers, Andreas






--Apple-Mail=_353F2A8B-789B-4AAB-95B5-AA663F50BB99
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmOaPyIACgkQcqXauRfM
H+BXnQ//d3kV9OyLF1tT9Mxbzv0Cwo/RJ6tu+trpQESCqi6LouRr2taGuv1hkTX7
y741tq0kITV6SLlQw411VV0/Gpz3kvGF7MXWb4UE11DAtVEeErGvKUn2v1WhbM2r
yGYQ//PeblWoBbMFDoSzgOWUyeQXy6ZimZak8XjEh/a4Yr/zFPmeb6ei1dAbe0xG
KPrkqxASQy6RW2wMxjabkPhcV6ntaSdJpYjdZzFKBC3UaiDz9IIYimrjf2QT/CND
BxcwcGTAVEX4WlrsONY/pfEqMYsWMcJ8tsOz2TyqVdWmFH4aXHK7lO+JJFJhayC+
L6+jiKySLaZFZwZw9DNvJ4PqGTrV2XThbCul9AsolUKIkqcQr2577ccud6qM3tF0
WZ6TZe/w6Im5d6poehpCP8O8gJ+2d9+xYcvH7y5ZSUFeSaY43cf8+34uB+h50wRU
BD51ZIAh88KAoi1eBe+r46PtmR8OeJRvjEQRo30OW5M4hAbIcpCAu2ugUo4fK/mH
0t50WfCuctM4Rj/jQjD2tFhrSgvY+qBiLseAGFGLR7NrZK+nIAZe8nyq1NBwdGMm
1RGgUEHMqGDLsTOM++0uhBfmoCQfv3JxwTdyRtC7vZ1ZDyDurXGw0EwhiWR/Guzj
VHN4LbF9pKEK8SKrrvWZk2pb1ONGg4che1ypL6n7fNYAQ4ATNj8=
=xxnC
-----END PGP SIGNATURE-----

--Apple-Mail=_353F2A8B-789B-4AAB-95B5-AA663F50BB99--
