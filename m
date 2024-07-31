Return-Path: <linux-ext4+bounces-3541-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9845C94250A
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 05:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B7D1F21D6C
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 03:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8121805E;
	Wed, 31 Jul 2024 03:24:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBDF1B7E4;
	Wed, 31 Jul 2024 03:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722396294; cv=none; b=G2cskZn5z+d1ccnw+xSwZr1uN7RrSGDs/CrpyIW8fRIn2iWvWvJxcaHNnfVbgxgUrRWxdNr/O1eWSKcDt1aNziXvHhI6OQ4LLyHWyfLYoCWLeMH29gMNsL4SqCg0WdhUWPv9ifeY8WOUw6Wvm4jG2bE9gWF4t7Z8B7S3kK13h60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722396294; c=relaxed/simple;
	bh=se5qPHX+45kqLYveaN/QeV4JLjgf9rYwG1qdS38SNDw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mb9nvEzBuPZfzORiNee9vqyLAbmIXfEqYLnYRv2bCeAP7sR/i0nsmr4ng3G7F3dcaT83BsOIMjvrYYhGCPE1HQOjo6p5J/ko+bZHSgLcC3KWah0XGeCZhcq45UMATnB5nm5ZSYelly+sQW4a4ogaFl4vpycrSEdRITm2wai35PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYcsN08qGz4f3jM1;
	Wed, 31 Jul 2024 11:24:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A7C421A1621;
	Wed, 31 Jul 2024 11:24:48 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4V+rqlmMIxcAQ--.41185S3;
	Wed, 31 Jul 2024 11:24:48 +0800 (CST)
Subject: Re: [PATCH 1/7] jbd2: correctly compare tids with tid_geq function in
 jbd2_fc_begin_commit
To: Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu, jack@suse.com
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
 <20240730113335.2365290-2-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <2209e7b1-999f-ce69-6d9f-4b825fa6f7d9@huaweicloud.com>
Date: Wed, 31 Jul 2024 11:24:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240730113335.2365290-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHL4V+rqlmMIxcAQ--.41185S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw1DWF43WFyrJFy3WF1fCrg_yoW3CrX_XF
	1SyrnrXrZIgrs5Aw18Cay8urnagrs7ur1rG3Wxtw1akw45GF1rtFnrJas8Kr1DWFWktrW5
	Aa92vw40qF9xXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7
	UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/7/30 19:33, Kemeng Shi wrote:
> Use tid_geq to compare tids to work over sequence number wraps.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/journal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 1ebf2393bfb7..da5a56d700f1 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -710,7 +710,7 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
>  		return -EINVAL;
>  
>  	write_lock(&journal->j_state_lock);
> -	if (tid <= journal->j_commit_sequence) {
> +	if (tid_geq(journal->j_commit_sequence, tid)) {
>  		write_unlock(&journal->j_state_lock);
>  		return -EALREADY;
>  	}
> 


