Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719AE5EF63F
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Sep 2022 15:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiI2NS1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 09:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiI2NS0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 09:18:26 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFA4817D423
        for <linux-ext4@vger.kernel.org>; Thu, 29 Sep 2022 06:18:25 -0700 (PDT)
Received: from [10.254.254.111] (ip5b402ecc.dynamic.kabel-deutschland.de [91.64.46.204])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2A48B20E0A27;
        Thu, 29 Sep 2022 06:18:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A48B20E0A27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1664457505;
        bh=bQV/cNWeK1uZUCjFLKjUSSe4yF/yfhJciuwxleOg8Ds=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=Wp7YIyrnZl2U8gbGF/cigUnMhlyx3zoG/INFQbQCaHQxNoAjFRPTHMh1pp1R7rwPM
         VccvwLstYroYUYUxqbnhKz4CflJc3zPkRlKvnqpS16VvLIBxJeK6RDZ+0MP2yGdUtj
         xhVFSiMAxGdELcuc5kn36FTx0zmLUiYXcMF2e1t8=
Message-ID: <d8b18ba8-ea12-b617-6b5e-455a1d7b5e21@linux.microsoft.com>
Date:   Thu, 29 Sep 2022 15:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To:     Jan Kara <jack@suse.cz>
Cc:     jack@suse.com, tytso@mit.edu, Ye Bin <yebin10@huawei.com>,
        linux-ext4@vger.kernel.org
References: <20220824100652.227m7eq4zqq7luir@quack3>
 <c77bf00f-4618-7149-56f1-b8d1664b9d07@linux.microsoft.com>
 <20220929082716.5urzcfk4hnapd3cr@quack3>
Content-Language: en-US
From:   Thilo Fromm <t-lo@linux.microsoft.com>
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
In-Reply-To: <20220929082716.5urzcfk4hnapd3cr@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-23.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Honza,

Thank you very much for your thorough feedback. We were unaware of the 
backtrace issue and will have a look at once.

>>> So this seems like a real issue. Essentially, the problem is that
>>> ext4_bmap() acquires inode->i_rwsem while its caller
>>> jbd2_journal_flush() is holding journal->j_checkpoint_mutex. This
>>> looks like a real deadlock possibility.
>>
>> Flatcar Container Linux users have reported a kernel issue which might be
>> caused by commit 51ae846cff5. The issue is triggered under I/O load in
>> certain conditions and leads to a complete system hang. I've pasted a
>> typical kernel log below; please refer to
>> https://github.com/flatcar/Flatcar/issues/847 for more details.
>>
>> The issue can be triggered on Flatcar release 3227.2.2 / kernel version
>> 5.15.63 (we ship LTS kernels) but not on release 3227.2.1 / kernel 5.15.58.
>> 51ae846cff5 was introduced to 5.15 in 5.15.61.
> 
> Well, so far your stacktraces do not really show anything pointing to that
> particular commit. So we need to understand that hang some more.

This makes sense and I agree. Sorry for the garbled stack traces.

In other news, one of our users - who can reliably trigger the issue in 
their set-up - ran tests with kernel 5.15.63 with and without commit 
51ae846cff5. Without the commit, the kernel hang did not occur (see 
https://github.com/flatcar/Flatcar/issues/847#issuecomment-1261967920).

We'll now focus on un-garbling our traces to get to the bottom of this.

>> ( Kernel log of a crash follows; more info here:
>> https://github.com/flatcar/Flatcar/issues/847 )
>>
[...]
>> [1282119.190346]  ret_from_fork+0x22/0x30
> 
> Hrm, so your backtraces seem to be strange. For example in this stacktrace
> we should have kjournald2() somewhere instead of
> jbd2_journal_check_available_features() which can hardly be there. So
> somehow stack unwinding or symbol resolution is strangely confused with
> this kernel. Compiling with any unusual config or compiler?

We're on GCC 10.3.0 and will review our build process to get to the 
bottom of this. Will get back to this thread as soon as we have news. 
Thanks again for pointing this out!

> So far it seems that most tasks are waiting for transaction to commit, jbd2
> thread committing the transaction waits for someone to drop its transaction
> reference which never happens. It is unclear who holds the transaction
> reference. But with stacktraces corrupted like this it is difficult to be
> certain.
> 
> So probably first try find out why stacktraces are not working right on
> your kernel and fix them. And then, if the hang happens, please trigger
> sysrq-w (or do echo w >/proc/sysrq-trigger if you can still get to the
> machine) and send here the output. It will dump all blocked tasks and from
> that we should be able to better understand what is happening.

Working on it!

Best regards,
Thilo
