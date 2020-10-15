Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAA728EF9F
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 11:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389014AbgJOJvw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 05:51:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:39118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388789AbgJOJvw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 15 Oct 2020 05:51:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AA9A7B138;
        Thu, 15 Oct 2020 09:51:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 698181E1338; Thu, 15 Oct 2020 11:51:51 +0200 (CEST)
Date:   Thu, 15 Oct 2020 11:51:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH] ext4: Detect already used quota file early
Message-ID: <20201015095151.GD7037@quack2.suse.cz>
References: <20201013132221.22725-1-jack@suse.cz>
 <43A89FE1-E2B2-4751-B79B-C99C3F15B1A8@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A89FE1-E2B2-4751-B79B-C99C3F15B1A8@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 15-10-20 01:33:24, Andreas Dilger wrote:
> On Oct 13, 2020, at 7:22 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > When we try to use file already used as a quota file again (for the same
> > or different quota type), strange things can happen. At the very least
> > lockdep annotations may be wrong but also inode flags may be wrongly set
> > / reset. When the file is used for two quota types at once we can even
> > corrupt the file and likely crash the kernel. Catch all these cases by
> > checking whether passed file is already used as quota file and bail
> > early in that case.
> > 
> > This fixes occasional generic/219 failure due to lockdep complaint.
> > 
> > Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Patch looks OK, but a minor question/suggestion below...
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index ea425b49b345..49b2e6be35c4 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -6042,6 +6042,11 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
> > 	/* Quotafile not on the same filesystem? */
> > 	if (path->dentry->d_sb != sb)
> > 		return -EXDEV;
> > +
> > +	/* Quota already enabled for this file? */
> > +	if (path->dentry->d_inode->i_flags & S_NOQUOTA)
> > +		return -EBUSY;
> 
> Any reason not to use IS_NOQUOTA(path->dentry->d_inode) here?  I was trying
> to see where S_NOQUOTA is set, and it seems that all of the quota code is
> using IS_NOQUOTA().

OK, right. I'll change that. Thanks for review.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
