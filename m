Return-Path: <linux-ext4+bounces-2507-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25138C5767
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 15:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533512822E3
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 13:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DACB144D26;
	Tue, 14 May 2024 13:53:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2E1448E7;
	Tue, 14 May 2024 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715694806; cv=none; b=Hw8nMYMxWSC9l5Gy6ps8YlRHiHQTZ/Vo2ZgshD9ntMw9sxqx9ltOmqG6dcDKTiCulB1cW5+nBugXj3UuKGz26UsXM/GrjwbG9aABHsZVQ1zLFNAi7aWNxvk9Sxpaey46yBWugps9YYvHrOqpTCXlR0C4mGeaVfOPVd/gbOQcRF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715694806; c=relaxed/simple;
	bh=O8hFA/T2LaGjTwRIMxIxq5cA/Tjjnvrs75x/Pq5EtTY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sLgncJhf6xTVMhTDjvZhSa7noLTdsijarwdnw0R74tqksbf5rmK1100dqk6UB2TzMmXTLJ9hBSRIYpEvFHeR5bseKRN/pcsKqbhdmDbOZzgE7IN/w60YpbFcCOrjTZQmubSKt+Zet/dfhvLGFWzMlssXm+55bIsr6JzMm3BDAvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VdyVY5hNnz4f3m7d;
	Tue, 14 May 2024 21:53:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E7B351A0199;
	Tue, 14 May 2024 21:53:19 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgBXfA_ObENm1cfPMw--.37697S3;
	Tue, 14 May 2024 21:53:19 +0800 (CST)
Subject: Re: [PATCH v2 2/9] jbd2: remove unused return info from
 jbd2_journal_write_metadata_buffer
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20240514112438.1269037-1-shikemeng@huaweicloud.com>
 <20240514112438.1269037-3-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <25ddaf34-bd98-2783-f7b3-42ea86d11b3d@huaweicloud.com>
Date: Tue, 14 May 2024 21:53:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240514112438.1269037-3-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBXfA_ObENm1cfPMw--.37697S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1fWw1furWfXw1rZF1UWrg_yoW5JryUpr
	95Ca4rAr90vry0yF1xXF4UJFWjgFWUuFyjkr1qk3Z5JayfXwn2gF1Iyr13Kr4jyF93Cw48
	AF1UCa4kGw4Yv3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbWCJP
	UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/14 19:24, Kemeng Shi wrote:
> The done_copy_out info from jbd2_journal_write_metadata_buffer is not
> used. Simply remove it.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Thanks, looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/commit.c  | 10 +++++-----
>  fs/jbd2/journal.c |  9 +++------
>  2 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 5e122586e06e..67077308b56b 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -353,7 +353,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  	struct buffer_head *descriptor;
>  	struct buffer_head **wbuf = journal->j_wbuf;
>  	int bufs;
> -	int flags;
> +	int escape;
>  	int err;
>  	unsigned long long blocknr;
>  	ktime_t start_time;
> @@ -661,10 +661,10 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  		 */
>  		set_bit(BH_JWrite, &jh2bh(jh)->b_state);
>  		JBUFFER_TRACE(jh, "ph3: write metadata");
> -		flags = jbd2_journal_write_metadata_buffer(commit_transaction,
> +		escape = jbd2_journal_write_metadata_buffer(commit_transaction,
>  						jh, &wbuf[bufs], blocknr);
> -		if (flags < 0) {
> -			jbd2_journal_abort(journal, flags);
> +		if (escape < 0) {
> +			jbd2_journal_abort(journal, escape);
>  			continue;
>  		}
>  		jbd2_file_log_bh(&io_bufs, wbuf[bufs]);
> @@ -673,7 +673,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>                     buffer */
>  
>  		tag_flag = 0;
> -		if (flags & 1)
> +		if (escape)
>  			tag_flag |= JBD2_FLAG_ESCAPE;
>  		if (!first_tag)
>  			tag_flag |= JBD2_FLAG_SAME_UUID;
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 207b24e12ce9..2dca2f613a8e 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -316,11 +316,8 @@ static void journal_kill_thread(journal_t *journal)
>   *
>   * Return value:
>   *  <0: Error
> - * >=0: Finished OK
> - *
> - * On success:
> - * Bit 0 set == escape performed on the data
> - * Bit 1 set == buffer copy-out performed (kfree the data after IO)
> + *  =0: Finished OK without escape
> + *  =1: Finished OK with escape
>   */
>  
>  int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
> @@ -455,7 +452,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	set_buffer_shadow(bh_in);
>  	spin_unlock(&jh_in->b_state_lock);
>  
> -	return do_escape | (done_copy_out << 1);
> +	return do_escape;
>  }
>  
>  /*
> 


