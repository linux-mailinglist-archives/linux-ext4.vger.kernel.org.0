Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE4F192C25
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Mar 2020 16:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgCYPVl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Mar 2020 11:21:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41732 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726838AbgCYPVl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Mar 2020 11:21:41 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02PFLDxG006021
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 11:21:14 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C131B420EBA; Wed, 25 Mar 2020 11:21:13 -0400 (EDT)
Date:   Wed, 25 Mar 2020 11:21:13 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] writeback: avoid double-writing the inode on a
 lazytime expiration
Message-ID: <20200325152113.GK53396@mit.edu>
References: <20200320024639.GH1067245@mit.edu>
 <20200320025255.1705972-1-tytso@mit.edu>
 <20200325092057.GA25483@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325092057.GA25483@infradead.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 25, 2020 at 02:20:57AM -0700, Christoph Hellwig wrote:
> >  	spin_unlock(&inode->i_lock);
> >  
> > -	if (dirty & I_DIRTY_TIME)
> > -		mark_inode_dirty_sync(inode);
> > +	/* This was a lazytime expiration; we need to tell the file system */
> > +	if (dirty & I_DIRTY_TIME_EXPIRED && inode->i_sb->s_op->dirty_inode)
> > +		inode->i_sb->s_op->dirty_inode(inode, I_DIRTY_SYNC);
> 
> I think this needs a very clear comment explaining why we don't go
> through __mark_inode_dirty.

I can take the explanation which is in the git commit description and
move it into the comment.

> But as said before I'd rather have a new lazytime_expired operation that
> makes it very clear what is happening.  We currenly have 4 file systems
> (ext4, f2fs, ubifs and xfs) that support lazytime, so this won't really
> be a major churn.

Again, I believe patch #2 does what you want; if it doesn't can you
explain why passing I_DIRTY_TIME_EXPIRED to s_op->dirty_inode() isn't
"a new lazytime expired operation that makes very clear what is
happening"?

I separated out patch #1 and patch #2 because patch #1 preserves
current behavior, and patch #2 modifies XFS code, which I don't want
to push Linus without an XFS reviewed-by.

N.b.  None of the other file systems required a change for patch #2,
so if you want, we can have the XFS tree carry patch #2, and/or
combine that with whatever other simplifying changes that you want.
Or I can combine patch #1 and patch #2, with an XFS Reviewed-by, and
send it through the ext4 tree.

What's your pleasure?

					- Ted

