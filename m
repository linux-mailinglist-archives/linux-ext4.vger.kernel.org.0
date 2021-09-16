Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB5F40D695
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Sep 2021 11:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbhIPJuC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Sep 2021 05:50:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48680 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhIPJuB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Sep 2021 05:50:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B63BE1FED1;
        Thu, 16 Sep 2021 09:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631785720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pA7YJEAb4eU2dh70GPHgOPoWUMmjwNSqzZseI4sFf3Q=;
        b=rNCM7SglVp5pn/tvVySqhQ2MN2nkpxOxpM95XaF0H4GhM0fEVPANTjsyi86x8Gkzij1j5Q
        Ge7TBXJq0gggcO2X8XpVQOuUec4AdNaYvvvITdKju5fGbEiyDtqtnYe19Sv3/85m6WWdCb
        kYBK6DZRa53zE0X0v9TjCRr+Bo94swo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631785720;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pA7YJEAb4eU2dh70GPHgOPoWUMmjwNSqzZseI4sFf3Q=;
        b=y+Nd/T71nQ7SJxR4nIDBn0A8mvUzGtZIoDjGnVaHqe8UCKowY/yy/7FndKka91P/bI0ad3
        9XpYplPtewWxC1CA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 911A7A3B8C;
        Thu, 16 Sep 2021 09:48:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5EB561E0C04; Thu, 16 Sep 2021 11:48:36 +0200 (CEST)
Date:   Thu, 16 Sep 2021 11:48:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext2: do not sleep in ext2_error()
Message-ID: <20210916094836.GD10610@quack2.suse.cz>
References: <20210903090538.GA7283@kili>
 <YTIZpijSZc+ykNUY@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTIZpijSZc+ykNUY@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 03-09-21 08:48:38, Theodore Ts'o wrote:
> On Fri, Sep 03, 2021 at 12:05:38PM +0300, Dan Carpenter wrote:
> > No one expects error logging functions to sleep so sometimes they are
> > called with spinlocks held.  In this case the problematic call tree is:
> > 
> > ext2_statfs() <- disables preempt
> > -> ext2_count_free_inodes()
> >    -> ext2_get_group_desc()
> >       -> ext2_error()
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > This is just from static analysis.  NOT TESTED!
> > 
> > Probably a safer fix would be to just call pr_err() instead of
> > ext2_error() in ext2_get_group_desc().  I can send that fix instead if
> > people want.
> 
> Looking at both of the ext2_error() calls in ext2_get_group_desc(),
> those are really more in the way of assertions rather than warning of
> an on-disk corruption issue.  The second "group descriptor not loaded"
> should never happen, and the "block_group >= groups_count" should have
> been caught via an invalid block number or check by the caller (or an
> outright code bug in say ext2_statfs().
> 
> So I suspect both of those would be more usefule as a WARN() rather
> than a call to ext2_error(), since stack trace would actually provide
> more useful data to root causing the issue.  Jan, what do you think?

Yes, I agree. Definitely better than not flushing error on other
ext2_error() calls. BTW, Dan, I don't see a patch with WARN() in my inbox.
Did it get lost somewhere?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
