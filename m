Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2FF404387
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Sep 2021 04:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242062AbhIICVf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Sep 2021 22:21:35 -0400
Received: from out1.migadu.com ([91.121.223.63]:43867 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241774AbhIICVe (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 8 Sep 2021 22:21:34 -0400
Subject: Re: [PATCH -next 2/6] ext4: introduce last_check_time record previous
 check time
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1631154023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IeoyoE9nFc/8AJQHWEf/XYpBZje7kZZE7EX8W6rfGjg=;
        b=RmdY+cIxfIOwQ3zyK++oDwDDsCi3JUNnNhKXAV7x5UQQe4+lNv1PzneVIawfLxyoJR7T5C
        WzKG70apqu3nySSDVh+iEZ70etsEpG0gMgtOjMfOo3jhQT0NuRoxgMIVnatDjQA640cVEJ
        JfRt1KcJFTfl2jnYbPOzRDLcJIHkxZw=
To:     Ye Bin <yebin10@huawei.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz
References: <20210906144754.2601607-1-yebin10@huawei.com>
 <20210906144754.2601607-3-yebin10@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <03bd0982-f0ad-78b4-7b98-cbfdbab9deec@linux.dev>
Date:   Thu, 9 Sep 2021 10:20:17 +0800
MIME-Version: 1.0
In-Reply-To: <20210906144754.2601607-3-yebin10@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: guoqing.jiang@linux.dev
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 9/6/21 10:47 PM, Ye Bin wrote:
> kmmpd:
> ...
>      diff = jiffies - last_update_time;
>      if (diff > mmp_check_interval * HZ) {
> ...
> As "mmp_check_interval = 2 * mmp_update_interval", 'diff' always little
> than 'mmp_update_interval', so there will never trigger detection.
> Introduce last_check_time record previous check time.
>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   fs/ext4/mmp.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index 12af6dc8457b..89797f12a815 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -152,6 +152,7 @@ static int kmmpd(void *data)
>   	int mmp_update_interval = le16_to_cpu(es->s_mmp_update_interval);
>   	unsigned mmp_check_interval;
>   	unsigned long last_update_time;
> +	unsigned long last_check_time;
>   	unsigned long diff;
>   	int retval = 0;
>   
> @@ -170,6 +171,7 @@ static int kmmpd(void *data)
>   
>   	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
>   	       sizeof(mmp->mmp_nodename));
> +	last_update_time = jiffies;
>   
>   	while (!kthread_should_stop() && !sb_rdonly(sb)) {
>   		if (!ext4_has_feature_mmp(sb)) {
> @@ -198,17 +200,18 @@ static int kmmpd(void *data)
>   		}
>   
>   		diff = jiffies - last_update_time;
> -		if (diff < mmp_update_interval * HZ)
> +		if (diff < mmp_update_interval * HZ) {
>   			schedule_timeout_interruptible(mmp_update_interval *
>   						       HZ - diff);
> +			diff = jiffies - last_update_time;
> +		}
>   
>   		/*
>   		 * We need to make sure that more than mmp_check_interval
> -		 * seconds have not passed since writing. If that has happened
> -		 * we need to check if the MMP block is as we left it.
> +		 * seconds have not passed since check. If that has happened
> +		 * we need to check if the MMP block is as we write it.
>   		 */
> -		diff = jiffies - last_update_time;
> -		if (diff > mmp_check_interval * HZ) {
> +		if (jiffies - last_check_time > mmp_check_interval * HZ) {

Before the above checking, seems last_check_time is not initialized yet.
>   			struct buffer_head *bh_check = NULL;
>   			struct mmp_struct *mmp_check;
>   
> @@ -234,6 +237,7 @@ static int kmmpd(void *data)
>   				goto wait_to_exit;
>   			}
>   			put_bh(bh_check);
> +			last_check_time = jiffies;
>   		}
>   
>   		 /*

Thanks,
Guoqing
