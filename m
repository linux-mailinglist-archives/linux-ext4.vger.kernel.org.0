Return-Path: <linux-ext4+bounces-8967-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C1BB030AC
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Jul 2025 12:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1967817E01C
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Jul 2025 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9A624BD03;
	Sun, 13 Jul 2025 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="T/qZU1Ty"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5557635977
	for <linux-ext4@vger.kernel.org>; Sun, 13 Jul 2025 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752403838; cv=none; b=DwJwgvjzXaR5PPW1Fx/SuUsietxHghDI/iovOn9fc/dLPgAyEodN6mxMGUHoCsuoHk7c4kg3MtAPm4DVQd70+dOzSc/1mfyv0/hoAq3DC1If2CUVLfh31bB+ci8Mgvwb2chLAWU5siG4KMLwJx3Y21LwqUn0tDQTVrZeEHi1O5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752403838; c=relaxed/simple;
	bh=GosI113vcBATsWaxEM5pec2KG7dBWIGIhJsusPdIpZM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=AagEll0IFUVFMJNUeV9CLm+TFwNi8CjGxFb+vOF1tL3C+we1Fyo88wI9EjF3XScJenKc2ahCqTDNNwSgff1M/Aptb7ZVox8SzgNx/MOO5eH0mBol+Mbl0JEijQWEIbMgKDnMChJ1oU10R4gXPCzwQW/4pjkHtJAjTGcI3fxVNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=T/qZU1Ty; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:subject:message-id:mime-version;
  bh=hAa77RXK+mHLtdOc6t+H5ossYq7F+DYCC3qZaCXGQBs=;
  b=T/qZU1TyPE2UMagO64B/u51sOFYsDkTEydmCSD+fuFqmvEDFwULaBw7M
   dsGymjo+GFR/F5xzyRYlj4mPchwd+bo7yJvUGTHmn8kPZT2qYW5PGJjRQ
   90+pPQLEVwYalOBkmNoPh7O9fuWIvvZbjCTUxwmTGC7UsYk7KhSJh+sK4
   8=;
X-CSE-ConnectionGUID: p2FHjAhcSrq/lNUygdD1QA==
X-CSE-MsgGUID: 0fPNuuL9Rga1uru/nprwig==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.16,308,1744063200"; 
   d="scan'208";a="231490231"
Received: from unknown (HELO hadrien.lan) ([172.59.115.247])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 12:49:21 +0200
Date: Sun, 13 Jul 2025 06:49:19 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Baokun Li <libaokun1@huawei.com>, Theodore Ts'o <tytso@mit.edu>, 
    linux-ext4@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: [tytso-ext4:pu 9/35] fs/ext4/mballoc.c:3760:29-30: WARNING kmalloc
 is used to allocate this memory at line 3725 (fwd)
Message-ID: <11da0f4-1dd-78af-b4b4-6a748e519444@inria.fr>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Could line 3760 just use kfree?

julia

