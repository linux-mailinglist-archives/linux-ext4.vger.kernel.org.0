Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F0E7C8963
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Oct 2023 18:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjJMP7L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Oct 2023 11:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjJMP7K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Oct 2023 11:59:10 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD373C2;
        Fri, 13 Oct 2023 08:58:28 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qrKYV-0001X0-4m; Fri, 13 Oct 2023 17:58:27 +0200
Message-ID: <fba67ba1-884a-4462-98d2-5de285015dad@leemhuis.info>
Date:   Fri, 13 Oct 2023 17:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: probable quota bug introduced in 6.6-rc1
Content-Language: en-US, de-DE
To:     Linux ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
References: <ZRytn6CxFK2oECUt@debian-BULLSEYE-live-builder-AMD64>
 <ZR0M-CFmh567Ogyg@debian.me>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZR0M-CFmh567Ogyg@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697212708;190ea2d6;
X-HE-SMSGID: 1qrKYV-0001X0-4m
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 04.10.23 08:58, Bagas Sanjaya wrote:
> On Tue, Oct 03, 2023 at 08:11:11PM -0400, Eric Whitney wrote:
>> When run on my test hardware, generic/270 triggers hung task timeouts when
>> run on a 6.6-rc1 (or -rc2, -rc3, -rc4) kernel with kvm-xfstests using the
>> nojournal test scenario.  The test always passes, but about 60% of the time
>> the running time of the test increases by an order of magnitude or more and
>> one or more of the hung task timeout warnings included below can be found in
>> the log.
>>
>> This does not reproduce on 6.5.  Bisection leads to this patch:
>>
>> dabc8b207566 ("quota: fix dqput() to follow the guarantees dquot_srcu should
>> provide")

#regzbot fix: 869b6ea1609f65
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

