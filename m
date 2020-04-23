Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6699F1B69F2
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 01:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgDWXhQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 19:37:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55783 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgDWXhP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Apr 2020 19:37:15 -0400
Received: from mail-qv1-f69.google.com ([209.85.219.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1jRlP5-0003ox-Rl
        for linux-ext4@vger.kernel.org; Thu, 23 Apr 2020 23:37:11 +0000
Received: by mail-qv1-f69.google.com with SMTP id u17so7855772qvi.9
        for <linux-ext4@vger.kernel.org>; Thu, 23 Apr 2020 16:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKGH2NB06VnzAq5VREHs1hV1dskXKO+xymT4lPZeT1Q=;
        b=nPC9EvGnI/3DaEjo8FuSwTlCp5n0Js9Bw3i+qujvDnRaWX1/e5Z661xzeHAP+eAq1M
         mku474mGWGtMeZk5jI0LKhX+gt1+9oxpQ+8v9gEIK+Dtf/E02V+cvLEE86zt1OECm3CD
         zKt4x47bwwH71mRU5lp82UUhlj6RfP2Ug9ugHIujgsxcqHHZidCXWeFkdHyPsWopZeDS
         ayGbmFkuLmuF9nu2HZaNi1Fx59CizGRmwF5unVVmqBAvnkmEcV8UNhuUrPGFt3BF+KFb
         bO1ts7bBSO9MGs5E81yc2kDg8uD4YYaCk2nnZsWpMO4a2G8R/w6n16pXKFtBQ4+QA5R1
         fFVQ==
X-Gm-Message-State: AGi0Pua4EPKa4YHCfpYv92j4pskHeUpWwye5GebbnAFOJMWzgVhf+StY
        2A4JE9fdmYtJc71zpHyzb9JRW8+ONqyq/XuTwPXw0nquHUSldjnPpC1Z4fXshTA+E/B6gmUErhq
        zCuVVRwFx1iwUr8etz84WwL+4CJtkczvrlHy9egM=
X-Received: by 2002:a37:6d2:: with SMTP id 201mr6350443qkg.154.1587685030612;
        Thu, 23 Apr 2020 16:37:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypJfI/3n7ZjxkUevPELEMo3hHsFagWnbi3XGeEDdU5fkADnskrMkFQhUVHVnUSAFd6Ij7Y7L4w==
X-Received: by 2002:a37:6d2:: with SMTP id 201mr6350422qkg.154.1587685030131;
        Thu, 23 Apr 2020 16:37:10 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id j14sm2529171qkk.92.2020.04.23.16.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 16:37:09 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     dann frazier <dann.frazier@canonical.com>,
        Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.com>
Subject: [RFC PATCH 00/11] ext4: data=journal: writeback mmap'ed pagecache
Date:   Thu, 23 Apr 2020 20:36:54 -0300
Message-Id: <20200423233705.5878-1-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ted Ts'o explains, in the linux-ext4 thread [1], that currently
data=journal + journal_checksum + mmap is not handled correctly,
and outlines the changes to fix it (+ items/breaks for clarity):

    """
    The fix is going to have to involve
    - fixing __ext4_journalled_writepage() to call set_page_writeback()
      before it unlocks the page,
    - adding a list of pages under data=journalled writeback
      which is attached to the transaction handle,
    - have the jbd2 commit hook call end_page_writeback()
      on all of these pages,
    - and then in the places where ext4 calls wait_for_stable_page()
      or grab_cache_page_write_begin(), we need to add:
    
    	if (ext4_should_journal_data(inode))
    		wait_on_page_writeback(page);
    
    It's all relatively straightforward except for the part
    where we have to attach a list of pages to the currently
    running transaction.  That will require adding some
    plumbing into the jbd2 layer.
    """

This is my first adventure into ext4, and after enough struggle
(and try harder!) with the first deadlock described in PATCH 02,
and address it to find the other deadlock (also described there),
and address it, I guess it wasn't that straighforward (for me :)
but absolutely very good learning!

(Granted, I now understand that the fix outlined is indeed the
way it is supposed to work and done in general, weren't it for
the need to unlock_page() before ext4_journal_start(), as that
compromised the base of writeback patterns as far as I learned.
Hope I didn't get that too wrong.)


Summary:
-------

The patchset is a bit long with 11 patches, but I tried to get
changes tiny to help with review, and better document how each
of them work, why and how this or that is done.  It's RFC as I
would like to ask for suggestions/feedback, if at all possible.

Patch 01 and 02 implement the outlined fix, with a few changes
(fix first deadlock; use existing plumbing in jbd2 as the list.)

Patch 03 fix a seconds-delay on msync().

Patch 04 introduces helpers to handle the second deadlock.

Patch 05-11 handle the second deadlock (three of these patches,
namely 07, 09 and 10 are changes not specific for data=journal,
affecting other journaling modes, so it's not on their subject.)

The order of the patches intentionally allow the issues on 03
and 05-11 to occur (while putting the core patches first), so
to allow issues to be reproduced/regression tested one by one,
as needed.  It can be changed, of course, so to enable actual
writeback changes in the last patch (when issues are patched.)


Testing:
-------

This has been built and regression tested on next-20200417.
(Also rebased and build tested on next-20200423 / "today").

On xfstests (commit b2faf204) quick group (and excluding
generic 430/431/434 which always hung): no regressions w/
data=ordered (default) nor data=journal,journal_checksum.

With data=ordered: (on both original and patched kernel)

    Failures: generic/223 generic/465 generic/553 generic/554 generic/565 generic/570

With data=journal,journal_checksum: (likewise)

    Failures: ext4/044 generic/223 generic/441 generic/553 generic/554 generic/565 generic/570

The test-case for the problem (and deadlocks) and further
stress testing is stress-ng (with 512 workers on 16 vCPUs)

    $ sudo mount -o data=journal,journal_checksum $DEV $MNT
    $ cd $MNT 
    $ sudo stress-ng --mmap 512 --mmap-file --timeout 1w

To reproduce the problem (without patchset), run it a bit
and crash the kernel (to cause unclean shutdown) w/ sysrq,
and mount the device again (it should fail / need e2fsck):

Original:

    [   27.660063] JBD2: Invalid checksum recovering data block 79449 in log
    [   27.792371] JBD2: recovery failed
    [   27.792854] EXT4-fs (vdc): error loading journal
    mount: /tmp/ext4: can't read superblock on /dev/vdc.

Patched:

    [  33.111230] EXT4-fs (vdc): 512 orphan inodes deleted
    [  33.111961] EXT4-fs (vdc): recovery complete
    [  33.114590] EXT4-fs (vdc): mounted filesystem with journalled data mode. Opts: data=journal,journal_checksum


RFC / Questions:
---------------

0) Usage of ext4_inode_info.i_datasync_tid for checks

We rely on the struct ext4_inode_info.i_datasync_tid field
(set by __ext4_journalled_writepage() and others) to check
it against the running transaction. Of course, other sites
set it too, and it might be that some of our checks return
false positives then (should be fine, just less efficient.)

To avoid such false positives, we could add another field
to that structure, exclusively for this, but that is more
8 bytes (pointer) for inodes and even on non-data=journal
cases.. so it didn't seem good enough reason, but if that
is better/worth it for efficiency reasons (speed, in this
case, vs. memory consumption) we could do it.

Maybe there are other ideas/better ways to do it?

1) Usage of ext4_force_commit() in ext4_writepages()

Patch 03 describes/fixes an issue where the underlying problem is,
if __ext4_journalled_writepage() does set_page_writeback() but no
journal commit is triggered, wait_on_page_writeback() may wait up
to seconds until the periodic journal commit happens.

The solution there, to fix the impact on msync(), is to just call
ext4_force_commit() (as it's done anyway in ext4_sync_file()), on
ext4_writepages().

Is that a good enough solution?  Other ideas?

2) Similar issue (unhandled) in ext4_writepage()

The other, related question is, what about direct callers of
ext4_writepage() that obviously do not use ext4_writepages() ?
(e.g., pageout() and writeout(); write_one_page() not used.)

Those are memory-cleasing writeback, which should not wait,
however, as mentioned in that patch, if its writeback goes
on for seconds and an data-integrity writeback/system call
comes in, it is delayed/wait_on_page_writeback() that long.

So, ideally, we should be trying to kick a journal commit?

It looks like ext4_handle_sync() is not the answer, since
it waits for commit to finish, and pageout() is called on
a list of pages by shrinking.  So, not effective to block
on each one of them.

We might not want to start anything right now, actually,
since the memory-cleasing writeback can be happening on
memory pressure scenarios, right?  But would need to do
something, to ensure that future wait_on_page_writeback()
do not wait too long.

Maybe the answer is something similar to jbd2 sync transaction
batching (used by ext4_handle_sync()), but in *async* fashion,
say, possibly implemented/batching in the jbd2 worker thread.
Is that reasonable?

...

Any comments/feedback/reviews are very appreciated.

Thank you in advance,
Mauricio

[1] https://lore.kernel.org/linux-ext4/20190830012236.GC10779@mit.edu/

Mauricio Faria de Oliveira (11):
  ext4: data=journal: introduce struct/kmem_cache
    ext4_journalled_wb_page/_cachep
  ext4: data=journal: handle page writeback in
    __ext4_journalled_writepage()
  ext4: data=journal: call ext4_force_commit() in ext4_writepages() for
    msync()
  ext4: data=journal: introduce helpers for journalled writeback
    deadlock
  ext4: data=journal: prevent journalled writeback deadlock in
    __ext4_journalled_writepage()
  ext4: data=journal: prevent journalled writeback deadlock in
    ext4_write_begin()
  ext4: grab page before starting transaction handle in
    ext4_convert_inline_data_to_extent()
  ext4: data=journal: prevent journalled writeback deadlock in
    ext4_convert_inline_data_to_extent()
  ext4: grab page before starting transaction handle in
    ext4_try_to_write_inline_data()
  ext4: deduplicate code with error legs in
    ext4_try_to_write_inline_data()
  ext4: data=journal: prevent journalled writeback deadlock in
    ext4_try_to_write_inline_data()

 fs/ext4/ext4_jbd2.h |  88 +++++++++++++++++++++++++
 fs/ext4/inline.c    | 153 +++++++++++++++++++++++++++++++-------------
 fs/ext4/inode.c     | 137 +++++++++++++++++++++++++++++++++++++--
 fs/ext4/page-io.c   |  11 ++++
 4 files changed, 341 insertions(+), 48 deletions(-)

-- 
2.20.1

