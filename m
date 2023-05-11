Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA3F6FF232
	for <lists+linux-ext4@lfdr.de>; Thu, 11 May 2023 15:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbjEKNLX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 May 2023 09:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238007AbjEKNKv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 May 2023 09:10:51 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A9A65AD
        for <linux-ext4@vger.kernel.org>; Thu, 11 May 2023 06:10:45 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1px64B-0006xe-FC; Thu, 11 May 2023 15:10:43 +0200
Message-ID: <110bcda8-f832-c858-3b61-5c0c7cf9e058@leemhuis.info>
Date:   Thu, 11 May 2023 15:10:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: 6.4-rc1 xfstests-bld adv regressions
Content-Language: en-US, de-DE
To:     Eric Whitney <enwlinux@gmail.com>, jack@suse.cz
Cc:     linux-ext4@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <ZFqO3xVnmhL7zv1x@debian-BULLSEYE-live-builder-AMD64>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZFqO3xVnmhL7zv1x@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1683810646;6ac8c3c1;
X-HE-SMSGID: 1px64B-0006xe-FC
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 09.05.23 20:20, Eric Whitney wrote:
> 
> I'm seeing two test regressions on 6.4-rc1 while running the adv test case
> with kvm-xfstests.  Both tests fail with 100% reliability in 100 trial runs,
> and the failures appear to depend solely upon the fast commit mount option.
> 
> The first is generic/065, where the relevant info from 065.full is:
> 
> _check_generic_filesystem: filesystem on /dev/vdc is inconsistent
> *** fsck.ext4 output ***
> fsck from util-linux 2.36.1
> e2fsck 1.47.0 (5-Feb-2023)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> Directories count wrong for group #16 (4294967293, counted=0).
> 
> 
> The second is generic/535, where the test output is:
> 
>      QA output created by 535
>      Silence is golden
>     +Before: 755
>     +After : 777
> 
> Both test failures bisect to:  e360c6ed7274 ("ext4: Drop special handling of
> journalled data from ext4_sync_file()").  Reverting this patch eliminates the
> test failures.  So, I thought I'd bring these to your attention.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced e360c6ed7274
#regzbot title ext4: adv test cases of kvm-xfstests fail
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
