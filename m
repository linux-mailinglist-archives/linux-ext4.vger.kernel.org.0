Return-Path: <linux-ext4+bounces-14033-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHXbLAgboGmzfgQAu9opvQ
	(envelope-from <linux-ext4+bounces-14033-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 11:06:00 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DA91A3F2E
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 11:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C62343012207
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 10:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846BB3A1D11;
	Thu, 26 Feb 2026 10:05:28 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE213A4F3A;
	Thu, 26 Feb 2026 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100328; cv=none; b=TC4HV17Pn63cCtsRKBsZ1xMPaGALHdxODfu6HwgbKzCmHYxcPdrToYsPObHmKsZ9PyZrSO3oOE6cOM4VDEG+7vVWU1o2J0TFF7L68wr2obIVcbJDy7+Rlx6ewD944jOiPNLX5x4CHEAG7fs1qBGxMtIFdl4QnbziwzmEyWfiRLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100328; c=relaxed/simple;
	bh=Jr71TEpuefliB8XSf5nWXwoG0tj6pv/9i9Mu40e8vMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Eq0DOPAB10eaRXThNxhi9TWp082YYnEJGPGSMy9t8g572UXTwV0xVt1U5j7vn/KnIJKD0craxlkq0CUqS8VRno5YtXrYefFGy2hYtW5+Eb0ZtzwZQA446XVWim7Jppq07y+/LeG75ZA1Y7VGWeRsKIzGYnk73V2B70PuRY+BU/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.108.10.175] (unknown [194.94.98.184])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 95D5A4C4430406;
	Thu, 26 Feb 2026 11:04:24 +0100 (CET)
Message-ID: <5b8c1811-c9d9-469a-b8d0-992814a11b9a@molgen.mpg.de>
Date: Thu, 26 Feb 2026 11:04:23 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: remove bdev_nonrot()
To: Damien Le Moal <dlemoal@kernel.org>
References: <20260226075448.2229655-1-dlemoal@kernel.org>
Content-Language: en-US
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
 linux-raid@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260226075448.2229655-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14033-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09DA91A3F2E
X-Rspamd-Action: no action

Dear Damien,


Thank you for your patch.


Am 26.02.26 um 08:54 schrieb Damien Le Moal:
> bdev_nonrot() is simply the negative return value of bdev_rot().
> So replace all call sites of bdev_nonrot() with calls to bdev_rot()
> and remove bdev_nonrot().

Is the generated code different now?

Is it worth the change, as it looks quite subjective if you prefer the 
one or the other way?

> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/md/raid1.c                  | 2 +-
>   drivers/md/raid10.c                 | 2 +-
>   drivers/md/raid5.c                  | 2 +-
>   drivers/target/target_core_file.c   | 2 +-
>   drivers/target/target_core_iblock.c | 2 +-
>   fs/btrfs/volumes.c                  | 4 ++--
>   fs/ext4/mballoc-test.c              | 2 +-
>   fs/ext4/mballoc.c                   | 2 +-
>   include/linux/blkdev.h              | 5 -----
>   mm/swapfile.c                       | 2 +-
>   10 files changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 181400e147c0..cda6af0712b9 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1878,7 +1878,7 @@ static bool raid1_add_conf(struct r1conf *conf, struct md_rdev *rdev, int disk,
>   	if (info->rdev)
>   		return false;
>   
> -	if (bdev_nonrot(rdev->bdev)) {
> +	if (!bdev_rot(rdev->bdev)) {
>   		set_bit(Nonrot, &rdev->flags);
>   		WRITE_ONCE(conf->nonrot_disks, conf->nonrot_disks + 1);
>   	}
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 0653b5d8545a..cfbd345805ca 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -806,7 +806,7 @@ static struct md_rdev *read_balance(struct r10conf *conf,
>   		if (!do_balance)
>   			break;
>   
> -		nonrot = bdev_nonrot(rdev->bdev);
> +		nonrot = !bdev_rot(rdev->bdev);
>   		has_nonrot_disk |= nonrot;
>   		pending = atomic_read(&rdev->nr_pending);
>   		if (min_pending > pending && nonrot) {
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index a8e8d431071b..ba9d6d05b089 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7541,7 +7541,7 @@ static struct r5conf *setup_conf(struct mddev *mddev)
>   	rdev_for_each(rdev, mddev) {
>   		if (test_bit(Journal, &rdev->flags))
>   			continue;
> -		if (bdev_nonrot(rdev->bdev)) {
> +		if (!bdev_rot(rdev->bdev)) {
>   			conf->batch_bio_dispatch = false;
>   			break;
>   		}
> diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
> index 3ae1f7137d9d..d6e3e5214652 100644
> --- a/drivers/target/target_core_file.c
> +++ b/drivers/target/target_core_file.c
> @@ -173,7 +173,7 @@ static int fd_configure_device(struct se_device *dev)
>   		 */
>   		dev->dev_attrib.max_write_same_len = 0xFFFF;
>   
> -		if (bdev_nonrot(bdev))
> +		if (!bdev_rot(bdev))
>   			dev->dev_attrib.is_nonrot = 1;
>   	} else {
>   		if (!(fd_dev->fbd_flags & FBDF_HAS_SIZE)) {
> diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
> index 3c92f94497b4..1087d1d17c36 100644
> --- a/drivers/target/target_core_iblock.c
> +++ b/drivers/target/target_core_iblock.c
> @@ -148,7 +148,7 @@ static int iblock_configure_device(struct se_device *dev)
>   	else
>   		dev->dev_attrib.max_write_same_len = 0xFFFF;
>   
> -	if (bdev_nonrot(bd))
> +	if (!bdev_rot(bd))
>   		dev->dev_attrib.is_nonrot = 1;
>   
>   	target_configure_write_atomic_from_bdev(&dev->dev_attrib, bd);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6fb0c4cd50ff..c6e49eb74f3a 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -694,7 +694,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>   			set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>   	}
>   
> -	if (!bdev_nonrot(file_bdev(bdev_file)))
> +	if (bdev_rot(file_bdev(bdev_file)))
>   		fs_devices->rotating = true;
>   
>   	if (bdev_max_discard_sectors(file_bdev(bdev_file)))
> @@ -2919,7 +2919,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   
>   	atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
>   
> -	if (!bdev_nonrot(device->bdev))
> +	if (bdev_rot(device->bdev))
>   		fs_devices->rotating = true;
>   
>   	orig_super_total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
> diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
> index 9fbdf6a09489..b9f22e3a8d5c 100644
> --- a/fs/ext4/mballoc-test.c
> +++ b/fs/ext4/mballoc-test.c
> @@ -72,7 +72,7 @@ static int mbt_mb_init(struct super_block *sb)
>   	ext4_fsblk_t block;
>   	int ret;
>   
> -	/* needed by ext4_mb_init->bdev_nonrot(sb->s_bdev) */
> +	/* needed by ext4_mb_init->bdev_rot(sb->s_bdev) */
>   	sb->s_bdev = kzalloc_obj(*sb->s_bdev);
>   	if (sb->s_bdev == NULL)
>   		return -ENOMEM;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 20e9fdaf4301..8a4dfe19878c 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3836,7 +3836,7 @@ int ext4_mb_init(struct super_block *sb)
>   		spin_lock_init(&lg->lg_prealloc_lock);
>   	}
>   
> -	if (bdev_nonrot(sb->s_bdev))
> +	if (!bdev_rot(sb->s_bdev))
>   		sbi->s_mb_max_linear_groups = 0;
>   	else
>   		sbi->s_mb_max_linear_groups = MB_DEFAULT_LINEAR_LIMIT;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index d463b9b5a0a5..e439d6fa8484 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1467,11 +1467,6 @@ static inline bool bdev_rot(struct block_device *bdev)
>   	return blk_queue_rot(bdev_get_queue(bdev));
>   }
>   
> -static inline bool bdev_nonrot(struct block_device *bdev)
> -{
> -	return !bdev_rot(bdev);
> -}
> -
>   static inline bool bdev_synchronous(struct block_device *bdev)
>   {
>   	return bdev->bd_disk->queue->limits.features & BLK_FEAT_SYNCHRONOUS;
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 94af29d1de88..60e21414624b 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3460,7 +3460,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>   	if (si->bdev && bdev_synchronous(si->bdev))
>   		si->flags |= SWP_SYNCHRONOUS_IO;
>   
> -	if (si->bdev && bdev_nonrot(si->bdev)) {
> +	if (si->bdev && !bdev_rot(si->bdev)) {
>   		si->flags |= SWP_SOLIDSTATE;
>   	} else {
>   		atomic_inc(&nr_rotate_swap);

My point above aside, the diff looks good.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

