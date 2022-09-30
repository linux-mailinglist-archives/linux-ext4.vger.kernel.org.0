Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB925F0B7F
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Sep 2022 14:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiI3MQZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Sep 2022 08:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiI3MQY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Sep 2022 08:16:24 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FDBF3C68
        for <linux-ext4@vger.kernel.org>; Fri, 30 Sep 2022 05:16:24 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oeEwI-0003sR-IN; Fri, 30 Sep 2022 14:16:22 +0200
Message-ID: <17a07226-722f-d98f-3641-0c1c768c3a46@leemhuis.info>
Date:   Fri, 30 Sep 2022 14:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
 #forregzbot
Content-Language: en-US, de-DE
To:     Thilo Fromm <t-lo@linux.microsoft.com>
Cc:     linux-ext4@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <c77bf00f-4618-7149-56f1-b8d1664b9d07@linux.microsoft.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <c77bf00f-4618-7149-56f1-b8d1664b9d07@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1664540184;e2f80536;
X-HE-SMSGID: 1oeEwI-0003sR-IN
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[Note: this mail is primarily send for documentation purposes and/or for
regzbot, my Linux kernel regression tracking bot. That's why I removed
most or all folks from the list of recipients, but left any that looked
like a mailing lists. These mails usually contain '#forregzbot' in the
subject, to make them easy to spot and filter out.]

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker.

On 28.09.22 09:30, Thilo Fromm wrote:
> Hello,
> 
>> So this seems like a real issue. Essentially, the problem is that
>> ext4_bmap() acquires inode->i_rwsem while its caller
>> jbd2_journal_flush() is holding journal->j_checkpoint_mutex. This
>> looks like a real deadlock possibility.
> 
> Flatcar Container Linux users have reported a kernel issue which might
> be caused by commit 51ae846cff5. The issue is triggered under I/O load
> in certain conditions and leads to a complete system hang. I've pasted a
> typical kernel log below; please refer to
> https://github.com/flatcar/Flatcar/issues/847 for more details.
> 
> The issue can be triggered on Flatcar release 3227.2.2 / kernel version
> 5.15.63 (we ship LTS kernels) but not on release 3227.2.1 / kernel
> 5.15.58. 51ae846cff5 was introduced to 5.15 in 5.15.61.
> 
>> Thinking about it some more, it does not seem locking i_rwsem in
>> ext4_bmap() is really workable and as I've noted in one of my replies
>> to this patch [1] it is not a complete solution to the problem anyway.
>> So I would be for reverting 51ae846cff5 and thinking more about how we
>> can make inline data locking suck less...
> 
> Any thoughts on the revert? After a cursory glance at 51ae846cff5 this
> commit merely seems to address a warning...

CCing the regression mailing list, as it should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot (using the commit id from the stable tree where this occurs
instead of 51ae846cff5):

#regzbot ^introduced 30dfb75e1f86454
#regzbot title ext4: system hangs on  Flatcar Container Linux
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
