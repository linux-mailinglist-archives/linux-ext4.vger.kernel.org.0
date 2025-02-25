Return-Path: <linux-ext4+bounces-6555-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C52A432AA
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2025 02:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E60165F69
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2025 01:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CBC7DA73;
	Tue, 25 Feb 2025 01:53:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAA8450FE;
	Tue, 25 Feb 2025 01:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740448397; cv=none; b=iAgV1TUglCAh0wdiX/R06S6OZUfd7E/8XxJwFjtiA22iDv5KcViuZM1jWayVyaXDGgN35JoWJLoYeq79ExdAX5KdO15xEfJ+7NdZYC/AYbO4WQ3SM5hgWyBUcwZAtMlKxJeTkpQGw9ltjRZLvFJAUyecEy3NH758nmBOcmfuCU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740448397; c=relaxed/simple;
	bh=gKtdkH/FUJhSmNeXPSQGpNJZSyRDX4r/ZF51CLUAd9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HhGAMDnlxVXdAscLea9UZcdrZl0lnTi+GWEKBmUVZiKGcafXO6oCOVHgVvn46uTM35Dm9A1ALoOqOv/vF4ZlTn6INzWRtlKhG2RqunKNYPWxgRZ4QZ1PG1lLm6K6Y1a7fEfgMU778JenOVe9G5qmSdTAyyh6W/oXWj35tDKy1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z20vZ11RPz1HLxh;
	Tue, 25 Feb 2025 09:51:38 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C38D1A016C;
	Tue, 25 Feb 2025 09:53:12 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 25 Feb
 2025 09:53:11 +0800
Message-ID: <3f9a67e2-ef08-47d4-b35e-41841e24bb71@huawei.com>
Date: Tue, 25 Feb 2025 09:53:10 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ext4: only defer sb update on error if SB_ACTIVE
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Jan Kara
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, Mahesh Kumar
	<maheshkumar657g@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>, Yang
 Erkun <yangerkun@huawei.com>
References: <cover.1740212945.git.ojaswin@linux.ibm.com>
 <da8af2e5170f0d94031b812d7d50c6ec1967db1b.1740212945.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <da8af2e5170f0d94031b812d7d50c6ec1967db1b.1740212945.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/2/22 16:40, Ojaswin Mujoo wrote:
> Presently we always BUG_ON if trying to start a transaction on a journal
> marked with JBD2_UNMOUNT, since this should never happen. However while
> running stress tests it was observed that in case of some error handling
> paths, it is possible for update_super_work to start a transaction after
> the journal is destroyed eg:
>
> (umount)
> ext4_kill_sb
>    kill_block_super
>      generic_shutdown_super
>        sync_filesystem /* commits all txns */
>        evict_inodes
>          /* might start a new txn */
>        ext4_put_super
> 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
>          jbd2_journal_destroy
>            journal_kill_thread
>              journal->j_flags |= JBD2_UNMOUNT;
>            jbd2_journal_commit_transaction
>              jbd2_journal_get_descriptor_buffer
>                jbd2_journal_bmap
>                  ext4_journal_bmap
>                    ext4_map_blocks
>                      ...
>                      ext4_inode_error
Just curious, since jbd2_journal_bmap() only queries the map and does not
create it, how does it fail here? Is there more information in dmesg?
Is s_journal_inum normal after file system corruption?

Thanks,
Baokun
>                        ext4_handle_error
>                          schedule_work(&sbi->s_sb_upd_work)
>
>                                                 /* work queue kicks in */
>                                                 update_super_work
>                                                   jbd2_journal_start
>                                                     start_this_handle
>                                                       BUG_ON(journal->j_flags &
>                                                              JBD2_UNMOUNT)
>
> Hence, make sure we only defer the update of ext4 sb if the sb is still
> active.  Otherwise, just fallback to an un-journaled commit.
>
> The important thing to note here is that we must only defer sb update if
> we have not yet flushed the s_sb_update_work queue in umount path else
> this race can be hit (point 1 below). Since we don't have a direct way
> to check for that we use SB_ACTIVE instead. The SB_ACTIVE check is a bit
> subtle so adding some notes below for future reference:
>
> 1. Ideally we would want to have a something like (flags & JBD2_UNMOUNT
> == 0) however this is not correct since we could end up scheduling work
> after it has been flushed:
>
>   ext4_put_super
>    flush_work(&sbi->s_sb_upd_work)
>
>                             **kjournald2**
>                             jbd2_journal_commit_transaction
>                             ...
>                             ext4_inode_error
>                               /* JBD2_UNMOUNT not set */
>                               schedule_work(s_sb_upd_work)
>
>     jbd2_journal_destroy
>      journal->j_flags |= JBD2_UNMOUNT;
>
>                                        **workqueue**
>                                        update_super_work
>                                         jbd2_journal_start
>                                          start_this_handle
>                                            BUG_ON(JBD2_UNMOUNT)
>
> Something like the above doesn't happen with SB_ACTIVE check because we
> are sure that the workqueue would be flushed at a later point if we are
> in the umount path.
>
> 2. We don't need a similar check in ext4_grp_locked_error since it is
> only called from mballoc and AFAICT it would be always valid to schedule
> work here.
>
> Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
> Suggested-by: Ritesh Harjani <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>   fs/ext4/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a963ffda692a..b7341e9acf62 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -706,7 +706,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>   		 * constraints, it may not be safe to do it right here so we
>   		 * defer superblock flushing to a workqueue.
>   		 */
> -		if (continue_fs && journal)
> +		if (continue_fs && journal && (sb->s_flags & SB_ACTIVE))
>   			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
>   		else
>   			ext4_commit_super(sb);



