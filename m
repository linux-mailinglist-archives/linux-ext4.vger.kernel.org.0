Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7CE199560
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Mar 2020 13:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgCaLdO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Mar 2020 07:33:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58936 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730343AbgCaLdO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 31 Mar 2020 07:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585654392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vYKV3g5u6QrBWtoLixYpsXj+HpYi8PXarujv8zMJzPU=;
        b=H6ddPLKZODhtN+ak/kUP7aM8ns1eWDisi+HDGI01AsVcdmC2DVKgfauk8zKWgLZ8Z5YLRC
        Ds95P5OWwOwNl491d+9Tkw75V2mXmkHxqrXr2oyP3oqIsDcOXZcnecLWnLPUZUljA3pbpi
        +oT379e9wiVAYf11xdgJJGqDTxx+wbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-uWRMHmJBM76whNDBIR-9HA-1; Tue, 31 Mar 2020 07:33:10 -0400
X-MC-Unique: uWRMHmJBM76whNDBIR-9HA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A12113FD;
        Tue, 31 Mar 2020 11:33:09 +0000 (UTC)
Received: from work (unknown [10.40.192.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A70996B8E;
        Tue, 31 Mar 2020 11:33:07 +0000 (UTC)
Date:   Tue, 31 Mar 2020 13:33:03 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] ext2fs: Fix off-by-one in dx_grow_tree()
Message-ID: <20200331113303.huhzo3jxdnhoupwv@work>
References: <20200330090932.29445-1-jack@suse.cz>
 <20200330090932.29445-3-jack@suse.cz>
 <20200330132712.ckevhpof4vrsx5rw@work>
 <20200330145531.GF26544@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330145531.GF26544@quack2.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 30, 2020 at 04:55:31PM +0200, Jan Kara wrote:
> On Mon 30-03-20 15:27:12, Lukas Czerner wrote:
> > On Mon, Mar 30, 2020 at 11:09:32AM +0200, Jan Kara wrote:
> > > There is an off-by-one error in dx_grow_tree() when checking whether we
> > > can add another level to the tree. Thus we can grow tree too much
> > > leading to possible crashes in the library or corrupted filesystem. Fix
> > > the bug.
> > 
> > Looks good, thanks
> > 
> > Reviewed-by: Lukas Czerner <lczerner@redhat.com>
> > 
> > Don't we have basically the same off-by-one in
> > e2fsck/pass1.c handle_htree() ?
> > 
> >        if ((root->indirect_levels > ext2_dir_htree_level(fs)) &&
> >            fix_problem(ctx, PR_1_HTREE_DEPTH, pctx))
> 
> I don't think so. It is indeed correct for root->indirect_levels to be
> equal to ext2_dir_htree_level(). However dx_grow_tree() is going to
> increase root->indirect_levels by 1 which is where tree would become
> invalid...
> 
> 								Honza

Hmm, are you sure ? I think the names are very confusing

root->indirect_levels is zero based, while ext2_dir_htree_level()
returns the maximum number of levels (that is 3 by default). If I am
right then indirect_levels must always be smaller then
ext2_dir_htree_level() and that is how we use it everywhere else - the
palce I am pointing out is an exception and I think it's a bug.

Indeed it looks like the bug got introduced in
3f0cf647539970474be8f607017ca7eccfc2fbbe

-       if ((root->indirect_levels > 1) &&
+       if ((root->indirect_levels > ext2_dir_htree_level(fs)) &&

Or am I missing something ?

-Lukas

> 
> > > 
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  lib/ext2fs/link.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/lib/ext2fs/link.c b/lib/ext2fs/link.c
> > > index 7b5bb022117c..469eea8cd06d 100644
> > > --- a/lib/ext2fs/link.c
> > > +++ b/lib/ext2fs/link.c
> > > @@ -473,7 +473,7 @@ static errcode_t dx_grow_tree(ext2_filsys fs, ext2_ino_t dir,
> > >  		    ext2fs_le16_to_cpu(info->frames[i].head->limit))
> > >  			break;
> > >  	/* Need to grow tree depth? */
> > > -	if (i < 0 && info->levels > ext2_dir_htree_level(fs))
> > > +	if (i < 0 && info->levels >= ext2_dir_htree_level(fs))
> > >  		return EXT2_ET_DIR_NO_SPACE;
> > >  	lblk = size / fs->blocksize;
> > >  	size += fs->blocksize;
> > > -- 
> > > 2.16.4
> > > 
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

