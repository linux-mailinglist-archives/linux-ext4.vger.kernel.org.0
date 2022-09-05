Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B5D5ACFC7
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Sep 2022 12:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237889AbiIEKQ7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Sep 2022 06:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbiIEKQk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Sep 2022 06:16:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF5E1EAD0
        for <linux-ext4@vger.kernel.org>; Mon,  5 Sep 2022 03:15:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 48BAE353D7;
        Mon,  5 Sep 2022 10:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662372905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O+9qVDs+u1/TKFgwJRgZYPagUghG3lSNH3L31/9HdHw=;
        b=M/eosKVGmudsPEyoZr+pvQP1DjEziMpdaE+xzx73CkYVQKuI/qIxI4ox9C9CQvGVUnSgmy
        AhZgtLY7rH1LVcl7HbWVIP8iM6kAKhFmb8CKsiRpsC4okEKUH8cNMy9QavHO8LzmOwZsTV
        zJIsONx8CkihP1GvHu7UP5SYx721bqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662372905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O+9qVDs+u1/TKFgwJRgZYPagUghG3lSNH3L31/9HdHw=;
        b=4FI+3kF8VWivI/jCF2fskI6gcrNP6Hu6ff4045WOhYjvnGfWg448420cZq9McgxGhbKawe
        Vr2n06qCvI61srDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3585C13A66;
        Mon,  5 Sep 2022 10:15:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e0jlDCnMFWNjQAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 05 Sep 2022 10:15:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9DDAEA0682; Mon,  5 Sep 2022 12:15:04 +0200 (CEST)
Date:   Mon, 5 Sep 2022 12:15:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH 0/2] ext4: Fix performance regression with mballoc
Message-ID: <20220905101504.vnx377x7eao42izi@quack3>
References: <c449eea8-87e4-3f74-5d11-d159eae28c0b@i2se.com>
 <46CC2CC6-FB9B-4F6B-AA68-926D28F69592@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46CC2CC6-FB9B-4F6B-AA68-926D28F69592@dilger.ca>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 04-09-22 12:32:59, Andreas Dilger wrote:
> On Sep 4, 2022, at 00:01, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > 
> >> Am 27.08.22 um 16:36 schrieb Ojaswin Mujoo:
> >>> On Fri, Aug 26, 2022 at 12:15:22PM +0200, Jan Kara wrote:
> >>> Hi Stefan,
> >>> 
> >>> On Thu 25-08-22 18:57:08, Stefan Wahren wrote:
> >>>>> Perhaps if you just download the archive manually, call sync(1), and measure
> >>>>> how long it takes to (untar the archive + sync) in mb_optimize_scan=0/1 we
> >>>>> can see whether plain untar is indeed making the difference or there's
> >>>>> something else influencing the result as well (I have checked and
> >>>>> rpi-update does a lot of other deleting & copying as the part of the
> >>>>> update)? Thanks.
> >>>> mb_optimize_scan=0 -> almost 5 minutes
> >>>> 
> >>>> mb_optimize_scan=1 -> almost 18 minutes
> >>>> 
> >>>> https://github.com/lategoodbye/mb_optimize_scan_regress/commit/3f3fe8f87881687bb654051942923a6b78f16dec
> >>> Thanks! So now the iostat data indeed looks substantially different.
> >>> 
> >>>            nooptimize    optimize
> >>> Total written        183.6 MB    190.5 MB
> >>> Time (recorded)        283 s        1040 s
> >>> Avg write request size    79 KB        41 KB
> >>> 
> >>> So indeed with mb_optimize_scan=1 we do submit substantially smaller
> >>> requests on average. So far I'm not sure why that is. Since Ojaswin can
> >>> reproduce as well, let's see what he can see from block location info.
> >>> Thanks again for help with debugging this and enjoy your vacation!
> >>> 
> >> Hi Jan and Stefan,
> >> 
> >> Apologies for the delay, I was on leave yesterday and couldn't find time to get to this.
> >> 
> >> So I was able to collect the block numbers using the method you suggested. I converted the
> >> blocks numbers to BG numbers and plotted that data to visualze the allocation spread. You can
> >> find them here:
> >> 
> >> mb-opt=0, patched kernel: https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/mbopt-0-patched.png
> >> mb-opt=1, patched kernel: https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/mbopt-1-patched.png
> >> mb-opt=1, unpatched kernel: https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/mbopt-1-unpatched.png
> >> 
> >> Observations:
> >> * Before the patched mb_optimize_scan=1 allocations were way more spread out in
> >>   40 different BGs.
> >> * With the patch, we still allocate in 36 different BGs but majority happen in
> >>   just 1 or 2 BGs.
> >> * With mb_optimize_scan=0, we only allocate in just 7 unique BGs, which could
> >>   explain why this is faster.
> > 
> > thanks this is very helpful for me to understand. So it seems to me that with disabled mb_optimized_scan we have a more sequential write behavior and with enabled mb_optimized_scan a more random write behavior.
> > 
> > From my understanding writing small blocks at random addresses of the sd card flash causes a lot of overhead, because the sd card controller need to erase huge blocks (up to 1 MB) before it's able to program the flash pages. This would explain why this series doesn't fix the performance issue, the total amount of BGs is still much higher.
> > 
> > Is this new block allocation pattern a side effect of the optimization or desired?
> 
> The goal of the mb_optimized_scan is to avoid a large amount of linear
> scanning for very large filesystems when there are many block groups that
> are full or fragmented. 
> 
> It seems for empty filesystems the new list management is not very ideal.

The filesystems here are actually about half full and not too fragmented.

> It probably makes sense to have a hybrid, with some small amount of
> linear scanning (eg. a meta block group worth), and then use the new list
> to find a new group if that doesn't find any group with free space. 

There is a heuristic to scan a few block groups linearly before using the
data structures to decide about the next block group in current mballoc
code but it gets used only for rotational devices. I don't know about some
easy way how to detect other types of storage like eMMC cards that also
benefit from better data allocation locality.

I have come up with two more patches on top of my current attempt which
improve allocation locality and at least for the untar case causing issues
on eMMC they do get close to the mb_optimize_scan=0 locality. I want to
check whether the higher locality does not hurt performance for highly
parallel workloads though. Then I'll post them for review and discussion.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
