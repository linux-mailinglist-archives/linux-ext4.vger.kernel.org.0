Return-Path: <linux-ext4+bounces-11397-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BB2C29BFC
	for <lists+linux-ext4@lfdr.de>; Mon, 03 Nov 2025 01:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8EB6343548
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Nov 2025 00:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DD21B87C9;
	Mon,  3 Nov 2025 00:56:16 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E4146588
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 00:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762131376; cv=none; b=JLtOUBo/xb5F1uYzt2RjzUGdbg3GWuDJUVwWA1uq6HIbKj/UpFJrW3+Hpx7CN0pn79mGV/TyZ4bCJOwP0J4shlL+cNbNDr+u/hi6UD6361j65MjV7w6hVeN5iOcCghJJoG30PC5xu+OYhanWV2CTg/09xuMAoBEZBTfen5xeIFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762131376; c=relaxed/simple;
	bh=8bm8Pol7Wd934UeQtrIu3YNEM4PJkWdJ+b6Czp9eaPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSYcfmHomf3SrZiE0jk600IGLs8Ky5Fd2T6uS9Ex7IDKbYS6ZyXzlri6eY0smNo3AeI9MqCUHuR6sHO/d9TA3dPkbwjLl9HViNAfo6SgmE5CqqH2J3gg0ZQpdpY9SgZJG0+BVY3RseFKjKI1HUibRIs9KRlnPwGdksREROrfqQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d0CnV6ctSzKHMTb
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 08:55:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 87A8A1A092F
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 08:56:02 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgD3TUag_Qdp2HkSCg--.28268S3;
	Mon, 03 Nov 2025 08:56:02 +0800 (CST)
Message-ID: <8d2dbd93-da25-4077-8070-dd2998820b41@huaweicloud.com>
Date: Mon, 3 Nov 2025 08:56:00 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] jbd2: store more accurate errno in superblock when
 possible
To: Wengang Wang <wen.gang.wang@oracle.com>, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca
References: <20251031210501.7337-1-wen.gang.wang@oracle.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251031210501.7337-1-wen.gang.wang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgD3TUag_Qdp2HkSCg--.28268S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1UGF1kurWfZw4xtw4xJFb_yoWruryUpr
	yDG348ArWj9ryUZF1xWF4UJFWq9340yFyUKr1Du3Wktw43XrnFqr4DJr1qgryYyas5Way5
	XrWUGwn8Cay0vFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 11/1/2025 5:05 AM, Wengang Wang wrote:
> When jbd2_journal_abort() is called, the provided error code is stored
> in the journal superblock. Some existing calls hard-code -EIO even when
> the actual failure is not I/O related.
> 
> This patch updates those calls to pass more accurate error codes,
> allowing the superblock to record the true cause of failure. This helps
> improve diagnostics and debugging clarity when analyzing journal aborts.
> 
> Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>

Looks good to me. Feel free to add:

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/super.c       |  4 ++--
>  fs/jbd2/checkpoint.c  |  2 +-
>  fs/jbd2/journal.c     | 15 +++++++++------
>  fs/jbd2/transaction.c |  5 +++--
>  4 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 33e7c08c9529..b82cee72f7e7 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -698,7 +698,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>  		WARN_ON_ONCE(1);
>  
>  	if (!continue_fs && !ext4_emergency_ro(sb) && journal)
> -		jbd2_journal_abort(journal, -EIO);
> +		jbd2_journal_abort(journal, -error);
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


