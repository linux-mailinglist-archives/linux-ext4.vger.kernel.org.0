Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB3A3094A2
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Jan 2021 12:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhA3K7M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 Jan 2021 05:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhA3K7H (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 30 Jan 2021 05:59:07 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0899C061573
        for <linux-ext4@vger.kernel.org>; Sat, 30 Jan 2021 02:58:26 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id kx7so7127890pjb.2
        for <linux-ext4@vger.kernel.org>; Sat, 30 Jan 2021 02:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=1xmLTVh+x+bHVQHV+pcks3Pcd/alitj/vGHdUpX2N84=;
        b=CNb22XAqsfZPbrgyOJM7Kp91327MV4mPHzeg1EUY+hwNYB2wYvKNzpldVYNb3DlweE
         iuSQML6UuhMakt8AKRSZNm9IOKsQrq2G76VqKjT6bWZQ7ZD9ijA8OrQpdLMhKPkhq2D8
         o+WtfoKCg3HuTu7pRbePGR6h8A0En+9g+TiDMa3lPCBFcRGV/TusNv59vR7GMSsjJ347
         +cMSSBn3aiBJSwPucdseZ0xecNryPJgCrg9v4mn6MHGD1dQlQ2+HMJXPuZQVc/B19JhU
         +p/TahZBEHARv11nemiCCPWiiAKbn5uXgPNM6Ys8mLVbSoQWbIfTA6HJo52kS10FyUlg
         o3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=1xmLTVh+x+bHVQHV+pcks3Pcd/alitj/vGHdUpX2N84=;
        b=HSaeip2o00pyvtY/TgQWgZtwXnqqqcYRvE33bL8c15gXo2SYaXTiCun+r7MU+jDQkP
         fefj0kjKrWRzWW1B91VpzLLvikZo+W2ebHpx4gyj451d0/UzK+e+3FM5DUjJyUr7iP1u
         jXcIn163bL6TGnvDqWcM8PNh7LBi3tI5cgNbBIevaeBirkGYC10gSi+HdvbIQR/+3XTb
         +aJp2I++AEZuZjwvwTgMO0zCATIirRvHQqW+OXSIYNtt9RTb2MytW64oBgFzrwcCzedg
         Vv91m8PVCqZgfuHE8uY6pbfEWo2SMjJOtv85TGsmtNyMD3PF8oCBZe0ZG+SYhbp2nT4S
         +YTg==
X-Gm-Message-State: AOAM533598ERZGbi4vjO1CL+WBBF0STUErRkQluzhbNx2fNBq59vaYkD
        HxViQ+CgFX1qJVuQsnor//qYjpIqbg1ryiSf
X-Google-Smtp-Source: ABdhPJygqanPVcjqvhykrVh5Btw2eUx/NSeOkBkNUBsaj4noPeCJgeAZX4Vq4f4MpDWq3RGP/dFGGg==
X-Received: by 2002:a17:90a:e547:: with SMTP id ei7mr8905567pjb.34.1612004306143;
        Sat, 30 Jan 2021 02:58:26 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 83sm11508927pfu.134.2021.01.30.02.58.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jan 2021 02:58:25 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D99BC3ED-A31C-49A9-9EE0-F0BC75D78FAE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F3787EB7-12C2-4AFC-9B67-1F52779111DF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 4/4] ext4: add proc files to monitor new structures
Date:   Sat, 30 Jan 2021 03:58:23 -0700
In-Reply-To: <20210129222931.623008-5-harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20210129222931.623008-1-harshadshirwadkar@gmail.com>
 <20210129222931.623008-5-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_F3787EB7-12C2-4AFC-9B67-1F52779111DF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 29, 2021, at 3:29 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> This patch adds a new file "mb_structs" which allows us to see the
> largest free order lists and the serialized average fragment tree.

It might make sense to split these two structs into separate files.
On large filesystems, there will be millions of groups, so having
to dump both structs to find out information about one or the other
would be a lot of overhead.

Also, while the "mb_groups" file can be large (one line per group)
for millions of groups, the files added here may have millions of
groups on the same line.  Text processing tools are used to dealing
with many lines in a file, but are relatively poor at dealing with
millions of characters on a single line...

