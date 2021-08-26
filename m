Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318173F835C
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Aug 2021 09:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhHZHw2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Aug 2021 03:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbhHZHw1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Aug 2021 03:52:27 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353C2C061757;
        Thu, 26 Aug 2021 00:51:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m26so2073845pff.3;
        Thu, 26 Aug 2021 00:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U3Wk1XJH+0LscJbf87RXYjbjUTP39Lf0DsYTghO2XsQ=;
        b=hFK1JMVoqG88JEMjWfXddA9MK5sp2LHBYqST2JwWrVl17hbL/7TVpW1saEzdKRBWG6
         ShfxAyK8TZcppVxv7QurIf62W7CgMu0tV9OHcX9tS5ig854iLV9qGcQ1IctCtbK/obOX
         6bkZy07lM69zBDzuMKE2tYHrDmLAxduRyP+PH4aazZG1nr2hb61lZ3rsZAJ1i0Q+ouv6
         wgWis9uIjetjHDEAAdxd9u/Y3o85+FKkpv/qpyPAeBWwLc8Ht2s2f9iKDvgSSRLCmCgY
         ePkrA6+9+VgQ9qdcfiF1lH71yKKAiwoY4beTDmRerKqHgGWA/74ybX6hehIkty/4xvZV
         rQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U3Wk1XJH+0LscJbf87RXYjbjUTP39Lf0DsYTghO2XsQ=;
        b=sHtB2B0JlpPDzIWXxPns4BT/ZxkiZzYuhgDJQE4CLd3eUa8cA77gb06Cr0L0elAfFA
         WkYGgaAGkiTDotdT43Z3YO6nzQV38cUJY/0bgQ2Mkm2aN0N69BxRxC1+fl1U8x6X2VcA
         neV37CKK4tsJ23Zx+Drj8HEHcnuy16xofcbk69USS7Yv0DeYu3G7sPCNW/qm8kooJUZJ
         /3e9qGtm2ZOhicw2YegBpUUcpkwD8RCx0po48jZ4RNVTWk2RY5Of5E0mbw1iZbiqYYoJ
         zWBzwzXkjNhGu8QGzkCCeSQG5ItNShGYsihXrKE1/fvQE8xdm8/jqJTM9TVWp5Jo1fGt
         aqgA==
X-Gm-Message-State: AOAM530wt25Mh+yzis4c7nlzNpBsXQyIguZtJ7GtT5l1fIMLEuSy3G8L
        raLhAX72SORorigFiejiKF8=
X-Google-Smtp-Source: ABdhPJz1wIS2yu5f830MJFo7fQihE5SCfSp1N1sUbftv7iY9TjVpi25UZFYMkMoEvLvmRDRqMFaNhw==
X-Received: by 2002:a65:6392:: with SMTP id h18mr2230628pgv.397.1629964300739;
        Thu, 26 Aug 2021 00:51:40 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([103.112.79.203])
        by smtp.gmail.com with ESMTPSA id s1sm1949167pfd.13.2021.08.26.00.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 00:51:40 -0700 (PDT)
Subject: Re: [PATCH V3 4/5] ext4: get discard out of jbd2 commit kthread
 contex
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
 <20210724074124.25731-5-jianchao.wan9@gmail.com> <YRV6qqZcsNBHZzyn@mit.edu>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Message-ID: <65c6aa35-5e4c-a717-d1dc-8842e3ce0424@gmail.com>
Date:   Thu, 26 Aug 2021 15:51:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRV6qqZcsNBHZzyn@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/8/13 3:46 AM, Theodore Ts'o wrote:
> On Sat, Jul 24, 2021 at 03:41:23PM +0800, Wang Jianchao wrote:
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 34be2f07449d..a496509e61b7 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -3474,6 +3530,14 @@ int ext4_mb_release(struct super_block *sb)
>>  	struct kmem_cache *cachep = get_groupinfo_cache(sb->s_blocksize_bits);
>>  	int count;
>>  
>> +	if (test_opt(sb, DISCARD)) {
>> +		/*
>> +		 * wait the discard work to drain all of ext4_free_data
>> +		 */
>> +		queue_work(ext4_discard_wq, &sbi->s_discard_work);
>> +		flush_work(&sbi->s_discard_work);
> 
> I agree with Jan --- it's not clear to me why the call to queue_work()
> is needed.  After the flush_work() call returns, if s_discard_work is
> still non-empty, there must be something terribly wrong --- are we
> missing something?

Yes，the queue_work() is redundant.
I will get rid of it in next version.

> 
>> @@ -3672,8 +3724,14 @@ int __init ext4_init_mballoc(void)
>>  	if (ext4_free_data_cachep == NULL)
>>  		goto out_ac_free;
>>  
>> +	ext4_discard_wq = alloc_workqueue("ext4discard", WQ_UNBOUND, 0);
>> +	if (!ext4_discard_wq)
>> +		goto out_free_data;
>> +
> 
> 
> Perhaps we should only allocate the workqueue when it's needed ---
> e.g., when a file system is mounted or remounted with "-o discard"?
> 
> Then in ext4_exit_malloc(), we only free it if ext4_discard_wq is
> non-NULL.
> 
> This would save a bit of memory on systems that wouldn't need the ext4
> discard work queue.

Yes, it make sense to the system with pool memory

Thanks so much
Jianchao

> 
> 					- Ted
> 
