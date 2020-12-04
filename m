Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA962CE461
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Dec 2020 01:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbgLDASz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 19:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730522AbgLDASz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 19:18:55 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39779C061A4F
        for <linux-ext4@vger.kernel.org>; Thu,  3 Dec 2020 16:18:15 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id 4so2116860plk.5
        for <linux-ext4@vger.kernel.org>; Thu, 03 Dec 2020 16:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Djlv40EKKSoCUgXs1R36EXU8d0IhqR/z01r0qDnjP4s=;
        b=j/kRD0wUAtuRWG8EUM7EsHNJObgn8RvuI0kRlx1YalvOJttECp54VbZC+zSDfkMwCV
         LzfGmECj7n9fNY0nQRKZIrhptojhmmg0r1+nonaaaoa4of7Y+ijFQIc1CM1WpaITl1OM
         XXFNLU4UG3Fi7OWIZDNCZXu17/pzLXG3esIlxiqTH4UJdkhpkzAfwFr+eD18IS6CPM+G
         c1ljmBZPkFTM+AArhHsQnW6/ACukziYxCCtsxKZQ0Z0RONXxGXRcA5rIF2KCMsiAE3+r
         3TVLLmiuaoEy90qBuCvV3mW/bL6th5TbRlv5zRgc0urfeA6ksV/EizhHuhV/uLFUqnr8
         9nMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Djlv40EKKSoCUgXs1R36EXU8d0IhqR/z01r0qDnjP4s=;
        b=DLv/TnfeleLi/ZjgOJeASNggoMadJsz9XDMo+XSRZUL58pFp0N/QtA61td1L/TH7iF
         onh/IXSbfnVkywS+MQAlyhfO7sxTbfJkM1uspMO3zOmSpc0XbwwcLtSOkVr6HRIoqQVd
         MJkN+ui730/Xt+ikCrU8FkLTtTkzv+pNMKeDbkM945eH0//usM/jfA4mezOupHyxznlJ
         nIOptyPBZx65lOUIS6PK8ZdOdahqqZwXtA3Vcpdg6DH/IyzM3seeGlYRFBis9uRrpejV
         1TMZSEhyagN44L38nAaoK6PNxLhY/6JiBao3GGScRedUMELQlnhksvf7ytzSAF0r/2SD
         JaFw==
X-Gm-Message-State: AOAM530ZZyw6SssCtFP9BhZVTKRcvfrGxW9UtBAzgci32AgktP9eporj
        HMikfpQ6UCQguEjtnA9yprEfXg==
X-Google-Smtp-Source: ABdhPJyT+nA4pZE3774wkBQndYiGb7WLgts5n2Kh8DUi/IYyp+IlBNZZbN1FD9J+eo9KQhW9pEHYrg==
X-Received: by 2002:a17:902:b408:b029:d6:d1e2:e1be with SMTP id x8-20020a170902b408b02900d6d1e2e1bemr1476259plr.34.1607041094660;
        Thu, 03 Dec 2020 16:18:14 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x5sm412862pjr.38.2020.12.03.16.18.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 16:18:13 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <EAE41980-F834-44D2-B882-EBE3790A39B9@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F2CE5FCA-0B87-4B7A-BC7A-4273CC56D292";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: avoid s_mb_prefetch to be zero in individual
 scenarios
