Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EC22436E2
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 10:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgHMIq0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Aug 2020 04:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMIqY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Aug 2020 04:46:24 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30245C061757
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 01:46:24 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j21so2469221pgi.9
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 01:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=s1VaL0fdK08dCf/ReKkQbzoB5axm9+CQsoq4dml9YJs=;
        b=Q3y6/k9gUVg1sfDFEZQXHOsrzauDP+2qpeZqebZGyoH0gIIj6ldrJdVnsaqZBsQCkD
         ogI2ygGuJY8U2t+tuqqN1/qj27s9Akny1VjfcQipDk72tr1XKrOcVpSWoqtf2sEPAo1Z
         bBvzkwNDJAbL9ebq/uh5Vh6WmR15PC7hU7Bwr0T2QBADubpMhUvUyERyUP9U88ukg17l
         plTMf/QPi5NyPDU/eX3GbUNczNc6XN7iYsxcG2vd/iMEyMEk1pm82Wimi0rGI5vlJTIC
         1hB9CFCueYUbTe9UTLF1wrAMH/mZjlk5sS6lB7DM3BqZglqyHiwINIvEuBO3CwU/TG/b
         pKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=s1VaL0fdK08dCf/ReKkQbzoB5axm9+CQsoq4dml9YJs=;
        b=ApcLs9bfGh81u9K9vqLvn/xGOrOhnhrHqw5kJ7llRO1bBjIem3K1pBpH+l+zdohgvB
         v0wesrZh/vWK5iEp/vrsQXNQ0xfqK9e3CnwuNHBQb08mwe+AgQdQF/og6DD3XuS2M3Or
         R2BwCQcYfiZu62tMc63QXS012YFHOJuHd+YKThUeIu5aqNXeWOhWmh3WcFhS/lJkzj26
         pLS9wS0/dUT+qOIo/hd1hSmjM3NTj1NiOipba24uv02w57XworleUUQRODPeSnJ9F21J
         L/IFhmhNv/WJ2VlHL94pY/JUOJh+J5MZACScOHUe758pJm8K9LUeEJcCIkGPeIuI6S+c
         s0gw==
X-Gm-Message-State: AOAM530iGgsXt/Pf+fwpOLA0r9QbXi72iOjXBM0xDFQeINgaww2PmKC1
        MSkhKh3fq6RNylXaLWxeLOp7Tg==
X-Google-Smtp-Source: ABdhPJyGvkDP2ssteEV64/IFKf9+/GCMsKRaGm1fj6Thi1/jsit8cAntPSinywjgigDKLl4MdPBE6w==
X-Received: by 2002:a63:d5f:: with SMTP id 31mr2645009pgn.331.1597308383536;
        Thu, 13 Aug 2020 01:46:23 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id z29sm5097473pfj.182.2020.08.13.01.46.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 01:46:22 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <CAE38860-4E75-4ED5-922B-828CF17FEFF2@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_53C1D89B-FA2A-4262-B9E7-4B90471FFEC8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4 2/2] ext4: limit the length of per-inode prealloc list
