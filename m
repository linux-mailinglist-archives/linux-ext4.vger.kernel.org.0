Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430F1799D7D
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Sep 2023 11:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241570AbjIJJ0R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 Sep 2023 05:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbjIJJ0R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 Sep 2023 05:26:17 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F8719E;
        Sun, 10 Sep 2023 02:26:12 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qfGhg-0007eD-Dk; Sun, 10 Sep 2023 11:26:04 +0200
Message-ID: <eb707c22-b64a-4b08-9cf9-fcbeb1ddf16c@leemhuis.info>
Date:   Sun, 10 Sep 2023 11:26:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [fstests generic/388, 455, 475, 482 ...] Ext4 journal recovery
 test fails
Content-Language: en-US, de-DE
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Zorro Lang <zlang@kernel.org>,
        linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
        regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
References: <87o7ie2fmm.fsf@doe.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <87o7ie2fmm.fsf@doe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694337972;f5d47b2e;
X-HE-SMSGID: 1qfGhg-0007eD-Dk
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

On 07.09.23 16:59, Ritesh Harjani (IBM) wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
>> On Thu, Sep 07, 2023 at 07:05:38PM +0530, Ritesh Harjani wrote:
>>> Thanks Matthew for proposing the final changes using folio.
>>> (there were just some minor change required for fs/reiserfs/ for unused variables)
>>> Pasting the final patch below (you as the author with my Signed-off-by &
>>> Tested-by), which I have tested it on my system with "ext4/1k -g auto"
>>
>> I'd rather split that patch up a bit -- I don't think the reiserfs
>> part fixes any actual problem.  I've pushed out
>> https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/bh-fixes
>>
>> or git clone git://git.infradead.org/users/willy/pagecache.git
>>
>> I credited you as the author on the second two since I just tidied up
>> your proposed fixes.
>>
>> I've also checked ocfs2 as the other user of JBD2 and I don't see any
>> problems there.
> 
> Thanks Matthew! :) 

#regzbot fix: jbd2: Remove page size assumptions
#regzbot ignore-activity

(fix can currently be found in
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/bh-fixes
as
https://git.infradead.org/users/willy/pagecache.git/commit/fc0a6fa4a2c7b434665f087801a06c544b16f085
)

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
