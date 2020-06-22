Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E321E203DAB
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jun 2020 19:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgFVRSb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Jun 2020 13:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbgFVRSb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Jun 2020 13:18:31 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ACEC061573
        for <linux-ext4@vger.kernel.org>; Mon, 22 Jun 2020 10:18:30 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e9so8430074pgo.9
        for <linux-ext4@vger.kernel.org>; Mon, 22 Jun 2020 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=OkkXi4LWXj76eUlVABFIjT6V7c6/WFwaQxqz25msDIA=;
        b=ptITDOaeVojZom4lkSOimBZvWzJafcHpmE9PqfC3Q2TV+1M+4NnUvHwehWlTlv4J1+
         Ms5Vbzb+Vysx1QbA7rU/u6VjH/2innyLq5K8LHyk810rAM3gwzbzebXAXAhU3DHGW3nX
         KbMNq/BaMEiOC19pEoYRpOhzZNyaR4ls9vgVuSsPuSiz1NLXVat8Fwem+JKMcN8p57W4
         jTBCU+9neME1lznmaeDvOi1KwudgZ3LqfXy1lgNRoHxhgjRA0L29k7AECZh0O3bIDt9d
         s9Uj4vc7B+xNH18V/EDTFYdwdOrvoYQfS5l4dL/cxKyHfL1BnIhrX84dZ6g5eIZ2Wb10
         pE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=OkkXi4LWXj76eUlVABFIjT6V7c6/WFwaQxqz25msDIA=;
        b=s8xwu6wrQ3hA/yBSZFWLfpBdhIBGs54HpKWEo7LBbviY3xoCoilimFYqjaM9WPab5L
         b30HptO+TyuSQ54wD7zAyfRCyxEPvaZ6W/nkuKtroG/h9wtE3dK8O8/G1AtOipuSGT8+
         8xIt2ft124zOgyGE1+Y/P0Bp+8xgTJLBnq4B9lP4Xoii4OfRETh0QSFImyxtb9jVy7RP
         IVTgYWy7amMC/8jMEIAkH7W7Fs+PNuqdpjSIT5WBMyjb1yT54OGSvmH0Js8tjyNlm9HB
         ZXnoaHfLKEW5HXfaWLzXylPSwU5JSuADs48fppKBRRlfCN4s29dTiztFPmHeFeqX6IjY
         PoDg==
X-Gm-Message-State: AOAM531uQ/tT4hLoNI1tQgUvP7YDtcjF73PFoClTeN2hdTUzROmTxG7u
        ZtL5SVKRROg+mmsLDV2tbdtPzw==
X-Google-Smtp-Source: ABdhPJwKQKWFPpq2ZLkkSdXcrTQX8wpcTBdOh1C2j0v4zmiqE1v4qCOlAeuWP6IOqVMjJD/Ygvhiiw==
X-Received: by 2002:a62:1692:: with SMTP id 140mr22101386pfw.168.1592846309591;
        Mon, 22 Jun 2020 10:18:29 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id p12sm11767565pgk.40.2020.06.22.10.18.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 10:18:28 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <9DE41B77-F78B-4108-A312-7BFC05E8E375@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_EDC49F4B-5F58-493A-939C-41F197008BC5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 1/2] ext4: introduce EXT4_BG_WAS_TRIMMED to optimize
 trim
