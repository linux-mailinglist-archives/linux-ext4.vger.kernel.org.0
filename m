Return-Path: <linux-ext4+bounces-2413-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 724398C0F60
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 14:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38A91C21488
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 12:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389611527A0;
	Thu,  9 May 2024 12:09:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D9B14B09C;
	Thu,  9 May 2024 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256557; cv=none; b=PrBJq6czycpumcOICfcxqf1PIdQX2vFJRlwiQDcdAGXqWEdTVk4OeKrEtwQi5zBhW4Ys+mrshdbcR9CoGcIIjXoF8UHJUyyb3FIlEAPFZyLwSj5lI481SYjiJ0+a82e8vGdttjVP8JlqgRz3jknxeLkz8MXH3XMmIMq/KLZP/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256557; c=relaxed/simple;
	bh=oZq6oVWidnT9H3M8+Ig2n8qCcxDsFEqjelAHqdOZVeI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XqZ6RlE6xrN7nZj8NO6vwJVYxbpBLF5m28PWkWxnJtmE62UWmAgzELwEpMmXB156fnWb7wf+4UCYK/0oKS6NJiM8OMCjGbg+KBAMkzE4oI5Fr2CPPoE/kM/im1hBxq6fA1qZyONLrd3dPUpTwFQuJYrRI2LqwpWgdjk/UgtV2Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VZrQp1D3sz4f3kpx;
	Thu,  9 May 2024 20:09:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 83C7A1A0F10;
	Thu,  9 May 2024 20:09:11 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgDnCw_mvDxmQLbrMQ--.46209S3;
	Thu, 09 May 2024 20:09:11 +0800 (CST)
Subject: Re: [PATCH 9/9] jbd2: remove unnecessary "should_sleep" in kjournald2
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
 <20240506141801.1165315-10-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <1f72fcda-a945-415e-0cb3-9de8de8efe60@huaweicloud.com>
Date: Thu, 9 May 2024 20:09:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506141801.1165315-10-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnCw_mvDxmQLbrMQ--.46209S3
X-Coremail-Antispam: 1UD129KBjvdXoWrurW7Jr15Jr17WFW3uw1rWFg_yoWkGwc_XF
	WSyrnrZrZIgrsrAFWIkw1DCr1Ykrs7Xr18Zan2yw4UKr1Dta1vyayDJF9rtwnxWFsaqrWY
	9a1I9a18Kr9FqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
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

On 2024/5/6 22:18, Kemeng Shi wrote:
> We only need to sleep if no running transaction is expired. Simply remove
> unnecessary "should_sleep".
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

It looks much clearer now.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/journal.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index ce9004f40ffb..65c6cfce9d92 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -220,15 +220,12 @@ static int kjournald2(void *arg)
>  		 * so we don't sleep
>  		 */
>  		DEFINE_WAIT(wait);
> -		int should_sleep = 1;
>  
>  		prepare_to_wait(&journal->j_wait_commit, &wait,
>  				TASK_INTERRUPTIBLE);
>  		transaction = journal->j_running_transaction;
> -		if (transaction && time_after_eq(jiffies,
> -						transaction->t_expires))
> -			should_sleep = 0;
> -		if (should_sleep) {
> +		if (transaction == NULL ||
> +		    time_before(jiffies, transaction->t_expires)) {
>  			write_unlock(&journal->j_state_lock);
>  			schedule();
>  			write_lock(&journal->j_state_lock);
> 


