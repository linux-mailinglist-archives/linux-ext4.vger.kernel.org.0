Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2D21D592E
	for <lists+linux-ext4@lfdr.de>; Fri, 15 May 2020 20:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgEOSjd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 May 2020 14:39:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39542 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgEOSjc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 May 2020 14:39:32 -0400
Received: from mail-vk1-f200.google.com ([209.85.221.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1jZfF3-0004mY-14
        for linux-ext4@vger.kernel.org; Fri, 15 May 2020 18:39:29 +0000
Received: by mail-vk1-f200.google.com with SMTP id k3so1177063vkb.13
        for <linux-ext4@vger.kernel.org>; Fri, 15 May 2020 11:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdyiyjzVBbo4Uf6pIokoTHuBU5ssG9nnTwt9VDOaH/8=;
        b=NyECbV6fP09lb0FdvJYIxhSnf8LkqJq8f/dJoO2RBhLhZOl1L8EHaSmlPfQNIFtGLF
         YmQCc57mXt4aFmoG6w/BgXd+ecSRXhHqit9uahzX35LI3Le3fRN0ih26hDjAdFCDffp3
         UMb/O8HIlKLtFdbBNtnaumKIZphqe8xWAs1Wd51FWKue/DEGH2IisTNGrd0tzrVCNo6x
         iPktE84hL4QP0ETNXnjRsN9VxZSWJHGwUZByVX2JWFdzsGJm5lBOOAJfMgXFkeOBE2rA
         gjKr735q4iIPwZl9szMoEcpBV7KbLYSV6mPu3XIEunXdkdFUaqLbh7rpZVPem9QoDBTK
         1sMg==
X-Gm-Message-State: AOAM533Tif1Rf1N4eCqJECVdQtIlDIu7UjwUaQce4FEt9z71t9t9qOKf
        uN9IOm/jSQRnW8LQ1JI0MBpZetclq5UBLaBMYBzTeVS/y+HxKniF3FGBuE23yeq0rKnbCvGljfH
        mnuSlPxAdP6nxFnlW1qUgEmEY+sYus9V4mVXQEeMGCBZklodoaf+wySA=
X-Received: by 2002:ab0:4a81:: with SMTP id s1mr4079695uae.108.1589567968033;
        Fri, 15 May 2020 11:39:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDdtBMJ9+y7ROWGo9tN+BMeJuagopTPuh9aShfAuCtJ98WMGaRff5Xgrk/jfb++EI6hkpTVjle5SMwETvwiq8=
X-Received: by 2002:ab0:4a81:: with SMTP id s1mr4079668uae.108.1589567967589;
 Fri, 15 May 2020 11:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200423233705.5878-1-mfo@canonical.com>
In-Reply-To: <20200423233705.5878-1-mfo@canonical.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Fri, 15 May 2020 15:39:16 -0300
Message-ID: <CAO9xwp1Gj+tffyp0Q=99VBnhX3WvHaq7qg7pf4kpty9_0+-ACQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] ext4: data=journal: writeback mmap'ed pagecache
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Cc:     dann frazier <dann.frazier@canonical.com>,
        Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On Thu, Apr 23, 2020 at 8:37 PM Mauricio Faria de Oliveira
<mfo@canonical.com> wrote:
[snip]
> Summary:
> -------
>
> The patchset is a bit long with 11 patches, but I tried to get
> changes tiny to help with review, and better document how each
> of them work, why and how this or that is done.  It's RFC as I
> would like to ask for suggestions/feedback, if at all possible.

If at all possible, may this patchset have at least a cursory look?

I'm aware it's been a busy period for some of you, so I just wanted
to friendly ping on it, in case this got buried deep under other stuff.

Thanks!


>
> Patch 01 and 02 implement the outlined fix, with a few changes
> (fix first deadlock; use existing plumbing in jbd2 as the list.)
>
> Patch 03 fix a seconds-delay on msync().
>
> Patch 04 introduces helpers to handle the second deadlock.
>
> Patch 05-11 handle the second deadlock (three of these patches,
> namely 07, 09 and 10 are changes not specific for data=journal,
> affecting other journaling modes, so it's not on their subject.)
>
> The order of the patches intentionally allow the issues on 03
> and 05-11 to occur (while putting the core patches first), so
> to allow issues to be reproduced/regression tested one by one,
> as needed.  It can be changed, of course, so to enable actual
> writeback changes in the last patch (when issues are patched.)
>
>
> Testing:
> -------
>
> This has been built and regression tested on next-20200417.
> (Also rebased and build tested on next-20200423 / "today").
>
> On xfstests (commit b2faf204) quick group (and excluding
> generic 430/431/434 which always hung): no regressions w/
> data=ordered (default) nor data=journal,journal_checksum.
>
> With data=ordered: (on both original and patched kernel)
>
>     Failures: generic/223 generic/465 generic/553 generic/554 generic/565 generic/570
>
> With data=journal,journal_checksum: (likewise)
>
>     Failures: ext4/044 generic/223 generic/441 generic/553 generic/554 generic/565 generic/570
>
> The test-case for the problem (and deadlocks) and further
> stress testing is stress-ng (with 512 workers on 16 vCPUs)
>
>     $ sudo mount -o data=journal,journal_checksum $DEV $MNT
>     $ cd $MNT
>     $ sudo stress-ng --mmap 512 --mmap-file --timeout 1w
>
> To reproduce the problem (without patchset), run it a bit
> and crash the kernel (to cause unclean shutdown) w/ sysrq,
> and mount the device again (it should fail / need e2fsck):
>
> Original:
>
>     [   27.660063] JBD2: Invalid checksum recovering data block 79449 in log
>     [   27.792371] JBD2: recovery failed
>     [   27.792854] EXT4-fs (vdc): error loading journal
>     mount: /tmp/ext4: can't read superblock on /dev/vdc.
>
> Patched:
>
>     [  33.111230] EXT4-fs (vdc): 512 orphan inodes deleted
>     [  33.111961] EXT4-fs (vdc): recovery complete
>     [  33.114590] EXT4-fs (vdc): mounted filesystem with journalled data mode. Opts: data=journal,journal_checksum
>
>
> RFC / Questions:
> ---------------
>
> 0) Usage of ext4_inode_info.i_datasync_tid for checks
>
> We rely on the struct ext4_inode_info.i_datasync_tid field
> (set by __ext4_journalled_writepage() and others) to check
> it against the running transaction. Of course, other sites
> set it too, and it might be that some of our checks return
> false positives then (should be fine, just less efficient.)
>
> To avoid such false positives, we could add another field
> to that structure, exclusively for this, but that is more
> 8 bytes (pointer) for inodes and even on non-data=journal
> cases.. so it didn't seem good enough reason, but if that
> is better/worth it for efficiency reasons (speed, in this
> case, vs. memory consumption) we could do it.
>
> Maybe there are other ideas/better ways to do it?
>
> 1) Usage of ext4_force_commit() in ext4_writepages()
>
> Patch 03 describes/fixes an issue where the underlying problem is,
> if __ext4_journalled_writepage() does set_page_writeback() but no
> journal commit is triggered, wait_on_page_writeback() may wait up
> to seconds until the periodic journal commit happens.
>
> The solution there, to fix the impact on msync(), is to just call
> ext4_force_commit() (as it's done anyway in ext4_sync_file()), on
> ext4_writepages().
>
> Is that a good enough solution?  Other ideas?
>
> 2) Similar issue (unhandled) in ext4_writepage()
>
> The other, related question is, what about direct callers of
> ext4_writepage() that obviously do not use ext4_writepages() ?
> (e.g., pageout() and writeout(); write_one_page() not used.)
>
> Those are memory-cleasing writeback, which should not wait,
> however, as mentioned in that patch, if its writeback goes
> on for seconds and an data-integrity writeback/system call
> comes in, it is delayed/wait_on_page_writeback() that long.
>
> So, ideally, we should be trying to kick a journal commit?
>
> It looks like ext4_handle_sync() is not the answer, since
> it waits for commit to finish, and pageout() is called on
> a list of pages by shrinking.  So, not effective to block
> on each one of them.
>
> We might not want to start anything right now, actually,
> since the memory-cleasing writeback can be happening on
> memory pressure scenarios, right?  But would need to do
> something, to ensure that future wait_on_page_writeback()
> do not wait too long.
>
> Maybe the answer is something similar to jbd2 sync transaction
> batching (used by ext4_handle_sync()), but in *async* fashion,
> say, possibly implemented/batching in the jbd2 worker thread.
> Is that reasonable?
>
> ...
>
> Any comments/feedback/reviews are very appreciated.
>
> Thank you in advance,
> Mauricio
>
> [1] https://lore.kernel.org/linux-ext4/20190830012236.GC10779@mit.edu/
>
> Mauricio Faria de Oliveira (11):
>   ext4: data=journal: introduce struct/kmem_cache
>     ext4_journalled_wb_page/_cachep
>   ext4: data=journal: handle page writeback in
>     __ext4_journalled_writepage()
>   ext4: data=journal: call ext4_force_commit() in ext4_writepages() for
>     msync()
>   ext4: data=journal: introduce helpers for journalled writeback
>     deadlock
>   ext4: data=journal: prevent journalled writeback deadlock in
>     __ext4_journalled_writepage()
>   ext4: data=journal: prevent journalled writeback deadlock in
>     ext4_write_begin()
>   ext4: grab page before starting transaction handle in
>     ext4_convert_inline_data_to_extent()
>   ext4: data=journal: prevent journalled writeback deadlock in
>     ext4_convert_inline_data_to_extent()
>   ext4: grab page before starting transaction handle in
>     ext4_try_to_write_inline_data()
>   ext4: deduplicate code with error legs in
>     ext4_try_to_write_inline_data()
>   ext4: data=journal: prevent journalled writeback deadlock in
>     ext4_try_to_write_inline_data()
>
>  fs/ext4/ext4_jbd2.h |  88 +++++++++++++++++++++++++
>  fs/ext4/inline.c    | 153 +++++++++++++++++++++++++++++++-------------
>  fs/ext4/inode.c     | 137 +++++++++++++++++++++++++++++++++++++--
>  fs/ext4/page-io.c   |  11 ++++
>  4 files changed, 341 insertions(+), 48 deletions(-)
>
> --
> 2.20.1
>


--
Mauricio Faria de Oliveira