Date:   Mon, 22 Jun 2020 11:18:24 -0600
In-Reply-To: <1592831677-13945-1-git-send-email-wangshilong1991@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Wang Shilong <wshilong@ddn.com>, Shuichi Ihara <sihara@ddn.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
References: <1592831677-13945-1-git-send-email-wangshilong1991@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_EDC49F4B-5F58-493A-939C-41F197008BC5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 22, 2020, at 7:14 AM, Wang Shilong <wangshilong1991@gmail.com> =
wrote:
>=20
> From: Wang Shilong <wshilong@ddn.com>
>=20
> Currently WAS_TRIMMED flag is not persistent, whenever filesystem was
> remounted, fstrim need walk all block groups again, the problem with
> this is FSTRIM could be slow on very large LUN SSD based filesystem.
>=20
> To avoid this kind of problem, we introduce a block group flag
> EXT4_BG_WAS_TRIMMED, the side effect of this is we need introduce
> extra one block group dirty write after trimming block group.
>=20
> And When clearing TRIMMED flag, block group will be journalled
> anyway, so it won't introduce any overhead.
>=20
> Cc: Shuichi Ihara <sihara@ddn.com>
> Cc: Andreas Dilger <adilger@dilger.ca>
> Cc: Wang Shilong <wangshilong1991@gmail.com>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> v2->v3:
> don't renumber EXT4_GROUP_INFO_* bits.
> v1->v2:
> call ext4_journal_get_write_access() before modify buffer.
> ---
> fs/ext4/ext4.h      | 14 +++++------
> fs/ext4/ext4_jbd2.h |  3 ++-
> fs/ext4/mballoc.c   | 59 +++++++++++++++++++++++++++++++++------------
> 3 files changed, 53 insertions(+), 23 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 42f5060f3cdf..252754da2f1b 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -368,6 +368,7 @@ struct flex_groups {
> #define EXT4_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not in use =
*/
> #define EXT4_BG_BLOCK_UNINIT	0x0002 /* Block bitmap not in use */
> #define EXT4_BG_INODE_ZEROED	0x0004 /* On-disk itable initialized to =
zero */
> +#define EXT4_BG_WAS_TRIMMED	0x0008 /* block group was trimmed */
>=20
> /*
>  * Macro-instructions used to manage group descriptors
> @@ -3138,7 +3139,6 @@ struct ext4_group_info {
> };
>=20
> #define EXT4_GROUP_INFO_NEED_INIT_BIT		0
> -#define EXT4_GROUP_INFO_WAS_TRIMMED_BIT		1
> #define EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT	2
> #define EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT	3
> #define EXT4_GROUP_INFO_BBITMAP_CORRUPT		\
> @@ -3153,12 +3153,12 @@ struct ext4_group_info {
> #define EXT4_MB_GRP_IBITMAP_CORRUPT(grp)	\
> 	(test_bit(EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT, =
&((grp)->bb_state)))
>=20
> -#define EXT4_MB_GRP_WAS_TRIMMED(grp)	\
> -	(test_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
> -#define EXT4_MB_GRP_SET_TRIMMED(grp)	\
> -	(set_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
> -#define EXT4_MB_GRP_CLEAR_TRIMMED(grp)	\
> -	(clear_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
> +#define EXT4_MB_GDP_WAS_TRIMMED(gdp)	\
> +	(gdp->bg_flags & cpu_to_le16(EXT4_BG_WAS_TRIMMED))
> +#define EXT4_MB_GDP_SET_TRIMMED(gdp)	\
> +	(gdp->bg_flags |=3D cpu_to_le16(EXT4_BG_WAS_TRIMMED))
> +#define EXT4_MB_GDP_CLEAR_TRIMMED(gdp)	\
> +	(gdp->bg_flags &=3D ~cpu_to_le16(EXT4_BG_WAS_TRIMMED))
>=20
> #define EXT4_MAX_CONTENTION		8
> #define EXT4_CONTENTION_THRESHOLD	2
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 00dc668e052b..a37e438f4b4d 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -123,7 +123,8 @@
> #define EXT4_HT_MOVE_EXTENTS     9
> #define EXT4_HT_XATTR           10
> #define EXT4_HT_EXT_CONVERT     11
> -#define EXT4_HT_MAX             12
> +#define EXT4_HT_FS_TRIM		12
> +#define EXT4_HT_MAX             13
>=20
> /**
>  *   struct ext4_journal_cb_entry - Base structure for callback =
information.
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index c0a331e2feb0..235a316584d0 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2923,15 +2923,6 @@ static void ext4_free_data_in_buddy(struct =
super_block *sb,
> 	rb_erase(&entry->efd_node, &(db->bb_free_root));
> 	mb_free_blocks(NULL, &e4b, entry->efd_start_cluster, =
entry->efd_count);
>=20
> -	/*
> -	 * Clear the trimmed flag for the group so that the next
> -	 * ext4_trim_fs can trim it.
> -	 * If the volume is mounted with -o discard, online discard
> -	 * is supported and the free blocks will be trimmed online.
> -	 */
> -	if (!test_opt(sb, DISCARD))
> -		EXT4_MB_GRP_CLEAR_TRIMMED(db);
> -
> 	if (!db->bb_free_root.rb_node) {
> 		/* No more items in the per group rb tree
> 		 * balance refcounts from ext4_mb_free_metadata()
> @@ -5084,8 +5075,7 @@ void ext4_free_blocks(handle_t *handle, struct =
inode *inode,
> 					 " group:%d block:%d count:%lu =
failed"
> 					 " with %d", block_group, bit, =
count,
> 					 err);
> -		} else
> -			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
> +		}
>=20
> 		ext4_lock_group(sb, block_group);
> 		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
> @@ -5095,6 +5085,14 @@ void ext4_free_blocks(handle_t *handle, struct =
inode *inode,
> 	ret =3D ext4_free_group_clusters(sb, gdp) + count_clusters;
> 	ext4_free_group_clusters_set(sb, gdp, ret);
> 	ext4_block_bitmap_csum_set(sb, block_group, gdp, bitmap_bh);
> +	/*
> +	 * Clear the trimmed flag for the group so that the next
> +	 * ext4_trim_fs can trim it.
> +	 * If the volume is mounted with -o discard, online discard
> +	 * is supported and the free blocks will be trimmed online.
> +	 */
> +	if (!test_opt(sb, DISCARD))
> +		EXT4_MB_GDP_CLEAR_TRIMMED(gdp);
> 	ext4_group_desc_csum_set(sb, block_group, gdp);
> 	ext4_unlock_group(sb, block_group);
>=20
> @@ -5348,8 +5346,15 @@ ext4_trim_all_free(struct super_block *sb, =
ext4_group_t group,
> 	ext4_grpblk_t next, count =3D 0, free_count =3D 0;
> 	struct ext4_buddy e4b;
> 	int ret =3D 0;
> +	struct ext4_group_desc *gdp;
> +	struct buffer_head *gdp_bh;
>=20
> 	trace_ext4_trim_all_free(sb, group, start, max);
> +	gdp =3D ext4_get_group_desc(sb, group, &gdp_bh);
> +	if (!gdp) {
> +		ret =3D -EIO;
> +		return ret;
> +	}
>=20
> 	ret =3D ext4_mb_load_buddy(sb, group, &e4b);
> 	if (ret) {
> @@ -5360,7 +5365,7 @@ ext4_trim_all_free(struct super_block *sb, =
ext4_group_t group,
> 	bitmap =3D e4b.bd_bitmap;
>=20
> 	ext4_lock_group(sb, group);
> -	if (EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) &&
> +	if (EXT4_MB_GDP_WAS_TRIMMED(gdp) &&
> 	    minblocks >=3D =
atomic_read(&EXT4_SB(sb)->s_last_trim_minblks))
> 		goto out;
>=20
> @@ -5399,14 +5404,38 @@ ext4_trim_all_free(struct super_block *sb, =
ext4_group_t group,
> 			break;
> 	}
>=20
> -	if (!ret) {
> +	if (!ret)
> 		ret =3D count;
> -		EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
> -	}
> out:
> 	ext4_unlock_group(sb, group);
> 	ext4_mb_unload_buddy(&e4b);
> +	if (ret > 0) {
> +		int err;
> +		handle_t *handle;
>=20
> +		handle =3D ext4_journal_start_sb(sb, EXT4_HT_FS_TRIM, =
1);
> +		if (IS_ERR(handle)) {
> +			ret =3D PTR_ERR(handle);
> +			goto out_return;
> +		}
> +		err =3D ext4_journal_get_write_access(handle, gdp_bh);
> +		if (err) {
> +			ret =3D err;
> +			goto out_journal;
> +		}
> +		ext4_lock_group(sb, group);
> +		EXT4_MB_GDP_SET_TRIMMED(gdp);
> +		ext4_group_desc_csum_set(sb, group, gdp);
> +		ext4_unlock_group(sb, group);
> +		err =3D ext4_handle_dirty_metadata(handle, NULL, =
gdp_bh);
> +		if (err)
> +			ret =3D err;
> +out_journal:
> +		err =3D ext4_journal_stop(handle);
> +		if (err)
> +			ret =3D err;
> +	}
> +out_return:
> 	ext4_debug("trimmed %d blocks in the group %d\n",
> 		count, group);
>=20
> --
> 2.25.4
>=20


Cheers, Andreas






--Apple-Mail=_EDC49F4B-5F58-493A-939C-41F197008BC5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7w5+AACgkQcqXauRfM
H+DXKw//SHaj3w/VyigzkeTjKiOv+Mz3JIjqR1lmcRwYHC8/iRyYDgiwRbtyoSOg
/w4XXPfHqFpeXfo/UVxgXBJOeWH0fc8QSoB/0JkQLlEllpcxHyCaFQByCjIYYS6G
+NMl0xdSuiUoyy60rbJYxofca8UA+caK1EPrmdlmdxIs1ByZxL0Imv/kSOdXRX7v
uF9y4wIF4fq3oKZHiry7ev+JXhfQoF8QAlnnjtQxpbYN0ccA7HGPPFWk4NKdoF0x
+F6fPmZtt+FmqYP8luNQiiTr68Mes8KtGGwpUoiZQGE0PskFtW1F4ijocxe9S1QE
phPszZ5SaeTwQI35PjXwHFSR9nRHo0nzWKRN2GHco3N/i28NhQSLFXsTC2gVqft0
IVWoV+RhF9lzE2vnOgzhV3KTU+ZlRNOsO2W5jKqnuNxlURXI+33D4lhh6wFnFxmu
oYXoBmgOAmaLFQYSC+7tnE4u08QlSrbxreyzn4J20501AxqSgAADAtcgvIHgNnh9
nvBaXde+C/5qOFHcqhSy7JlyZXGua4pFSUvzPbn5CKKOW8kz4Knxhv4vtikHT66e
1X+IReXJhF0niqPBCUxtg/9rBIU6T14b/GQ2w9kiJVHAeF86WyInbOWSsak/X/Mk
/Oy5trDFMEhAMQj1O2mkhmBqiRisQrHnoZw8MH8YIVllHmnP2tY=
=O9QS
-----END PGP SIGNATURE-----

--Apple-Mail=_EDC49F4B-5F58-493A-939C-41F197008BC5--