---------- Forwarded message ----------
Date: Sun, 13 Jul 2025 16:28:01 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: [tytso-ext4:pu 9/35] fs/ext4/mballoc.c:3760:29-30: WARNING kmalloc is
    used to allocate this memory at line 3725

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-ext4@vger.kernel.org
TO: Baokun Li <libaokun1@huawei.com>
CC: "Theodore Ts'o" <tytso@mit.edu>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git pu
head:   a3404072989e188560fb86c1116ef76bcb8a5c4d
commit: c1ba37650891e5cb970ad406a15f7c1baa3c6e33 [9/35] ext4: utilize multiple global goals to reduce contention
:::::: branch date: 13 hours ago
:::::: commit date: 13 hours ago
config: i386-randconfig-052-20250713 (https://download.01.org/0day-ci/archive/20250713/202507131637.ay2myDnW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202507131637.ay2myDnW-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/ext4/mballoc.c:3760:29-30: WARNING kmalloc is used to allocate this memory at line 3725

vim +3760 fs/ext4/mballoc.c

55cdd0af2bc5ffc Wang Jianchao      2021-07-24  3600
9d99012ff26380a Akira Fujita       2012-05-28  3601  int ext4_mb_init(struct super_block *sb)
c9de560ded61faa Alex Tomas         2008-01-29  3602  {
c9de560ded61faa Alex Tomas         2008-01-29  3603  	struct ext4_sb_info *sbi = EXT4_SB(sb);
6be2ded1d7c51b3 Aneesh Kumar K.V   2008-07-23  3604  	unsigned i, j;
935244cd54b86ca Nicolai Stange     2016-05-05  3605  	unsigned offset, offset_incr;
c9de560ded61faa Alex Tomas         2008-01-29  3606  	unsigned max;
74767c5a2dca0a6 Shen Feng          2008-07-11  3607  	int ret;
c9de560ded61faa Alex Tomas         2008-01-29  3608
4b68f6df105966f Harshad Shirwadkar 2021-04-01  3609  	i = MB_NUM_ORDERS(sb) * sizeof(*sbi->s_mb_offsets);
c9de560ded61faa Alex Tomas         2008-01-29  3610
c9de560ded61faa Alex Tomas         2008-01-29  3611  	sbi->s_mb_offsets = kmalloc(i, GFP_KERNEL);
c9de560ded61faa Alex Tomas         2008-01-29  3612  	if (sbi->s_mb_offsets == NULL) {
fb1813f4a8a27bb Curt Wohlgemuth    2010-10-27  3613  		ret = -ENOMEM;
fb1813f4a8a27bb Curt Wohlgemuth    2010-10-27  3614  		goto out;
c9de560ded61faa Alex Tomas         2008-01-29  3615  	}
ff7ef329b268b60 Yasunori Goto      2008-12-17  3616
4b68f6df105966f Harshad Shirwadkar 2021-04-01  3617  	i = MB_NUM_ORDERS(sb) * sizeof(*sbi->s_mb_maxs);
c9de560ded61faa Alex Tomas         2008-01-29  3618  	sbi->s_mb_maxs = kmalloc(i, GFP_KERNEL);
c9de560ded61faa Alex Tomas         2008-01-29  3619  	if (sbi->s_mb_maxs == NULL) {
fb1813f4a8a27bb Curt Wohlgemuth    2010-10-27  3620  		ret = -ENOMEM;
fb1813f4a8a27bb Curt Wohlgemuth    2010-10-27  3621  		goto out;
fb1813f4a8a27bb Curt Wohlgemuth    2010-10-27  3622  	}
fb1813f4a8a27bb Curt Wohlgemuth    2010-10-27  3623
2892c15ddda6a76 Eric Sandeen       2011-02-12  3624  	ret = ext4_groupinfo_create_slab(sb->s_blocksize);
2892c15ddda6a76 Eric Sandeen       2011-02-12  3625  	if (ret < 0)
fb1813f4a8a27bb Curt Wohlgemuth    2010-10-27  3626  		goto out;
c9de560ded61faa Alex Tomas         2008-01-29  3627
c9de560ded61faa Alex Tomas         2008-01-29  3628  	/* order 0 is regular bitmap */
c9de560ded61faa Alex Tomas         2008-01-29  3629  	sbi->s_mb_maxs[0] = sb->s_blocksize << 3;
c9de560ded61faa Alex Tomas         2008-01-29  3630  	sbi->s_mb_offsets[0] = 0;
c9de560ded61faa Alex Tomas         2008-01-29  3631
c9de560ded61faa Alex Tomas         2008-01-29  3632  	i = 1;
c9de560ded61faa Alex Tomas         2008-01-29  3633  	offset = 0;
935244cd54b86ca Nicolai Stange     2016-05-05  3634  	offset_incr = 1 << (sb->s_blocksize_bits - 1);
c9de560ded61faa Alex Tomas         2008-01-29  3635  	max = sb->s_blocksize << 2;
c9de560ded61faa Alex Tomas         2008-01-29  3636  	do {
c9de560ded61faa Alex Tomas         2008-01-29  3637  		sbi->s_mb_offsets[i] = offset;
c9de560ded61faa Alex Tomas         2008-01-29  3638  		sbi->s_mb_maxs[i] = max;
935244cd54b86ca Nicolai Stange     2016-05-05  3639  		offset += offset_incr;
935244cd54b86ca Nicolai Stange     2016-05-05  3640  		offset_incr = offset_incr >> 1;
c9de560ded61faa Alex Tomas         2008-01-29  3641  		max = max >> 1;
c9de560ded61faa Alex Tomas         2008-01-29  3642  		i++;
4b68f6df105966f Harshad Shirwadkar 2021-04-01  3643  	} while (i < MB_NUM_ORDERS(sb));
4b68f6df105966f Harshad Shirwadkar 2021-04-01  3644
83e80a6e3543f37 Jan Kara           2022-09-08  3645  	sbi->s_mb_avg_fragment_size =
83e80a6e3543f37 Jan Kara           2022-09-08  3646  		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct list_head),
83e80a6e3543f37 Jan Kara           2022-09-08  3647  			GFP_KERNEL);
83e80a6e3543f37 Jan Kara           2022-09-08  3648  	if (!sbi->s_mb_avg_fragment_size) {
83e80a6e3543f37 Jan Kara           2022-09-08  3649  		ret = -ENOMEM;
83e80a6e3543f37 Jan Kara           2022-09-08  3650  		goto out;
83e80a6e3543f37 Jan Kara           2022-09-08  3651  	}
83e80a6e3543f37 Jan Kara           2022-09-08  3652  	sbi->s_mb_avg_fragment_size_locks =
83e80a6e3543f37 Jan Kara           2022-09-08  3653  		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
83e80a6e3543f37 Jan Kara           2022-09-08  3654  			GFP_KERNEL);
83e80a6e3543f37 Jan Kara           2022-09-08  3655  	if (!sbi->s_mb_avg_fragment_size_locks) {
83e80a6e3543f37 Jan Kara           2022-09-08  3656  		ret = -ENOMEM;
83e80a6e3543f37 Jan Kara           2022-09-08  3657  		goto out;
83e80a6e3543f37 Jan Kara           2022-09-08  3658  	}
83e80a6e3543f37 Jan Kara           2022-09-08  3659  	for (i = 0; i < MB_NUM_ORDERS(sb); i++) {
83e80a6e3543f37 Jan Kara           2022-09-08  3660  		INIT_LIST_HEAD(&sbi->s_mb_avg_fragment_size[i]);
83e80a6e3543f37 Jan Kara           2022-09-08  3661  		rwlock_init(&sbi->s_mb_avg_fragment_size_locks[i]);
83e80a6e3543f37 Jan Kara           2022-09-08  3662  	}
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3663  	sbi->s_mb_largest_free_orders =
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3664  		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct list_head),
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3665  			GFP_KERNEL);
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3666  	if (!sbi->s_mb_largest_free_orders) {
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3667  		ret = -ENOMEM;
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3668  		goto out;
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3669  	}
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3670  	sbi->s_mb_largest_free_orders_locks =
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3671  		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3672  			GFP_KERNEL);
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3673  	if (!sbi->s_mb_largest_free_orders_locks) {
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3674  		ret = -ENOMEM;
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3675  		goto out;
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3676  	}
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3677  	for (i = 0; i < MB_NUM_ORDERS(sb); i++) {
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3678  		INIT_LIST_HEAD(&sbi->s_mb_largest_free_orders[i]);
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3679  		rwlock_init(&sbi->s_mb_largest_free_orders_locks[i]);
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3680  	}
c9de560ded61faa Alex Tomas         2008-01-29  3681
c9de560ded61faa Alex Tomas         2008-01-29  3682  	spin_lock_init(&sbi->s_md_lock);
d08854f5bcf3ea0 Theodore Ts'o      2016-06-26  3683  	sbi->s_mb_free_pending = 0;
ce774e5365e46be Jinke Han          2023-06-12  3684  	INIT_LIST_HEAD(&sbi->s_freed_data_list[0]);
ce774e5365e46be Jinke Han          2023-06-12  3685  	INIT_LIST_HEAD(&sbi->s_freed_data_list[1]);
55cdd0af2bc5ffc Wang Jianchao      2021-07-24  3686  	INIT_LIST_HEAD(&sbi->s_discard_list);
55cdd0af2bc5ffc Wang Jianchao      2021-07-24  3687  	INIT_WORK(&sbi->s_discard_work, ext4_discard_work);
5036ab8df278f98 Wang Jianchao      2021-08-30  3688  	atomic_set(&sbi->s_retry_alloc_pending, 0);
c9de560ded61faa Alex Tomas         2008-01-29  3689
c9de560ded61faa Alex Tomas         2008-01-29  3690  	sbi->s_mb_max_to_scan = MB_DEFAULT_MAX_TO_SCAN;
c9de560ded61faa Alex Tomas         2008-01-29  3691  	sbi->s_mb_min_to_scan = MB_DEFAULT_MIN_TO_SCAN;
c9de560ded61faa Alex Tomas         2008-01-29  3692  	sbi->s_mb_stats = MB_DEFAULT_STATS;
c9de560ded61faa Alex Tomas         2008-01-29  3693  	sbi->s_mb_stream_request = MB_DEFAULT_STREAM_THRESHOLD;
c9de560ded61faa Alex Tomas         2008-01-29  3694  	sbi->s_mb_order2_reqs = MB_DEFAULT_ORDER2_REQS;
f52f3d2b9fbab73 Ojaswin Mujoo      2023-05-30  3695  	sbi->s_mb_best_avail_max_trim_order = MB_DEFAULT_BEST_AVAIL_TRIM_ORDER;
7e170922f06bf46 Ojaswin Mujoo      2023-05-30  3696
27baebb849d46d9 Theodore Ts'o      2011-09-09  3697  	/*
27baebb849d46d9 Theodore Ts'o      2011-09-09  3698  	 * The default group preallocation is 512, which for 4k block
27baebb849d46d9 Theodore Ts'o      2011-09-09  3699  	 * sizes translates to 2 megabytes.  However for bigalloc file
27baebb849d46d9 Theodore Ts'o      2011-09-09  3700  	 * systems, this is probably too big (i.e, if the cluster size
27baebb849d46d9 Theodore Ts'o      2011-09-09  3701  	 * is 1 megabyte, then group preallocation size becomes half a
27baebb849d46d9 Theodore Ts'o      2011-09-09  3702  	 * gigabyte!).  As a default, we will keep a two megabyte
27baebb849d46d9 Theodore Ts'o      2011-09-09  3703  	 * group pralloc size for cluster sizes up to 64k, and after
27baebb849d46d9 Theodore Ts'o      2011-09-09  3704  	 * that, we will force a minimum group preallocation size of
27baebb849d46d9 Theodore Ts'o      2011-09-09  3705  	 * 32 clusters.  This translates to 8 megs when the cluster
27baebb849d46d9 Theodore Ts'o      2011-09-09  3706  	 * size is 256k, and 32 megs when the cluster size is 1 meg,
27baebb849d46d9 Theodore Ts'o      2011-09-09  3707  	 * which seems reasonable as a default.
27baebb849d46d9 Theodore Ts'o      2011-09-09  3708  	 */
27baebb849d46d9 Theodore Ts'o      2011-09-09  3709  	sbi->s_mb_group_prealloc = max(MB_DEFAULT_GROUP_PREALLOC >>
27baebb849d46d9 Theodore Ts'o      2011-09-09  3710  				       sbi->s_cluster_bits, 32);
d7a1fee135771e6 Dan Ehrenberg      2011-07-17  3711  	/*
d7a1fee135771e6 Dan Ehrenberg      2011-07-17  3712  	 * If there is a s_stripe > 1, then we set the s_mb_group_prealloc
d7a1fee135771e6 Dan Ehrenberg      2011-07-17  3713  	 * to the lowest multiple of s_stripe which is bigger than
d7a1fee135771e6 Dan Ehrenberg      2011-07-17  3714  	 * the s_mb_group_prealloc as determined above. We want
d7a1fee135771e6 Dan Ehrenberg      2011-07-17  3715  	 * the preallocation size to be an exact multiple of the
d7a1fee135771e6 Dan Ehrenberg      2011-07-17  3716  	 * RAID stripe size so that preallocations don't fragment
d7a1fee135771e6 Dan Ehrenberg      2011-07-17  3717  	 * the stripes.
d7a1fee135771e6 Dan Ehrenberg      2011-07-17  3718  	 */
d7a1fee135771e6 Dan Ehrenberg      2011-07-17  3719  	if (sbi->s_stripe > 1) {
d7a1fee135771e6 Dan Ehrenberg      2011-07-17  3720  		sbi->s_mb_group_prealloc = roundup(
ff2beee206d23f4 Ojaswin Mujoo      2024-08-30  3721  			sbi->s_mb_group_prealloc, EXT4_NUM_B2C(sbi, sbi->s_stripe));
d7a1fee135771e6 Dan Ehrenberg      2011-07-17  3722  	}
c9de560ded61faa Alex Tomas         2008-01-29  3723
c1ba37650891e5c Baokun Li          2025-06-23  3724  	sbi->s_mb_last_groups = kcalloc(MB_LAST_GROUPS, sizeof(ext4_group_t),
c1ba37650891e5c Baokun Li          2025-06-23 @3725  					GFP_KERNEL);
c1ba37650891e5c Baokun Li          2025-06-23  3726  	if (sbi->s_mb_last_groups == NULL) {
c1ba37650891e5c Baokun Li          2025-06-23  3727  		ret = -ENOMEM;
c1ba37650891e5c Baokun Li          2025-06-23  3728  		goto out;
c1ba37650891e5c Baokun Li          2025-06-23  3729  	}
c1ba37650891e5c Baokun Li          2025-06-23  3730
730c213c79a6381 Eric Sandeen       2008-09-13  3731  	sbi->s_locality_groups = alloc_percpu(struct ext4_locality_group);
c9de560ded61faa Alex Tomas         2008-01-29  3732  	if (sbi->s_locality_groups == NULL) {
fb1813f4a8a27bb Curt Wohlgemuth    2010-10-27  3733  		ret = -ENOMEM;
c1ba37650891e5c Baokun Li          2025-06-23  3734  		goto out_free_last_groups;
c9de560ded61faa Alex Tomas         2008-01-29  3735  	}
730c213c79a6381 Eric Sandeen       2008-09-13  3736  	for_each_possible_cpu(i) {
c9de560ded61faa Alex Tomas         2008-01-29  3737  		struct ext4_locality_group *lg;
730c213c79a6381 Eric Sandeen       2008-09-13  3738  		lg = per_cpu_ptr(sbi->s_locality_groups, i);
c9de560ded61faa Alex Tomas         2008-01-29  3739  		mutex_init(&lg->lg_mutex);
6be2ded1d7c51b3 Aneesh Kumar K.V   2008-07-23  3740  		for (j = 0; j < PREALLOC_TB_SIZE; j++)
6be2ded1d7c51b3 Aneesh Kumar K.V   2008-07-23  3741  			INIT_LIST_HEAD(&lg->lg_prealloc_list[j]);
c9de560ded61faa Alex Tomas         2008-01-29  3742  		spin_lock_init(&lg->lg_prealloc_lock);
c9de560ded61faa Alex Tomas         2008-01-29  3743  	}
c9de560ded61faa Alex Tomas         2008-01-29  3744
10f0d2a517796b8 Christoph Hellwig  2022-04-15  3745  	if (bdev_nonrot(sb->s_bdev))
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3746  		sbi->s_mb_max_linear_groups = 0;
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3747  	else
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3748  		sbi->s_mb_max_linear_groups = MB_DEFAULT_LINEAR_LIMIT;
79a77c5ac34cc27 Yu Jian            2011-08-01  3749  	/* init file for buddy data */
79a77c5ac34cc27 Yu Jian            2011-08-01  3750  	ret = ext4_mb_init_backend(sb);
7aa0baeaba4afc4 Tao Ma             2011-10-06  3751  	if (ret != 0)
7aa0baeaba4afc4 Tao Ma             2011-10-06  3752  		goto out_free_locality_groups;
79a77c5ac34cc27 Yu Jian            2011-08-01  3753
7aa0baeaba4afc4 Tao Ma             2011-10-06  3754  	return 0;
7aa0baeaba4afc4 Tao Ma             2011-10-06  3755
7aa0baeaba4afc4 Tao Ma             2011-10-06  3756  out_free_locality_groups:
7aa0baeaba4afc4 Tao Ma             2011-10-06  3757  	free_percpu(sbi->s_locality_groups);
7aa0baeaba4afc4 Tao Ma             2011-10-06  3758  	sbi->s_locality_groups = NULL;
c1ba37650891e5c Baokun Li          2025-06-23  3759  out_free_last_groups:
c1ba37650891e5c Baokun Li          2025-06-23 @3760  	kvfree(sbi->s_mb_last_groups);
c1ba37650891e5c Baokun Li          2025-06-23  3761  	sbi->s_mb_last_groups = NULL;
fb1813f4a8a27bb Curt Wohlgemuth    2010-10-27  3762  out:
83e80a6e3543f37 Jan Kara           2022-09-08  3763  	kfree(sbi->s_mb_avg_fragment_size);
83e80a6e3543f37 Jan Kara           2022-09-08  3764  	kfree(sbi->s_mb_avg_fragment_size_locks);
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3765  	kfree(sbi->s_mb_largest_free_orders);
196e402adf2e4cd Harshad Shirwadkar 2021-04-01  3766  	kfree(sbi->s_mb_largest_free_orders_locks);
fb1813f4a8a27bb Curt Wohlgemuth    2010-10-27  3767  	kfree(sbi->s_mb_offsets);
7aa0baeaba4afc4 Tao Ma             2011-10-06  3768  	sbi->s_mb_offsets = NULL;
fb1813f4a8a27bb Curt Wohlgemuth    2010-10-27  3769  	kfree(sbi->s_mb_maxs);
7aa0baeaba4afc4 Tao Ma             2011-10-06  3770  	sbi->s_mb_maxs = NULL;
fb1813f4a8a27bb Curt Wohlgemuth    2010-10-27  3771  	return ret;
c9de560ded61faa Alex Tomas         2008-01-29  3772  }
c9de560ded61faa Alex Tomas         2008-01-29  3773

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

