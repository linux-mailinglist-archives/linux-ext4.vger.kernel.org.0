Return-Path: <linux-ext4+bounces-12579-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4DDCF3936
	for <lists+linux-ext4@lfdr.de>; Mon, 05 Jan 2026 13:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74761307BF73
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jan 2026 12:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846303396F7;
	Mon,  5 Jan 2026 12:18:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC833112D3;
	Mon,  5 Jan 2026 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615532; cv=none; b=ORlOlarwB2hKx3jYNSpigZebyKjIpOLovJjUvv5a1MKZdUxTvON1crfc9TgFuJx9X9mh2EIIvXbxO7NMZ4WY57M2QCaUwQQZPwkyPEmaB8GoFFttOgss+ZwnXTp56wy1yS/LtiMM29/4qMkyftcuIZqNAAr4rxFmO/N4rBukq8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615532; c=relaxed/simple;
	bh=nEvW+/Ybi59uffTV+jnuzEE0kvBSPRKegMXjHpSTe/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Z0nI1v8TVHF2R1L9TN4grmxObyBt/eOZKYMUmvEcx9PCx7lx+vmt5y8O4TRiEMJxedV90F2lgtdDZWw4Dwd1XTjqllMC2jhultu2/5JN+/sCoknWDBV7MYEWwKc4ymdcGgBP6/nUdooYKMZhHoJm3uhyMUWZ1rxOS6ix1+xU+wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dlCx52q8vzYQv30;
	Mon,  5 Jan 2026 20:17:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 366374058C;
	Mon,  5 Jan 2026 20:18:44 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgAHaPgirFtpO+LgCg--.51928S3;
	Mon, 05 Jan 2026 20:18:44 +0800 (CST)
Message-ID: <e3465e09-0b6f-419c-9af5-00e750448e53@huaweicloud.com>
Date: Mon, 5 Jan 2026 20:18:42 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 1/2] ext4: fast_commit: assert i_data_sem only before
 sleep
To: Li Chen <me@linux.beauty>, linux-ext4@vger.kernel.org
References: <20251224032943.134063-1-me@linux.beauty>
 <20251224032943.134063-2-me@linux.beauty>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251224032943.134063-2-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHaPgirFtpO+LgCg--.51928S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyrAr47XF4xtF13CF43GFg_yoW5ZrWkpr
	4fCFyrJrs7JrW0grs7trW8ZF1Ikw4kGw4UWFy3KFyxXrs8X3WfKFsxKF1fGF9rKr4kAw1Y
	q3WYvrW7Xay0ka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jjVbkUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi Li,

On 12/24/2025 11:29 AM, Li Chen wrote:
> ext4_fc_track_inode() can return without sleeping when
> EXT4_STATE_FC_COMMITTING is already clear. The lockdep assertion for
> ei->i_data_sem was done unconditionally before the wait loop, which can
> WARN in call paths that hold i_data_sem even though we never block. Move
> lockdep_assert_not_held(&ei->i_data_sem) into the actual sleep path,
> right before schedule().
> 
> Signed-off-by: Li Chen <me@linux.beauty>

Thank you for the fix patch! However, the solution does not seem to fix
the issue. IIUC, the root cause of this issue is the following race
condition (show only one case), and it may cause a real ABBA dead lock
issue.

ext4_map_blocks()
 hold i_data_sem // <- A
 ext4_mb_new_blocks()
  ext4_dirty_inode()
                                 ext4_fc_commit()
                                  ext4_fc_perform_commit()
                                   set EXT4_STATE_FC_COMMITTING  <-B
                                   ext4_fc_write_inode_data()
                                   ext4_map_blocks()
                                    hold i_data_sem  // <- A
   ext4_fc_track_inode()
    wait EXT4_STATE_FC_COMMITTING  <- B
                                  jbd2_fc_end_commit()
                                   ext4_fc_cleanup()
                                    clear EXT4_STATE_FC_COMMITTING()

Postponing the lockdep assertion to the point where sleeping is actually
necessary does not resolve this deadlock issue, it merely masks the
problem, right?

I currently don't quite understand why only ext4_fc_track_inode() needs
to wait for the inode being fast committed to be completed, instead of
adding it to the FC_Q_STAGING list like other tracking operations. So
now I don't have a good idea to fix this problem either.  Perhaps we
need to rethink the necessity of this waiting, or find a way to avoid
acquiring i_data_sem during fast commit.

Thanks,
Yi.

> ---
>  fs/ext4/fast_commit.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index d0926967d086..b0c458082997 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -566,13 +566,6 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
>  	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
>  		return;
>  
> -	/*
> -	 * If we come here, we may sleep while waiting for the inode to
> -	 * commit. We shouldn't be holding i_data_sem when we go to sleep since
> -	 * the commit path needs to grab the lock while committing the inode.
> -	 */
> -	lockdep_assert_not_held(&ei->i_data_sem);
> -
>  	while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
>  #if (BITS_PER_LONG < 64)
>  		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
> @@ -586,8 +579,16 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
>  				   EXT4_STATE_FC_COMMITTING);
>  #endif
>  		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> -		if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
> +		if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
> +			/*
> +			 * We might sleep while waiting for the inode to commit.
> +			 * We shouldn't be holding i_data_sem when we go to sleep
> +			 * since the commit path may grab it while committing this
> +			 * inode.
> +			 */
> +			lockdep_assert_not_held(&ei->i_data_sem);
>  			schedule();
> +		}
>  		finish_wait(wq, &wait.wq_entry);
>  	}
>  


