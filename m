Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD06470E58
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Dec 2021 00:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344921AbhLJXIy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Dec 2021 18:08:54 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41945 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229685AbhLJXIx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Dec 2021 18:08:53 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-106.corp.google.com [104.133.8.106] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BAN5DsF020313
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 18:05:14 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2A5FA4205DB; Fri, 10 Dec 2021 18:05:13 -0500 (EST)
Date:   Fri, 10 Dec 2021 18:05:13 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3] ext4: implement support for get/set fs label
Message-ID: <YbPdKWBn9gnYjRYZ@mit.edu>
References: <20211112082019.22078-1-lczerner@redhat.com>
 <20211210151624.36414-1-lczerner@redhat.com>
 <20211210152220.5scsal2r6smfvrey@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210152220.5scsal2r6smfvrey@work>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 10, 2021 at 04:22:20PM +0100, Lukas Czerner wrote:
> 
> There are couple of places in ext4 where we change superblock using
> journal; set features, generate s_encrypt_pw_salt, modify s_last_orphan,
> s_last_mounted and there is also ext4_update_super() in
> flush_stashed_error_work().  Also all the wild things done in resize.c.
> 
> I think we should consolidate all or most of those under a single helper
> and I was thiking about how to go about it cleanly.

There are some changes which I think need to be restricted to only the
primary superblock.  This includes updates to s_last_orphan,
s_last_mounted, and flushing error information by
flush_stashed_error_work().  The last is because if we've found some
kind of file system corruption, the problem might have been in a
corrupted superblock.  So we don't necessary want to mess with the
backup superblocks, since that might propagate the problem to all of
the backup superblocks.  And s_last_orphan, s_last_mounted, are
updated all the time, and they should only be updating the primary
superblock because (a) the performance impacts if we need to update
multiple sueprblocks, and (b) one of the ways we can avoid backup
superblocks from being corrupted is to avoid updating them.

So we should only be updating backup superblocks when we *have* to,
because we're updating something fundamental about the file system
metadata --- such as the size of the file system, when we're doing an
online resize --- or we're changing the UUID, or the Label, etc.  BTW,
updating features is something that we generally avoid in new kernel
code; we've done it in the past, but it's better for the system
adminsirator to explicitly needs to enable a feature, as opposed to
having the kernel updating the feature when we create a huge file, for
example.

> We could play games with modifying s_es directly, which just points
> into s_sbh. And rely on the fact that it's read only once so we
> maybe should be able to modify it and then do the journal dance
> afterwards? I don't know if that's even allowed, but it sounds weird
> to me.

Well, that's how we do things today when we update the primary
superblock, and I think that's the right thing to do thing.  We need
to modify s_sbh->b_data in any case so that the journalling works
correctly in any case.

For the backup superblocks, for the ones which we are updating as part
of the transaction, we need to do it via a their bh using the jbd2
updating protocol.  What I have in mind is to pass into the "update
superblock" function a callback function which actually modifies the
appropriate primary or backup superblock.  So there would be a
callback function that updates s_uuid, or s_volume_name, etc.

So the updating_superblock function would do the following:

   * get a handle that updates 3 blocks (the primary and two backups)
   * call jbd2_journal_get_write_access() on s_bh
   * call callback function to update primary superblock (s_bh)
   * update the superblock checksum
   * call ext4_handle_dirty_metadata on s_bh
   * For the first two backup superblocks
      - get a bh for the backup superblock
      - if the bh is not buffer_verified, check the checksum on
        the backup superblock, and if it is not valid, call
	ext4_error() indicating that the backup superblock is invalid,
	and skip updating it.
     - get write access on the bh for the backup superblock
     - call the callback funnction to update the backup superblock
     - call ext4_handle_dirty_metadata
   * call jbd2_journal_stop(handle)

Does this make sense to you?

> One disadvantage might be that on-disk modification from userspace on
> mounted file systems will not work anymore, since it will always be
> overwriten by the in-kernel in-memory representation.

Well, eventually I'd like to deprecate, and perhaps outright disallow
on-disk modification from userspace.  But we need to create ioctls
that can do everything tune2fs can validly do on a mounted file
system, and then wait to make sure the newer version e2fsprogs has
been installed everywhere that where a user might try to install an
updated kernel before we can change the kernel to disallow direct
updates to the ext4 superblock.

Given that users may be installing random upstream kernel on a RHEL or
SLES system, and they may be doing that without updating e2fsprogs
first, anything which breaks current versions of e2fsprogs is going to
cause a huge amount of pain when a platinum customer calls either Red
Hat or Google Cloud's support personnel, and you and I won't want to
get dragged into a support call with an irate customer with a huge
cloud or RHEL spend and where the customer relationship exec is trying
very hard to keep the customer happy.... 

So out of sheer self defense, it's going to be a while before we can
deprecate direct modification of the superblock by programs like
tune2fs.  As in, probably 8 to 10 years.  :-/

						- Ted
