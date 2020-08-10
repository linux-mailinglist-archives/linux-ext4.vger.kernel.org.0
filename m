Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEA524009F
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Aug 2020 03:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgHJBCX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 9 Aug 2020 21:02:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36762 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgHJBCW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 9 Aug 2020 21:02:22 -0400
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1k4wCf-0006zi-6N
        for linux-ext4@vger.kernel.org; Mon, 10 Aug 2020 01:02:17 +0000
Received: by mail-qt1-f197.google.com with SMTP id z20so6448495qti.21
        for <linux-ext4@vger.kernel.org>; Sun, 09 Aug 2020 18:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VqgCHk38H4pqdYz3hVCIDZW+GBFrMFTawre1Otx0GcI=;
        b=ATrV/86mcnYF+1NMmTbmNWD8uYE8a4yc/Q7WFMbeTGq7tFCNGk+deIz/bL9V2l+nCL
         JudCWKH4m9fnicEKAhBcNTI4y1SrOb9bJ/8vEsBcqbrWq2KvA6QCQwCCBJzEPBHV2poE
         lQolHif6OsIXVixT2ooKYmOlfN7wBDMnn7RzoSwSL8FH7rWdm9gJfZ5QEqV/xR+Vu0XF
         7RU8rkrvBi4gbhMqvyPbCLfrDa5oaGlE8NkbDsk5h1JFQ2H1NPZSlRiVYvXGPqnxjGlh
         O6ywM5hgbIQM2tH1z5pr8Ekri1bLZW0fk59PYhUTXaNQcqBP3sSX9JeUt3hv2gTfL0hH
         frgA==
X-Gm-Message-State: AOAM533Q7uxxibT9bshciXfal+kWy4+5+GlVL4n90vtiHQivvunA4/U1
        FJ8ptIScsdWC7VaH7gTXz1+wT68C/p/tjxWkVmWQ1bwbS4RPX2NQZ6w5Xfl0r7UaFPHkKi+oHK/
        csr45jnE8y2BPLWyQHN7LRIaCsP8HyO+2Wp7EmL8=
X-Received: by 2002:a0c:d44e:: with SMTP id r14mr26036010qvh.105.1597021335040;
        Sun, 09 Aug 2020 18:02:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz09d6YjtfVtQ+59aDuCIc04SO+NC1F9X0z5gAZHVfYG3pCC+PP3nnkXsT+fmgg4QP72qmCXQ==
X-Received: by 2002:a0c:d44e:: with SMTP id r14mr26035947qvh.105.1597021334321;
        Sun, 09 Aug 2020 18:02:14 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id 95sm44815qtc.29.2020.08.09.18.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 18:02:13 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>,
        Jan Kara <jack@suse.com>
Subject: [RFC PATCH v2 0/5] ext4/jbd2: data=journal: write-protect pages on transaction commit
Date:   Sun,  9 Aug 2020 22:02:03 -0300
Message-Id: <20200810010210.3305322-1-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

Upfront, thanks again for taking the time about a month ago to provide
your understanding of this problem and suggestions on how to implement
this fix [1].

I'd like to ask for your comments on the patchset so far, and have a few questions.

First, there is a test case to reproduce the issue:

Essentially, it enlarges the race window during journal commit, between
buffer checksum calculation and commit to disk, for userspace to modify
mmap()ed buffers, then panic afterwards.  Later, journal recovery fails
due to invalid checksum.

Patch 1 is the kernel hack to allow it.
The last 2 files in the series are the a setup script to create/mount
a loopdev w/ ext4 data=journal filesystem, and the C test case for it.

Test is essentially:

    fd = open("file");
    addr = mmap(fd);
    pwrite(fd, "a", 1, 0);
    addr[0] = 'a';
    press_enter(); // when asked for.
    addr[0] = 'b';

Usage:

    $ gcc -o test test.c
    $ ./ext4.sh && cd /ext4 && ~/test

    Press enter to change buffer contents
    # wait for periodic journal commit
    [   26.286197] TESTCASE: Cookie found. Waiting 5 seconds for changes.
    # now press enter

    Buffer contents changed
    Press enter to change buffer contents
    # just wait
    [   31.370558] TESTCASE: Cookie eaten. Resumed.
    [   31.375906] Kernel panic - not syncing: TESTCASE: checksum changed; commit record done; panic!
    [   31.379799] CPU: 1 PID: 649 Comm: jbd2/loop0-8 Not tainted 5.8.0.mfo.1 #111
    ...
    [   31.400643] Rebooting in 5 seconds..

    $ ./ext4.sh mount
    ...
    + sudo mount -o data=journal /dev/loop0 /ext4
    [   27.334874] EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, and O_DIRECT support!
    [   27.339492] JBD2: Invalid checksum recovering data block 8705 in log
    [   27.342716] JBD2: recovery failed
    [   27.343316] EXT4-fs (loop0): error loading journal
    mount: /ext4: can't read superblock on /dev/loop0.


