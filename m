Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D99572FDF8
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jun 2023 14:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjFNMLj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jun 2023 08:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243671AbjFNMLf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jun 2023 08:11:35 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7B51FCB;
        Wed, 14 Jun 2023 05:11:17 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q9PLH-0001aW-Hc; Wed, 14 Jun 2023 14:11:15 +0200
Message-ID: <b23be3ce-80cb-fb74-d28c-af3d16e34b31@leemhuis.info>
Date:   Wed, 14 Jun 2023 14:11:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Fwd: ext4_check_descriptors: Block bitmap for group 0 overlaps
 block group descriptors
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux ext4 Development <linux-ext4@vger.kernel.org>
References: <17d7e7f8-ad8d-1696-32b7-3ff9fd4548c1@gmail.com>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <17d7e7f8-ad8d-1696-32b7-3ff9fd4548c1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686744677;5a2e74d9;
X-HE-SMSGID: 1q9PLH-0001aW-Hc
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

On 11.06.23 04:27, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> Fail to mount a filesystem in kernel 6.4.0
>>
> [...]
> 
> #regzbot introduced: v6.3..v6.4 https://bugzilla.kernel.org/show_bug.cgi?id=217534
> #regzbot title: Block bitmap for group 0 overlaps block group descriptors, causing mount failure
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217534

The reporter meanwhile confirmed that the issue is also fixed by
reverting ad3f09be6cf ("ext4: remove unnecessary check in
ext4_bg_num_gdb_nometa") and likely a dup of
https://lore.kernel.org/regressions/e61d9895-0c22-ae7b-1641-761a4932a966@leemhuis.info/

Revert already posted. Telling regzbot:

#regzbot monitor:
https://lore.kernel.org/all/60d81a63-4e8e-690d-b0c2-3c20c780a5d6@huaweicloud.com/
#regzbot monitor:
https://lore.kernel.org/all/20230613225025.3859522-1-shikemeng@huaweicloud.com/
#regzbot fix: Revert "ext4: remove unnecessary check in
ext4_bg_num_gdb_nometa"
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
