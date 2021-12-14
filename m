Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F68474875
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Dec 2021 17:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhLNQqm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Dec 2021 11:46:42 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49412 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhLNQqm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Dec 2021 11:46:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 375651F37C;
        Tue, 14 Dec 2021 16:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639500401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Krx9ujt9U+CXGnLAv7z/kYbX8eg3fh5j6WLUs21e2BQ=;
        b=R0DHQZA1hHW46jQPA5cyJ2mLrcj+9Gy8UcsF1azHs0BUAPxfW6uMFz+C0Xtc7XGzFvblAb
        voSDvmRXJC+onqYGnxgaycPJZQxbojanWSV8YCEx1dI30MpkBHqhfWMjJajElt+SxElQbk
        l6Gp6HW4QsZB1fTzRu7JG/7YSNQWBzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639500401;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Krx9ujt9U+CXGnLAv7z/kYbX8eg3fh5j6WLUs21e2BQ=;
        b=B8epb+tPC1YiOqb6J3L/qYNvRQTEqjWJcE/pr+z+3mwzE0LYI0AeBCN7Qf785QQRfX0+Kq
        QOVKr+7o2kvDIQBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA64F13A1D;
        Tue, 14 Dec 2021 16:46:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G39XLXDKuGFDDQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 14 Dec 2021 16:46:40 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 8d974c9e;
        Tue, 14 Dec 2021 16:46:38 +0000 (UTC)
Date:   Tue, 14 Dec 2021 16:46:38 +0000
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
Subject: Re: [PATCH] ext4: set csum seed in tmp inode while migrating to
 extents
Message-ID: <YbjKbqsVdK3LzKMm@suse.de>
References: <bug-213357-13602@https.bugzilla.kernel.org>
 <20211206143733.18918-1-lhenriques@suse.de>
 <20211214120317.GA5503@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211214120317.GA5503@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 14, 2021 at 01:03:17PM +0100, Jan Kara wrote:
> On Mon 06-12-21 14:37:33, Luís Henriques wrote:
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
> 
> Thanks for debugging this! Two comments below:

And thanks for the review!

> > diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> > index 7e0b4f81c6c0..dd4ece38fc83 100644
> > --- a/fs/ext4/migrate.c
> > +++ b/fs/ext4/migrate.c
> > @@ -413,7 +413,7 @@ int ext4_ext_migrate(struct inode *inode)
> >  	handle_t *handle;
> >  	int retval = 0, i;
> >  	__le32 *i_data;
> > -	struct ext4_inode_info *ei;
> > +	struct ext4_inode_info *ei, *tmp_ei;
> 
> Probably no need for the new tmp_ei variable when you use it only once...

Sure, I'll drop that new variable in v2.

> > @@ -503,6 +503,10 @@ int ext4_ext_migrate(struct inode *inode)
> >  	}
> >  
> >  	ei = EXT4_I(inode);
> > +	tmp_ei = EXT4_I(tmp_inode);
> > +	/* Use the right seed for checksumming */
> > +	tmp_ei->i_csum_seed = ei->i_csum_seed;
> > +
> 
> I think this is subtly broken in another way: If we crash in the middle of
> migration, tmp_inode (and possibly attached extent tree blocks) will have
> wrong checksums (remember that i_csum_seed is computed from inode number)
> and so orphan cleanup will fail. On the other hand in that case the orphan
> cleanup will free blocks we have already managed to attach to the tmp_inode
> although they are still properly attached to the old 'inode'. So the
> recovery from a crash in the middle of the migration seems to be broken
> anyway. So I guess what you do is an improvement. But can you perhaps:
> 
> 1) Move i_csum_seed initialization to a bit earlier in ext4_ext_migrate()
> just after we have got the tmp_inode from  ext4_new_inode()? That way all
> inode writes will at least happen with the same csum.
> 
> 2) Add a comment you are updating the csum seed so that metadata blocks get
> proper checksum for 'inode' and that recovery from a crash in the middle of
> migration is currently broken.

Obviously, I did not realize the recovery process was broken and I
appreciate you took the time to explain _how_ it is broken.  I'll add a
new item to (the bottom of) my to-do list and maybe one of these days I
get to look into it.

I'll send out v2 shortly, implementing your suggestions.

Cheers,
--
Luís

> 
> Thanks!
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
