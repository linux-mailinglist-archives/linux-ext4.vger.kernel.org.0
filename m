Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48F14757BF
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Dec 2021 12:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbhLOL2z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Dec 2021 06:28:55 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45390 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhLOL2z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Dec 2021 06:28:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3AB9D1F386;
        Wed, 15 Dec 2021 11:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639567734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQ2mT8sPongM7OSvFwi+xpew7h++uNyqWwdreNcBJIQ=;
        b=LXj7bgvmEJrHsiGANpI9hKCD3AWX69dVbuHs1V6b4PIj104RaTmErHgt7687fduUUC4tfr
        EX9BrZF6x5R172WhCGVYAhBKWiZhfzBQShoGtZ0hI/MSx6jWooJSCOKLxk1xVCct6nozWy
        gdiCG0H9pWYkCUxkNXXo8K1n/4JSWdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639567734;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQ2mT8sPongM7OSvFwi+xpew7h++uNyqWwdreNcBJIQ=;
        b=5elwOpG733ifsWdMWQ3gdi8sfV3fAlh7CFIDYuPFYkjhRrTn5gFT7DdxXnxpuT+egFnxkK
        ME4u8gxQ04/KK2BA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 22B50A3B83;
        Wed, 15 Dec 2021 11:28:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E81DD1F2C94; Wed, 15 Dec 2021 12:28:52 +0100 (CET)
Date:   Wed, 15 Dec 2021 12:28:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
Subject: Re: [PATCH v2] ext4: set csum seed in tmp inode while migrating to
 extents
Message-ID: <20211215112852.GM14044@quack2.suse.cz>
References: <20211214175058.19511-1-lhenriques@suse.de>
 <20211215004945.GD69182@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211215004945.GD69182@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 14-12-21 16:49:45, Darrick J. Wong wrote:
> On Tue, Dec 14, 2021 at 05:50:58PM +0000, Luís Henriques wrote:
> > When migrating to extents, the temporary inode will have it's own checksum
> > seed.  This means that, when swapping the inodes data, the inode checksums
> > will be incorrect.
> > 
> > This can be fixed by recalculating the extents checksums again.  Or simply
> > by copying the seed into the temporary inode.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=213357
> > Reported-by: Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
> > Signed-off-by: Luís Henriques <lhenriques@suse.de>
> > ---
> >  fs/ext4/migrate.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > changes since v1:
> > 
> > * Dropped tmp_ei variable
> > * ->i_csum_seed is now initialised immediately after tmp_inode is created
> > * New comment about the seed initialization and stating that recovery
> >   needs to be fixed.
> > 
> > Cheers,
> > --
> > Luís
> > 
> > diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> > index 7e0b4f81c6c0..36dfc88ce05b 100644
> > --- a/fs/ext4/migrate.c
> > +++ b/fs/ext4/migrate.c
> > @@ -459,6 +459,17 @@ int ext4_ext_migrate(struct inode *inode)
> >  		ext4_journal_stop(handle);
> >  		goto out_unlock;
> >  	}
> > +	/*
> > +	 * Use the correct seed for checksum (i.e. the seed from 'inode').  This
> > +	 * is so that the metadata blocks will have the correct checksum after
> > +	 * the migration.
> > +	 *
> > +	 * Note however that, if a crash occurs during the migration process,
> > +	 * the recovery process is broken because the tmp_inode checksums will
> > +	 * be wrong and the orphans cleanup will fail.
> 
> ...and then what does the user do?

Run fsck of course! And then recover from backups :) I know this is sad but
the situation is that our migration code just is not crash-safe (if we
crash we are going to free blocks that are still used by the migrated
inode) and Luis makes it work in case we do not crash (which should be
hopefully more common) and documents it does not work in case we crash.
So overall I'd call it a win.

But maybe we should just remove this online-migration functionality
completely from the kernel? That would be also a fine solution for me. I
was thinking whether we could somehow make the inode migration crash-safe
but I didn't think of anything which would not require on-disk format
change...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
