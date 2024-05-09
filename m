Return-Path: <linux-ext4+bounces-2412-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B83768C0F20
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 14:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42FBEB22BC5
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 12:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1B714BFA2;
	Thu,  9 May 2024 12:02:10 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E3926ACD;
	Thu,  9 May 2024 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256130; cv=none; b=D9zLYDlN335A5l/M3jcG00j5oz5nlJagLbos8bX0yamBwFD2syVg77ufn2AxGdFtHQUZrBnrDORVrsEiI4YlXLak93PRXxBCkGBDZ4Ys80LMTkST/Chv8LD08zO3YhZwfdgU/4naHCeOBMPs9GprPxRqtCGVnVyj6NpQGf+vDQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256130; c=relaxed/simple;
	bh=OJEdNarYECP9O+WEWFnUpjnxScB+yFr4+3Q2Zzo7IbQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KtghTRteB6BITBTV3BO4A7J3VEyRQ3FkjvpmhO2isx9T9VL0NCornpaxHvB+C6qgs3URQ6DuH40Tmh8sqAHchQfGPesysr+Yiua8ZEoLoKWgsTg08sHjVMORB+rTwLNblvF/EBz4UqbWvo/CLqJbsnnlnu89n4XBkY7nSm2fl2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VZrGT0rWzz4f3lg2;
	Thu,  9 May 2024 20:01:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 054B51A016E;
	Thu,  9 May 2024 20:02:03 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgBHaw45uzxm7j_rMQ--.32908S3;
	Thu, 09 May 2024 20:02:02 +0800 (CST)
Subject: Re: [PATCH 8/9] jbd2: remove dead check of JBD2_UNMOUNT in kjournald2
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
 <20240506141801.1165315-9-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <68817ebf-8f3b-c40c-a7d0-82139d9e452b@huaweicloud.com>
Date: Thu, 9 May 2024 20:02:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506141801.1165315-9-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHaw45uzxm7j_rMQ--.32908S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZF15WF4fXFyxXFWxKw1DAwb_yoWfKFb_Zr
	4IvrnrZrZ3Kr18JFWxCw15ur1Ygrs7ur48A34xt34qkw1UJa1xZF1kJryYk3s8ua1vqrW5
	u3Z2ka18Kr9aqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
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
> We always set JBD2_UNMOUNT with j_state_lock held in journal_kill_thread.
> In kjournald2, we check JBD2_UNMOUNT flag two times under the same
> j_state_lock. Then the second check is unnecessary.
> Also see comment in struct journal_s about lock rule of j_flags.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/journal.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index e8f592fbd6e1..ce9004f40ffb 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -228,8 +228,6 @@ static int kjournald2(void *arg)
>  		if (transaction && time_after_eq(jiffies,
>  						transaction->t_expires))
>  			should_sleep = 0;
> -		if (journal->j_flags & JBD2_UNMOUNT)
> -			should_sleep = 0;
>  		if (should_sleep) {
>  			write_unlock(&journal->j_state_lock);
>  			schedule();
> 


