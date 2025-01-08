Return-Path: <linux-ext4+bounces-5975-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A716A05187
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 04:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C318D3A7897
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 03:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88AC1993B7;
	Wed,  8 Jan 2025 03:22:35 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A403FBB3;
	Wed,  8 Jan 2025 03:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736306555; cv=none; b=cAqik3L8Hf3egMT150QGxkPBpfhpXW/aujFR49CmbNNHtjWVzpfdm4+22tNrJvd5A2XFeY3xdkzM7wYg6cwIFy45lQScole0/SaDjNaJ3jcozO2XwgNqATu9RNQEH7qizmt3YTrvRukYM4hhyLolY9z9+0aHCfL69sdqmDKBHos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736306555; c=relaxed/simple;
	bh=lySTETslTfr+QLKFol70nMEL1JGeg18FtEEIv1HSi3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UujHEGGTO2ZoWyApNki8wzjg8p8qbFxeb1tsydtiDg5GOl5QPUx3y9RMXV8Mv8LQOOBvbanWNBdSXRAbkRhtLpeWsNNFWcESPY2stfNcstWfwTFn1ysAAI6ajLILglrqnl/4BqaQ0RXyZhYNvbMtYCXnpryjvW6hpDvk+WyheHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YSYB675c5z4f3kvs;
	Wed,  8 Jan 2025 11:22:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5B4221A0DD1;
	Wed,  8 Jan 2025 11:22:28 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAHa19y731nqE1nAQ--.53697S3;
	Wed, 08 Jan 2025 11:22:28 +0800 (CST)
Message-ID: <4136cb23-a18a-4a45-8096-8ded6cf03d4a@huaweicloud.com>
Date: Wed, 8 Jan 2025 11:22:26 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] jbd2: correct stale function name in comment
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
 <20241224202707.1530558-6-shikemeng@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241224202707.1530558-6-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHa19y731nqE1nAQ--.53697S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw18tF1DurW8KFy5KryrCrg_yoW8uF1Upr
	9Yka45ZrZ8Z34jvF1fWay5GrW2q34kXrWUGFWv93Z7Ka15J3saqr48try2qrWDKFn7K34U
	AF4DCwn5G3y09FDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUehL0UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/25 4:27, Kemeng Shi wrote:
> Rename stale journal_clear_revoked_flag to jbd2_clear_buffer_revoked_flags.
> Rename stale journal_switch_revoke to jbd2_journal_switch_revoke_table.
> Rename stale __journal_file_buffer to __jbd2_journal_file_buffer.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/revoke.c      | 8 ++++----
>  fs/jbd2/transaction.c | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
> index af0208ed3619..5b7350109c5a 100644
> --- a/fs/jbd2/revoke.c
> +++ b/fs/jbd2/revoke.c
> @@ -474,7 +474,7 @@ void jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
>  }
>  
>  /*
> - * journal_clear_revoked_flag clears revoked flag of buffers in
> + * jbd2_clear_buffer_revoked_flags clears revoked flag of buffers in
>   * revoke table to reflect there is no revoked buffers in the next
>   * transaction which is going to be started.
>   */
> @@ -503,9 +503,9 @@ void jbd2_clear_buffer_revoked_flags(journal_t *journal)
>  	}
>  }
>  
> -/* journal_switch_revoke table select j_revoke for next transaction
> - * we do not want to suspend any processing until all revokes are
> - * written -bzzz
> +/* jbd2_journal_switch_revoke_table table select j_revoke for next
> + * transaction we do not want to suspend any processing until all
> + * revokes are written -bzzz
>   */
>  void jbd2_journal_switch_revoke_table(journal_t *journal)
>  {
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index e00b87635512..908baf73b188 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -2191,7 +2191,7 @@ static int __dispose_buffer(struct journal_head *jh, transaction_t *transaction)
>  		/*
>  		 * We don't want to write the buffer anymore, clear the
>  		 * bit so that we don't confuse checks in
> -		 * __journal_file_buffer
> +		 * __jbd2_journal_file_buffer
>  		 */
>  		clear_buffer_dirty(bh);
>  		__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);


