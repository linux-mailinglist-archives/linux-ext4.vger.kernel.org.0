Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849B63D5194
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Jul 2021 05:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhGZDAG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Jul 2021 23:00:06 -0400
Received: from out0.migadu.com ([94.23.1.103]:22137 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230321AbhGZDAA (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 25 Jul 2021 23:00:00 -0400
Subject: Re: [PATCH V3 5/5] ext4: make fallocate retry when err is ENOSPC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1627270825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E1m6o7frjqTUOmT2nx81UzVsmLYlKMFTSb1RXceNpcY=;
        b=Wq/ingbqY2/8co3Wbpac3nVNGJ1WRdLpSi1zMfORxMClqWUMtKhQz5G3ueVKgr/27It7Rw
        RAyMOgtSXbHMaoOGdMdU4bUHx9aGV+7qUMZ2+cOfhvmB55o6Qua1vjKYXIxlwv4q+nTL43
        +csALRFXjOliutInIvRJksWBl/Th8Ig=
To:     Wang Jianchao <jianchao.wan9@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
 <20210724074124.25731-6-jianchao.wan9@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <0ac551b1-6295-9117-757d-12bee70de588@linux.dev>
Date:   Mon, 26 Jul 2021 11:40:17 +0800
MIME-Version: 1.0
In-Reply-To: <20210724074124.25731-6-jianchao.wan9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: guoqing.jiang@linux.dev
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On 7/24/21 3:41 PM, Wang Jianchao wrote:
> From: Wang Jianchao <wangjianchao@kuaishou.com>
>
> The blocks may be waiting for journal commit to be freed back to
> mb buddy. Let fallocate wait and retry in that case.
>
> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
> ---
>   fs/ext4/extents.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 92ad64b89d9b..ad0b874d3448 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4635,7 +4635,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>   	struct inode *inode = file_inode(file);
>   	loff_t new_size = 0;
>   	unsigned int max_blocks;
> -	int ret = 0;
> +	int ret = 0, retries = 0;
>   	int flags;
>   	ext4_lblk_t lblk;
>   	unsigned int blkbits = inode->i_blkbits;
> @@ -4656,6 +4656,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>   		     FALLOC_FL_INSERT_RANGE))
>   		return -EOPNOTSUPP;
>   
> +retry:
>   	ext4_fc_start_update(inode);
>   
>   	if (mode & FALLOC_FL_PUNCH_HOLE) {
> @@ -4722,6 +4723,9 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>   	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
>   exit:
>   	ext4_fc_stop_update(inode);
> +	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
> +		goto retry;
> +

Not sure if it is necessary since ext4_alloc_file_blocks already retries 
allocate.

Thanks,
Guoqing