Date:   Thu, 3 Dec 2020 17:18:10 -0700
In-Reply-To: <1606794575-6230-1-git-send-email-brookxu@tencent.com>
Cc:     Ted Tso <tytso@mit.edu>, Alex Zhuravlev <bzzz@whamcloud.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Chunguang Xu <brookxu.cn@gmail.com>
References: <1606794575-6230-1-git-send-email-brookxu@tencent.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_F2CE5FCA-0B87-4B7A-BC7A-4273CC56D292
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 30, 2020, at 8:49 PM, Chunguang Xu <brookxu.cn@gmail.com> wrote:
>=20
> From: Chunguang Xu <brookxu@tencent.com>
>=20
> patch cfd7323 introduces block bitmap prefetch, and expects to read
> block bitmaps of flex_bg through an IO. However, it seems to ignore
> the value range of s_log_groups_per_flex. In the scenario where the
> value of s_log_groups_per_flex is greater than 27, s_mb_prefetch or
> s_mb_prefetch_limit will overflow, cause a divide zero exception.
>=20
> In addition, the logic of calculating nr maybe also flawed, because
> the size of flexbg is fixed during a single mount, but s_mb_prefetch
> can be modified, which causes nr to fail to meet the value condition
> of [1, flexbg_size].
>=20
> PID: 3873   TASK: ffff88800f11d880  CPU: 2   COMMAND: "executor"
> #0 [ffff8880114a6ec0] __show_regs.cold.7 at ffffffff83cf29e2
> #1 [ffff8880114a6f40] do_trap at ffffffff81065c61
> #2 [ffff8880114a6f98] do_error_trap at ffffffff81065d65
> #3 [ffff8880114a6fe0] exc_divide_error at ffffffff83dd2fd4
> #4 [ffff8880114a7000] asm_exc_divide_error at ffffffff83e00872
>    [exception RIP: ext4_mb_regular_allocator+3885]
>    RIP: ffffffff8191258d  RSP: ffff8880114a70b8  RFLAGS: 00010246
>    RAX: 0000000000000000  RBX: 0000000000000000  RCX: ffffffff8191257a
>    RDX: 0000000000000000  RSI: 0000000000000000  RDI: 0000000000000005
>    RBP: 0000000000000200   R8: ffff88800f11d880   R9: ffffed1001e23b11
>    R10: ffff88800f11d887  R11: ffffed1001e23b10  R12: ffff888010147000
>    R13: 0000000000000000  R14: 0000000000000002  R15: dffffc0000000000
>    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> #5 [ffff8880114a7260] ext4_mb_new_blocks at ffffffff8191b6ba
> #6 [ffff8880114a7420] ext4_new_meta_blocks at ffffffff81870d6f
> #7 [ffff8880114a74e8] ext4_xattr_block_set at ffffffff819ced37
> #8 [ffff8880114a7758] ext4_xattr_set_handle at ffffffff819d4776
> #9 [ffff8880114a7928] ext4_xattr_set at ffffffff819d501b
>    RIP: 000000000045eb29  RSP: 00007ff74e97bc38  RFLAGS: 00000246
>    RAX: ffffffffffffffda  RBX: 000000000055bf00  RCX: 000000000045eb29
>    RDX: 00000000200000c0  RSI: 0000000020000080  RDI: 0000000020000040
>    RBP: 00000000004b068e   R8: 0000000000000001   R9: 0000000000000000
>    R10: 0000000000000002  R11: 0000000000000246  R12: 000000000055bf00
>    R13: 00007fff50fc111f  R14: 00007ff74e97bdc0  R15: 0000000000022000
>    ORIG_RAX: 00000000000000bc  CS: 0033  SS: 002b
>=20
> The maximum size of a single IO will be limited by multiple factors,
> such as max_hw_sectors, max_dev_sectors, BLK_DEF_MAX_SECTORS. The
> max_hw_sectors, max_dev_sectors are determined by the device, and
> BLK_DEF_MAX_SECTORS is a constant. In most scenarios, users will not
> modify max_sectors. Therefore, we can safely assume that the maximum
> size of a single IO is BLK_DEF_MAX_SECTORS. So far, we have determined
> the number of blocks that a single IO can hold. Usually the file
> system block is a multiple of the disk block, but we will ignore this
> for now. According to the current value of BLK_DEF_MAX_SECTORS and

BLK_DEF_MAX_SECTORS is 2560, or 1280KB, which isn't really a good
limit for the IO size.  I think BLK_MAX_SEGMENT_SIZE =3D 65536 =3D 32MB
is a better upper limit to use in this case.  This will almost always
be limited by he actual flexbg size, but provides a reasonable upper
limit that will still be useful into the future.

