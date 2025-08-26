Return-Path: <linux-ext4+bounces-9621-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D789BB3517A
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 04:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A0E68364D
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 02:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593501A3154;
	Tue, 26 Aug 2025 02:18:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840861FCE
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756174729; cv=none; b=uI2ciqGgfe/IQs4od65IoSD/aAX9T3BtQ3z5LiN4tCcS1NGQho3p5Nl25U03eZJHydyy6uTxWrxgJ5fCB3xfP/IFeZ4B0ax7hENlACWUniGk7xgm/T/mycMbC3U4oaFPKl9y/J6rLcvMiqb7sF3Fe8wID90ojHK1vZAWuR/5zUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756174729; c=relaxed/simple;
	bh=bOmbm2cW/iDsD5Uvr4wNnkXbzrekwjqUlD9u8azONMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0ov6/m9U5rTioA0OIO9Zm0qrH64Lg5ojoDGwDa1PFYLF3LrgYruZoqW5xRjhaZpUsI4kOjug8OlKKRDUBmm82PfjUFQR6pG9R2dASB8fGXIU2P3vvka/bovGhakSjq7zGgoK8icRdP78nWwR2/ZmIheRoUKdmdaZGeQLVZGeIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9rtr2wMhzKHN3T
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 10:18:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0A5B41A0B76
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 10:18:44 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAncY2CGa1oTuJAAQ--.17747S3;
	Tue, 26 Aug 2025 10:18:43 +0800 (CST)
Message-ID: <2793c29e-4cdf-42a2-b8ce-55d362b560c3@huaweicloud.com>
Date: Tue, 26 Aug 2025 10:18:42 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: Increase IO priority of checkpoint.
To: Julian Sun <sunjunchao@bytedance.com>, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, jack@suse.com
References: <20250825125339.1368799-1-sunjunchao@bytedance.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250825125339.1368799-1-sunjunchao@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAncY2CGa1oTuJAAQ--.17747S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyUZF4xGFyrtFWxZw18Xwb_yoWkCFg_WF
	Z5Krs8Ww4kJF4FqFZ09r17WFn5Kw1fWFykC340yrnxKw1DKa4vqFs3t3s3K3s7Kr9YkFZ8
	AFn7XrnYyrs2yjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbO8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 8/25/2025 8:53 PM, Julian Sun wrote:
> In commit 6a3afb6ac6df ("jbd2: increase the journal IO's priority"),
> the priority of IOs initiated by jbd2 has been raised, exempting them
> from WBT throttling.
> Checkpoint is also a crucial operation of jbd2. While no serious issues
> have been observed so far, it should still be reasonable to exempt
> checkpoint from WBT throttling.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

Looks reasonable to me. Thanks for the patch!

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/checkpoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 38861ca04899..2d0719bf6d87 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -131,7 +131,7 @@ __flush_batch(journal_t *journal, int *batch_count)
>  
>  	blk_start_plug(&plug);
>  	for (i = 0; i < *batch_count; i++)
> -		write_dirty_buffer(journal->j_chkpt_bhs[i], REQ_SYNC);
> +		write_dirty_buffer(journal->j_chkpt_bhs[i], JBD2_JOURNAL_REQ_FLAGS);
>  	blk_finish_plug(&plug);
>  
>  	for (i = 0; i < *batch_count; i++) {


