Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0902A4D1C
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Sep 2019 03:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfIBBbg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 1 Sep 2019 21:31:36 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:41938 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728982AbfIBBbg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 1 Sep 2019 21:31:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---0Tb2sFeZ_1567387883;
Received: from 10.65.158.221(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0Tb2sFeZ_1567387883)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Sep 2019 09:31:23 +0800
Subject: Re: [PATCH] ext4: disable mount with both dioread_nolock and
 nodelalloc
To:     linux-ext4@vger.kernel.org
References: <20190731130600.7867-1-xiaoguang.wang@linux.alibaba.com>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <12533d10-22e4-59bc-c7db-4c7ca5c2df69@linux.alibaba.com>
Date:   Mon, 2 Sep 2019 09:31:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731130600.7867-1-xiaoguang.wang@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

hi,

Ping.
For this patch, I'm afraid someone else still takes effort to look into this issue.

Regards,
Xiaoguang Wang

> Mount with both dioread_nolock and nodelalloc will result in huge
> performance drop, which indeed is an known issue, so before we fix
> this issue, currently we disable this behaviour. Below test reproducer
> can reveal this performance drop.
> 
>      mount -o remount,dioread_nolock,delalloc /dev/vdb1
>      rm -f testfile
>      start_time=$(date +%s)
>      dd if=/dev/zero of=testfile bs=4096 count=$((1024*256))
>      sync
>      end_time=$(date +%s)
>      echo $((end_time - start_time))
> 
>      mount -o remount,dioread_nolock,nodelalloc /dev/vdb1
>      rm -f testfile
>      start_time=$(date +%s)
>      dd if=/dev/zero of=testfile bs=4096 count=$((1024*256))
>      sync
>      end_time=$(date +%s)
>      echo $((end_time - start_time))
> 
> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> ---
>   fs/ext4/super.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 4079605d437a..1a2b2c0cd1b8 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2098,6 +2098,12 @@ static int parse_options(char *options, struct super_block *sb,
>   		int blocksize =
>   			BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
>   
> +		if (!test_opt(sb, DELALLOC)) {
> +			ext4_msg(sb, KERN_ERR, "can't mount with "
> +				 "both dioread_nolock and nodelalloc");
> +			return 0;
> +		}
> +
>   		if (blocksize < PAGE_SIZE) {
>   			ext4_msg(sb, KERN_ERR, "can't mount with "
>   				 "dioread_nolock if block size != PAGE_SIZE");
> 