Second, this is a recap of your solution implementation suggestion [1], with line breaks added for clarity:

    """
    So I'd suggest a somewhat different solution.

    Instead of trying to mark, when page is under writeback, do it the other way around
    and make jbd2 kick ext4 on transaction commit to writeprotect journalled pages.

    Then, because of do_journal_get_write_access() in ext4_page_mkwrite() we are sure pages
    cannot be writeably mapped into page tables until transaction commit finishes
    (or we'll copy data to commit to b_frozen_data).

    Now let me explain a bit more the "make jbd2 kick ext4 on transaction
    commit to writeprotect journalled pages" part.

    I think we could mostly reuse the data=ordered machinery for that.

    data=ordered machinery tracks with each running transaction also a list of inodes
    for which we need to flush data pages before doing commit of metadata into the journal.

    Now we could use the same mechanism for data=journal mode -
    we'd track in the inode list inodes with writeably mapped pages
    and on transaction commit we need to writeprotect these pages using clear_page_dirty_for_io().

    Probably the best place to add inode to this list is ext4_journalled_writepage().

    To do the commit handling we probably need to introduce callbacks that jbd2 will call
    instead of journal_submit_inode_data_buffers() in journal_submit_data_buffers()
    and instead of filemap_fdatawait_range_keep_errors() in journal_finish_inode_data_buffers().

    In data=ordered mode ext4 will just do what jbd2 does in its callback,

    when inode's data should be journalled, the callback will
    use write_cache_pages() to iterate and writeprotect all dirty pages.

    The writepage callback just returns AOP_WRITEPAGE_ACTIVATE,

    some care needs to be taken to redirty a page in the writepage callback
     A) if not all its underlying buffers are part of the committing transaction
     B) or if some buffer already has b_next_transaction set
        (since in that case the page was already dirtied also against the following transaction).

    But it should all be reasonably doable.
    """

[1] https://lore.kernel.org/linux-ext4/20200610132139.GG12551@quack2.suse.cz/

If I understood it correctly:
- Patch 2 implements the callback mechanism.
- Patch 3 implements the write-protect code.
- Patch 4 has changes to ext4_page_mkwrite() discussed below.
- Patch 5 introduces debug messages for RFC discussion only.

Third, my changes/observations/questions:

1) > Probably the best place to add inode to this list is ext4_journalled_writepage().

I think we also need it in ext4_page_mkwrite(), right?  See the test case, for example:

    fd = open("file");
    addr = mmap(fd);
    pwrite(fd, "a", 1, 0);
    addr[0] = 'a';
    press_enter(); // when asked for.
    addr[0] = 'b';

Here pwrite() led to ext4_write_begin() which added the inode to a transaction (not to the transaction's inode list).

Now the jbd2 thread commits the transaction, before any writeback work or msync() call.
So __ext4_journalled_writepage() didn't get called; the page is still writeably mapped.

And it could be changed / problem reproduced with the test case.
Added some debug messages and line breaks for clarity:

    $ cd /ext4 && ~/test
    <...>
    [   20.668889] TESTDBG: ext4_write_begin() :: journal started: inode ffff8f72eda5fca8, txn ffff8f72f5ea0300
    [   20.670593] TESTDBG: do_get_write_access() :: entry for bh: ffff8f72edae2d68, offset: 0000, page ffffe50288a0a200, inode: ffff8f72eda5fca8
    [   20.672018] TESTDBG: ext4_journalled_write_end() :: journal stopped: inode ffff8f72eda5fca8

    [   20.673769] TESTDBG: ext4_page_mkwrite() :: entry for inode ffff8f72eda5fca8
    [   20.675016] TESTDBG: ext4_bh_tdbg() :: bh: ffff8f72edae2d68, data offset: 0000, page: ffffe50288a0a200, inode: ffff8f72eda5fca8
    [   20.677639] TESTDBG: ext4_page_mkwrite() :: returning; all buffers mapped for inode ffff8f72eda5fca8

    Press enter to change buffer contents
    [   26.250842] TESTDBG: journal_submit_data_buffers() :: entry for transaction: 0xffff8f72f5ea0300
    <...>
    [   26.283521] TESTDBG: jbd2_journal_write_metadata_buffer() :: copy out: done/need 0/0, bh: ffff8f72edae2d68, offset: 0000, page: ffffe50288a0a200, inode: ffff8f72eda5fca8
    [   26.286197] TESTCASE: Cookie found. Waiting 5 seconds for changes.
    # Press enter

    Buffer contents changed
    Press enter to change buffer contents
    [   31.370558] TESTCASE: Cookie eaten. Resumed.
    [   31.375906] Kernel panic - not syncing: TESTCASE: checksum changed; commit record done; panic!

So, we should have ext4_page_mkwrite() add the inode to the transaction's inode list to fix this case, IIUIC.


2) Do not return early in ext4_page_mkwrite() 'if we have all the buffers mapped'?

