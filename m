Return-Path: <linux-ext4+bounces-3543-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E2A942512
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 05:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62961C20FFF
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 03:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579BB17BA9;
	Wed, 31 Jul 2024 03:32:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EDDD53F;
	Wed, 31 Jul 2024 03:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722396758; cv=none; b=kFkUx0daEOyZD82da4oa3tGski1nWJYiqcKrzhQGMqLCMPBSQ1mXN0B71TaGNE4SUJgh2bhqeh3me7lOPQJSrBz+kuXYt64i8zUAHooY7+GlV5LUH6n845MKdWvCrE1smbp5vK+r6LBkrhYKnumZu1SPT8hc55GE4iqiSsi06Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722396758; c=relaxed/simple;
	bh=OcKkyaIuU7nn5A3fNLhRbyZpGp2r74y3TUXNXFQNmTA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y3NHy9AVkevhaoz1lX3YkcZ6bIV3Rz+ps6A3JzeS6Oc7M8kJ0bhRd+nnBSCHKfLp8ewuFUrISMR4j+kAqMFvvFk5fZlRxfDD7q5iM+AygM3lh83SI1Lk2IowslvNwkdhMcdo72EHiTzZ4BWAQwVftmMZUQmv7j0vlJHK267tK8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYd2B6CYXz4f3jJF;
	Wed, 31 Jul 2024 11:32:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C75DB1A0568;
	Wed, 31 Jul 2024 11:32:32 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBHboRQsKlmeA1dAQ--.41576S3;
	Wed, 31 Jul 2024 11:32:32 +0800 (CST)
Subject: Re: [PATCH 3/7] jbd2: remove unused return value of
 jbd2_fc_release_bufs
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
 <20240730113335.2365290-4-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <db2d02ca-1e7c-dcae-1464-beab262cbef8@huaweicloud.com>
Date: Wed, 31 Jul 2024 11:32:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240730113335.2365290-4-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHboRQsKlmeA1dAQ--.41576S3
X-Coremail-Antispam: 1UD129KBjvJXoW7try7ZrW7JryrGw1rWFW5trb_yoW8WrW5pa
	s7Ja40kr9Y9ryUAwn7WFs8JFW09F40kFyUGrsruwnYkw43GrsFqrsrtwn3tryvyr4rKw4Y
	vr1vgw4kG3y0grJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07URKZ
	XUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/7/30 19:33, Kemeng Shi wrote:
> Remove unused return value of jbd2_fc_release_bufs.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/journal.c    | 4 +---
>  include/linux/jbd2.h | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index b5d02de1ffff..312c7575b54f 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -903,7 +903,7 @@ int jbd2_fc_wait_bufs(journal_t *journal, int num_blks)
>  }
>  EXPORT_SYMBOL(jbd2_fc_wait_bufs);
>  
> -int jbd2_fc_release_bufs(journal_t *journal)
> +void jbd2_fc_release_bufs(journal_t *journal)
>  {
>  	struct buffer_head *bh;
>  	int i, j_fc_off;
> @@ -917,8 +917,6 @@ int jbd2_fc_release_bufs(journal_t *journal)
>  		put_bh(bh);
>  		journal->j_fc_wbuf[i] = NULL;
>  	}
> -
> -	return 0;
>  }
>  EXPORT_SYMBOL(jbd2_fc_release_bufs);
>  
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index b900c642210c..735229e8ad17 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1665,7 +1665,7 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out);
>  int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode);
>  int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode);
>  int jbd2_fc_wait_bufs(journal_t *journal, int num_blks);
> -int jbd2_fc_release_bufs(journal_t *journal);
> +void jbd2_fc_release_bufs(journal_t *journal);
>  
>  /*
>   * is_journal_abort
> 


