Return-Path: <linux-ext4+bounces-3542-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0016E94250E
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 05:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73632851EB
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 03:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578B0182B3;
	Wed, 31 Jul 2024 03:30:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C875AC2FD;
	Wed, 31 Jul 2024 03:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722396646; cv=none; b=SSJPYuIB/ChvlFH3kRgNXoUteO+FWjXoXnPzJ4ju/WC5w+OsxNFO/fqjcLkN6AcGl8vE321hlUbud0yL4kpBpghvp6BxbH5kjapEXF8ScsLcTF4cGLwBf42XNBgmR7bL/wX0BvTSfT3tbUE4zqU6EXAJyQb/q+iThSkjCttamfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722396646; c=relaxed/simple;
	bh=r9tdMYi+tLdRl0KvGAxa4+K7TVyq62cAz8Qk1wyLrgs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=a+Ls7bzQhGrw3e00GfrM61YhgCOAXYUOj/GbZBlKr9YVoNS7rGd7RalcMVFmNMjkqo+EqdiF5+qodbqoKOyDnG4Yy2sKlvi1gnn7MXvMgwLFirwWlgMqq+bkHdMCLZ/8a2G+fRRlvnrqut+7MpkSeqDSkmK+14H8N+cQ6c+ToTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYd0745vyz4f3jjw;
	Wed, 31 Jul 2024 11:30:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 38A1F1A17FC;
	Wed, 31 Jul 2024 11:30:40 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoTfr6lm6u1cAQ--.41250S3;
	Wed, 31 Jul 2024 11:30:40 +0800 (CST)
Subject: Re: [PATCH 2/7] jbd2: remove dead check in journal_alloc_journal_head
To: Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu, jack@suse.com
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
 <20240730113335.2365290-3-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <e3322360-6085-b050-8b5c-1467da26d0af@huaweicloud.com>
Date: Wed, 31 Jul 2024 11:30:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240730113335.2365290-3-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXPoTfr6lm6u1cAQ--.41250S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr1rtw47Wr4DWryUZFWUurg_yoW3Cwc_WF
	4IvrnxXrZxXr4rArW8Ca4rurnagrn7Zr1kCw1xtwnxKryjqFWkJFn7A34rJrZxu3WIkFW3
	Kayv93y8tr9rtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwzuWDU
	UUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/7/30 19:33, Kemeng Shi wrote:
> We will alloc journal_head with __GFP_NOFAIL anyway, test for failure
> is pointless.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

A nice cleanup.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/journal.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index da5a56d700f1..b5d02de1ffff 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2866,8 +2866,7 @@ static struct journal_head *journal_alloc_journal_head(void)
>  		ret = kmem_cache_zalloc(jbd2_journal_head_cache,
>  				GFP_NOFS | __GFP_NOFAIL);
>  	}
> -	if (ret)
> -		spin_lock_init(&ret->b_state_lock);
> +	spin_lock_init(&ret->b_state_lock);
>  	return ret;
>  }
>  
> 


