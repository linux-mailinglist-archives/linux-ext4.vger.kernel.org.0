Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B8133C723
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Mar 2021 20:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhCOTx3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Mar 2021 15:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbhCOTxB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Mar 2021 15:53:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58109C06174A
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 12:53:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so141114pjb.0
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=HO3hnDhbh+w6AwmTYhfooJbOvB/zXedociBZVtAwWtE=;
        b=ZfUcj5q266g/89W16sBrInKtxpV36hIl/21VbLaGlSaSnZeWtNDAEkbCXunsb3/kyC
         /L8Zj1adgG9C8wUTlk8xyIb2A9eok9KKiXPzOXsUW0pgTzuZr0RJAti26jjrFoPMiUIt
         KX77A65kPy7O/WfjvRwQZQ6ju4AnITYwhNuzZyv76xyxtk4Xekg81RCnmNz96Pb8m2TS
         56KvQVR+vbUb6pYoxoGIH9+YUv4nB/Sojmj/JzH+7EA+k4h2+OVr7qBiUOvTL0ihqLk0
         /6xVzbPvbigYhVwPfgPHcIzI/LAjF+LI1l7FLkH8F96KTtbOxnL2DViromCbbLSjw7ah
         YT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=HO3hnDhbh+w6AwmTYhfooJbOvB/zXedociBZVtAwWtE=;
        b=OtZLp4vKClc0HgPCh9rCSm6L75IVGYetgm461akl+ChFks9zW3TgQCQX3PpYm0nTVS
         IUMgDcy86fGXP9W2h6ncyGO5OvlscTMbc2TeWzH1FPjJeLWfqUL08l20V3szcKKc1QPT
         U/tS+gZFuv9AZumFcsAC10YRMD2hhkd8DMSiQASJJdAkuDrHN1gP1qScGuy9uHqRDvCS
         jD8TxqZ92KqtRxQNNVGsAG+4wCS7+J2e4JwGRtPWTVqFBJM6TZ4auiCDJRBFPKgiK2Di
         n1EiRgXgJt+3mD1k5J2veWOnMrvjLItUykasMHNgvb3ANTSBEo/yO8ZdZZYpXSe8D7jc
         92ig==
X-Gm-Message-State: AOAM531QwtBcbVTnnBF8dnZwlMDldgQWkZN+4mVGwIb5sNB2d0+KUHkX
        WA9EcZTRWITTKNr326cKUgt3tJ2TtM5klPjp
X-Google-Smtp-Source: ABdhPJzpBuQWGVl7IM7ktijj5XB6jje6KWpc3xwfq/5+sA/iS+/znY0sZz+NooTuQ3apg9IgyvJFmA==
X-Received: by 2002:a17:90a:bf91:: with SMTP id d17mr761535pjs.138.1615837980929;
        Mon, 15 Mar 2021 12:53:00 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id r184sm14163622pfc.107.2021.03.15.12.52.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 12:53:00 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <DAE182A4-3B2A-4521-A5FB-84C7B55DB5A5@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_596BA404-EB1B-4E94-BF12-C4337EF6A3CB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4 6/6] ext4: add proc files to monitor new structures
Date:   Mon, 15 Mar 2021 13:52:59 -0600
In-Reply-To: <20210315173716.360726-7-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
 <20210315173716.360726-7-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_596BA404-EB1B-4E94-BF12-C4337EF6A3CB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 15, 2021, at 11:37 AM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> This patch adds a new file "mb_structs_summary" which allows us to see
