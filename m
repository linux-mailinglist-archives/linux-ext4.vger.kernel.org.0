Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38A97128B81
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Dec 2019 21:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfLUU05 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Dec 2019 15:26:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49896 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfLUU05 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Dec 2019 15:26:57 -0500
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1iilKv-0007LX-UW
        for linux-ext4@vger.kernel.org; Sat, 21 Dec 2019 20:26:54 +0000
Received: by mail-pf1-f199.google.com with SMTP id p126so2943072pfb.9
        for <linux-ext4@vger.kernel.org>; Sat, 21 Dec 2019 12:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cZJnzCdSrrv2RZCPOARBmKGnM2pvfZNA8hg0rBoQYZE=;
        b=EAKVcgh0WxSUOI8DXHyv5EJioRl4Dil9cA219bIf/XH5A/FgLqwL3irvELJbgwGlf4
         2DWCBHRHI6NjYSQB5ewSfCiA1ZStSG5UUcQxZiJ27WbKPDXEd8hAqwM1V5GqJbrEfi4i
         KspIk8qZUF9nCfIgCwhHcdjpktC4PB2PB7TGRF+pL8CuNmKc1KP78Lspxr2IvnlWOcr3
         kLByp2d2eCYdJXug858lyFfNXhhaQ8IADjo+bcEg1ht0JO42cK1vTnjNbf+JIoCq7AsI
         a7B3HM0Om88Ro6wkCPrp2YlhDTOBR9BOZIUlf0X5u+YbAkJdumz9MgPNI7erme5srUgT
         6iog==
X-Gm-Message-State: APjAAAUXBJ1ru019dUKQAYC7vFnRrawZd2JZtj6wDlXDeOFfVJFiPI9n
        srcbQqQkYhkfexZ/IlC9xuKrpgRjLi92JRsJnt02SalfQ/Jm3DseRGb5L2Vc5a7nFdrAFnzjlXK
        BH6v/ejVxZB5C3re9ib34RtnkbedQdeKodmZU4RE=
X-Received: by 2002:a63:4f54:: with SMTP id p20mr22743169pgl.246.1576960012512;
        Sat, 21 Dec 2019 12:26:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxuEp+T7Cqq5onJlv+o4GBPq5BhZSFQwqLJg6qwlVGVxq29BNEn20G2y7SOH+ogJg0iiXo2qQ==
X-Received: by 2002:a63:4f54:: with SMTP id p20mr22743149pgl.246.1576960012125;
        Sat, 21 Dec 2019 12:26:52 -0800 (PST)
Received: from localhost.localdomain ([170.81.134.253])
        by smtp.gmail.com with ESMTPSA id r7sm18554467pfg.34.2019.12.21.12.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 12:26:51 -0800 (PST)
From:   mfo@canonical.com
To:     tytso@mit.edu
Cc:     dann.frazier@canonical.com, linux-ext4@vger.kernel.org,
        mauricio.foliveira@gmail.com
Subject: Re: ext4 fsck vs. kernel recovery policy
Date:   Sat, 21 Dec 2019 17:26:29 -0300
Message-Id: <20191221202630.30718-1-mfo@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830012236.GC10779@mit.edu>
References: <20190830012236.GC10779@mit.edu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Mauricio Faria de Oliveira <mfo@canonical.com>

On Thu, 29 Aug 2019 21:22:36 -0400, Theodore Y. Ts'o wrote:
> Dann, any interest in trying to code this fix?

Hi Ted,

Dann and I discussed this a little bit, and I could try to code this fix.

It's working for the most part (i.e., no regressions on xfstests, and it
runs our test-case / stress-ng mmap/file test without issues), but I had
a few questions about a couple of deadlocks I've hit/fixed (that I think
may still happen on other paths), and your opinion/advice on the code.

I'm sending the RFC patch too (on v5.5-rc2) to describe these questions.
It's clearly not final. Any comments/feedback would be much appreciated!

Apologies for the long email upfront; hope the extra context does help.

On Thu, 29 Aug 2019 21:22:36 -0400, Theodore Y. Ts'o wrote:
> The fix is going to have to involve fixing __ext4_journalled_writepage()
> to call set_page_writeback() before it unlocks the page, <snip>


Q1: That's the page_unlock() in 'out:', right?  

Otherwise (in page_unlock() after get_page()) the code hits a deadlock
in the next page_lock(), against write_cache_pages(), because it calls
page_lock() and then wait_on_page_writeback().


Q2: Must set_page_writeback() occur before ext4_journal_stop() ?

I think so, to prevent a race condition between the journal commit hook
running shortly after ext4_journal_stop() trying to end_page_writeback()
before set_page_writeback() runs (which hits a BUG()),
but wondered if any guarantees exist that could relax this case/order.


> <snip> adding a list of
> pages under data=journalled writeback which is attached to the
> transaction handle, have the jbd2 commit hook call end_page_writeback()
> on all of these pages, <snip>

Q3: Instead of coding something new for this, I re-used something,
but it seems to be relatively more overhead -- what do you think?

I relied on 'struct ext4_journal_cb_entry' and ext4_journal_callback_add(),
which adds such callback entries in handle->h_transaction->t_private_list.

Those entries are called back from ext4_journal_commit_callback(), which is
'sbi->s_journal->j_commit_callback' called by jbd2_journal_commit_transaction().

This is relatively more costly/higher overhead compared with your suggestion:

i.e., allocates memory for callback entry, and on the commit hook loops over
a list of callback entries and call their function pointers on their private
data field / page pointer, then call end_page_writeback() and kfree() entry;

vs. still allocating memory for a callback entry item (just a page pointer)
but then just calling one function to go over a list of page pointers, and
call end_page_writeback() on them.


