Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3A75A45AF
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Aug 2022 11:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiH2JEj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Aug 2022 05:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiH2JEh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Aug 2022 05:04:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376C05A3D0
        for <linux-ext4@vger.kernel.org>; Mon, 29 Aug 2022 02:04:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C85A31F9B4;
        Mon, 29 Aug 2022 09:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661763874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XZgBZ0UjxV3NhRmoxt3daPk3erKHgHAsqa3xw2RObig=;
        b=3cOvnbyJwr1k08t6qC3m/rTEpS+ryvdrQYS6+CUOWOoL52Ghc3xzxigbKPDO2JCBSyOjX/
        RFOeVsZVLWncfqfiKPTgNW4bWM/Mq9Kfg0VbwJJSQMCUN65NByeD9lJsBF5v8Pz4gzDDm1
        JuzGGkotxFaTPz+kJCDYw41yCCrSamo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661763874;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XZgBZ0UjxV3NhRmoxt3daPk3erKHgHAsqa3xw2RObig=;
        b=N/TwuyVliN31haKK5kSehMKsP05UZ899KpstMK324xVhYUVggvcCxcEJJxNP2Ndl4beCdn
        xjoz0SZrlbW2NlAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A588C1352A;
        Mon, 29 Aug 2022 09:04:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8rtdKCKBDGNiHwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 29 Aug 2022 09:04:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0ADDEA066D; Mon, 29 Aug 2022 11:04:34 +0200 (CEST)
Date:   Mon, 29 Aug 2022 11:04:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, Stefan Wahren <stefan.wahren@i2se.com>,
        Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH 0/2] ext4: Fix performance regression with mballoc
Message-ID: <20220829090434.sfxv3rrma32apbi2@quack3>
References: <20220823134508.27854-1-jack@suse.cz>
 <8e164532-c436-241f-33be-4b41f7f67235@i2se.com>
 <20220824104010.4qvw46zmf42te53n@quack3>
 <743489b4-4f9d-3a4d-d87e-e6bf981027c4@i2se.com>
 <20220825091842.fybrfgdzd56xi53i@quack3>
 <0a01dfee-59bf-7a16-6272-683a886e1299@i2se.com>
 <20220826101522.b552tn646qobrjdx@quack3>
 <Ywor0BFVnLYj2bxH@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ywor0BFVnLYj2bxH@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 27-08-22 20:06:00, Ojaswin Mujoo wrote:
> On Fri, Aug 26, 2022 at 12:15:22PM +0200, Jan Kara wrote:
> > Hi Stefan,
> > 
> > On Thu 25-08-22 18:57:08, Stefan Wahren wrote:
> > > > Perhaps if you just download the archive manually, call sync(1), and measure
> > > > how long it takes to (untar the archive + sync) in mb_optimize_scan=0/1 we
> > > > can see whether plain untar is indeed making the difference or there's
> > > > something else influencing the result as well (I have checked and
> > > > rpi-update does a lot of other deleting & copying as the part of the
> > > > update)? Thanks.
> > > 
> > > mb_optimize_scan=0 -> almost 5 minutes
> > > 
> > > mb_optimize_scan=1 -> almost 18 minutes
> > > 
> > > https://github.com/lategoodbye/mb_optimize_scan_regress/commit/3f3fe8f87881687bb654051942923a6b78f16dec
> > 
> > Thanks! So now the iostat data indeed looks substantially different.
> > 
> > 			nooptimize	optimize
> > Total written		183.6 MB	190.5 MB
> > Time (recorded)		283 s		1040 s
> > Avg write request size	79 KB		41 KB
> > 
> > So indeed with mb_optimize_scan=1 we do submit substantially smaller
> > requests on average. So far I'm not sure why that is. Since Ojaswin can
> > reproduce as well, let's see what he can see from block location info.
> > Thanks again for help with debugging this and enjoy your vacation!
> > 
> 
> Hi Jan and Stefan,
> 
> Apologies for the delay, I was on leave yesterday and couldn't find time to get to this.
> 
> So I was able to collect the block numbers using the method you suggested. I converted the 
> blocks numbers to BG numbers and plotted that data to visualze the allocation spread. You can 
> find them here:
> 
> mb-opt=0, patched kernel: https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/mbopt-0-patched.png
> mb-opt=1, patched kernel: https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/mbopt-1-patched.png
> mb-opt=1, unpatched kernel: https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/mbopt-1-unpatched.png
> 
> Observations:
> * Before the patched mb_optimize_scan=1 allocations were way more spread out in
>   40 different BGs.
> * With the patch, we still allocate in 36 different BGs but majority happen in
>   just 1 or 2 BGs.
> * With mb_optimize_scan=0, we only allocate in just 7 unique BGs, which could
>   explain why this is faster.

Thanks for testing Ojaswin! Based on iostats from Stefan, I'm relatively
confident the spread between block groups is responsible for the
performance regression. Iostats show pretty clearly that the write
throughput is determined by the average write request size which is
directly related to the number of block groups we allocate from.

Your stats for patched kernel show that there are two block groups which
get big part of allocations (these are likely the target block groups) but
then remaining ~1/3 is spread a lot. I'm not yet sure why that is... I
guess I will fiddle some more with my test VM and try to reproduce these
allocation differences (on my test server the allocation pattern on patched
kernel is very similar with mb_optimize_scan=0/1).

> Also, one strange thing I'm seeing is that the perfs don't really show any
> particular function causing the regression, which is surprising considering
> mb_optimize_scan=1 almost takes 10 times more time.

Well, the time is not spent by CPU. We spend more time waiting for IO which
is not visible in perf profiles. You could plot something like offcpu flame
graphs, there the difference would be visible but I don't expect you'd see
anything more than just we spend more time in functions waiting for
writeback to complete.

> Lastly, FWIW I'm not able to replicate the regression when using loop devices
> and mb_optmize_scan=1 performs similar to mb-opmtimize_scan=0 (without patches
> as well). Not sure if this is related to the issue or just some side effect of
> using loop devices.

This is because eMMC devices seem to be very sensitive to IO pattern (and
write request size). For loop devices, we don't care about request size
much so that's why mb_optimize_scan makes no big difference. But can you
still see the difference in the allocation pattern with the loop device?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
