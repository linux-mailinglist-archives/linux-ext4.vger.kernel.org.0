Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC4B47262A
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Dec 2021 10:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhLMJtU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Dec 2021 04:49:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235689AbhLMJpH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 13 Dec 2021 04:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639388705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AMrz+ag1Xxdq2bh1L6GJlRVB89sgPl3amSCYA2q3OCU=;
        b=TGQDCgfR2jgU0Lr6bJQTk7eDSMzTrHp3ZnWNj0W88So/KBec7jZ2uL6HEeEpPEo8bgqBb3
        0cqNHWArFTw9xvZwJdSUUtiErFlsBoxd/CjWUi/krUR0u/DEO83s4UDhBsD+pcr/6ovETW
        7+7VWPxnF4yAt4/K0wFRGrk/XcWKKCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-BKcmxoQxPTyRKIwdGxVI1Q-1; Mon, 13 Dec 2021 04:45:01 -0500
X-MC-Unique: BKcmxoQxPTyRKIwdGxVI1Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D60AA64083;
        Mon, 13 Dec 2021 09:45:00 +0000 (UTC)
Received: from work (unknown [10.40.193.245])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D482226E8;
        Mon, 13 Dec 2021 09:44:59 +0000 (UTC)
Date:   Mon, 13 Dec 2021 10:44:50 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3] ext4: implement support for get/set fs label
Message-ID: <20211213094450.uzu3fhojhwkmtxrk@work>
References: <20211112082019.22078-1-lczerner@redhat.com>
 <20211210151624.36414-1-lczerner@redhat.com>
 <20211210152220.5scsal2r6smfvrey@work>
 <YbPdKWBn9gnYjRYZ@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbPdKWBn9gnYjRYZ@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 10, 2021 at 06:05:13PM -0500, Theodore Y. Ts'o wrote:
> On Fri, Dec 10, 2021 at 04:22:20PM +0100, Lukas Czerner wrote:
> > 
> > There are couple of places in ext4 where we change superblock using
> > journal; set features, generate s_encrypt_pw_salt, modify s_last_orphan,
> > s_last_mounted and there is also ext4_update_super() in
> > flush_stashed_error_work().  Also all the wild things done in resize.c.
> > 
> > I think we should consolidate all or most of those under a single helper
> > and I was thiking about how to go about it cleanly.
> 
> There are some changes which I think need to be restricted to only the
> primary superblock.  This includes updates to s_last_orphan,

Yes. I agree. It was never my intention to suggest that we have to
update backup superblocks with every primary superblock update.

> s_last_mounted, and flushing error information by
> flush_stashed_error_work().  The last is because if we've found some
> kind of file system corruption, the problem might have been in a
> corrupted superblock.  So we don't necessary want to mess with the
> backup superblocks, since that might propagate the problem to all of
> the backup superblocks.  And s_last_orphan, s_last_mounted, are
> updated all the time, and they should only be updating the primary
> superblock because (a) the performance impacts if we need to update
> multiple sueprblocks, and (b) one of the ways we can avoid backup
> superblocks from being corrupted is to avoid updating them.

Hmm that's a good point. What't I've done in v3 is to just copy the data
from primary to secondary superblock location without even bothering to
read the backup superblock, but it really looks like it's not desirable.

> 
> So we should only be updating backup superblocks when we *have* to,
> because we're updating something fundamental about the file system
> metadata --- such as the size of the file system, when we're doing an
> online resize --- or we're changing the UUID, or the Label, etc.  BTW,
> updating features is something that we generally avoid in new kernel
> code; we've done it in the past, but it's better for the system
> adminsirator to explicitly needs to enable a feature, as opposed to
> having the kernel updating the feature when we create a huge file, for
> example.

Agreed.

