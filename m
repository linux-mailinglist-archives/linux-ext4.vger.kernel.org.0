Return-Path: <linux-ext4+bounces-2988-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF1C919F84
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 08:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6184D1F22C1F
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 06:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2116B3A28B;
	Thu, 27 Jun 2024 06:47:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177161CA96;
	Thu, 27 Jun 2024 06:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719470848; cv=none; b=EqmPMBZ8y0SIo0UL+0Xc8e5tX7KAQR3q3FGoGWPFpX5nY5Utr83+5DE0QieZGoW7U53hwIqOHadTnxHpIzgJfcezENIpEp9FiB8TlSvrGwdZr2+X1tIaAC1rJjTDDaMALH8NC+21VDRDjqXaumFnp0TNQ2tpAxD6z72Idjze/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719470848; c=relaxed/simple;
	bh=QnfsP5dbMie3UMBSy+3N5TRGD4S5gcLtThKSPjv5MRY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jX3U6iuDAZQWiD8CX1RcHRgbzwj03lAtIqKGOznZtF+EzNe8XxkwlrHABcCHybR0iU/oe5ez9v4h0I+zCW6ctRlMf5TQnCF3fr2C4mU6gkUUddHfL3dN0mOG1A3sPRSP08hwCDVs/KAXflbzN5qWX+GCo79LrGPGxsYMIuIhTsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W8pyk1ygyz4f3l1Z;
	Thu, 27 Jun 2024 14:47:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 756D91A0568;
	Thu, 27 Jun 2024 14:47:22 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgB34Yb5Cn1mgJHhAQ--.14721S3;
	Thu, 27 Jun 2024 14:47:22 +0800 (CST)
Subject: Re: [PATCH v2 1/4] jbd2: Make jbd2_journal_get_max_txn_bufs()
 internal
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, Alexander Coffin
 <alex.coffin@maticrobots.com>, stable@vger.kernel.org,
 Ted Tso <tytso@mit.edu>
References: <20240624165406.12784-1-jack@suse.cz>
 <20240624170127.3253-1-jack@suse.cz>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <0d8ad437-78fb-d5c1-d7d5-0e4be45c2061@huaweicloud.com>
Date: Thu, 27 Jun 2024 14:47:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240624170127.3253-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgB34Yb5Cn1mgJHhAQ--.14721S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1xGw45uF4rGFy8Gw4UArb_yoW8KFWrpF
	y8Ga48CFyFvFWUAFn7Wr4UXrW0q3y0kryUKr4Duw1ktw45trn7tw17Krn3tF90yrW09w18
	Zr1DCw4DGw4j9rDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/6/25 1:01, Jan Kara wrote:
> There's no reason to have jbd2_journal_get_max_txn_bufs() public
> function. Currently all users are internal and can use
> journal->j_max_transaction_buffers instead. This saves some unnecessary
> recomputations of the limit as a bonus which becomes important as this
> function gets more complex in the following patch.
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>

A good cleanup.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/commit.c     | 2 +-
>  fs/jbd2/journal.c    | 5 +++++
>  include/linux/jbd2.h | 5 -----
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 75ea4e9a5cab..e7fc912693bd 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -766,7 +766,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  		if (first_block < journal->j_tail)
>  			freed += journal->j_last - journal->j_first;
>  		/* Update tail only if we free significant amount of space */
> -		if (freed < jbd2_journal_get_max_txn_bufs(journal))
> +		if (freed < journal->j_max_transaction_buffers)
>  			update_tail = 0;
>  	}
>  	J_ASSERT(commit_transaction->t_state == T_COMMIT);
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 03c4b9214f56..1bb73750d307 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1698,6 +1698,11 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
>  	return journal;
>  }
>  
> +static int jbd2_journal_get_max_txn_bufs(journal_t *journal)
> +{
> +	return (journal->j_total_len - journal->j_fc_wbufsize) / 4;
> +}
> +
>  /*
>   * Given a journal_t structure, initialise the various fields for
>   * startup of a new journaling session.  We use this both when creating
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index ab04c1c27fae..f91b930abe20 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1660,11 +1660,6 @@ int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode);
>  int jbd2_fc_wait_bufs(journal_t *journal, int num_blks);
>  int jbd2_fc_release_bufs(journal_t *journal);
>  
> -static inline int jbd2_journal_get_max_txn_bufs(journal_t *journal)
> -{
> -	return (journal->j_total_len - journal->j_fc_wbufsize) / 4;
> -}
> -
>  /*
>   * is_journal_abort
>   *
> 


