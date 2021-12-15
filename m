Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8F14756CE
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Dec 2021 11:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241745AbhLOKqh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Dec 2021 05:46:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49412 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbhLOKqe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Dec 2021 05:46:34 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 06DA4212C5;
        Wed, 15 Dec 2021 10:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639565193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bpoF3w2sXkbd6DeH6yzXYffX71F0PbtZ17ZhiKaTL1A=;
        b=T5hEYRXAuV3tmkgiVCAVlo9qs6mjd0yEu2vyWic6Y5P36iZE4WN2QP//h3r3VfS+m5B3dX
        U3qtSHY/lVmkqiiKfy7++cVd4RaF1cBs7f6mC0GTU/kUTpFrUxO9Imcpk/7lI4gV/YXxie
        QxWxHYohePFDkZUTW4NOnxKQO/q809c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639565193;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bpoF3w2sXkbd6DeH6yzXYffX71F0PbtZ17ZhiKaTL1A=;
        b=xDRQ9ovsUNp+te6fodoIjq6DtoyGUfvZBMOvBl+2c7OHrVAXfn7h49GeVSOV1TWN1TKgcR
        GsIlrtMfmTYbFoAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 845DC13B1C;
        Wed, 15 Dec 2021 10:46:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +fE+HYjHuWH8egAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 15 Dec 2021 10:46:32 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 71b77ca0;
        Wed, 15 Dec 2021 10:46:30 +0000 (UTC)
Date:   Wed, 15 Dec 2021 10:46:30 +0000
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
Subject: Re: [PATCH v2] ext4: set csum seed in tmp inode while migrating to
 extents
Message-ID: <YbnHhgYgcrA8KrwB@suse.de>
References: <20211214175058.19511-1-lhenriques@suse.de>
 <20211215004945.GD69182@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211215004945.GD69182@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 14, 2021 at 04:49:45PM -0800, Darrick J. Wong wrote:
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

I can't really say I know what is the right thing for a user to do.  But
my understanding is that my patch doesn't change a lot: the recovery
process would still fail in a slightly different way, and will need to be
fixed at some point.

I believe the userspace tools already have support to handle orphan file,
but a quick look at the latest version of the patchset show that these
tools can't handle this either, and the recovery will also fail.  But I
may be wrong.

Cheers,
--
Luís

> 
> --D
> 
> > +	 */
> > +	ei = EXT4_I(inode);
> > +	EXT4_I(tmp_inode)->i_csum_seed = ei->i_csum_seed;
> >  	i_size_write(tmp_inode, i_size_read(inode));
> >  	/*
> >  	 * Set the i_nlink to zero so it will be deleted later
> > @@ -502,7 +513,6 @@ int ext4_ext_migrate(struct inode *inode)
> >  		goto out_tmp_inode;
> >  	}
> >  
> > -	ei = EXT4_I(inode);
> >  	i_data = ei->i_data;
> >  	memset(&lb, 0, sizeof(lb));
> >  
