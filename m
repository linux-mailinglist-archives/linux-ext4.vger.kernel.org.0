Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30363319729
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Feb 2021 00:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhBKXw1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 18:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhBKXvY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Feb 2021 18:51:24 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B796BC061574
        for <linux-ext4@vger.kernel.org>; Thu, 11 Feb 2021 15:49:49 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o63so5066709pgo.6
        for <linux-ext4@vger.kernel.org>; Thu, 11 Feb 2021 15:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=eFv++60qehHxmjzRnsQApBAwqwV7Njx9FKdBgaL2WBI=;
        b=iHRJGqO5AktaBwhwIuPDsBo7NuqAD2nRb75ry+0/GYzOMHOogae9UZxG2ghCL2vXOV
         +XFW3eiWnBzjnFY1iCsljlAtioav9c11yjj2+lMOwIQwuiFtL77MIAvKf2BrbaJ+oF9U
         A+Ua4bu2W/JX3y7BkwV2H1AnL4aIxNEMIwrgrqG4pFXfeWoDJ+fcU8Vbq8zV0dYh1oNc
         B8Mn+0HaqN5Sy1Xp+27iWAbVVFNt4xJX5fz99Rbahgk/kgDTpNtDHdQfgM5sNkHPHJyg
         RX65UiNPzn8eoPY4xSWpapLHB9PBLYBJyHezEuiYT/gkfsJjIcSdXLNAg7DN2xOQBDRE
         4W0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=eFv++60qehHxmjzRnsQApBAwqwV7Njx9FKdBgaL2WBI=;
        b=jy5NfwZs998OfAXES8+2iwztFRBj3sm2vsEAW27uasUHKtZHDj01QiTB9LCWvjS79l
         uxk5uIVf5HSCKIpakxuMOGY0wHQkPa7elF0gapsqu9wlINjBlivx98eGiW+3pNX/Jqd9
         wBV2ANj7Tzk+Hyrmhx4b3F2LPEThc3MIcQFCOmwiFPhxTy8XcFqKwagzpH52J486NYxH
         MU9qi8poPk2F8SEJfnkq5wlibWS046Mc3RrC3IJUEx95Ig+PuvSyAWnF1UUPlDWpyvDN
         cOZjSe0Z0cChHA74FFGuWSutIJfQ2d9CAvHK27YlHfzqvLQPRaUt2ODCb3LJFwxglYtu
         cDgA==
X-Gm-Message-State: AOAM531ZqVAN0gGl+rOvZEtpoLvVQ2/Lr0mfzg98m25pSrbALZR/d1sa
        uY+0hbD/meyDnT3+MvAJlmw2Ng==
X-Google-Smtp-Source: ABdhPJykKu81WpXsGDN18LlapECJXunpTFbcOZyt9rD+qxgzyupNLo4sf/YGFlPJ6c0fkNqOzr46Kw==
X-Received: by 2002:a63:4b15:: with SMTP id y21mr565162pga.234.1613087389123;
        Thu, 11 Feb 2021 15:49:49 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 74sm6874615pfw.53.2021.02.11.15.49.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Feb 2021 15:49:48 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <22587F00-0B06-4D95-9E20-4B0C70F813FA@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DA3680BB-B76A-410B-8FD3-6268070A19CC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 2/5] ext4: add mballoc stats proc file
Date:   Thu, 11 Feb 2021 16:49:45 -0700
In-Reply-To: <20210209202857.4185846-3-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        artem.blagodarenko@gmail.com, Shuichi Ihara <sihara@ddn.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
 <20210209202857.4185846-3-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_DA3680BB-B76A-410B-8FD3-6268070A19CC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 9, 2021, at 1:28 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> Add new stats for measuring the performance of mballoc. This patch is