> the summary of the new allocator structures added in this
> series. Here's the sample output of file:
>=20
> optimize_scan: 1
> max_free_order_lists:
>        list_order_0_groups: 0
>        list_order_1_groups: 0
>        list_order_2_groups: 0
>        list_order_3_groups: 0
>        list_order_4_groups: 0
>        list_order_5_groups: 0
>        list_order_6_groups: 0
>        list_order_7_groups: 0
>        list_order_8_groups: 0
>        list_order_9_groups: 0
>        list_order_10_groups: 0
>        list_order_11_groups: 0
>        list_order_12_groups: 0
>        list_order_13_groups: 40
> fragment_size_tree:
>        tree_min: 16384
>        tree_max: 32768
>        tree_nodes: 40
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/ext4.h    |  1 +
> fs/ext4/mballoc.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++
> fs/ext4/sysfs.c   |  2 ++
> 3 files changed, 89 insertions(+)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 5930c8cb5159..f6a36a0e07c1 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2822,6 +2822,7 @@ int __init ext4_fc_init_dentry_cache(void);
>=20
> /* mballoc.c */
> extern const struct seq_operations ext4_mb_seq_groups_ops;
> +extern const struct seq_operations ext4_mb_seq_structs_summary_ops;
> extern long ext4_mb_stats;
> extern long ext4_mb_max_to_scan;
> extern int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset);
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index fb53ec1e1d37..7ce1d1283fd9 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2945,6 +2945,92 @@ int ext4_seq_mb_stats_show(struct seq_file =
*seq, void *offset)
> 	return 0;
> }
>=20
> +static void *ext4_mb_seq_structs_summary_start(struct seq_file *seq, =
loff_t *pos)
> +{
> +	struct super_block *sb =3D PDE_DATA(file_inode(seq->file));
> +	unsigned long position;
> +
> +	read_lock(&EXT4_SB(sb)->s_mb_rb_lock);
> +
> +	if (*pos < 0 || *pos >=3D MB_NUM_ORDERS(sb) + 1)
> +		return NULL;
> +	position =3D *pos + 1;
> +	return (void *) ((unsigned long) position);
> +}
> +
> +static void *ext4_mb_seq_structs_summary_next(struct seq_file *seq, =
void *v, loff_t *pos)
> +{
> +	struct super_block *sb =3D PDE_DATA(file_inode(seq->file));
> +	unsigned long position;
> +
> +	++*pos;
> +	if (*pos < 0 || *pos >=3D MB_NUM_ORDERS(sb) + 1)
> +		return NULL;
> +	position =3D *pos + 1;
> +	return (void *) ((unsigned long) position);
> +}
> +
> +static int ext4_mb_seq_structs_summary_show(struct seq_file *seq, =
void *v)
> +{
> +	struct super_block *sb =3D PDE_DATA(file_inode(seq->file));
> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> +	unsigned long position =3D ((unsigned long) v);
> +	struct ext4_group_info *grp;
> +	struct rb_node *n;
> +	unsigned int count, min, max;
> +
> +	position--;
> +	if (position >=3D MB_NUM_ORDERS(sb)) {
> +		seq_puts(seq, "fragment_size_tree:\n");
> +		n =3D rb_first(&sbi->s_mb_avg_fragment_size_root);
> +		if (!n) {
> +			seq_puts(seq, "\ttree_min: 0\n\ttree_max: =
0\n\ttree_nodes: 0\n");
> +			return 0;
> +		}
> +		grp =3D rb_entry(n, struct ext4_group_info, =
bb_avg_fragment_size_rb);
> +		min =3D grp->bb_fragments ? grp->bb_free / =
grp->bb_fragments : 0;
> +		count =3D 1;
> +		while (rb_next(n)) {
> +			count++;
> +			n =3D rb_next(n);
> +		}
> +		grp =3D rb_entry(n, struct ext4_group_info, =
bb_avg_fragment_size_rb);
> +		max =3D grp->bb_fragments ? grp->bb_free / =
grp->bb_fragments : 0;
> +
> +		seq_printf(seq, "\ttree_min: %u\n\ttree_max: =
%u\n\ttree_nodes: %u\n",
> +			   min, max, count);
> +		return 0;
> +	}
> +
> +	if (position =3D=3D 0) {
> +		seq_printf(seq, "optimize_scan: %d\n",
> +			   test_opt2(sb, MB_OPTIMIZE_SCAN) ? 1 : 0);
> +		seq_puts(seq, "max_free_order_lists:\n");
> +	}
> +	count =3D 0;
> +	list_for_each_entry(grp, =
&sbi->s_mb_largest_free_orders[position],
> +			    bb_largest_free_order_node)
> +		count++;
> +	seq_printf(seq, "\tlist_order_%u_groups: %u\n",
> +		   (unsigned int)position, count);
> +
> +	return 0;
> +}
> +
> +static void ext4_mb_seq_structs_summary_stop(struct seq_file *seq, =
void *v)
> +{
> +	struct super_block *sb =3D PDE_DATA(file_inode(seq->file));
> +
> +	read_unlock(&EXT4_SB(sb)->s_mb_rb_lock);
> +}
> +
> +const struct seq_operations ext4_mb_seq_structs_summary_ops =3D {
> +	.start  =3D ext4_mb_seq_structs_summary_start,
> +	.next   =3D ext4_mb_seq_structs_summary_next,
> +	.stop   =3D ext4_mb_seq_structs_summary_stop,
> +	.show   =3D ext4_mb_seq_structs_summary_show,
> +};
> +
> static struct kmem_cache *get_groupinfo_cache(int blocksize_bits)
> {
> 	int cache_index =3D blocksize_bits - EXT4_MIN_BLOCK_LOG_SIZE;
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 16b8a838f631..4a3b78684f83 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -525,6 +525,8 @@ int ext4_register_sysfs(struct super_block *sb)
> 				&ext4_mb_seq_groups_ops, sb);
> 		proc_create_single_data("mb_stats", 0444, sbi->s_proc,
> 				ext4_seq_mb_stats_show, sb);
> +		proc_create_seq_data("mb_structs_summary", 0444, =
sbi->s_proc,
> +				&ext4_mb_seq_structs_summary_ops, sb);
> 	}
> 	return 0;
> }
> --
> 2.31.0.rc2.261.g7f71774620-goog
>=20