Date:   Thu, 13 Aug 2020 02:46:21 -0600
In-Reply-To: <530dadc7-7bee-6d90-38b8-3af56c428297@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
References: <530dadc7-7bee-6d90-38b8-3af56c428297@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_53C1D89B-FA2A-4262-B9E7-4B90471FFEC8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Aug 7, 2020, at 2:44 AM, brookxu <brookxu.cn@gmail.com> wrote:
>=20
> In the scenario of writing sparse files, the Per-inode prealloc list =
may
> be very long, resulting in high overhead for =
ext4_mb_use_preallocated().
> To circumvent this problem, we limit the maximum length of per-inode
> prealloc list to 512 and allow users to modify it.
>=20
> After patching, we observed that the sys ratio of cpu has dropped, and
> the system throughput has increased significantly. We created a =
process
> to write the sparse file, and the running time of the process on the
> fixed kernel was significantly reduced, as follows:
>=20
> Running time on unfixed kernel=EF=BC=9A
> [root@TENCENT64 ~]# time taskset 0x01 ./sparse /data1/sparce.dat
> real    0m2.051s
> user    0m0.008s
> sys     0m2.026s
>=20
> Running time on fixed kernel=EF=BC=9A
> [root@TENCENT64 ~]# time taskset 0x01 ./sparse /data1/sparce.dat
> real    0m0.471s
> user    0m0.004s
> sys     0m0.395s
>=20
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/ext4.h              |  3 ++-
> fs/ext4/extents.c           | 10 ++++----
> fs/ext4/file.c              |  2 +-
> fs/ext4/indirect.c          |  2 +-
> fs/ext4/inode.c             |  6 ++---
> fs/ext4/ioctl.c             |  2 +-
> fs/ext4/mballoc.c           | 57 =
+++++++++++++++++++++++++++++++++++++++++----
> fs/ext4/mballoc.h           |  4 ++++
> fs/ext4/move_extent.c       |  4 ++--
> fs/ext4/super.c             |  2 +-
> fs/ext4/sysfs.c             |  2 ++
> include/trace/events/ext4.h | 14 ++++++-----
> 12 files changed, 83 insertions(+), 25 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 42f5060..68e0ebe 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1501,6 +1501,7 @@ struct ext4_sb_info {
> 	unsigned int s_mb_stats;
> 	unsigned int s_mb_order2_reqs;
> 	unsigned int s_mb_group_prealloc;
> +	unsigned int s_mb_max_inode_prealloc;
> 	unsigned int s_max_dir_size_kb;
> 	/* where last allocation was done - for stream allocation */
> 	unsigned long s_mb_last_group;
> @@ -2651,7 +2652,7 @@ extern int ext4_init_inode_table(struct =
super_block *sb,
> extern ext4_fsblk_t ext4_mb_new_blocks(handle_t *,
> 				struct ext4_allocation_request *, int =
*);
> extern int ext4_mb_reserve_blocks(struct super_block *, int);
> -extern void ext4_discard_preallocations(struct inode *);
> +extern void ext4_discard_preallocations(struct inode *, unsigned =
int);
> extern int __init ext4_init_mballoc(void);
> extern void ext4_exit_mballoc(void);
> extern void ext4_free_blocks(handle_t *handle, struct inode *inode,
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 221f240..a40f928 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -100,7 +100,7 @@ static int ext4_ext_trunc_restart_fn(struct inode =
*inode, int *dropped)
> 	 * i_mutex. So we can safely drop the i_data_sem here.
> 	 */
> 	BUG_ON(EXT4_JOURNAL(inode) =3D=3D NULL);
> -	ext4_discard_preallocations(inode);
> +	ext4_discard_preallocations(inode, 0);
> 	up_write(&EXT4_I(inode)->i_data_sem);
> 	*dropped =3D 1;
> 	return 0;
> @@ -4272,7 +4272,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct =
inode *inode,
> 			 * not a good idea to call discard here =
directly,
> 			 * but otherwise we'd need to call it every =
free().
> 			 */
> -			ext4_discard_preallocations(inode);
> +			ext4_discard_preallocations(inode, 0);
> 			if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
> 				fb_flags =3D =
EXT4_FREE_BLOCKS_NO_QUOT_UPDATE;
> 			ext4_free_blocks(handle, inode, NULL, newblock,
> @@ -5299,7 +5299,7 @@ static int ext4_collapse_range(struct inode =
*inode, loff_t offset, loff_t len)
> 	}
>=20
> 	down_write(&EXT4_I(inode)->i_data_sem);
> -	ext4_discard_preallocations(inode);
> +	ext4_discard_preallocations(inode, 0);
>=20
> 	ret =3D ext4_es_remove_extent(inode, punch_start,
> 				    EXT_MAX_BLOCKS - punch_start);
> @@ -5313,7 +5313,7 @@ static int ext4_collapse_range(struct inode =
*inode, loff_t offset, loff_t len)
> 		up_write(&EXT4_I(inode)->i_data_sem);
> 		goto out_stop;
> 	}
> -	ext4_discard_preallocations(inode);
> +	ext4_discard_preallocations(inode, 0);
>=20
> 	ret =3D ext4_ext_shift_extents(inode, handle, punch_stop,
> 				     punch_stop - punch_start, =
SHIFT_LEFT);
> @@ -5445,7 +5445,7 @@ static int ext4_insert_range(struct inode =
*inode, loff_t offset, loff_t len)
> 		goto out_stop;
>=20
> 	down_write(&EXT4_I(inode)->i_data_sem);
> -	ext4_discard_preallocations(inode);
> +	ext4_discard_preallocations(inode, 0);
>=20
> 	path =3D ext4_find_extent(inode, offset_lblk, NULL, 0);
> 	if (IS_ERR(path)) {
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 2a01e31..e3ab8ea 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -148,7 +148,7 @@ static int ext4_release_file(struct inode *inode, =
struct file *filp)
> 		        !EXT4_I(inode)->i_reserved_data_blocks)
> 	{
> 		down_write(&EXT4_I(inode)->i_data_sem);
> -		ext4_discard_preallocations(inode);
> +		ext4_discard_preallocations(inode, 0);
> 		up_write(&EXT4_I(inode)->i_data_sem);
> 	}
> 	if (is_dx(inode) && filp->private_data)
> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> index be2b66e..ec6b930 100644
> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -696,7 +696,7 @@ static int ext4_ind_trunc_restart_fn(handle_t =
*handle, struct inode *inode,
> 	 * i_mutex. So we can safely drop the i_data_sem here.
> 	 */
> 	BUG_ON(EXT4_JOURNAL(inode) =3D=3D NULL);
> -	ext4_discard_preallocations(inode);
> +	ext4_discard_preallocations(inode, 0);
> 	up_write(&EXT4_I(inode)->i_data_sem);
> 	*dropped =3D 1;
> 	return 0;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 10dd470..bb9e1cd 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -383,7 +383,7 @@ void ext4_da_update_reserve_space(struct inode =
*inode,
> 	 */
> 	if ((ei->i_reserved_data_blocks =3D=3D 0) &&
> 	    !inode_is_open_for_write(inode))
> -		ext4_discard_preallocations(inode);
> +		ext4_discard_preallocations(inode, 0);
> }
>=20
> static int __check_block_validity(struct inode *inode, const char =
*func,
> @@ -4056,7 +4056,7 @@ int ext4_punch_hole(struct inode *inode, loff_t =
offset, loff_t length)
> 	if (stop_block > first_block) {
>=20
> 		down_write(&EXT4_I(inode)->i_data_sem);
> -		ext4_discard_preallocations(inode);
> +		ext4_discard_preallocations(inode, 0);
>=20
> 		ret =3D ext4_es_remove_extent(inode, first_block,
> 					    stop_block - first_block);
> @@ -4211,7 +4211,7 @@ int ext4_truncate(struct inode *inode)
>=20
> 	down_write(&EXT4_I(inode)->i_data_sem);
>=20
> -	ext4_discard_preallocations(inode);
> +	ext4_discard_preallocations(inode, 0);
>=20
> 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> 		err =3D ext4_ext_truncate(handle, inode);
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 999cf6a..a5fcc23 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -202,7 +202,7 @@ static long swap_inode_boot_loader(struct =
super_block *sb,
> 	reset_inode_seed(inode);
> 	reset_inode_seed(inode_bl);
>=20
> -	ext4_discard_preallocations(inode);
> +	ext4_discard_preallocations(inode, 0);
>=20
> 	err =3D ext4_mark_inode_dirty(handle, inode);
> 	if (err < 0) {
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 4f21f34..28a139f 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2736,6 +2736,7 @@ int ext4_mb_init(struct super_block *sb)
> 	sbi->s_mb_stats =3D MB_DEFAULT_STATS;
> 	sbi->s_mb_stream_request =3D MB_DEFAULT_STREAM_THRESHOLD;
> 	sbi->s_mb_order2_reqs =3D MB_DEFAULT_ORDER2_REQS;
> +	sbi->s_mb_max_inode_prealloc =3D MB_DEFAULT_MAX_INODE_PREALLOC;
> 	/*
> 	 * The default group preallocation is 512, which for 4k block
> 	 * sizes translates to 2 megabytes.  However for bigalloc file
> @@ -4103,7 +4104,7 @@ static void ext4_mb_new_preallocation(struct =
ext4_allocation_context *ac)
>  *
>  * FIXME!! Make sure it is valid at all the call sites
>  */
> -void ext4_discard_preallocations(struct inode *inode)
> +void ext4_discard_preallocations(struct inode *inode, unsigned int =
needed)
> {
> 	struct ext4_inode_info *ei =3D EXT4_I(inode);
> 	struct super_block *sb =3D inode->i_sb;
> @@ -4121,15 +4122,18 @@ void ext4_discard_preallocations(struct inode =
*inode)
>=20
> 	mb_debug(sb, "discard preallocation for inode %lu\n",
> 		 inode->i_ino);
> -	trace_ext4_discard_preallocations(inode);
> +	trace_ext4_discard_preallocations(inode,  needed);
>=20
> 	INIT_LIST_HEAD(&list);
>=20
> +	if (needed =3D=3D 0)
> +		needed =3D UINT_MAX;
> +
> repeat:
> 	/* first, collect all pa's in the inode */
> 	spin_lock(&ei->i_prealloc_lock);
> -	while (!list_empty(&ei->i_prealloc_list)) {
> -		pa =3D list_entry(ei->i_prealloc_list.next,
> +	while (!list_empty(&ei->i_prealloc_list) && needed) {
> +		pa =3D list_entry(ei->i_prealloc_list.prev,
> 				struct ext4_prealloc_space, =
pa_inode_list);
> 		BUG_ON(pa->pa_obj_lock !=3D &ei->i_prealloc_lock);
> 		spin_lock(&pa->pa_lock);
> @@ -4150,6 +4154,7 @@ void ext4_discard_preallocations(struct inode =
*inode)
> 			spin_unlock(&pa->pa_lock);
> 			list_del_rcu(&pa->pa_inode_list);
> 			list_add(&pa->u.pa_tmp_list, &list);
> +			needed--;
> 			continue;
> 		}
>=20
> @@ -4549,10 +4554,42 @@ static void ext4_mb_add_n_trim(struct =
ext4_allocation_context *ac)
> }
>=20
> /*
> + * if per-inode prealloc list is too long, trim some PA
> + */
> +static void
> +ext4_mb_trim_inode_pa(struct inode *inode)
> +{
> +	struct ext4_inode_info *ei =3D EXT4_I(inode);
> +	struct ext4_sb_info *sbi =3D EXT4_SB(inode->i_sb);
> +	struct ext4_prealloc_space *pa;
> +	int count =3D 0, delta;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) =
{
> +		spin_lock(&pa->pa_lock);
> +		if (pa->pa_deleted) {
> +			spin_unlock(&pa->pa_lock);
> +			continue;
> +		}
> +		count++;
> +		spin_unlock(&pa->pa_lock);
> +	}
> +	rcu_read_unlock();
> +
> +	delta =3D (sbi->s_mb_max_inode_prealloc >> 2) + 1;
> +	if (count > sbi->s_mb_max_inode_prealloc + delta) {
> +		count -=3D sbi->s_mb_max_inode_prealloc;
> +		ext4_discard_preallocations(inode, count);
> +	}
> +}
> +
> +/*
>  * release all resource we used in allocation
>  */
> static int ext4_mb_release_context(struct ext4_allocation_context *ac)
> {
> +	struct inode *inode =3D ac->ac_inode;
> +	struct ext4_inode_info *ei =3D EXT4_I(inode);
> 	struct ext4_sb_info *sbi =3D EXT4_SB(ac->ac_sb);
> 	struct ext4_prealloc_space *pa =3D ac->ac_pa;
> 	if (pa) {
> @@ -4578,6 +4615,17 @@ static int ext4_mb_release_context(struct =
ext4_allocation_context *ac)
> 				ext4_mb_add_n_trim(ac);
> 			}
> 		}
> +
> +		if (pa->pa_type =3D=3D MB_INODE_PA) {
> +			/*
> +			 * treat per-inode prealloc list as a lru list, =
then try
> +			 * to trim the least recently used PA.
> +			 */
> +			spin_lock(pa->pa_obj_lock);
> +			list_move(&ei->i_prealloc_list, =
&pa->pa_inode_list);
> +			spin_unlock(pa->pa_obj_lock);
> +		}
> +
> 		ext4_mb_put_pa(ac, ac->ac_sb, pa);
> 	}
> 	if (ac->ac_bitmap_page)
> @@ -4587,6 +4635,7 @@ static int ext4_mb_release_context(struct =
ext4_allocation_context *ac)
> 	if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC)
> 		mutex_unlock(&ac->ac_lg->lg_mutex);
> 	ext4_mb_collect_stats(ac);
> +	ext4_mb_trim_inode_pa(inode);
> 	return 0;
> }
>=20
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index 6b4d17c..e75b474 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -73,6 +73,10 @@
>  */
> #define MB_DEFAULT_GROUP_PREALLOC	512
>=20
> +/*
> + * maximum length of inode prealloc list
> + */
> +#define MB_DEFAULT_MAX_INODE_PREALLOC	512
>=20
> struct ext4_free_data {
> 	/* this links the free block information from sb_info */
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 1ed86fb..0d601b8 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -686,8 +686,8 @@
>=20
> out:
> 	if (*moved_len) {
> -		ext4_discard_preallocations(orig_inode);
> -		ext4_discard_preallocations(donor_inode);
> +		ext4_discard_preallocations(orig_inode, 0);
> +		ext4_discard_preallocations(donor_inode, 0);
> 	}
>=20
> 	ext4_ext_drop_refs(path);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 330957e..8ce61f3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1216,7 +1216,7 @@ void ext4_clear_inode(struct inode *inode)
> {
> 	invalidate_inode_buffers(inode);
> 	clear_inode(inode);
> -	ext4_discard_preallocations(inode);
> +	ext4_discard_preallocations(inode, 0);
> 	ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
> 	dquot_drop(inode);
> 	if (EXT4_I(inode)->jinode) {
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 6c9fc9e..92f04e9 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -215,6 +215,7 @@ static ssize_t journal_task_show(struct =
ext4_sb_info *sbi, char *buf)
> EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
> EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
> EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
> +EXT4_RW_ATTR_SBI_UI(mb_max_inode_prealloc, s_mb_max_inode_prealloc);
> EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
> EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
> EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, =
s_err_ratelimit_state.interval);
> @@ -257,6 +258,7 @@ static ssize_t journal_task_show(struct =
ext4_sb_info *sbi, char *buf)
> 	ATTR_LIST(mb_order2_req),
> 	ATTR_LIST(mb_stream_req),
> 	ATTR_LIST(mb_group_prealloc),
> +	ATTR_LIST(mb_max_inode_prealloc),
> 	ATTR_LIST(max_writeback_mb_bump),
> 	ATTR_LIST(extent_max_zeroout_kb),
> 	ATTR_LIST(trigger_fs_error),
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index cc41d69..61736d8 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -746,24 +746,26 @@
> );
>=20
> TRACE_EVENT(ext4_discard_preallocations,
> -	TP_PROTO(struct inode *inode),
> +	TP_PROTO(struct inode *inode, unsigned int needed),
>=20
> -	TP_ARGS(inode),
> +	TP_ARGS(inode, needed),
>=20
> 	TP_STRUCT__entry(
> -		__field(	dev_t,	dev			)
> -		__field(	ino_t,	ino			)
> +		__field(	dev_t,		dev		)
> +		__field(	ino_t,		ino		)
> +		__field(	unsigned int,	needed		)
>=20
> 	),
>=20
> 	TP_fast_assign(
> 		__entry->dev	=3D inode->i_sb->s_dev;
> 		__entry->ino	=3D inode->i_ino;
> +		__entry->needed	=3D needed;
> 	),
>=20
> -	TP_printk("dev %d,%d ino %lu",
> +	TP_printk("dev %d,%d ino %lu needed %u",
> 		  MAJOR(__entry->dev), MINOR(__entry->dev),
> -		  (unsigned long) __entry->ino)
> +		  (unsigned long) __entry->ino, __entry->needed)
> );
>=20
> TRACE_EVENT(ext4_mb_discard_preallocations,
> --
> 1.8.3.1
>=20


Cheers, Andreas






--Apple-Mail=_53C1D89B-FA2A-4262-B9E7-4B90471FFEC8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl80/d0ACgkQcqXauRfM
H+A2WA//Sg/cF1Aq7H0t1Lu+zNef6YuKYN74qLHGuogZM2nZ4RQVLF66zcYcmrqN
W21T/3aK8ZPHEoXZaNTxG3ctVsEM2JhyyGRqysyVf2kF+BtkkXQmLdisADvQSKTG
NwFr7/YJd2k4JOXsBQh1+UwYN5nfbYaJnH0tmeyfYb1V8TktnrfAk9a0AqVQNO0E
8mBgIHj3e5NXWZ/ok5OxNG1z1UIbLMho5XaqdOLzADtghGp2R0BBl82o/UeXTzEl
UU5V3nkiYLkYJMqY2cBzRs4GmcEjAlH7e08LjCjK4ZzCseoKRPgZrXxeIfQyxEh6
jrZfDHZk8ZvHtzwOynBQwAg2Lncaa0FqjCxG/UE/0E1gVpH9P3jTEb2Mu2Kc4HKp
0f44gELIj2c3nZNhQGndt4F50lCJcPU3mKtMS8U5uo9jFEXf3w//T+CqUcFTVp1e
Thk8NcQc514ZHV6rtua6IHtUNDAruL1YLQcnqeYK3Bvapb9FtAMRlfygyvktMOIg
FynhJRUYh6oBeQhl/mVLgNnBmOLn/na00n8nFH/8vKJbNCu5sGS/rSzMSCZmcTNb
JrmzGOrS5rrYSL4zublWNg11l3cE5F+6xz3KUoac3C51CTH3xw2giaxB7td74G66
O33bCEeiuF0wSu5KmEyHbk3Ib8gUcybn72qB07HumsgE1o6M+Ok=
=x671
-----END PGP SIGNATURE-----

--Apple-Mail=_53C1D89B-FA2A-4262-B9E7-4B90471FFEC8--