There's this check in ext4_page_mkwrite():

        /*
         * Return if we have all the buffers mapped. This avoids the need to do
         * journal_start/journal_stop which can block and take a long time
         */

Corresponding to this line in the debug messages:

    [   20.677639] TESTDBG: ext4_page_mkwrite() :: returning; all buffers mapped for inode ffff8f72eda5fca8

That returns early, *before* do_journal_get_write_access(), which is needed in data=journal,
regardless of whether all buffers are mapped: we could exit ext4_page_mkwrite() then change
buffers under commit during the race window.
    
So, it seems we should ignore that for data=journal, which allows us to ext4_journal_start()
and get a transaction handle, used to add the inode to the transaction's inode list (per #1.)

This is Patch 6.

With the changes from 1) and 2), the inode is added to the transaction's inode list,
and the callback does write-protect the page correctly.

When trying to change the buffer contents later (pressing enter) there _is_ a wait in
ext4_page_mkwrite() as expected!  But it's first at the file_update_time() because it
calls do_get_write_access() for that inode, which is also in the transaction.

I presume that a commit can start after file_update_time() and before ext4_journal_start()
in ext4_page_mkwrite(), so we'd still have to keep these changes to ext4_page_mkwrite() ?

    $ cd /ext4 && ~/test
    <...>
    [  142.264078] TESTDBG: do_get_write_access() :: entry for bh: ffff98e12f35fa90, offset: 0000, page ffffd06548c1c400, inode: ffff98e136849118

    [  142.266110] TESTDBG: ext4_write_begin() :: journal started: inode ffff98e12f2c0508, txn ffff98e12f1ec200
    [  142.268063] TESTDBG: do_get_write_access() :: entry for bh: ffff98e12f35f6e8, offset: 0000, page ffffd06548ccc100, inode: ffff98e12f2c0508
    [  142.269728] TESTDBG: ext4_journalled_write_end() :: journal stopped: inode ffff98e12f2c0508

    [  142.271894] TESTDBG: ext4_page_mkwrite() :: entry for inode ffff98e12f2c0508
    [  142.273498] TESTDBG: ext4_bh_tdbg() :: bh: ffff98e12f35f6e8, data offset: 0000, page: ffffd06548ccc100, inode: ffff98e12f2c0508
    [  142.276779] TESTDBG: ext4_page_mkwrite() :: before djgwa(), for inode ffff98e12f2c0508
    [  142.276781] TESTDBG: ext4_page_mkwrite() :: after  djgwa(), for inode ffff98e12f2c0508
    [  142.278273] TESTDBG: ext4_page_mkwrite() :: Added inode to txn list: inode ffff98e12f2c0508, txn = ffff98e12f1ec200, err = 0    
    Press enter to change buffer contents
    # Waiting...
    [  148.140148] TESTDBG: journal_submit_data_buffers() :: entry for transaction: 0xffff98e12f1ec200
    [  148.145770] TESTDBG: journal_submit_data_buffers() :: txn list has inode ffff98e12f2c0508 (write data flag: 0x2)
    [  148.148453] TESTDBG: ext4_journalled_submit_inode_data_buffers() :: entry for inode: ffff98e12f2c0508
    [  148.148462] TESTDBG: ext4_journalled_writepage_callback() :: entry for bh ffff98e12f35f6e8, page ffffd06548ccc100, inode: ffff98e12f2c0508
    [  148.150920] TESTDBG: ext4_journalled_writepage_callback() :: redirty for bh ffff98e12f35f680, jh, 0000000000000000, txn 0000000000000000, next_txn 0000000000000000
    <...>
    [  148.168741] TESTDBG: jbd2_journal_write_metadata_buffer() :: copy out: done/need 0/0, bh: ffff98e12f35fa90, offset: 0000, page: ffffd06548c1c400, inode: ffff98e136849118
    [  148.170897] TESTDBG: jbd2_journal_write_metadata_buffer() :: copy out: done/need 0/0, bh: ffff98e12f35f6e8, offset: 0000, page: ffffd06548ccc100, inode: ffff98e12f2c0508
    [  148.173067] TESTCASE: Cookie found. Waiting 5 seconds for changes.
    # Press enter.
        
    [  149.553705] TESTDBG: ext4_page_mkwrite() :: entry for inode ffff98e12f2c0508
    [  149.553719] TESTDBG: do_get_write_access() :: entry for bh: ffff98e132905d00, offset: 0000, page ffffd06548c7f580, inode: ffff98e136849118
    [  153.259932] TESTCASE: Cookie eaten. Resumed.
    # Note that dgwa() above waited the 5 seconds to move on, but for another inode (ext4_page_mkwrite() -> file_update_time()), not the file's inode

    [  153.264679] TESTDBG: ext4_journalled_finish_inode_data_buffers() :: entry for inode: ffff98e12f2c0508
    [  153.264885] TESTDBG: do_get_write_access() :: entry for bh: ffff98e132905d00, offset: 0000, page ffffd06548c7f580, inode: ffff98e136849118
    [  153.267647] TESTDBG: ext4_bh_tdbg() :: bh: ffff98e12f35f6e8, data offset: 0000, page: ffffd06548ccc100, inode: ffff98e12f2c0508
    [  153.275150] TESTDBG: ext4_page_mkwrite() :: before djgwa(), for inode ffff98e12f2c0508
    [  153.275153] TESTDBG: do_get_write_access() :: entry for bh: ffff98e12f35f6e8, offset: 0000, page ffffd06548ccc100, inode: ffff98e12f2c0508
    [  153.277669] TESTDBG: ext4_page_mkwrite() :: after  djgwa(), for inode ffff98e12f2c0508
    Buffer contents changed
    Press enter to change buffer contents
    [  153.280907] TESTDBG: ext4_page_mkwrite() :: Added inode to txn list: inode ffff98e12f2c0508, txn = ffff98e135db5d00, err = 0