Cheers, Andreas






--Apple-Mail=_596BA404-EB1B-4E94-BF12-C4337EF6A3CB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmBPuxsACgkQcqXauRfM
H+CGsg//T6OU5Xodhu0Byfaw35hre8GU7ZR+L8BwWG2/LfigP6DKBqpR4x8u+CR1
av6hVaetNMyIMaaf2hBpbBQIN4BJwzPHJErQgcUiGGfcmm3GRiFhWnLOY432fZta
AGSYcBFEqjXPMTolEEQQCfV2uE1RNgLimvsVYYP3SQmnEVfQ0yiuBFFsRWS6VTDi
GJJgILAH6fjAg0ba56VJWGj6X/O1AVSPFWvFNjnv+5eqeu4qVH9QBGut5/HfeMr9
Jqx6g6aybY8S4zmNMX7LsiDxCLfE9FQRcvMqLkyX4msOpL/v4qj9EpOl9fpQmTle
HRidotfs25E1dsg0UHdN40tSUMi6xgf2PkuPI54FnJb93oeVa8IyHxo4qUcURI0S
PzsgqdzADYbb80uQIEv4LF1SK6QwUfPMbOVwMrqxv2eV+aOSSnhS3elUE7RyjdYH
GugnKzLkwGvRYbaT3ogizyx0QrOD3Gb9thIWH+0kLpvHAqM+E/KQbGvRbfM6OzCY
fNLF9w6IbeG4qsL5lBHI00cDoIpINBPEm5eODOsB+lmEiOafJE6UUb10XqzUciZw
g+pSHmjM/G7ltX5/zLy28wJfjb7CmfW67Jm3pd/+RgcKMsq7iUJWVK/74tfeGjB9
+8pDaLkCfQ6VZ4T5r0sSZg87wPKGapsC1rp43hnjmr4GhqNRgIk=
=wInG
-----END PGP SIGNATURE-----

--Apple-Mail=_596BA404-EB1B-4E94-BF12-C4337EF6A3CB--