> comprehensive considerations, the maximum number of bitmap blocks that
> can be loaded by a single IO can be safely limited to 2^12. This maybe
> a good choice to solve divide zero problem and avoiding performance
> degradation.
>=20
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> Reviewed-by: Samuel Liao <samuelliao@tencent.com>
> ---
> fs/ext4/mballoc.c | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 24af9ed..06af4ca 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2395,9 +2395,10 @@ void ext4_mb_prefetch_fini(struct super_block =
*sb, ext4_group_t group,
>=20
> 				nr =3D sbi->s_mb_prefetch;
> 				if (ext4_has_feature_flex_bg(sb)) {
> -					nr =3D (group / =
sbi->s_mb_prefetch) *
> -						sbi->s_mb_prefetch;
> -					nr =3D nr + sbi->s_mb_prefetch - =
group;
> +					nr =3D 1 << =
sbi->s_log_groups_per_flex;
> +					if (group & (nr - 1))
> +						nr -=3D group & (nr - =
1);
> +					nr =3D min(nr, =
sbi->s_mb_prefetch);
> 				}
> 				prefetch_grp =3D ext4_mb_prefetch(sb, =
group,
> 							nr, =
&prefetch_ios);
> @@ -2700,7 +2701,7 @@ static int ext4_mb_init_backend(struct =
super_block *sb)
> 	ext4_group_t ngroups =3D ext4_get_groups_count(sb);
> 	ext4_group_t i;
> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> -	int err;
> +	int err, log;

(style) this variable should be declared inside the block below.

> 	struct ext4_group_desc *desc;
> 	struct ext4_group_info ***group_info;
> 	struct kmem_cache *cachep;
> @@ -2733,7 +2734,8 @@ static int ext4_mb_init_backend(struct =
super_block *sb)
>=20
> 	if (ext4_has_feature_flex_bg(sb)) {
> 		/* a single flex group is supposed to be read by a =
single IO */
> -		sbi->s_mb_prefetch =3D 1 << =
sbi->s_es->s_log_groups_per_flex;
> +		log =3D min_t(unsigned char, 12, =
sbi->s_es->s_log_groups_per_flex);
> +		sbi->s_mb_prefetch =3D 1 << log;

Rather than hard-code "12" here, it would be better to use =
BLK_MAX_SEGMENT_SIZE
directly, so that it is clear in the future where this value came from, =
like:

	if (ext4_has_feature_flex_bg(sb)) {
+		unsigned int len;
+
		/* a single flex group is supposed to be read by a =
single IO */
-		sbi->s_mb_prefetch =3D 1 << =
sbi->s_es->s_log_groups_per_flex;
+		len =3D min(BLK_MAX_SEGMENT_SIZE >> =
(sb->s_blocksize_bits - 9),
+			  1 << sbi->s_es->s_log_groups_per_flex);
+		sbi->s_mb_prefetch =3D len;

Note the need for "min_t()" can be avoided by using "1" or "1U" as =
needed in
the second half of "min()" to match the type of BLK_MAX_SEGMENT_SIZE.

Cheers, Andreas






--Apple-Mail=_F2CE5FCA-0B87-4B7A-BC7A-4273CC56D292
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/JgEIACgkQcqXauRfM
H+DLYg/9HdoJA0UDXinet/LorTEY+BZM8HGJmUyNOW1JKfoZyDTP2C+xfO+dE1J0
jPI5J/bGK5FAN7Dz+Cz+zJ45D1jXURbiZTTqAa45mHfukpnvWCNMeQK75wuBem3V
cv+9Ud7WAGOT3gSC2axRybOZ1zb/xvmEZ07x20I2yh3Z+4IGZ8h0PhL4NWmlxLtP
i8cyNeLIaHj2EmEQJ2uUaX71HOiKP6l2Q8oqDIjaW9zuD2vRHtgg/xBFC/aU6bzp
nCuGcl/g0DirK9QNod9aE4C2L1CYNmLlV3K9YVUgUXoE2kqyqJpLq2ahvGkqndll
cCMtUJPlRCpi63zNlkZYkf6KjqzeDoa8R0ikNwMEbuhnx9eZZOFn8gzOIa4q+krz
SejkH1YeqHj5aILbxdhcaDgrgplL/Jubv3jp0vtdmYFE+LMQbOGVCzoAGJAo/6YB
67mY5KlUjDK9FiMZu1U4Xx3hpjbT6N16dmovzUJCbpRwlJBqAVHNiJ2mjgRPd1W8
LBzQ/P1NpjU0+XTvp1tTfIKS7ZjtmMfTpD9q/WUbev91o2sqpCt7r20E3QhsiMIp
VUiWnxaLO++z65km8tqWMmXrUGYdgWZjqOjy/gBuILGvLWadC0kYSm/KJ+hxZKIX
gcrx2kook4Fhzdfj/W7YrX/1HZTP4xk3Xq6VFOfcsq/p5N/fzRw=
=LUTe
-----END PGP SIGNATURE-----

--Apple-Mail=_F2CE5FCA-0B87-4B7A-BC7A-4273CC56D292--