> <snip> and then in the places where ext4 calls
> wait_for_stable_page() or grab_cache_page_write_begin(),
> we need to add:
> 
> 	if (ext4_should_journal_data(inode))
> 		wait_on_page_writeback(page);
>

Q4: When done between ext4_journal_start() and ext4_journal_stop() this
hit a deadlock with jbd2_journal_commit_transaction(), described below.

I wonder if this is due to an implementation/logic error on my code.
If you could please provide some detail about it, that'd be helpful.

The deadlock is:

Task 1) stress-ng: calls jbd2_journal_force_commit().

Task 2) jbd2 task: calls jbd2_journal_commit_transaction(),
  which is waiting on 'write_lock(&j_state_lock)' in the
 'while (atomic_read(&commit_transaction->t_updates))' loop.

If I understand it correctly, this is waiting on updates to the
transaction handle to finish, ie they called ext4_journal_start()
but _not yet_ ext4_journal_stop() (where jbd2 drops 't_updates').

Then there is,

Task 3) stress-ng: calls ext4_write_begin() and is stopped at
  wait_on_page_writeback() between ext4_journal_start()/_stop(),
  right after wait_for_stable_page(), per the algorithm described.

(all stack traces provided later in the email)

So wait_on_page_writeback() waits for jbd2_journal_commit_transaction()
to eventually callback end_page_writeback() - but that is waiting for
wait_on_page_writeback() to finish and then call ext4_journal_stop().

That deadlock could be fixed by moving the wait_on_page_writeback()
before ext4_journal_start().  

But since wait_for_stable_page() is already in place, and it can
call wait_on_page_writeback() too and thus hit the same deadlock,

I wonder if this issue is more general and has to be fixed for this
implementation, or this implementation has to change to adapt to the
existing logic, and avoid this issue.


> It's all relatively straightforward except for the part where we have to
> attach a list of pages to the currently running transaction.  That
> will require adding  some plumbing into the jbd2 layer.

There was this other issue I had to work around, again not sure if it's
a problem on my code, or something that actually needs to be considered.

If set_page_writeback() is used on the msync() / ext4_sync_file() path,
there's a delay of seconds in file_write_and_wait_range() as it calls
wait_on_page_writeback(), until the periodic journal commit clears it.

msync()
-> ext4_sync_file()
   -> file_write_and_wait_range() 
      -> __filemap_fdatawrite_range()
         -> ...
            -> __ext4_journalled_writepage()
      -> __filemap_fdatawait_range()
         -> wait_on_page_writeback()

So, I added a 'sync' parameter to __ext4_journalled_writepage(), and it's
only true in that path (checks for (wbc->sync_mode == WB_SYNC_ALL)).

Q5: Is it okay to skip set/end_page_writeback() for this path, since
ext4_sync_file() already calls ext4_force_commit() for data=journal?

Q6: Or should __ext4_journalled_writepage() use ext4_handle_sync()
in the sync case, or maybe on both sync/async cases anyway?


Thank you,
Mauricio


Test-case:
---

# mkfs.ext4 -F $DEV && \
  mount -o data=journal,journal_checksum $DEV $PATH && \
  cd $PATH && \
  stress-ng --mmap 512 --mmap-file -t 1w


Stack traces from Q4:
---

Task 1)
comm stress-ng-mmap state D
[<0>] jbd2_log_wait_commit+0xa7/0x110
[<0>] __jbd2_journal_force_commit+0x53/0x90
[<0>] jbd2_journal_force_commit+0x18/0x30
[<0>] ext4_sync_file+0x140/0x3c0
[<0>] __x64_sys_msync+0x193/0x200
[<0>] do_syscall_64+0x43/0x110
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9


Task 2)
comm jbd2/vdc-8 state D
[<0>] jbd2_journal_commit_transaction+0x242/0x187f
[<0>] kjournald2+0xb2/0x280
[<0>] kthread+0xf6/0x130
[<0>] ret_from_fork+0x35/0x40

jbd2_journal_commit_transaction+0x242 is:

while (atomic_read(&commit_transaction->t_updates)) {
...
	if (atomic_read(&commit_transaction->t_updates)) {
	...
	write_lock(&journal->j_state_lock); // <<-- HERE.


Task 3)
comm stress-ng-mmap state D
[<0>] wait_on_page_bit+0xfe/0x1c0
[<0>] ext4_write_begin+0x215/0x640
[<0>] generic_perform_write+0xba/0x1c0
[<0>] __generic_file_write_iter+0x143/0x1c0
[<0>] ext4_file_write_iter+0xdc/0x380
[<0>] new_sync_write+0x116/0x1b0
[<0>] vfs_write+0xb1/0x190
[<0>] ksys_write+0x5a/0xd0
[<0>] do_syscall_64+0x43/0x110
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

ext4_write_begin+0x215/0x640 is:

retry_journal:
...
        handle = ext4_journal_start(...)
...
        /* In case writeback began while the page was unlocked */
        wait_for_stable_page(page);
        if (ext4_should_journal_data(inode))
                wait_on_page_writeback(page); // <<-- HERE.
...


Other tasks:

comm stress-ng-mmap state D
[<0>] wait_transaction_locked+0x82/0xc0
[<0>] add_transaction_credits+0xd5/0x290
[<0>] start_this_handle+0xf6/0x450
[<0>] jbd2__journal_start+0xd7/0x1e0
...
(from: syscall, pagefault)


Mauricio Faria de Oliveira (1):
  ext4: set page writeback on journalled writepage

 fs/ext4/ext4_jbd2.h | 11 ++++++
 fs/ext4/inline.c    | 13 +++++++
 fs/ext4/inode.c     | 82 ++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 102 insertions(+), 4 deletions(-)

-- 
2.17.1

