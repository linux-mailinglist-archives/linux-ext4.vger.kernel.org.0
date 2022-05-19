Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE6852CF6A
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 11:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiESJai (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 05:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbiESJai (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 05:30:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C4565433
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 02:30:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 88FEF1F7AB;
        Thu, 19 May 2022 09:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652952635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gHbaY6tIsNDYgJWhKmav75WX1PotvGxbms3PV/NyZCQ=;
        b=HGBaGQTSr0i7WxPOa6ZbE8S4ypYpbSDYZ9HRGRRACWFW58KfEoKpG2bTAK0TrY+0qLNOYA
        tsJG8IjhjMgWzKBhq3fMEekwKp34mzIJlzO1SD+RuxUgun+Pf7oII1sK0Yj5BUnyO9NjMK
        08ZiSt5SaQpJKlnI2cM87j8QybMGndg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652952635;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gHbaY6tIsNDYgJWhKmav75WX1PotvGxbms3PV/NyZCQ=;
        b=/WhOPcqdBpJ30pNVBqIB1y/voEoImgykJuQk3t/HpYG8VrhMfa6cgXGSk9R6XisW3Vm6xf
        uQEmVbM0gnEwEODA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 780242C15D;
        Thu, 19 May 2022 09:30:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 10ED8A062F; Thu, 19 May 2022 11:30:35 +0200 (CEST)
Date:   Thu, 19 May 2022 11:30:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: fix warning when submitting superblock in
 ext4_commit_super()
Message-ID: <20220519093035.2kazqodrv4nqauwf@quack3.lan>
References: <20220518141020.2432652-1-yi.zhang@huawei.com>
 <20220518170617.vooz4ycfe73xsszx@riteshh-domain>
 <94e7b5f7-54c8-d04a-3a3a-31768b630862@huawei.com>
 <20220519062929.i52y2mwonnrbvr64@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519062929.i52y2mwonnrbvr64@riteshh-domain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 19-05-22 11:59:29, Ritesh Harjani wrote:
> On 22/05/19 11:13AM, Zhang Yi wrote:
> > On 2022/5/19 1:06, Ritesh Harjani wrote:
> > > On 22/05/18 10:10PM, Zhang Yi wrote:
> > >> We have already check the io_error and uptodate flag before submitting
> > >> the superblock buffer, and re-set the uptodate flag if it has been
> > >> failed to write out. But it was lockless and could be raced by another
> > >> ext4_commit_super(), and finally trigger '!uptodate' WARNING when
> > >> marking buffer dirty. Fix it by submit buffer directly.
> > >
> > > I agree that there could be a race with multiple processes trying to call
> > > ext4_commit_super(). Do you have a easy reproducer for this issue?
> > >
> >
> > Sorry, I don't have a easy reproducer, but we can always reproduce it through
> > inject delay and add filters into the ext4_commit_super().

...
 
> > > Also do you think something like below should fix the problem too?
> > > So if you lock the buffer from checking until marking the buffer dirty, that
> > > should avoid the race too that you are reporting.
> > > Thoughts?
> > >
> >
> > Thanks for your suggestion. I've thought about this solution and yes it's simpler
> > to fix the race, but I think we lock and unlock the sbh several times just for
> > calling standard buffer write helpers is not so good. Opencode the submit
> > procedure looks more clear to me.
> 
> I agree your solution was cleaner since it does not has a lot of lock/unlock.
> My suggestion came in from looking at the history.
> This lock was added here [1] and I think it somehow got removed in this patch[2]
> 
> [1]: https://lore.kernel.org/linux-ext4/1467285150-15977-2-git-send-email-pranjas@gmail.com/
> [2]: https://lore.kernel.org/linux-ext4/20201216101844.22917-5-jack@suse.cz/

So the reason why I've move unlock_buffer() into ext4_update_super() was
mostly so that the function does not return with buffer lock (which is an
odd calling convention) when I was adding another user of it
(flush_stashed_error_work()).

> Rather then solutions, I had few queries :)
> 1. What are the implications of not using
> mark_buffer_dirty()/__sync_dirty_buffer()

Not much. Using submit_bh() directly is fine. Just the duplication of the
checks is somewhat unpleasant.

> 2. In your solution one thing which I was not clear of, was whether we
> should call clear_buffer_dirty() before calling submit_bh(), in case if
> somehow(?) the state of the buffer was already marked dirty? Not sure how
> this can happen, but I see the logic in mark_buffer_dirty() which checks,
> if the buffer is already marked dirty, it simply returns. Then
> __sync_dirty_buffer() clears the buffer dirty state.

It could happen e.g. if there was journalled update of the superblock
before. I guess calling clear_buffer_dirty() before submit_bh() does no
harm.

Otherwise I like Yi's solution.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
