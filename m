Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34474575EB0
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Jul 2022 11:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiGOJfW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Jul 2022 05:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiGOJfW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Jul 2022 05:35:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB99F2408A
        for <linux-ext4@vger.kernel.org>; Fri, 15 Jul 2022 02:35:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 475701F980;
        Fri, 15 Jul 2022 09:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657877719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=owx2JDqfc0TOeM3bbay7BNOkMXr2qpK39L0Mw901F24=;
        b=Zx608Kl0/3/rKee6hG1Ud73TkrG0Qxirg96JEA0okhg1sV3mKjJzFzuoUe4lR/ty7hI5HN
        FniCqmxiti0l5btb/dc599uNkszjCNhdhUCtr722IdQldYV4U7KcSTfQ6kHrNjW7BmufIb
        GCdgtK7PoPV98G5zKffgq4XHSH71HCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657877719;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=owx2JDqfc0TOeM3bbay7BNOkMXr2qpK39L0Mw901F24=;
        b=G8ZRonmsc0MHxPzayrtenGHX/mQSyI/UG/uyZqOos0IWFaTng/yt8/B9NEplucDrGzanRE
        SRWE9wOIsazurnCg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3875A2C141;
        Fri, 15 Jul 2022 09:35:19 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DEFA9A0657; Fri, 15 Jul 2022 11:35:18 +0200 (CEST)
Date:   Fri, 15 Jul 2022 11:35:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Kiselev, Oleg" <okiselev@amazon.com>
Cc:     Jan Kara <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 2/2] ext4: avoid resizing to a partial cluster size
Message-ID: <20220715093518.tzl2upullc5pymo2@quack3>
References: <9CDF7393-5645-4E8A-9D68-01CF7F4C4955@amazon.com>
 <20220714135231.aull3vo44yfa6azg@quack3>
 <0CC0FCE1-F8A2-4966-B848-AD2D9DF9A713@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0CC0FCE1-F8A2-4966-B848-AD2D9DF9A713@amazon.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 15-07-22 01:00:01, Kiselev, Oleg wrote:
> >> @@ -1624,7 +1624,8 @@ static int ext4_setup_next_flex_gd(struct super_block *sb,
> >> 
> >>      o_blocks_count = ext4_blocks_count(es);
> >> 
> >> -     if (o_blocks_count == n_blocks_count)
> >> +     if ((o_blocks_count == n_blocks_count) ||
> >> +         ((n_blocks_count - o_blocks_count) < sbi->s_cluster_ratio))
> >>              return 0;
> > 
> > So why do you silently do nothing with unaligned size? I'd expect we should
> > catch this condition already in ext4_resize_fs() and return EINVAL in that
> > case...
> 
> Failing a resize with an error will be an unexpected behavior that will
> break software that calls resize2fs without specifying the size.  We ran
> into this issue because we make our filesystems on top of DRBD devices,
> and DRBD aligns its metadata on 4K boundaries.  This results in space
> available for the filesystem having an “odd” size.  Our preference is for
> the utilities to silently fix the fs size down to the nearest “safe” size
> rather than get sporadic errors.   I had submitted a patch for resize2fs
> that rounds the fs target size down to the nearest cluster boundary.  In
> principle it’s similar to the size-rounding that is done now for 4K
> blocks.   Using updated e2fsprogs isn’t mandatory for using ext4 in the
> newer kernels, so making the kernel safe(r) for bigalloc resizes seems
> like a good idea.

I see. Honestly, doing automatic "fixups" of passed arguments to syscalls /
ioctls has bitten us more than once in the past. That's why I'm cautious
about that. It seems convenient initially but then when contraints change
(e.g. you'd want to be rounding to a different number) you suddently find
you have no way to extend the API without breaking some userspace. That's
why I prefer to put these "rounding convenience" functions into userspace.

That being said I don't feel too strongly about this particular case so I
guess I'll defer the final decision about the policy to Ted.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