It would be good to have a "summary" file that dumps general info
about these structs (e.g. the number of groups at each list order,
depth of the rbtree).  That could be maintained easily for the c0
lists at least, since the list is locked whenever a group is added
and removed.

In Artem's patch to improve mballoc for large filesystems (which
didn't land, but was useful anyway), there was an "mb_alloc_stats"
file added:

=
https://github.com/lustre/lustre-release/blob/master/ldiskfs/kernel_patche=
s/patches/rhel8/ext4-simple-blockalloc.patch#L102

/proc/fs/ldiskfs/dm-2/mb_alloc_stats:mballoc:
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:   blocks: 0
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:   reqs: 0
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:   success: 0
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:   extents_scanned: 0
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:           goal_hits: 0
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:           2^n_hits: 0
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:           breaks: 0
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:           lost: 0
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:   useless_c1_loops: 0
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:   useless_c2_loops: 0
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:   useless_c3_loops: 163
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:   skipped_c1_loops: 0
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:   skipped_c2_loops: 1230
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:   skipped_c3_loops: 0
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:   buddies_generated: 6305
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:   buddies_time_used: 20165523
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:   preallocated: 9943702
/proc/fs/ldiskfs/dm-2/mb_alloc_stats:   discarded: 10506

that would still be useful to maintain, since only a few of the lines
are specific to his patch ({useless,skipped}_c[123]_loops)

> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
> fs/ext4/ext4.h    |  1 +
> fs/ext4/mballoc.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++
> fs/ext4/sysfs.c   |  2 ++
> 3 files changed, 82 insertions(+)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index da12a083bf52..835e304e3113 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2809,6 +2809,7 @@ int __init ext4_fc_init_dentry_cache(void);
>=20
> /* mballoc.c */
> extern const struct seq_operations ext4_mb_seq_groups_ops;
> +extern const struct seq_operations ext4_mb_seq_structs_ops;
> extern long ext4_mb_stats;
> extern long ext4_mb_max_to_scan;
> extern int ext4_mb_init(struct super_block *);
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 413259477b03..ec4656903bd4 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2741,6 +2741,85 @@ const struct seq_operations =
ext4_mb_seq_groups_ops =3D {
> 	.show   =3D ext4_mb_seq_groups_show,
> };
>=20
> +static void *ext4_mb_seq_structs_start(struct seq_file *seq, loff_t =
*pos)
> +{
> +	struct super_block *sb =3D PDE_DATA(file_inode(seq->file));
> +	unsigned long position;
> +
> +	read_lock(&EXT4_SB(sb)->s_mb_rb_lock);
> +
> +	if (*pos < 0 || *pos >=3D MB_NUM_ORDERS(sb) + =
ext4_get_groups_count(sb))
> +		return NULL;
> +	position =3D *pos + 1;
> +	return (void *) ((unsigned long) position);
> +}
> +
> +static void *ext4_mb_seq_structs_next(struct seq_file *seq, void *v, =
loff_t *pos)
> +{
> +	struct super_block *sb =3D PDE_DATA(file_inode(seq->file));
> +	unsigned long position;
> +
> +	++*pos;
> +	if (*pos < 0 || *pos >=3D MB_NUM_ORDERS(sb) + =
ext4_get_groups_count(sb))
> +		return NULL;
> +	position =3D *pos + 1;
> +	return (void *) ((unsigned long) position);
> +}
> +
> +static int ext4_mb_seq_structs_show(struct seq_file *seq, void *v)
> +{
> +	struct super_block *sb =3D PDE_DATA(file_inode(seq->file));
> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> +	unsigned long position =3D ((unsigned long) v);
> +	struct ext4_group_info *grpinfo;
> +	struct rb_node *n;
> +	int i;
> +
> +	position--;
> +
> +	if (position >=3D MB_NUM_ORDERS(sb)) {
> +		position -=3D MB_NUM_ORDERS(sb);
> +		if (position =3D=3D 0)
> +			seq_puts(seq, "Group, Avg Fragment Size\n");
> +		n =3D rb_first(&sbi->s_mb_avg_fragment_size_root);
> +		for (i =3D 0; n && i < position; i++)
> +			n =3D rb_next(n);
> +		if (!n)
> +			return 0;
> +		grpinfo =3D rb_entry(n, struct ext4_group_info, =
bb_avg_fragment_size_rb);
> +		seq_printf(seq, "%d, %d\n",
> +			   grpinfo->bb_group,
> +			   grpinfo->bb_fragments ? grpinfo->bb_free / =
grpinfo->bb_fragments : 0);
> +		return 0;
> +	}
> +
> +	if (position =3D=3D 0)
> +		seq_puts(seq, "Largest Free Order Lists:\n");
> +
> +	seq_printf(seq, "[%ld]: ", position);
> +	list_for_each_entry(grpinfo, =
&sbi->s_mb_largest_free_orders[position],
> +			    bb_largest_free_order_node)	{
> +		seq_printf(seq, "%d ", grpinfo->bb_group);
> +	}
> +	seq_puts(seq, "\n");
> +
> +	return 0;
> +}
> +
> +static void ext4_mb_seq_structs_stop(struct seq_file *seq, void *v)
> +{
> +	struct super_block *sb =3D PDE_DATA(file_inode(seq->file));
> +
> +	read_unlock(&EXT4_SB(sb)->s_mb_rb_lock);
> +}
> +
> +const struct seq_operations ext4_mb_seq_structs_ops =3D {
> +	.start  =3D ext4_mb_seq_structs_start,
> +	.next   =3D ext4_mb_seq_structs_next,
> +	.stop   =3D ext4_mb_seq_structs_stop,
> +	.show   =3D ext4_mb_seq_structs_show,
> +};
> +
> static struct kmem_cache *get_groupinfo_cache(int blocksize_bits)
> {
> 	int cache_index =3D blocksize_bits - EXT4_MIN_BLOCK_LOG_SIZE;
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 4e27fe6ed3ae..828d58b98310 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -527,6 +527,8 @@ int ext4_register_sysfs(struct super_block *sb)
> 					ext4_fc_info_show, sb);
> 		proc_create_seq_data("mb_groups", S_IRUGO, sbi->s_proc,
> 				&ext4_mb_seq_groups_ops, sb);
> +		proc_create_seq_data("mb_structs", 0444, sbi->s_proc,
> +				&ext4_mb_seq_structs_ops, sb);
> 	}
> 	return 0;
> }
> --
> 2.30.0.365.g02bc693789-goog
>=20


