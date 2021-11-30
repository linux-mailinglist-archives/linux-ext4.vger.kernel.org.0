Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EF3463040
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Nov 2021 10:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240599AbhK3Jxm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Nov 2021 04:53:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240643AbhK3JxQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 30 Nov 2021 04:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638265797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EOasfDOdVDQ8zMIq5l7EtG2AtJ6syjRwqqrBeYbgB9I=;
        b=TfnzGwj97shGi/o4i5mcJo3GcF0ceqummnhUhdhms3hUqABR+V+AxAixGTycqBXFbwegXW
        b6ZipPbmRyNdb5x6EHpiWZ6kURVeseumAjs+i9Tq1Xvy61XPEw3fGPX/GfaLUCVlKwgmTU
        DnuqWxZmFA7XP5NV+EU5rWQ+VNbXw6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-mMUSVXsAOfiIzMxP_eLxXA-1; Tue, 30 Nov 2021 04:49:56 -0500
X-MC-Unique: mMUSVXsAOfiIzMxP_eLxXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03C3384B9A9;
        Tue, 30 Nov 2021 09:49:55 +0000 (UTC)
Received: from work (unknown [10.40.194.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4664460C0F;
        Tue, 30 Nov 2021 09:49:54 +0000 (UTC)
Date:   Tue, 30 Nov 2021 10:49:50 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4: implement support for get/set fs label
Message-ID: <20211130094950.ixqkxrjne6ldryeg@work>
References: <20211111215904.21237-1-lczerner@redhat.com>
 <20211112082019.22078-1-lczerner@redhat.com>
 <YaWTuCoIyaDBsUWF@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaWTuCoIyaDBsUWF@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 29, 2021 at 10:00:08PM -0500, Theodore Y. Ts'o wrote:
> On Fri, Nov 12, 2021 at 09:20:19AM +0100, Lukas Czerner wrote:
> > +	/* Update backup superblocks */
> > +	ngroups = ext4_get_groups_count(sb);
> > +	for (grp = 0; grp < ngroups; grp++) {
> > +
> 		...
> > +		ret = ext4_journal_ensure_credits_fn(handle, 1,
> > +						     EXT4_MAX_TRANS_DATA,
> > +						     0, 0);
> > +		if (ret < 0)
> > +			break;
> 
> This doesn't look right.  This will try to make sure there is at least
> one credit left on the handle, and if there isn't it will attempt to
> add EXT4_MAX_TRANS_DATA to the handle --- and if there isn't enough
> room remaining in the journal to add that number of credits, no
> credits will be added, and ext4_journal_ensure_credits_fn() will
> return a positive integer (in our current implementation it will
> always return 1).

Oops, I was sure I've seen this somewhere in the code, but I guess I was
wrong. Should have checked what it actually returns. Thanks for pointing
this out.

> 
> So once run out of credits, and there is no more room in the journal,
> we we will proceed, and when we try to modify the backup superblock, a
> WARN_ON will be triggered and ext4_handle_dirty_metadata() will
> trigger an ext4_error(), which would be unfortunate.
> 
> I'd also point out that for very large file systems, I'm not convinced
> that we need to atomically update all of the backup superblocks at the
> same time.  Sure, probably makes sense to update the primary, and
> superblocks for block groups 0 and 1 atomically (or s_backup_bgs[0,1]
> a sparse_super2 file system) using the journal.
> 
> But after that?  I'd suggest not running the updates for the rest
> through the journal at all, and just write them out directly.  Nothing
> else will try to read or write the backup superblock blocks, so
> there's no reason why we have to be super careful writing out the
> rest.  If we crash after we've only updated the first 20 backup
> superblocks --- that's probably 18 more than a user will actually use
> in the first place.
> 
> That allows us to simply reserve 3 credits, and we won't need to try
> to extend the handle, which means we don't have to implement some kind
> of fallback logic in case the handle extension fails.

I think I agree. But in this case should we at least attempt to check
and update the backup superblocks in fsck? Not sure if we do that
already.

> 
> 
> One other comment.  Eventually (and not so in the distant future)
> we're going to want to use the same superblock updating logic to
> handle changing the UUID, and possibly, for other tune2fs operations.
> The reason for this is that there are some people who are trying to
> update the UUID and resize the file system to fit the size of the
> cloud block device (e.g., either an Amazon EBS or GCE's PD) in
> separate systemd unit scripts.  This results in race conditions that
> can cause either the tune2fs or resize2fs to fail --- rarely, but if
> you are starting up thousands and thousands of VM's per day, even the
> rare becomes common place.  This is the reason of e2fsprogs commit
> 6338a8467564 ("libext2fs: retry reading superblock on open when
> checksum is bad") but that turns out not to be enough; although it
> does reduce the incidence rate by another order of magnitude or two.
> 
> So....  we should probably have a mutex which prevents two ioctls
> which is modifying the superblock from running at the same time.  It's
> *probably* going to be OK for now, since the second ioctl racing to
> update the superblock will update the checksum, and so long as we have
> journalling enabled, we shouldn't have a bad checksum end up on disk.
> But we're going to want to add an ioctl to fetch the superblock, and
> at that point we'll definitely need the mutex to protect the
> superblock getter from getting an inconsistent view of the superblock.
> 
> The other thing that might be nice would be if the superblock update
> function was abstracted out, and the FS_IOC_SETLABEL ioctl provided a
> callback function which updates the label.
> 
> Neither of these two suggestions are strictly necessary for your patch
> series (although the mutex will prevent problems with racing
> FS_IOC_SETLABEL and FS_IOC_GETLABEL ioctls), so if you don't want to
> make these changes now, I'm not going to insist on them; we can
> always make these improvements when we implement FS_IOC_SETUUID,
> FS_IOC_GETUUID, and EXT4_IOC_GET_SB.  (BTW, I believe Darrick has
> patches to implement FS_IOC_[SG]ETUUID for xfs and possibly some other
> file systems, IIRC, but those have never been landed in Linus's tree.)

It's not a critical functionality so it can wait. I'll think about
implementing the superblock modification system. Thanks for the useful
pointers.

> 
> And finally, thanks for working on FS_IOC_SETLABEL!  It has been on my
> todo list for a long time, but it's never managed to make the top of
> the priority queue...

No problem, I am happy to help.

-Lukas

> 
> Cheers,
> 
>      	      	    	      	   	      = Ted
> 

