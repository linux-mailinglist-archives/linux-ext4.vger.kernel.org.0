Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF087D305
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2019 03:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfHAB5S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Jul 2019 21:57:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34239 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfHAB5S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Jul 2019 21:57:18 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5so72498090otk.1
        for <linux-ext4@vger.kernel.org>; Wed, 31 Jul 2019 18:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=m/KDAm617lM5vMHWnb0yOVA/uQsQ8BKEofp9Ibmuy+c=;
        b=Y8pJZD60Zx9glbWxSAu63w226o90IYuRm9tYE2znEwqdkIW3uNCqI1Bl7K9A17ywI5
         0HMR5qijDNK2Dya47dPxe1bHlafZCpLbiPCCahGrusRWbqa0dgVnPLZoks6hYN9pUx9F
         taPW7AZ1OqmlnRIasXkfj4dhy0tEITsPGe3d5fQ47mFfqYLGptF9Yy36B6WHXoWg4CSN
         oxK3nBzGY5eVaKpbWuoLt+ZvEsMpO+tLiwNAhfvhVsfYoilSplXmkvxHJcHhvTygl1mX
         dw4bbxj5pJYtIc44kSIYo9plqX9FCer3EsMOa76HukneSsiccSA42AFCvND+5yGMGAWP
         MbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m/KDAm617lM5vMHWnb0yOVA/uQsQ8BKEofp9Ibmuy+c=;
        b=T0Uqo3DuJWcCWfL8OFTfVWKOaU6PrUftOhXMQ8HGHDdE54bIL6jmwW3ha97grGJRN2
         FzTK4feUO+kPTP+aAnn5/lKZbjKQbNR1UDbx1FAn4tBrYMvoZlnv0S2p+nuJu4oqwkrM
         cE6BZeRY8fgWUN5AWl+twDxMXP1DJQQi32VPBEKU8kDtbkRbdBECIH2l/YdSluheTcZm
         G4fTQIXFccrQC9Fw8vvQWUCQrP3zp1sx0agpDjEw4iXSKcP2EwLFiJQmV6Om4fWHr96y
         0zPsX9ort0r79mPfv5pknEzwmYmdwHUUb8oLRvDZGu9cY51/W3mslaOLz14PFan3zO+v
         cTSg==
X-Gm-Message-State: APjAAAVd48X3lT+2wfSDV1QCLu0pyouZQg9SAGYSSKVLEtiuszoQ+glR
        6m2Ogk8e9DCpyjRYwm/yIzmH7K4e
X-Google-Smtp-Source: APXvYqysgfpXWcQ4FYeg4LSCS7cjS6U+wZlCdw1WFQx39YMJ+ftEpDHOSuH4Riuig9KpwKhUeuLscQ==
X-Received: by 2002:a05:6830:1249:: with SMTP id s9mr95590850otp.33.1564624636918;
        Wed, 31 Jul 2019 18:57:16 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([205.204.117.13])
        by smtp.gmail.com with ESMTPSA id w9sm23378022otk.16.2019.07.31.18.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 18:57:16 -0700 (PDT)
Subject: Re: [PATCH] ext4: disable mount with both dioread_nolock and
 nodelalloc
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        linux-ext4@vger.kernel.org
References: <20190731130600.7867-1-xiaoguang.wang@linux.alibaba.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <1e05adf4-cb79-c503-4c7d-bf7f7eb2f218@gmail.com>
Date:   Thu, 1 Aug 2019 09:57:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731130600.7867-1-xiaoguang.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 19/7/31 21:06, Xiaoguang Wang wrote:
> Mount with both dioread_nolock and nodelalloc will result in huge
> performance drop, which indeed is an known issue, so before we fix
> this issue, currently we disable this behaviour. Below test reproducer
> can reveal this performance drop.
> 
>     mount -o remount,dioread_nolock,delalloc /dev/vdb1
>     rm -f testfile
>     start_time=$(date +%s)
>     dd if=/dev/zero of=testfile bs=4096 count=$((1024*256))
>     sync
>     end_time=$(date +%s)
>     echo $((end_time - start_time))
> 
>     mount -o remount,dioread_nolock,nodelalloc /dev/vdb1
>     rm -f testfile
>     start_time=$(date +%s)
>     dd if=/dev/zero of=testfile bs=4096 count=$((1024*256))
>     sync
>     end_time=$(date +%s)
>     echo $((end_time - start_time))
> 
> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> ---
>  fs/ext4/super.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 4079605d437a..1a2b2c0cd1b8 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2098,6 +2098,12 @@ static int parse_options(char *options, struct super_block *sb,
>  		int blocksize =
>  			BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
>  
> +		if (!test_opt(sb, DELALLOC)) {
> +			ext4_msg(sb, KERN_ERR, "can't mount with "
> +				 "both dioread_nolock and nodelalloc");
> +			return 0;
> +		}
> +
I suggest move it down to keep blocksize check logic together.

Other than that, looks good to me.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

>  		if (blocksize < PAGE_SIZE) {
>  			ext4_msg(sb, KERN_ERR, "can't mount with "
>  				 "dioread_nolock if block size != PAGE_SIZE");
> 
