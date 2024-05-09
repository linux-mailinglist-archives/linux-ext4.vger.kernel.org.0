Return-Path: <linux-ext4+bounces-2411-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 609FA8C0F04
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 13:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE861B21945
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 11:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5FD148303;
	Thu,  9 May 2024 11:51:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E114A90;
	Thu,  9 May 2024 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715255515; cv=none; b=G1rp3JVZNK4enIPuZISIYILtNYjkxqqJvaGCNdwB5MePkiqixneCgr8j4DZdVoAOYW1NTWa3utUi8cTEHdpuS1yyzybjDRLBUAx5iZrBmnIsk9x5nPtS78Cyu+d1f/o8Xw0EqPCK19Wifmporg0ZIO6R8UA4HFa9vcRyaIB/gB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715255515; c=relaxed/simple;
	bh=yenylc1AgrZ1yz38O8wb+OBMYcDFl1j/589u+vWWWp4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DESFi/2IUO+3J8zri2hUvvJN5GGmYp2NCAQ47apCJVtkFxwWUdZFCAMSQ7uvBB+KHG+mcfEYJW5JKtNs/RnpOqNtvKcUUgoAMqLcpkkDOHXFfO5F8sLbWVchWHsM4wWq+opiZhAZX9Y6YTP9OiDQg38/BXR2zDREJ23O1O9t7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VZr2g5s78z4f3jHV;
	Thu,  9 May 2024 19:51:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2C6E41A016E;
	Thu,  9 May 2024 19:51:48 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgCnyw7SuDxmDJXqMQ--.3S3;
	Thu, 09 May 2024 19:51:48 +0800 (CST)
Subject: Re: [PATCH 7/9] jbd2: remove dead equality check of
 j_commit_[sequence/request] in kjournald2
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
 <20240506141801.1165315-8-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <90912168-9295-ac60-6a4c-687fe12ebd7a@huaweicloud.com>
Date: Thu, 9 May 2024 19:51:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506141801.1165315-8-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCnyw7SuDxmDJXqMQ--.3S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1ruw48GF4DZF48JFy8uFg_yoW8Gr48pr
	Wku3WjyFWru3y0grn7KF4DXFWUZ3yjkFyjgrnIkwn3Jw4UJ34Ikwn3trn3JrWqyrZ3G348
	XFsY9an7Gw1Y9a7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUU
	UUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/6 22:17, Kemeng Shi wrote:
> In kjournald2, two equality checks of j_commit_[sequence/request] are
> under the same j_state_lock. As j_commit_[sequence/request] are updated
> concurrently with j_state_lock held during runtime, the second check is
> unnecessary.
> The j_commit_sequence is only updated concurrently in
> jbd2_journal_commit_transaction with j_state_lock held.
> The j_commit_request is only updated concurrently in
> __jbd2_log_start_commit with j_state_lock held.
> Also see comment in struct journal_s about lock rule of j_commit_sequence
> and j_commit_request.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks reasonable to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/journal.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 01e33b643e4d..e8f592fbd6e1 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -224,8 +224,6 @@ static int kjournald2(void *arg)
>  
>  		prepare_to_wait(&journal->j_wait_commit, &wait,
>  				TASK_INTERRUPTIBLE);
> -		if (journal->j_commit_sequence != journal->j_commit_request)
> -			should_sleep = 0;
>  		transaction = journal->j_running_transaction;
>  		if (transaction && time_after_eq(jiffies,
>  						transaction->t_expires))
> 


