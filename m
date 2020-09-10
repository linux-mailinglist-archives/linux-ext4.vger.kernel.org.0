Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B021E264F12
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Sep 2020 21:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgIJTd6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Sep 2020 15:33:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43001 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgIJTbf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Sep 2020 15:31:35 -0400
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1kGSI8-0000i6-RI
        for linux-ext4@vger.kernel.org; Thu, 10 Sep 2020 19:31:33 +0000
Received: by mail-qt1-f197.google.com with SMTP id m13so4896432qtu.10
        for <linux-ext4@vger.kernel.org>; Thu, 10 Sep 2020 12:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LuSXWTsin8cF8bzKkoixqrxuBXCzvzGP6uXIxX5Rv+w=;
        b=n6PLbvTVkl2R3MJiykeo6J7FUX4zDZFFb0EN8MDQ6/moxSZ8T4NO9ZIQ3+47MxtbFb
         x9/rA6cB03ZLtagoHDryFrEdTvOvG0Etv4fgz64Di18Rlc/djbwszqOoJvmlPtARHlcf
         HT6z60zKCOul4sYRvUCyIy6c0GTxmFBSR0Iy99ayJko+ZVeat4juCGe2z8Lm3/ZJMzzL
         4j1OK0z6cc1fOM2uUmmf6PPgNnw8SKs5lOvjjn/dck0lh2qxF0BnCQVRaAedlqV6G4C/
         KK6yZTNvbXPLSydALJb+ozRv5KGmx9VBsBXpirOympebOmNlUJEPxq/JpFTDeBSwZvWa
         Pufw==
X-Gm-Message-State: AOAM530S6k/VMJ1Y6Hqn5Sj4/QhKCDU/OPEHcTBWNtY8V1A9kBvvftuK
        5BZPSP6I1v7PyZlVrE+3Z023OXV7hzIjRNsas1afb2wO2YxT9pdALLV+cycxxh7DW+j7Tau48fK
        qVRxzTC0D4zl9BatHhInDY3kGED+yIa8fQwUvrUM=
X-Received: by 2002:ae9:ef92:: with SMTP id d140mr9232941qkg.73.1599766291852;
        Thu, 10 Sep 2020 12:31:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyZhJeuJAS61vLtuS9a5AHy70InG5CeeZxiVfSoD8pHjtHSd6j77SH54gT/SYXL8Lw4At6bQ==
X-Received: by 2002:ae9:ef92:: with SMTP id d140mr9232918qkg.73.1599766291557;
        Thu, 10 Sep 2020 12:31:31 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id u4sm6410391qkk.68.2020.09.10.12.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:31:30 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>
Subject: [RFC PATCH v3 0/3] ext4/jbd2: data=journal: write-protect pages on transaction commit
Date:   Thu, 10 Sep 2020 16:31:24 -0300
Message-Id: <20200910193127.276214-1-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey Jan,

This series implements your suggestions for the RFC PATCH v2 set,
which we mostly talked about in cover letter [1] and PATCH 3 [2].
(I added Suggested-by: tags, by the way, for due credit.)

It looks almost good on fstests: zero regressions on data=ordered,
and only one regression in data=journal (generic/347); I'll check.
(That's with ext4; I'll check ocfs2, but it's only a minor change.)

However, there's an issue I have to check with you about, that we
exposed from the original kernel. It's described below, but other
than this I _guess_ this should be close if you don't spot errors.

Thanks!
Mauricio

...

Testing with 'stress-ng --mmap <N> --mmap-file' runs well for days,
but it occasionally hits:

  JBD2: Spotted dirty metadata buffer (dev = vdc, blocknr = 74775).
  There's a risk of filesystem corruption in case of system crash.

I added dump_stack() in warn_dirty_buffer(), and it usually comes
from jbd2_journal_file_buffer(, BJ_Forget) in the commit function.
When filing from BJ_Shadow to BJ_Forget.. so it possibly happened
while BH_Shadow was still set!

So I instrumented [test_]set_buffer_dirty() macros to dump_stack()
if BH_Shadow is set (i.e. buffer being set dirty during write-out.)

This showed that the occasional BH_Dirty setter with BH_Shadow set
is block_page_mkwrite() in ext4_page_mkwrite(). And it seems right,
because it's called before do_journal_get_write_access() (where we
check for/wait on BH_Shadow.)

ext4_page_mkwrite():

        err = block_page_mkwrite(vma, vmf, get_block);
        if (!err && ext4_should_journal_data(inode)) {
                if (ext4_walk_page_buffers(handle, page_buffers(page), 0,
                          PAGE_SIZE, NULL, do_journal_get_write_access)) {

The patches didn't directly break this, they only allow this code
to run more often as we disabled an early-return optimization for
the case 'all buffers mapped' in data=journal (question 2 in [1]):

ext4_page_mkwrite():

         * Return if we have all the buffers mapped.
	...
-       if (page_has_buffers(page)) {
+       if (page_has_buffers(page) && !ext4_should_journal_data(inode)) {


In order to confirm it, I built the unpatched v5.9-rc4 kernel, with
just the change to disable that optimization in data=journal -- and
it hit that occasionally too ("JBD2: Spotted dirty metadata buffer".)

I was naive enough to mindlessly try to swap the order of those two
statements, in hopes that do_journal_get_write_access() should wait
for BH_Shadow to clear, and then we just call block_page_mkwrite().
BUT it trips into the BUG() check in page_buffers() in the former.

I still have to dig more about it, but if you have something quick
in mind, I'd appreciate any comments/feedback about it, if it gets
more complex than I can see.

Thanks again!

[1] https://lore.kernel.org/linux-ext4/20200819092735.GI1902@quack2.suse.cz/
[2] https://lore.kernel.org/linux-ext4/20200821102625.GB3432@quack2.suse.cz/

Mauricio Faria de Oliveira (3):
  jbd2: introduce/export functions
    jbd2_journal_submit|finish_inode_data_buffers()
  jbd2, ext4, ocfs2: introduce/use journal callbacks
    j_submit|finish_inode_data_buffers()
  ext4: data=journal: write-protect pages on
    j_submit_inode_data_buffers()

 fs/ext4/inode.c      | 29 +++++++++++-----
 fs/ext4/super.c      | 82 ++++++++++++++++++++++++++++++++++++++++++++
 fs/jbd2/commit.c     | 58 +++++++++++++++++--------------
 fs/jbd2/journal.c    |  2 ++
 fs/ocfs2/super.c     | 15 ++++++++
 include/linux/jbd2.h | 29 +++++++++++++++-
 6 files changed, 181 insertions(+), 34 deletions(-)

-- 
2.17.1

