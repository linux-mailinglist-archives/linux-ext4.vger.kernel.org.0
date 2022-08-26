Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A8A5A23B9
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Aug 2022 11:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245278AbiHZJH0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Aug 2022 05:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245058AbiHZJHY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Aug 2022 05:07:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5B8D5E94
        for <linux-ext4@vger.kernel.org>; Fri, 26 Aug 2022 02:07:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A646833781;
        Fri, 26 Aug 2022 09:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661504841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k/YOAeMrO41lEY4+8aSzYGR7Fy/5LXHbHEaiBePREWM=;
        b=tlR6q+ofUogLpBrFZ+w22StOHygBtx7OUUPB0ad9FIEQzEvHibG4PDC4opUNsIw9IFxU2C
        KkHvt5u21e/p6un6qMfREWt9nutYriQozkCgcsWcePyUcIzGO3yRRKDT65cp2CQja7LV71
        mSI/MaNNzvNc+DBbGXayEQ7JCukYdyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661504841;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k/YOAeMrO41lEY4+8aSzYGR7Fy/5LXHbHEaiBePREWM=;
        b=Ctw1HYd5pXsNzHIjl0dbCWAY16hzc/YpRu1NvL6f+2QZgPVnI5cRo9XeKDMp2gO2SDoVMM
        ldJr/ZwKGjOSe0BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89EDD13421;
        Fri, 26 Aug 2022 09:07:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v5OoIUmNCGPoNwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 26 Aug 2022 09:07:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0F3CAA0679; Fri, 26 Aug 2022 11:07:21 +0200 (CEST)
Date:   Fri, 26 Aug 2022 11:07:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, Stefan Wahren <stefan.wahren@i2se.com>,
        Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH 0/2] ext4: Fix performance regression with mballoc
Message-ID: <20220826090721.z2hn4rjffsyveeud@quack3>
References: <20220823134508.27854-1-jack@suse.cz>
 <8e164532-c436-241f-33be-4b41f7f67235@i2se.com>
 <20220824104010.4qvw46zmf42te53n@quack3>
 <20220824141338.ailht7uzm6ihkofb@quack3>
 <Ywe2IKIvwlca1ab9@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ywe2IKIvwlca1ab9@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 25-08-22 23:19:48, Ojaswin Mujoo wrote:
