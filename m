Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AE37DAB34
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Oct 2023 07:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjJ2G2P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Oct 2023 02:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2G2O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Oct 2023 02:28:14 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9190ECC
        for <linux-ext4@vger.kernel.org>; Sat, 28 Oct 2023 23:28:11 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qwzHO-0002WO-2k; Sun, 29 Oct 2023 07:28:10 +0100
Message-ID: <e920c120-e463-463b-8d06-e539c23368d2@leemhuis.info>
Date:   Sun, 29 Oct 2023 07:28:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Subject: Re: task hung in ext4_fallocate #2
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     linux-ext4@vger.kernel.org
References: <20231017033725.r6pfo5a4ayqisct7@awork3.anarazel.de>
 <00375284-2071-4dea-9009-9cd2d0de71e1@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <00375284-2071-4dea-9009-9cd2d0de71e1@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1698560891;c0008d86;
X-HE-SMSGID: 1qwzHO-0002WO-2k
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux regression tracking. A
change or fix related to the regression discussed in this thread was
posted or applied, but it did not use a Closes: tag to point to the
report, as Linus and the documentation call for. Things happen, no
worries -- but now the regression tracking bot needs to be told manually
about the fix. See link in footer if these mails annoy you.]

On 20.10.23 09:01, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:
> On 17.10.23 05:37, Andres Freund wrote:
>>
>> As previously reported in https://lore.kernel.org/all/20231004004247.zkswbseowwwc6vvk@alap3.anarazel.de/
>> I found some hangs below ext4_fallocate(), in 6.6-rc*.  As it looks like my
>> issue was unrelated to the thread I had responded to, I was asked to start
>> this new thread.
>>
>> I just was able to reproduce the issue, after upgrading to 6.6-rc6 - this time
>> it took ~55min of high load (io_uring using branch of postgres, running a
>> write heavy transactional workload concurrently with concurrent bulk data
>> load) to trigger the issue.
>>
>> For now I have left the system running, in case there's something you would
>> like me to check while the system is hung.
>> [...]
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced v6.5..v6.6-rc6
> #regzbot title ext4: task hung in ext4_fallocate
> #regzbot ignore-activity

#regzbot fix: 838b35bb6a89c36da07ca39520ec071d
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
