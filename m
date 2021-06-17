Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2523AAEB1
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jun 2021 10:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFQI03 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Jun 2021 04:26:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59916 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhFQI0Z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Jun 2021 04:26:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 040121FDBF;
        Thu, 17 Jun 2021 08:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623918257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ocwISkwd2DoOrqaNFs+kdDGeb9ADhTOAAIoYlQbYlAk=;
        b=JxbkxeYSKr51yIjw5++Gn+yt6v+XU71ttapnEXpDmE8bfmBweJWVTdW4wzDLKStLWvOXc3
        zerKChQP5P7XOhyEE7mWUnXU7R4YhOmTu1tfxnTR29jJI9p648zOplkavKYK4t68URVRlp
        bHi8r0EihUpoa51yqDs8lbaeac9Xhqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623918257;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ocwISkwd2DoOrqaNFs+kdDGeb9ADhTOAAIoYlQbYlAk=;
        b=vX5CpxJIs9eqsbgqXiSJfXrxaV5oN74BMbJWPkwLzqtjLuOij0y/dRWswjyQpadlEVzbJ4
        6Tpl8cO8z64pR6Ag==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id EA0F9A3BB7;
        Thu, 17 Jun 2021 08:24:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CAEDA1F2C64; Thu, 17 Jun 2021 10:24:16 +0200 (CEST)
Date:   Thu, 17 Jun 2021 10:24:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/4] ext4: Support for checksumming from journal triggers
Message-ID: <20210617082416.GC32587@quack2.suse.cz>
References: <20210616105655.5129-1-jack@suse.cz>
 <20210616105655.5129-2-jack@suse.cz>
 <0DB920A0-26A5-4B76-B2E6-78B1B678072C@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0DB920A0-26A5-4B76-B2E6-78B1B678072C@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 16-06-21 13:56:30, Andreas Dilger wrote:
> On Jun 16, 2021, at 4:56 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > JBD2 layer support triggers which are called when journaling layer moves
> > buffer to a certain state. We can use the frozen trigger, which gets
> > called when buffer data is frozen and about to be written out to the
> > journal, to compute block checksums for some buffer types (similarly as
> > does ocfs2). This avoids unnecessary repeated recomputation of the
> > checksum (at the cost of larger window where memory corruption won't be
> > caught by checksumming) and is even necessary when there are
> > unsynchronized updaters of the checksummed data.
> > 
> > So add argument to ext4_journal_get_write_access() and
> > ext4_journal_get_create_access() which describes buffer type so that
> > triggers can be set accordingly. This patch is mostly only a change of
> > prototype of the above mentioned functions and a few small helpers. Real
> > checksumming will come later.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> 
> Comment inline.
> 
> > 
> > diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> > index be799040a415..f601e24b6015 100644
> > --- a/fs/ext4/ext4_jbd2.c
> > +++ b/fs/ext4/ext4_jbd2.c
> > @@ -229,11 +231,18 @@ int __ext4_journal_get_write_access(const char *where, unsigned int line,
> > 
> > 	if (ext4_handle_valid(handle)) {
> > 		err = jbd2_journal_get_write_access(handle, bh);
> > -		if (err)
> > +		if (err) {
> > 			ext4_journal_abort_handle(where, line, __func__, bh,
> > 						  handle, err);
> > +			return err;
> > +		}
> > 	}
> > -	return err;
> > +	if (trigger_type == EXT4_JTR_NONE || !ext4_has_metadata_csum(sb))
> > +		return 0;
> > +	WARN_ON_ONCE(trigger_type >= EXT4_JOURNAL_TRIGGER_COUNT);
> 
> I'm not sure WARN_ON_ONCE() is enough here.  This would essentially result
> in executing a random (or maybe NULL) function pointer later on.  Either
> trigger_type should be checked early and return an error, or this should
> be a BUG_ON() so that the crash happens here instead of in jbd context.

Good point, I'll fix that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
