Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70AF462ACB
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Nov 2021 04:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhK3DDd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Nov 2021 22:03:33 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51239 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229996AbhK3DDc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Nov 2021 22:03:32 -0500
Received: from callcc.thunk.org (c-24-1-67-28.hsd1.il.comcast.net [24.1.67.28])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1AU309sl009458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 22:00:09 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B2E4942004A; Mon, 29 Nov 2021 22:00:08 -0500 (EST)
Date:   Mon, 29 Nov 2021 22:00:08 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4: implement support for get/set fs label
Message-ID: <YaWTuCoIyaDBsUWF@mit.edu>
References: <20211111215904.21237-1-lczerner@redhat.com>
 <20211112082019.22078-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112082019.22078-1-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 12, 2021 at 09:20:19AM +0100, Lukas Czerner wrote:
> +	/* Update backup superblocks */
> +	ngroups = ext4_get_groups_count(sb);
> +	for (grp = 0; grp < ngroups; grp++) {
> +
		...
> +		ret = ext4_journal_ensure_credits_fn(handle, 1,
> +						     EXT4_MAX_TRANS_DATA,
> +						     0, 0);
> +		if (ret < 0)
> +			break;

This doesn't look right.  This will try to make sure there is at least
one credit left on the handle, and if there isn't it will attempt to
add EXT4_MAX_TRANS_DATA to the handle --- and if there isn't enough
room remaining in the journal to add that number of credits, no
credits will be added, and ext4_journal_ensure_credits_fn() will
return a positive integer (in our current implementation it will
always return 1).

So once run out of credits, and there is no more room in the journal,
we we will proceed, and when we try to modify the backup superblock, a
WARN_ON will be triggered and ext4_handle_dirty_metadata() will
trigger an ext4_error(), which would be unfortunate.

I'd also point out that for very large file systems, I'm not convinced
that we need to atomically update all of the backup superblocks at the
same time.  Sure, probably makes sense to update the primary, and
superblocks for block groups 0 and 1 atomically (or s_backup_bgs[0,1]
a sparse_super2 file system) using the journal.

But after that?  I'd suggest not running the updates for the rest
through the journal at all, and just write them out directly.  Nothing
else will try to read or write the backup superblock blocks, so
there's no reason why we have to be super careful writing out the
rest.  If we crash after we've only updated the first 20 backup
superblocks --- that's probably 18 more than a user will actually use
in the first place.

That allows us to simply reserve 3 credits, and we won't need to try
to extend the handle, which means we don't have to implement some kind
of fallback logic in case the handle extension fails.


One other comment.  Eventually (and not so in the distant future)
we're going to want to use the same superblock updating logic to
handle changing the UUID, and possibly, for other tune2fs operations.
The reason for this is that there are some people who are trying to
update the UUID and resize the file system to fit the size of the
cloud block device (e.g., either an Amazon EBS or GCE's PD) in
separate systemd unit scripts.  This results in race conditions that
can cause either the tune2fs or resize2fs to fail --- rarely, but if
you are starting up thousands and thousands of VM's per day, even the
rare becomes common place.  This is the reason of e2fsprogs commit
6338a8467564 ("libext2fs: retry reading superblock on open when
checksum is bad") but that turns out not to be enough; although it
does reduce the incidence rate by another order of magnitude or two.

So....  we should probably have a mutex which prevents two ioctls
which is modifying the superblock from running at the same time.  It's
*probably* going to be OK for now, since the second ioctl racing to
update the superblock will update the checksum, and so long as we have
journalling enabled, we shouldn't have a bad checksum end up on disk.
But we're going to want to add an ioctl to fetch the superblock, and
at that point we'll definitely need the mutex to protect the
superblock getter from getting an inconsistent view of the superblock.

The other thing that might be nice would be if the superblock update
function was abstracted out, and the FS_IOC_SETLABEL ioctl provided a
callback function which updates the label.

Neither of these two suggestions are strictly necessary for your patch
series (although the mutex will prevent problems with racing
FS_IOC_SETLABEL and FS_IOC_GETLABEL ioctls), so if you don't want to
make these changes now, I'm not going to insist on them; we can
always make these improvements when we implement FS_IOC_SETUUID,
FS_IOC_GETUUID, and EXT4_IOC_GET_SB.  (BTW, I believe Darrick has
patches to implement FS_IOC_[SG]ETUUID for xfs and possibly some other
file systems, IIRC, but those have never been landed in Linus's tree.)

And finally, thanks for working on FS_IOC_SETLABEL!  It has been on my
todo list for a long time, but it's never managed to make the top of
the priority queue...

Cheers,

     	      	    	      	   	      = Ted
