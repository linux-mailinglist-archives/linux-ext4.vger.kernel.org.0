Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAB87D233D
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Oct 2023 15:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjJVNqV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Oct 2023 09:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVNqU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 22 Oct 2023 09:46:20 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBAFDF;
        Sun, 22 Oct 2023 06:46:18 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1quYmW-0006af-O9; Sun, 22 Oct 2023 15:46:16 +0200
Message-ID: <9ba95b5e-72cb-445a-99b7-54dad4dab148@leemhuis.info>
Date:   Sun, 22 Oct 2023 15:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Content-Language: en-US, de-DE
To:     Linux kernel regressions list <regressions@lists.linux.dev>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
References: <20230830102434.xnlh66omhs6ninet@quack3>
 <ZS5hhpG97QSvgYPf@smile.fi.intel.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <ZS5hhpG97QSvgYPf@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697982378;427ac114;
X-HE-SMSGID: 1quYmW-0006af-O9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 17.10.23 12:27, Andy Shevchenko wrote:
> On Wed, Aug 30, 2023 at 12:24:34PM +0200, Jan Kara wrote:
>>   Hello Linus,
>>
>>   could you please pull from
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v6.6-rc1
>>
>> to get:
>> * fixes for possible use-after-free issues with quota when racing with
>>   chown
>> * fixes for ext2 crashing when xattr allocation races with another
>>   block allocation to the same file from page writeback code
>> * fix for block number overflow in ext2
>> * marking of reiserfs as obsolete in MAINTAINERS
>> * assorted minor cleanups
>>
>> Top of the tree is df1ae36a4a0e. The full shortlog is:
> 
> This merge commit (?) broke boot on Intel Merrifield.
> It has earlycon enabled and only what I got is watchdog
> trigger without a bit of information printed out.
> 
> I tried to give a two bisects with the same result.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot (using info from
https://lore.kernel.org/all/ZS5hhpG97QSvgYPf@smile.fi.intel.com/ here):

#regzbot ^introduced 024128477809f8
#regzbot title quota: boot on Intel Merrifield after merge commit
1500e7e0726e
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