> 
> > We could play games with modifying s_es directly, which just points
> > into s_sbh. And rely on the fact that it's read only once so we
> > maybe should be able to modify it and then do the journal dance
> > afterwards? I don't know if that's even allowed, but it sounds weird
> > to me.
> 
> Well, that's how we do things today when we update the primary
> superblock, and I think that's the right thing to do thing.  We need
> to modify s_sbh->b_data in any case so that the journalling works
> correctly in any case.

What I had in mind was more along the lines of:

 * update primary superblock

 * call jbd2_journal_get_write_access() on s_sbh
 * update the superblock checksum
 * call ext4_handle_dirty_metadata on s_sbh

All that in order to disassociate the small piece of code changing the
superblock data from the journalling and commiting code that is always
the same. My idea was to replace the chunk of code in all places where
we change the primary superblock using journal (not talking about backup
superblock here at all, that's a separate issue) with

 * update primary superblock, say for example:
       sbi->s_es->s_last_orphan = cpu_to_le32(inode->i_ino);
 * call sync_primary_superblock() function to jourhal and commit s_sbh

And for that I though that we would need a separate sb structure from
s_es so that we avoid changing s_sbh before calling
jbd2_journal_get_write_access() on it. But maybe I am overthinking it.

> 
> For the backup superblocks, for the ones which we are updating as part
> of the transaction, we need to do it via a their bh using the jbd2
> updating protocol.  What I have in mind is to pass into the "update
> superblock" function a callback function which actually modifies the
> appropriate primary or backup superblock.  So there would be a
> callback function that updates s_uuid, or s_volume_name, etc.
> 
> So the updating_superblock function would do the following:
> 
>    * get a handle that updates 3 blocks (the primary and two backups)
>    * call jbd2_journal_get_write_access() on s_bh
>    * call callback function to update primary superblock (s_bh)
>    * update the superblock checksum
>    * call ext4_handle_dirty_metadata on s_bh
>    * For the first two backup superblocks
>       - get a bh for the backup superblock
>       - if the bh is not buffer_verified, check the checksum on
>         the backup superblock, and if it is not valid, call
> 	ext4_error() indicating that the backup superblock is invalid,
> 	and skip updating it.
>      - get write access on the bh for the backup superblock
>      - call the callback funnction to update the backup superblock
>      - call ext4_handle_dirty_metadata
>    * call jbd2_journal_stop(handle)
> 
> Does this make sense to you?

That's pretty much what is done in v3 of the patch, except I just copy
the data from primary superblock to backup superblock which I now agree
is not ideal for reasons you already highlighted above. I'll change that
so that ext4_update_backup_sb() also accepts the callback function.

> 
> > One disadvantage might be that on-disk modification from userspace on
> > mounted file systems will not work anymore, since it will always be
> > overwriten by the in-kernel in-memory representation.
> 
> Well, eventually I'd like to deprecate, and perhaps outright disallow
> on-disk modification from userspace.  But we need to create ioctls
> that can do everything tune2fs can validly do on a mounted file
> system, and then wait to make sure the newer version e2fsprogs has
> been installed everywhere that where a user might try to install an
> updated kernel before we can change the kernel to disallow direct
> updates to the ext4 superblock.
> 
> Given that users may be installing random upstream kernel on a RHEL or
> SLES system, and they may be doing that without updating e2fsprogs
> first, anything which breaks current versions of e2fsprogs is going to
> cause a huge amount of pain when a platinum customer calls either Red
> Hat or Google Cloud's support personnel, and you and I won't want to
> get dragged into a support call with an irate customer with a huge
> cloud or RHEL spend and where the customer relationship exec is trying
> very hard to keep the customer happy.... 
> 
> So out of sheer self defense, it's going to be a while before we can
> deprecate direct modification of the superblock by programs like
> tune2fs.  As in, probably 8 to 10 years.  :-/

Sigh... Yeah, we're stuck with having to keep in mind that userspace could
be changing the superblock right under our hands.

Thanks!
-Lukas

> 
> 						- Ted
> 

