Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F1D477021
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Dec 2021 12:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbhLPLXx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Dec 2021 06:23:53 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57346 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbhLPLXx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Dec 2021 06:23:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 341571F3A7;
        Thu, 16 Dec 2021 11:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639653832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yYm+R7cr4adPDWiFod+5aMGuNNtXVF82GGH15TvHfTU=;
        b=uo0y0/96VKYCjMRTI9tTf2QpkyU6o9tc/kLhfjDp5m1D58KCVVlAOxXs/lTQcfQVCmMgwP
        lLFAwKF/06f8RdPA5+/7MXLuC102m/4bsodSP4EYeT+1JWhwl0P7Ls6Ve0JvTljn92TJA3
        Lt2VEkoDzCrLPG2drkDv1tnWTl6Ham4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639653832;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yYm+R7cr4adPDWiFod+5aMGuNNtXVF82GGH15TvHfTU=;
        b=C17gmf9vGSVNz1QdvWkUTfBoJq+75pXJt7MzcpFoYgjnWeoWg1G/zr1u81ad28soGGpxK7
        KYSlm/9pGNReVNBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9663B13B4B;
        Thu, 16 Dec 2021 11:23:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +qKrIcchu2H/NwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 16 Dec 2021 11:23:51 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id fe209b2a;
        Thu, 16 Dec 2021 11:23:50 +0000 (UTC)
Date:   Thu, 16 Dec 2021 11:23:50 +0000
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
Subject: Re: [PATCH v2] ext4: set csum seed in tmp inode while migrating to
 extents
Message-ID: <YbshxgbAnt7rupQG@suse.de>
References: <20211214175058.19511-1-lhenriques@suse.de>
 <20211215004945.GD69182@magnolia>
 <20211215112852.GM14044@quack2.suse.cz>
 <20211215141237.lrymhbebgjunh4n2@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211215141237.lrymhbebgjunh4n2@work>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 15, 2021 at 03:12:37PM +0100, Lukas Czerner wrote:
> On Wed, Dec 15, 2021 at 12:28:52PM +0100, Jan Kara wrote:
> > On Tue 14-12-21 16:49:45, Darrick J. Wong wrote:
> > > On Tue, Dec 14, 2021 at 05:50:58PM +0000, Luís Henriques wrote:
> > > > When migrating to extents, the temporary inode will have it's own checksum
> > > > seed.  This means that, when swapping the inodes data, the inode checksums
> > > > will be incorrect.
> > > > 
> > > > This can be fixed by recalculating the extents checksums again.  Or simply
> > > > by copying the seed into the temporary inode.
> > > > 
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=213357
> > > > Reported-by: Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
> > > > Signed-off-by: Luís Henriques <lhenriques@suse.de>
> > > > ---
> > > >  fs/ext4/migrate.c | 12 +++++++++++-
> > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > > 
> > > > changes since v1:
> > > > 
> > > > * Dropped tmp_ei variable
> > > > * ->i_csum_seed is now initialised immediately after tmp_inode is created
> > > > * New comment about the seed initialization and stating that recovery
> > > >   needs to be fixed.
> > > > 
> > > > Cheers,
> > > > --
> > > > Luís
> > > > 
> > > > diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> > > > index 7e0b4f81c6c0..36dfc88ce05b 100644
> > > > --- a/fs/ext4/migrate.c
> > > > +++ b/fs/ext4/migrate.c
> > > > @@ -459,6 +459,17 @@ int ext4_ext_migrate(struct inode *inode)
> > > >  		ext4_journal_stop(handle);
> > > >  		goto out_unlock;
> > > >  	}
> > > > +	/*
> > > > +	 * Use the correct seed for checksum (i.e. the seed from 'inode').  This
> > > > +	 * is so that the metadata blocks will have the correct checksum after
> > > > +	 * the migration.
> > > > +	 *
> > > > +	 * Note however that, if a crash occurs during the migration process,
> > > > +	 * the recovery process is broken because the tmp_inode checksums will
> > > > +	 * be wrong and the orphans cleanup will fail.
> > > 
> > > ...and then what does the user do?
> > 
> > Run fsck of course! And then recover from backups :) I know this is sad but
> > the situation is that our migration code just is not crash-safe (if we
> > crash we are going to free blocks that are still used by the migrated
> > inode) and Luis makes it work in case we do not crash (which should be
> > hopefully more common) and documents it does not work in case we crash.
> > So overall I'd call it a win.
> > 
> > But maybe we should just remove this online-migration functionality
> > completely from the kernel? That would be also a fine solution for me. I
> > was thinking whether we could somehow make the inode migration crash-safe
> > but I didn't think of anything which would not require on-disk format
> > change...
> 
> Since this is not something that anyone can honestly recommend doing
> without a prior backup and a word of warning I personaly would be in favor
> of removing it.

BTW, in case migration is kept in the kernel (even with the broken
recovery), I think it's worth turning this bug reproducer into an ext4
fstest.  I was planning to do so, but I'd rather wait to see if the effort
is worthwhile (i.e. if migration is kept or not).

Cheers,
--
Luís