3) When checking to redirty the page in the writepage callback,
   does a buffer without a journal head means we should redirty
   the page? (for the reason it's not part of the committing txn)

For example, in this case, the writepage callback is called,
checks the first buffer head is part of the committing txn,
but the next one has no journal head, so it's not part of any
transaction (including the committing txn, of course) so it
does redirty the page.

    [  148.148462] TESTDBG: ext4_journalled_writepage_callback() :: entry for bh ffff98e12f35f6e8, page ffffd06548ccc100, inode: ffff98e12f2c0508
    [  148.150920] TESTDBG: ext4_journalled_writepage_callback() :: redirty for bh ffff98e12f35f680, jh, 0000000000000000, txn 0000000000000000, next_txn 0000000000000000

4) Should we clear the PageChecked bit?

We don't clear the PageChecked bit, thus later when the writeback
work kicks in, __ext4_journalled_writepage() adds the page to the
transaction's inode list again.

Since the page is clean, it just goes into the submit data buffers
callback, but write_cache_pages() returns before the writepage callback.

Should we try to provent that by, say, clearing the pagechecked bit
in case we don't have to redirty the page (in the writepage callback) ?

5) Inodes with inline data.  I haven't checked in detail yet, but
would appreciate if you have a brief explanation about them, and
if they need special handling since they apparently don't get
do_journal_get_write_access() called (eg, see __ext4_journalled_writepage()).

Thank you very much,
Mauricio

Mauricio Faria de Oliveira (5):
  jbd2: test case for ext4 data=journal/mmap() journal corruption
  jbd2: introduce journal callbacks j_submit|finish_inode_data_buffers
  ext4: data=journal: write-protect pages on submit inode data buffers
    callback
  ext4: data=journal: add inode to transaction inode list in
    ext4_page_mkwrite()
  ext4/jbd2: debugging messages

 fs/ext4/inode.c       | 42 ++++++++++++++++++++++--
 fs/ext4/super.c       | 75 +++++++++++++++++++++++++++++++++++++++++++
 fs/jbd2/commit.c      | 55 ++++++++++++++++++++++++++++---
 fs/jbd2/journal.c     |  5 +++
 fs/jbd2/transaction.c |  4 +++
 include/linux/jbd2.h  | 21 +++++++++++-
 6 files changed, 194 insertions(+), 8 deletions(-)

-- 
2.17.1