Cheers, Andreas






--Apple-Mail=_F3787EB7-12C2-4AFC-9B67-1F52779111DF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAVO88ACgkQcqXauRfM
H+Bn+w/9HiJYPZ+eCCc8Tf+jcKc6PVzyYhjc0xBW98t0nzBEtjjAprYddLYauhEH
cAuGff1hpkiVreQ3dU1EKugCUNXtPBVFwPJqIT9hEigtRq093sUQEIcjKCmf5Iy+
ssLilrx18xsRaqwpCUGYSLzPfAuqUXd8033ETdvcxU7jVX59QVYxljtGldvMt6iT
NVw+lg5YFu+jC+7THS2ySQ0Jet85fYBP2RgAl+5sOlgrcLWi3pE51o+99/uVFJ0O
Ock0jlY2VpQ9Gh+3AjMGs3KN223PBqII0PbCzefwqML8t7+tUDgyTOm6SBYR0p12
5zAZUAHhMnZ6alEHLEhuUgY0fxM1zs/FmSA4tomBoL1qcW0cT+xpDZu47/BSJFRF
KPh9SNIsX0P90TMrQO9Yz5CHt9K7ArZb8J4aCXGAYSXWGUuksJXR+XuQI/bovq8c
R/5pFhJuJbCTdV+M0w5sKnw4sAP2FIVO52y/SH1g1TIf6l9YsBtgrbeYDOm6j262
3CBDv3KURStKgPSdS3w5r43dKm2olVG9+CSk317jEZJrgyPvPVPNZ8YgaoFxn/KQ
Yie7aTf9zLuT+WAlik9qPVKWG4UpmM4A5qsmqQMZKxLvmbklaLrndHjgmbRkl1ZC
vsT8A8hpjVzQjlH2Z+XnCnyHa8MOThkxgJ38SVYCjyWmy1mv4cU=
=gNJ/
-----END PGP SIGNATURE-----

--Apple-Mail=_F3787EB7-12C2-4AFC-9B67-1F52779111DF--