> forked from Artem Blagodarenko's work that can be found here:
>=20
> =
https://github.com/lustre/lustre-release/blob/master/ldiskfs/kernel_patche=
s/patches/rhel8/ext4-simple-blockalloc.patch
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/ext4.h    |  4 ++++
> fs/ext4/mballoc.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-
> fs/ext4/mballoc.h |  1 +
> fs/ext4/sysfs.c   |  2 ++
> 4 files changed, 57 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 6dd127942208..317b43420ecf 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1549,6 +1549,8 @@ struct ext4_sb_info {
> 	atomic_t s_bal_success;	/* we found long enough chunks */
> 	atomic_t s_bal_allocated;	/* in blocks */
> 	atomic_t s_bal_ex_scanned;	/* total extents scanned */
> +	atomic_t s_bal_groups_considered;	/* number of groups =
considered */
> +	atomic_t s_bal_groups_scanned;	/* number of groups scanned */
> 	atomic_t s_bal_goals;	/* goal hits */
> 	atomic_t s_bal_breaks;	/* too long searches */
> 	atomic_t s_bal_2orders;	/* 2^order hits */
> @@ -1558,6 +1560,7 @@ struct ext4_sb_info {
> 	atomic_t s_mb_preallocated;
> 	atomic_t s_mb_discarded;
> 	atomic_t s_lock_busy;
> +	atomic64_t s_bal_cX_failed[4];		/* cX loop didn't find =
blocks */
>=20
> 	/* locality groups */
> 	struct ext4_locality_group __percpu *s_locality_groups;
> @@ -2808,6 +2811,7 @@ int __init ext4_fc_init_dentry_cache(void);
> extern const struct seq_operations ext4_mb_seq_groups_ops;
> extern long ext4_mb_stats;
> extern long ext4_mb_max_to_scan;
> +extern int ext4_seq_mb_stats_show(struct seq_file *seq, void =
*offset);
> extern int ext4_mb_init(struct super_block *);
> extern int ext4_mb_release(struct super_block *);
> extern ext4_fsblk_t ext4_mb_new_blocks(handle_t *,
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 07b78a3cc421..fffd0770e930 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2083,6 +2083,7 @@ static bool ext4_mb_good_group(struct =
ext4_allocation_context *ac,
>=20
> 	BUG_ON(cr < 0 || cr >=3D 4);
>=20
> +	ac->ac_groups_considered++;
> 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
> 		return false;
>=20
> @@ -2420,6 +2421,9 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
> 			if (ac->ac_status !=3D AC_STATUS_CONTINUE)
> 				break;
> 		}
> +		/* Processed all groups and haven't found blocks */
> +		if (sbi->s_mb_stats && i =3D=3D ngroups)
> +			atomic64_inc(&sbi->s_bal_cX_failed[cr]);
> 	}
>=20
> 	if (ac->ac_b_ex.fe_len > 0 && ac->ac_status !=3D AC_STATUS_FOUND =
&&
> @@ -2548,6 +2552,48 @@ const struct seq_operations =
ext4_mb_seq_groups_ops =3D {
> 	.show   =3D ext4_mb_seq_groups_show,
> };
>=20
> +int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
> +{
> +	struct super_block *sb =3D (struct super_block *)seq->private;
> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> +
> +	seq_puts(seq, "mballoc:\n");
> +	if (!sbi->s_mb_stats) {
> +		seq_puts(seq, "\tmb stats collection turned off.\n");
> +		seq_puts(seq, "\tTo enable, please write \"1\" to sysfs =
file mb_stats.\n");
> +		return 0;
> +	}
> +	seq_printf(seq, "\treqs: %u\n", atomic_read(&sbi->s_bal_reqs));
> +	seq_printf(seq, "\tsuccess: %u\n", =
atomic_read(&sbi->s_bal_success));
> +
> +	seq_printf(seq, "\tgroups_scanned: %u\n",  =
atomic_read(&sbi->s_bal_groups_scanned));
> +	seq_printf(seq, "\tgroups_considered: %u\n",  =
atomic_read(&sbi->s_bal_groups_considered));
> +	seq_printf(seq, "\textents_scanned: %u\n", =
atomic_read(&sbi->s_bal_ex_scanned));
> +	seq_printf(seq, "\t\tgoal_hits: %u\n", =
atomic_read(&sbi->s_bal_goals));
> +	seq_printf(seq, "\t\t2^n_hits: %u\n", =
atomic_read(&sbi->s_bal_2orders));
> +	seq_printf(seq, "\t\tbreaks: %u\n", =
atomic_read(&sbi->s_bal_breaks));
> +	seq_printf(seq, "\t\tlost: %u\n", =
atomic_read(&sbi->s_mb_lost_chunks));
> +
> +	seq_printf(seq, "\tuseless_c0_loops: %llu\n",
> +		   (unsigned long =
long)atomic64_read(&sbi->s_bal_cX_failed[0]));
> +	seq_printf(seq, "\tuseless_c1_loops: %llu\n",
> +		   (unsigned long =
long)atomic64_read(&sbi->s_bal_cX_failed[1]));
> +	seq_printf(seq, "\tuseless_c2_loops: %llu\n",
> +		   (unsigned long =
long)atomic64_read(&sbi->s_bal_cX_failed[2]));
> +	seq_printf(seq, "\tuseless_c3_loops: %llu\n",
> +		   (unsigned long =
long)atomic64_read(&sbi->s_bal_cX_failed[3]));
> +	seq_printf(seq, "\tbuddies_generated: %u/%u\n",
> +		   atomic_read(&sbi->s_mb_buddies_generated),
> +		   ext4_get_groups_count(sb));
> +	seq_printf(seq, "\tbuddies_time_used: %llu\n",
> +		   atomic64_read(&sbi->s_mb_generation_time));
> +	seq_printf(seq, "\tpreallocated: %u\n",
> +		   atomic_read(&sbi->s_mb_preallocated));
> +	seq_printf(seq, "\tdiscarded: %u\n",
> +		   atomic_read(&sbi->s_mb_discarded));
> +	return 0;
> +}
> +
> static struct kmem_cache *get_groupinfo_cache(int blocksize_bits)
> {
> 	int cache_index =3D blocksize_bits - EXT4_MIN_BLOCK_LOG_SIZE;
> @@ -2968,9 +3014,10 @@ int ext4_mb_release(struct super_block *sb)
> 				atomic_read(&sbi->s_bal_reqs),
> 				atomic_read(&sbi->s_bal_success));
> 		ext4_msg(sb, KERN_INFO,
> -		      "mballoc: %u extents scanned, %u goal hits, "
> +		      "mballoc: %u extents scanned, %u groups scanned, =
%u goal hits, "
> 				"%u 2^N hits, %u breaks, %u lost",
> 				atomic_read(&sbi->s_bal_ex_scanned),
> +				atomic_read(&sbi->s_bal_groups_scanned),
> 				atomic_read(&sbi->s_bal_goals),
> 				atomic_read(&sbi->s_bal_2orders),
> 				atomic_read(&sbi->s_bal_breaks),
> @@ -3579,6 +3626,8 @@ static void ext4_mb_collect_stats(struct =
ext4_allocation_context *ac)
> 		if (ac->ac_b_ex.fe_len >=3D ac->ac_o_ex.fe_len)
> 			atomic_inc(&sbi->s_bal_success);
> 		atomic_add(ac->ac_found, &sbi->s_bal_ex_scanned);
> +		atomic_add(ac->ac_groups_scanned, =
&sbi->s_bal_groups_scanned);
> +		atomic_add(ac->ac_groups_considered, =
&sbi->s_bal_groups_considered);
> 		if (ac->ac_g_ex.fe_start =3D=3D ac->ac_b_ex.fe_start &&
> 				ac->ac_g_ex.fe_group =3D=3D =
ac->ac_b_ex.fe_group)
> 			atomic_inc(&sbi->s_bal_goals);
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index e75b4749aa1c..7597330dbdf8 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -161,6 +161,7 @@ struct ext4_allocation_context {
> 	/* copy of the best found extent taken before preallocation =
efforts */
> 	struct ext4_free_extent ac_f_ex;
>=20
> +	__u32 ac_groups_considered;
> 	__u16 ac_groups_scanned;
> 	__u16 ac_found;
> 	__u16 ac_tail;
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 4e27fe6ed3ae..752d1c261e2a 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -527,6 +527,8 @@ int ext4_register_sysfs(struct super_block *sb)
> 					ext4_fc_info_show, sb);
> 		proc_create_seq_data("mb_groups", S_IRUGO, sbi->s_proc,
> 				&ext4_mb_seq_groups_ops, sb);
> +		proc_create_single_data("mb_stats", 0444, sbi->s_proc,
> +				ext4_seq_mb_stats_show, sb);
> 	}
> 	return 0;
> }
> --
> 2.30.0.478.g8a0d178c01-goog
>=20


Cheers, Andreas






--Apple-Mail=_DA3680BB-B76A-410B-8FD3-6268070A19CC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAlwpkACgkQcqXauRfM
H+AQ6BAAlsDEyQFOYH+grecldSZDycpXKbuXq4h2qyFaCKWN2yWLoHNpsuGUzdnI
i0Vaym/x80fuf64NQq5Uzq+KPdk/BXO/q7ltChaHOThB9k5ud4DLSTbOdGMxRxCo
I0Ep6GL6lTBfRjxJHTNBKc9IORAEBX4WRJTbdvO7UVBEf/cVNcUutRehwPWkumuD
vau5swiiBw4ThLQTGu2LrRNxXSH6LmgxqOSPP3F3A0Oe2xw8ukuUB80l2Y9mRfDL
N9XxfI2lMPNw3mddf9FwIdtKfL9Eb+V+KU1l8TybUiPWnyyapIRQ7THUjK+RLe06
LPpIVWGhRuFAdIm0PYfz/BfwRqA9dGnZLDhkElVO444X0MXwWbKt93g2+FiWwnu0
o8+RrzdzsTJw3W7kYrOxC1KaPcC3IzSKgf1NObznCDVA1rvHxMZNJGllGT21d+EP
KcNv8mnCb8KY0gRa4PA467T6VlU125wOR2svG955bEhj+TvyW5+sRC0Ik5agtplw
etJkun/dJk0HxUmV2zC19ECDpBh4p+7fVklPn86qzpIzlXINFFwUxYZ7+Fd+tXWH
gdoIj1kfETRq6yU/A5eobW9BN9i9ZyfRBKQ3RZ2iBwCCuAHJcDvFSVmyRPJCXw4f
sBpDVl6LsOYurV4sR40kXvJdQAdsKS7Q9rNbaIIfBsepzsy0GtI=
=LbeU
-----END PGP SIGNATURE-----

--Apple-Mail=_DA3680BB-B76A-410B-8FD3-6268070A19CC--
