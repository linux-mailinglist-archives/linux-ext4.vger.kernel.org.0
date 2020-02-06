Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9DF9154177
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2020 10:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgBFJ7W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Feb 2020 04:59:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:53454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgBFJ7W (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 6 Feb 2020 04:59:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7DE49AC6B;
        Thu,  6 Feb 2020 09:59:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5486B1E0E31; Thu,  6 Feb 2020 10:59:19 +0100 (CET)
Date:   Thu, 6 Feb 2020 10:59:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/3] e2fsck: Clarify overflow link count error message
Message-ID: <20200206095919.GH14001@quack2.suse.cz>
References: <20200205100138.30053-1-jack@suse.cz>
 <20200205100138.30053-2-jack@suse.cz>
 <23FB58CC-BE93-4602-8B1C-9DA06FAE0F1A@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23FB58CC-BE93-4602-8B1C-9DA06FAE0F1A@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 05-02-20 10:38:04, Andreas Dilger wrote:
> On Feb 5, 2020, at 3:01 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > When directory link count is set to overflow value (1) but during pass 4
> > we find out the exact link count would fit, we either silently fix this
> > (which is not great because e2fsck then reports the fs was modified but
> > output doesn't indicate why in any way), or we report that link count is
> > wrong and ask whether we should fix it (in case -n option was
> > specified). The second case is even more misleading because it suggests
> > non-trivial fs corruption which then gets silently fixed on the next
> > run. Similarly to how we fix up other non-problems, just create a new
> > error message for the case directory link count is not overflown anymore
> > and always report it to clarify what is going on.
> > 
> > 
> > diff --git a/e2fsck/problem.c b/e2fsck/problem.c
> > index c7c0ba986006..cde369d03034 100644
> > --- a/e2fsck/problem.c
> > +++ b/e2fsck/problem.c
> > @@ -2035,6 +2035,11 @@ static struct e2fsck_problem problem_table[] = {
> > 	  N_("@d exceeds max links, but no DIR_NLINK feature in @S.\n"),
> > 	  PROMPT_FIX, 0, 0, 0, 0 },
> > 
> > +	/* Directory ref count set to overflow but it doesn't have to be */
> 
> > +	{ PR_4_DIR_OVERFLOW_REF_COUNT,
> > +	  N_("@d @i %i ref count set to overflow value %Il but could be exact value %N.  "),
> 
> IMHO, you don't need to print "value %Il" since that will always be "1"?
> That would shorten the message to fit on a single line.

Yeah, will change.

> Also, lease keep the comment and the actual error message identical.
> Otherwise, it is harder to find the PR_* number and the related code in
> e2fsck when trying to debug a problem.  So the comment should be:
> 
> 	/* Directory inode ref count set to overflow but could be exact value */

Sure, thanks for catching this.

> To be honest, I don't see the benefit of the @d, @i, etc. abbreviations
> in the messages anymore.  The few bytes of space savings is IMHO outweighed
> by the added complexity in understanding and finding the messages in the
> code, and added complexity in e2fsck itself when printing the messages.

I tend to agree but I was never bothered enough to try to change that.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
