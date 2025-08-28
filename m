Return-Path: <linux-ext4+bounces-9724-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EB3B390D4
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 03:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61030188DD48
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 01:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4305E13FEE;
	Thu, 28 Aug 2025 01:14:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86F6FC5
	for <linux-ext4@vger.kernel.org>; Thu, 28 Aug 2025 01:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343664; cv=none; b=av1zyFrsazaTPoWxHOq04zTq5Y+zTZCw/wAkK9iBqjeh84/zJAkge47etRF9X+zFUTVYv3YGgxvSIb87Iffg5LR/4WquWvpSmzrloufq6i1PIcel42LFFhrdI5aANEOheh6VVYNlHNa4mWwJ4D0GlOB1h9c3VEJLcgtBHo3Vvis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343664; c=relaxed/simple;
	bh=NBgKfdxvz0+OrCVJgtxMkXL+JUZGC3gcAqb3+24RMUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7nMolCcyJSi0islTjB5ycDHe2YJkoFxdkC4FXj2+LKpH89BJGSd/GgwQ5BOuw/axQfhjxL1LlYTHE1m+s+qjYo3mtqjKawHZHmYusJK2aTvlbbBQcftjWAKOgyULOXS+xVECImqx4060G4RuIMEWblWnno0kSnAytHlxZBAh+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cC3MY2p6zzKHMSX
	for <linux-ext4@vger.kernel.org>; Thu, 28 Aug 2025 09:14:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 135061A0E57
	for <linux-ext4@vger.kernel.org>; Thu, 28 Aug 2025 09:14:17 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAncY1nra9oxHMhAg--.9248S3;
	Thu, 28 Aug 2025 09:14:16 +0800 (CST)
Message-ID: <5c51369c-6b7b-4622-adf9-396ffc534d22@huaweicloud.com>
Date: Thu, 28 Aug 2025 09:14:15 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Increase IO priority of fastcommit.
To: Julian Sun <sunjunchao@bytedance.com>, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, jack@suse.cz, harshadshirwadkar@gmail.com,
 ritesh.list@gmail.com
References: <20250827121812.1477634-1-sunjunchao@bytedance.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250827121812.1477634-1-sunjunchao@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAncY1nra9oxHMhAg--.9248S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW5JF1xJF1Utry7ZFyDGFg_yoW8Xw4kpF
	9Ik34rAF4DXw17uan7Ga18WrWjg3ykWF4xZFW2k343XrZFqrn7XFWfK3W3Aa1YkFWkZa45
	JF1akry7Gw4ak37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 8/27/2025 8:18 PM, Julian Sun wrote:
> The following code paths may result in high latency or even task hangs:
>    1. fastcommit io is throttled by wbt.
>    2. jbd2_fc_wait_bufs() might wait for a long time while
> JBD2_FAST_COMMIT_ONGOING is set in journal->flags, and then
> jbd2_journal_commit_transaction() waits for the
> JBD2_FAST_COMMIT_ONGOING bit for a long time while holding the write
> lock of j_state_lock.
>    3. start_this_handle() waits for read lock of j_state_lock which
> results in high latency or task hang.
> 
> Given the fact that ext4_fc_commit() already modifies the current
> process' IO priority to match that of the jbd2 thread, it should be
> reasonable to match jbd2's IO submission flags as well.
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/fast_commit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 42bee1d4f9f9..fa66b08de999 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -663,7 +663,7 @@ void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t star
>  
>  static void ext4_fc_submit_bh(struct super_block *sb, bool is_tail)
>  {
> -	blk_opf_t write_flags = REQ_SYNC;
> +	blk_opf_t write_flags = JBD2_JOURNAL_REQ_FLAGS;
>  	struct buffer_head *bh = EXT4_SB(sb)->s_fc_bh;
>  
>  	/* Add REQ_FUA | REQ_PREFLUSH only its tail */


