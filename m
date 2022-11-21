Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274936327BB
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 16:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiKUPUy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 10:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiKUPUc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 10:20:32 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457ABA414A
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 07:18:14 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ox8Yk-00043Y-8z; Mon, 21 Nov 2022 16:18:10 +0100
Message-ID: <a98303db-85df-a64d-d672-c16d1e0d8b49@leemhuis.info>
Date:   Mon, 21 Nov 2022 16:18:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Content-Language: en-US, de-DE
To:     Jan Kara <jack@suse.cz>,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Thilo Fromm <t-lo@linux.microsoft.com>,
        Ye Bin <yebin10@huawei.com>, jack@suse.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, regressions@lists.linux.dev
References: <20221024104628.ozxjtdrotysq2haj@quack3>
 <643d007e-1041-4b3d-ed5e-ae47804f279d@linux.microsoft.com>
 <20221026101854.k6qgunxexhxthw64@quack3>
 <20221110125758.GA6919@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221110152637.g64p4hycnd7bfnnr@quack3>
 <20221110192701.GA29083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221111142424.vwt4khbtfzd5foiy@quack3>
 <20221111151029.GA27244@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221111155238.GA32201@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221121133559.srie6oy47udavj52@quack3>
 <20221121150018.tq63ot6qja3mfhpw@quack3>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20221121150018.tq63ot6qja3mfhpw@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1669043895;c619f593;
X-HE-SMSGID: 1ox8Yk-00043Y-8z
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21.11.22 16:00, Jan Kara wrote:
> OK, attached patch fixes the deadlock for me. Can you test whether it fixes
> the problem for you as well? Thanks!

Jan, many thx for taking care of this. There is one small thing to
improve, please add the following tags to your patch:

Link:
https://lore.kernel.org/r/c77bf00f-4618-7149-56f1-b8d1664b9d07@linux.microsoft.com/

Not sure, maybe a reported-by for Syzbot would be good as well, see:
https://lore.kernel.org/linux-ext4/000000000000892a3005e5b5d96c@google.com/

To explain: Linus[1] and others considered proper link tags in cases
like important, as they allow anyone to look into the backstory weeks or
years from now. That why they should be placed here, as outlined by the
documentation[2]. I care personally, because these tags make my
regression tracking efforts a whole lot easier, as they allow my
tracking bot 'regzbot' to automatically connect reports with patches
posted or committed to fix tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

[1] for details, see:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

[2] see Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)

