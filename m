Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5E2475A58
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Dec 2021 15:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbhLOOMy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Dec 2021 09:12:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243206AbhLOOMx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Dec 2021 09:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639577571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8F8rhWm3cAZvDLz8+C4c0NNLwqP6rp57iJ8wx1AiHaU=;
        b=WZwpqBd/5ocaK/TBxThP9KhxKloQODzhIDw+9GmQM9caIQB7uDFKtE6NvidotE2NhFJGjB
        BJbx7A/USKgL5q8TsjlAzPl1CSbN6jZJFIFpdQ6z9VYUV1LfHprofOx5nFutr5JH2f6G67
        KQz33P5Wod4jSDHKMxiJZj6bxZUM26E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-lCtA5eQ3MQ6Qv3LL93mSWQ-1; Wed, 15 Dec 2021 09:12:45 -0500
X-MC-Unique: lCtA5eQ3MQ6Qv3LL93mSWQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A5E3801AC5;
        Wed, 15 Dec 2021 14:12:44 +0000 (UTC)
Received: from work (unknown [10.40.195.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E35BA5FC22;
        Wed, 15 Dec 2021 14:12:41 +0000 (UTC)
Date:   Wed, 15 Dec 2021 15:12:37 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        =?utf-8?B?THXDrXM=?= Henriques <lhenriques@suse.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
Subject: Re: [PATCH v2] ext4: set csum seed in tmp inode while migrating to
 extents
Message-ID: <20211215141237.lrymhbebgjunh4n2@work>
References: <20211214175058.19511-1-lhenriques@suse.de>
 <20211215004945.GD69182@magnolia>
 <20211215112852.GM14044@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211215112852.GM14044@quack2.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 15, 2021 at 12:28:52PM +0100, Jan Kara wrote:
> On Tue 14-12-21 16:49:45, Darrick J. Wong wrote:
> > On Tue, Dec 14, 2021 at 05:50:58PM +0000, Luís Henriques wrote:
> > > When migrating to extents, the temporary inode will have it's own checksum
> > > seed.  This means that, when swapping the inodes data, the inode checksums
> > > will be incorrect.
> > > 
> > > This can be fixed by recalculating the extents checksums again.  Or simply
> > > by copying the seed into the temporary inode.
> > > 
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=213357
> > > Reported-by: Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
> > > Signed-off-by: Luís Henriques <lhenriques@suse.de>
> > > ---
> > >  fs/ext4/migrate.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > changes since v1:
> > > 
> > > * Dropped tmp_ei variable
> > > * ->i_csum_seed is now initialised immediately after tmp_inode is created
> > > * New comment about the seed initialization and stating that recovery
> > >   needs to be fixed.
> > > 
> > > Cheers,
> > > --
> > > Luís
> > > 
> > > diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> > > index 7e0b4f81c6c0..36dfc88ce05b 100644
> > > --- a/fs/ext4/migrate.c
> > > +++ b/fs/ext4/migrate.c
> > > @@ -459,6 +459,17 @@ int ext4_ext_migrate(struct inode *inode)
> > >  		ext4_journal_stop(handle);
> > >  		goto out_unlock;
> > >  	}
> > > +	/*
> > > +	 * Use the correct seed for checksum (i.e. the seed from 'inode').  This
> > > +	 * is so that the metadata blocks will have the correct checksum after
> > > +	 * the migration.
> > > +	 *
> > > +	 * Note however that, if a crash occurs during the migration process,
> > > +	 * the recovery process is broken because the tmp_inode checksums will
> > > +	 * be wrong and the orphans cleanup will fail.
> > 
> > ...and then what does the user do?
> 
> Run fsck of course! And then recover from backups :) I know this is sad but
> the situation is that our migration code just is not crash-safe (if we
> crash we are going to free blocks that are still used by the migrated
> inode) and Luis makes it work in case we do not crash (which should be
> hopefully more common) and documents it does not work in case we crash.
> So overall I'd call it a win.
> 
> But maybe we should just remove this online-migration functionality
> completely from the kernel? That would be also a fine solution for me. I
> was thinking whether we could somehow make the inode migration crash-safe
> but I didn't think of anything which would not require on-disk format
> change...

Since this is not something that anyone can honestly recommend doing
without a prior backup and a word of warning I personaly would be in favor
of removing it.

-Lukas

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

