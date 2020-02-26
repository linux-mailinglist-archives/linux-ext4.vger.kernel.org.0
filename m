Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6DB416FEBF
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2020 13:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgBZMQv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Feb 2020 07:16:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:35546 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgBZMQv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 26 Feb 2020 07:16:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BF2BAAF8E;
        Wed, 26 Feb 2020 12:16:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1B73B1E0EA2; Wed, 26 Feb 2020 13:16:49 +0100 (CET)
Date:   Wed, 26 Feb 2020 13:16:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH v2] ext2: Silence lockdep warning about reclaim under
 xattr_sem
Message-ID: <20200226121649.GK10728@quack2.suse.cz>
References: <20200225120803.7901-1-jack@suse.cz>
 <20200226113219.16F065205A@d06av21.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226113219.16F065205A@d06av21.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 26-02-20 17:02:18, Ritesh Harjani wrote:
> 
> 
> On 2/25/20 5:38 PM, Jan Kara wrote:
> > Lockdep complains about a chain:
> >    sb_internal#2 --> &ei->xattr_sem#2 --> fs_reclaim
> > 
> > and shrink_dentry_list -> ext2_evict_inode -> ext2_xattr_delete_inode ->
> > down_write(ei->xattr_sem) creating a locking cycle in the reclaim path.
> > This is however a false positive because when we are in
> > ext2_evict_inode() we are the only holder of the inode reference and
> > nobody else should touch xattr_sem of that inode. So we cannot ever
> > block on acquiring the xattr_sem in the reclaim path.
> > 
> > Silence the lockdep warning by using down_write_trylock() in
> > ext2_xattr_delete_inode() to not create false locking dependency.
> > 
> > Reported-by: "J. R. Okajima" <hooanon05g@gmail.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Agreed with evict() will only be called when it's the last reference going
> down and so we won't be blocked on xattr_sem.
> Thanks for clearly explaining the problem in the cover letter.
> 
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Thanks for review! I've now pushed the patch to my tree.

								Honza
> 
> 
> > ---
> >   fs/ext2/xattr.c | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > Changes since v1:
> > - changed WARN_ON to WARN_ON_ONCE
> > 
> > diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> > index 0456bc990b5e..9ad07c7ef0b3 100644
> > --- a/fs/ext2/xattr.c
> > +++ b/fs/ext2/xattr.c
> > @@ -790,7 +790,15 @@ ext2_xattr_delete_inode(struct inode *inode)
> >   	struct buffer_head *bh = NULL;
> >   	struct ext2_sb_info *sbi = EXT2_SB(inode->i_sb);
> > 
> > -	down_write(&EXT2_I(inode)->xattr_sem);
> > +	/*
> > +	 * We are the only ones holding inode reference. The xattr_sem should
> > +	 * better be unlocked! We could as well just not acquire xattr_sem at
> > +	 * all but this makes the code more futureproof. OTOH we need trylock
> > +	 * here to avoid false-positive warning from lockdep about reclaim
> > +	 * circular dependency.
> > +	 */
> > +	if (WARN_ON_ONCE(!down_write_trylock(&EXT2_I(inode)->xattr_sem)))
> > +		return;
> >   	if (!EXT2_I(inode)->i_file_acl)
> >   		goto cleanup;
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