> On Wed, Aug 24, 2022 at 04:13:38PM +0200, Jan Kara wrote:
> > On Wed 24-08-22 12:40:10, Jan Kara wrote:
> > > Hi Stefan!
> > > 
> > > On Wed 24-08-22 12:17:14, Stefan Wahren wrote:
> > > > Am 23.08.22 um 22:15 schrieb Jan Kara:
> > > > > Hello,
> > > > > 
> > > > > So I have implemented mballoc improvements to avoid spreading allocations
> > > > > even with mb_optimize_scan=1. It fixes the performance regression I was able
> > > > > to reproduce with reaim on my test machine:
> > > > > 
> > > > >                       mb_optimize_scan=0     mb_optimize_scan=1     patched
> > > > > Hmean     disk-1       2076.12 (   0.00%)     2099.37 (   1.12%)     2032.52 (  -2.10%)
> > > > > Hmean     disk-41     92481.20 (   0.00%)    83787.47 *  -9.40%*    90308.37 (  -2.35%)
> > > > > Hmean     disk-81    155073.39 (   0.00%)   135527.05 * -12.60%*   154285.71 (  -0.51%)
> > > > > Hmean     disk-121   185109.64 (   0.00%)   166284.93 * -10.17%*   185298.62 (   0.10%)
> > > > > Hmean     disk-161   229890.53 (   0.00%)   207563.39 *  -9.71%*   232883.32 *   1.30%*
> > > > > Hmean     disk-201   223333.33 (   0.00%)   203235.59 *  -9.00%*   221446.93 (  -0.84%)
> > > > > Hmean     disk-241   235735.25 (   0.00%)   217705.51 *  -7.65%*   239483.27 *   1.59%*
> > > > > Hmean     disk-281   266772.15 (   0.00%)   241132.72 *  -9.61%*   263108.62 (  -1.37%)
> > > > > Hmean     disk-321   265435.50 (   0.00%)   245412.84 *  -7.54%*   267277.27 (   0.69%)
> > > > > 
> > > > > Stefan, can you please test whether these patches fix the problem for you as
> > > > > well? Comments & review welcome.
> > > > 
> > > > i tested the whole series against 5.19 and 6.0.0-rc2. In both cases the
> > > > update process succeed which is a improvement, but the download + unpack
> > > > duration ( ~ 7 minutes ) is not as good as with mb_optimize_scan=0 ( ~ 1
> > > > minute ).
> > > 
> > > OK, thanks for testing! I'll try to check specifically untar whether I can
> > > still see some differences in the IO pattern on my test machine.
> > 
> > I have created the same tar archive as you've referenced (files with same
> > number of blocks) and looked at where blocks get allocated with
> > mb_optimize_scan=0 and with mb_optimize_scan=1 + my patches. And the
> > resulting IO pattern looks practically the same on my test machine. In
> > particular in both cases files get allocated only in 6 groups, if I look
> > at the number of erase blocks that are expected to be touched by file data
> > (for various erase block sizes from 512k to 4MB) I get practically same
> > numbers for both cases.
> > 
> > Ojaswin, I think you've also mentioned you were able to reproduce the issue
> > in your setup? Are you still able to reproduce it with the patched kernel?
> > Can you help debugging while Stefan is away?
> > 
> >                 Honza
> Hi Jan,
> 
> So I ran some more tests on v6.0-rc2 kernel with and without your patches and
> here are the details:
> 
> Workload:-
>   time tar -xf rpi-firmware.tar -C ./test
>   time sync
> 
> System details:
>   - Rpi 3b+ w/ 8G memory card (~4G free)
>   - tar is ~120MB compressed

Hum, maybe the difference is that I've tried with somewhat larger (20G) and
otherwise empty filesystem...

> And here is the output of time command for various tests. Since some of them
> take some time to complete, I ran them only 2 3 times each so the numbers might
> vary but they are indicative of the issue.
> 
> v6.0-rc2 (Without patches)
> 
> mb_optimize_scan = 0
> 
> **tar**
> real    1m39.574s
> user    0m10.311s
> sys     0m2.761s  
> 
> **sync**
> real    0m22.269s
> user    0m0.001s
> sys     0m0.005s
> 
> mb_optimize_scan = 1
> 
> **tar**
> real    21m25.288s
> user    0m9.607
> sys     0m3.026
> 
> **sync**
> real    1m23.402s
> user    0m0.005s
> sys     0m0.000s
> 
> v6.0-rc2 (With patches)
> 
> mb_optimize_scan = 0
> 
> * similar to unpatched (~1 to 2mins) *
> 
> mb_optimize_scan = 1
> 
> **tar**
> real    5m7.858s
> user    0m11.008s
> sys     0m2.739s
> 
> **sync**
> real    6m7.308s
> user    0m0.003s
> sys     0m0.001s
> 
> At this point, I'm pretty confident that it is the untar operation that is
> having most of the regression and no other download/delete operations in
> rpi-update are behind the delay. Further, it does seem like your patches
> improve the performance but, from my tests, we are still not close to the
> mb_optimize_scan=0 numbers.

Yes, thanks for the tests!

> I'm going to spend some more time trying to collect the perfs and which block 
> group the allocations are happening during the untar to see if we can get a better
> idea from that data. Let me know if you'd want me to collect anything else.
> 
> PS: One question, to find the blocks groups being used I'm planning to take
> the dumpe2fs output before and after untar and then see the groups where free blocks
> changed (since there is nothing much running on Pi i assume this should give us
> a rough idea of allocation pattern of untar), just wanted to check if there's a
> better way to get this data.

I have used 'find <target-dir> -exec filefrag -v {} \;' to get block
numbers of files. That gets you better insight than plain dumpe2fs
numbers...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
