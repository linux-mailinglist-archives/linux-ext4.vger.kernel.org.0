Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B42A66788E
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jan 2023 16:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbjALPGY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Jan 2023 10:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbjALPFu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Jan 2023 10:05:50 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01666144A;
        Thu, 12 Jan 2023 06:54:25 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pFyyE-0003z5-5G; Thu, 12 Jan 2023 15:54:22 +0100
Message-ID: <78f2cd63-2c58-68c4-9d4b-a587974b7108@leemhuis.info>
Date:   Thu, 12 Jan 2023 15:54:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: EXT4 IOPS degradation in 5.10 compared to 5.4
Content-Language: en-US, de-DE
To:     "Bhatnagar, Rishabh" <risbhat@amazon.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        abuehaze@amazon.com,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <03d52010-06a8-9bff-0565-b698b48850a9@amazon.com>
From:   "Linux kernel regression tracking (#adding)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <03d52010-06a8-9bff-0565-b698b48850a9@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673535266;02abb5b1;
X-HE-SMSGID: 1pFyyE-0003z5-5G
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

On 12.01.23 03:06, Bhatnagar, Rishabh wrote:
> Hi Theodore/Jan
> 
> Please ignore the previous mail which isn't formatted well.
> 
> 
> We have been seeing a consistent 3% degradation in IOPS score between
> 5.4 and 5.10 stable kernels while running fio tests.
> 
> I'm running test case on m6g.8xlarge AWS instances using arm64. The test
> involves:
> 
> [...]>
> After doing some kernel bisecting between we were able to pinpoint this
> commit that drops the iops score by 10~15 points (~3%).
> ext4: avoid unnecessary transaction starts during writeback
> (6b8ed62008a49751fc71fefd2a4f89202a7c2d4d)
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 6b8ed62008a49751fc71
#regzbot title ext4: consistent 3% degradation in IOPS score
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
