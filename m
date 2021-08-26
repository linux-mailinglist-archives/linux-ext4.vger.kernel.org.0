Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F03E3F82F4
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Aug 2021 09:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbhHZHQt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Aug 2021 03:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240109AbhHZHQs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Aug 2021 03:16:48 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695CDC061757;
        Thu, 26 Aug 2021 00:16:01 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 2so1969959pfo.8;
        Thu, 26 Aug 2021 00:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ABjNhP2gy40aUcdUMsv9ukpTDQl/Hf7OG0QTpeYrhCY=;
        b=jiL6os6V6Maudeg+konCqokW7+3CdtOmCY4XhejQXcPxW11lEBdzStFTi18fv1+pF8
         EObhGbcf/6FRI8H572DKJKOtWWOFvGxqq1LZ8+ul12ikdkgvyCYXC/IbMQ15aHz5kkv6
         Yvf4SOma5/hop3OOnPpgtEZmoulQoqcZi1fn6FqMni2R9W8kPkH939iCihFPeqsR87Uh
         iExH//M+XlBBQ02c2E3jWS4Jf8D88panUOC64lGZWoQRF4OKDtVEXobfMUDMlHLIvWdm
         b90gV1tl1/Sx56yaLHBeJMuM84ouS41RcOXb1qCJAzMbd5cH6iLleQ15cs9IFAwJ4+96
         VFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ABjNhP2gy40aUcdUMsv9ukpTDQl/Hf7OG0QTpeYrhCY=;
        b=L8CKgtpIBktpgwRTEfJT41hL0eN+yxbNLZllEgmaqWUH2tHaTsM/bPr+cmXpDfePE4
         TCb7/bP1qxKCryck7K0Ci84ywBWoIjJqGwB44Xhwuo03mnnhyPwzjqMcSoyWOQ4AlrRE
         86atPyS7JRyV3urj/vBUc/QULVXQ9r33F4vjwHS2AbbpW4bNSWr/mos4xc1G25TlQpIv
         rOKFkEdmClOL6Y7eN3aq+HkEPFmQi6D3ELOzMDyiZsewTK+cW9ZUj/gopvEqomDblSY9
         XYV5VDKkzUzjbd5ar3m0PGZds1f/MukaN3Dv1hFPdu70oM+HpyFOACuq69t8wI30dwpw
         NDyA==
X-Gm-Message-State: AOAM532RXe5fxHiSqNp6JdUuW5gq/GLmCiPFuiDXr05mbCdTtt+5jLTr
        /dSkxKfrU8bXzSSE+g6xJUI=
X-Google-Smtp-Source: ABdhPJyIDsYfXofx6NjbJNU4vScDzfiLT5YUKj52vpA5jIoerwylz8GT6fAYvM0o5ONvE/fD+f9YaA==
X-Received: by 2002:a65:6084:: with SMTP id t4mr2145300pgu.25.1629962160271;
        Thu, 26 Aug 2021 00:16:00 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([162.219.34.243])
        by smtp.gmail.com with ESMTPSA id w16sm1911352pff.130.2021.08.26.00.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 00:15:59 -0700 (PDT)
Subject: Re: [PATCH V3 4/5] ext4: get discard out of jbd2 commit kthread
 contex
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
 <20210724074124.25731-5-jianchao.wan9@gmail.com>
 <20210804154530.GL4578@quack2.suse.cz>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Message-ID: <6621227f-e710-2fa2-bc09-c4c66c34eb14@gmail.com>
Date:   Thu, 26 Aug 2021 15:15:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804154530.GL4578@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/8/4 11:45 PM, Jan Kara wrote:
> On Sat 24-07-21 15:41:23, Wang Jianchao wrote:
>> From: Wang Jianchao <wangjianchao@kuaishou.com>
>>
>> Right now, discard is issued and waited to be completed in jbd2
>> commit kthread context after the logs are committed. When large
>> amount of files are deleted and discard is flooding, jbd2 commit
>> kthread can be blocked for long time. Then all of the metadata
>> operations can be blocked to wait the log space.
>>
>> One case is the page fault path with read mm->mmap_sem held, which
>> wants to update the file time but has to wait for the log space.
>> When other threads in the task wants to do mmap, then write mmap_sem
>> is blocked. Finally all of the following read mmap_sem requirements
>> are blocked, even the ps command which need to read the /proc/pid/
>> -cmdline. Our monitor service which needs to read /proc/pid/cmdline
>> used to be blocked for 5 mins.
>>
>> This patch frees the blocks back to buddy after commit and then do
>> discard in a async kworker context in fstrim fashion, namely,
>>  - mark blocks to be discarded as used if they have not been allocated
>>  - do discard
>>  - mark them free
>> After this, jbd2 commit kthread won't be blocked any more by discard
>> and we won't get NOSPC even if the discard is slow or throttled.
>>
>> Link: https://marc.info/?l=linux-kernel&m=162143690731901&w=2
>> Suggested-by: Theodore Ts'o <tytso@mit.edu>
>> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
> 
> Looks good to me. Just one small comment below. With that addressed feel
> free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 
>> @@ -3474,6 +3530,14 @@ int ext4_mb_release(struct super_block *sb)
>>  	struct kmem_cache *cachep = get_groupinfo_cache(sb->s_blocksize_bits);
>>  	int count;
>>  
>> +	if (test_opt(sb, DISCARD)) {
>> +		/*
>> +		 * wait the discard work to drain all of ext4_free_data
>> +		 */
>> +		queue_work(ext4_discard_wq, &sbi->s_discard_work);
> 
> Do we really need to queue the work here? The filesystem should be
> quiescent by now, we take care to queue the work whenever we add item to
> empty list. So it should be enough to have flush_work() here and then
> possibly
> 
> 	WARN_ON_ONCE(!list_empty(&sbi->s_discard_list))
> 
> Or am I missing something?

queue_work here is indeed redundant.

Thanks so much for you point out this.
Jianchao

> 
> 								Honza
> 
>> +		flush_work(&sbi->s_discard_work);
>> +	}
>> +
