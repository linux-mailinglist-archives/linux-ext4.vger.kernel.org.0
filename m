Return-Path: <linux-ext4+bounces-11049-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FF2C0887B
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Oct 2025 04:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3037D3AEE9E
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Oct 2025 02:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393E522F75E;
	Sat, 25 Oct 2025 02:04:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCF1218596
	for <linux-ext4@vger.kernel.org>; Sat, 25 Oct 2025 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761357854; cv=none; b=tk74T8kpTChXIx9qUqxSdC19QA7peAtsR4bi+QScCJ9fQ7bmigvbAYSIp03BIQlyz8XFcm9VAq9BvncDiK/BnHo2HnEquFJrLuiqyilcFmLemQwGOzPyHPL4E7vfZmrLRudvfAFwlLK6XNwfhIJ7bPbDkHlCU6i3xHc0epqr4Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761357854; c=relaxed/simple;
	bh=9bfnNLm3s+PdwjBM2ns9oeleVC9ZNMQDd1OVQaeW2Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cl0Fn8x4dF2YTL8yn3+wM28g7qHUuQ2Nm4y5+SI4o+N/MYZQXLnan99ycRppgxJMO0LGoPOWnq+6oc/nZBUfH+yqXXNFAVq3BpAr9w9Tw7Xpi516rzK3JxjYS0I8SUrwZmjFo5jhar0dpJgkNHD2EZjb+kK06BdSfx1nYXpvzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ctjj82rBrzYQtlH
	for <linux-ext4@vger.kernel.org>; Sat, 25 Oct 2025 10:03:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id EC0491A176B
	for <linux-ext4@vger.kernel.org>; Sat, 25 Oct 2025 10:04:06 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBXrUUVMPxoaXgUBg--.42985S3;
	Sat, 25 Oct 2025 10:04:06 +0800 (CST)
Message-ID: <9c0b71f1-0cb3-4777-a9d7-dc9510fbb760@huaweicloud.com>
Date: Sat, 25 Oct 2025 10:04:05 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: store more accurate errno in superblock when
 possible
To: Wengang Wang <wen.gang.wang@oracle.com>, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca
References: <20251024193532.45525-1-wen.gang.wang@oracle.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251024193532.45525-1-wen.gang.wang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBXrUUVMPxoaXgUBg--.42985S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4ktF45tFykCF43Ww4xCrg_yoWruFW7pr
	yDG34kArWq9ryUZF1xWF4UJFWq9340yFyUKr1DC3Wktw43XrnFqr4DJr1qgryYyas5Way5
	XrWUG3s8Cay09rDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 10/25/2025 3:35 AM, Wengang Wang wrote:
> When jbd2_journal_abort() is called, the provided error code is stored
> in the journal superblock. Some existing calls hard-code -EIO even when
> the actual failure is not I/O related.
> 
> This patch updates those calls to pass more accurate error codes,
> allowing the superblock to record the true cause of failure. This helps
> improve diagnostics and debugging clarity when analyzing journal aborts.
> 
> Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>

Thank you for the patch, it makes sense to me. I have just one minor
comment below.

> ---
>  fs/ext4/super.c       |  4 ++--
>  fs/jbd2/checkpoint.c  |  2 +-
>  fs/jbd2/journal.c     | 15 +++++++++------
>  fs/jbd2/transaction.c |  5 +++--
>  4 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 33e7c08c9529..baf1098cac63 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -698,7 +698,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>  		WARN_ON_ONCE(1);
>  
>  	if (!continue_fs && !ext4_emergency_ro(sb) && journal)
> -		jbd2_journal_abort(journal, -EIO);
> +		jbd2_journal_abort(journal, error);
		                            ^^^^^
		                            this should be -error

The others look good to me.

Thanks,
Yi.

>  
>  	if (!bdev_read_only(sb->s_bdev)) {
>  		save_error_info(sb, error, ino, block, func, line);
> @@ -5842,7 +5842,7 @@ static int ext4_journal_bmap(journal_t *journal, sector_t *block)
>  		ext4_msg(journal->j_inode->i_sb, KERN_CRIT,
>  			 "journal bmap failed: block %llu ret %d\n",
>  			 *block, ret);
> -		jbd2_journal_abort(journal, ret ? ret : -EIO);
> +		jbd2_journal_abort(journal, ret ? ret : -EFSCORRUPTED);
>  		return ret;
>  	}
>  	*block = map.m_pblk;
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 2d0719bf6d87..de89c5bef607 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -113,7 +113,7 @@ __releases(&journal->j_state_lock)
>  				       "journal space in %s\n", __func__,
>  				       journal->j_devname);
>  				WARN_ON(1);
> -				jbd2_journal_abort(journal, -EIO);
> +				jbd2_journal_abort(journal, -ENOSPC);
>  			}
>  			write_lock(&journal->j_state_lock);
>  		} else {
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d480b94117cd..d965dc0b9a59 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -937,8 +937,8 @@ int jbd2_journal_bmap(journal_t *journal, unsigned long blocknr,
>  			printk(KERN_ALERT "%s: journal block not found "
>  					"at offset %lu on %s\n",
>  			       __func__, blocknr, journal->j_devname);
> +			jbd2_journal_abort(journal, ret ? ret : -EFSCORRUPTED);
>  			err = -EIO;
> -			jbd2_journal_abort(journal, err);
>  		} else {
>  			*retp = block;
>  		}
> @@ -1858,8 +1858,9 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
>  
>  	if (is_journal_aborted(journal))
>  		return -EIO;
> -	if (jbd2_check_fs_dev_write_error(journal)) {
> -		jbd2_journal_abort(journal, -EIO);
> +	ret = jbd2_check_fs_dev_write_error(journal);
> +	if (ret) {
> +		jbd2_journal_abort(journal, ret);
>  		return -EIO;
>  	}
>  
> @@ -2156,9 +2157,11 @@ int jbd2_journal_destroy(journal_t *journal)
>  	 * failed to write back to the original location, otherwise the
>  	 * filesystem may become inconsistent.
>  	 */
> -	if (!is_journal_aborted(journal) &&
> -	    jbd2_check_fs_dev_write_error(journal))
> -		jbd2_journal_abort(journal, -EIO);
> +	if (!is_journal_aborted(journal)) {
> +		int ret = jbd2_check_fs_dev_write_error(journal);
> +		if (ret)
> +			jbd2_journal_abort(journal, ret);
> +	}
>  
>  	if (journal->j_sb_buffer) {
>  		if (!is_journal_aborted(journal)) {
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 3e510564de6e..44dfaa9e7839 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -1219,7 +1219,8 @@ int jbd2_journal_get_write_access(handle_t *handle, struct buffer_head *bh)
>  		return -EROFS;
>  
>  	journal = handle->h_transaction->t_journal;
> -	if (jbd2_check_fs_dev_write_error(journal)) {
> +	rc = jbd2_check_fs_dev_write_error(journal);
> +	if (rc) {
>  		/*
>  		 * If the fs dev has writeback errors, it may have failed
>  		 * to async write out metadata buffers in the background.
> @@ -1227,7 +1228,7 @@ int jbd2_journal_get_write_access(handle_t *handle, struct buffer_head *bh)
>  		 * it out again, which may lead to on-disk filesystem
>  		 * inconsistency. Aborting journal can avoid it happen.
>  		 */
> -		jbd2_journal_abort(journal, -EIO);
> +		jbd2_journal_abort(journal, rc);
>  		return -EIO;
>  	}
>  


