Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2220E27B583
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Sep 2020 21:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgI1TlM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Sep 2020 15:41:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38902 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1TlM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Sep 2020 15:41:12 -0400
Received: from mail-qk1-f198.google.com ([209.85.222.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1kMz1J-00028z-6X
        for linux-ext4@vger.kernel.org; Mon, 28 Sep 2020 19:41:09 +0000
Received: by mail-qk1-f198.google.com with SMTP id j5so1284408qka.7
        for <linux-ext4@vger.kernel.org>; Mon, 28 Sep 2020 12:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yLqTieO3hDkbI4EnX1s+4DSqiVKXjYq4JM3v8YoHHoo=;
        b=nvcefkYOW1WEK9t7lrFZ5F1GjiFRnIsM6ghwaHyHlJdV1znTprXNp3YYw/07BTGron
         JlkOI2ozv7xOOGBVNbHCZ3L2dp3zSbEx4V+oQr+rwMZYBfXQGRNMA2C91ACgHEws9vWs
         koU86aXiJCM7PD78bt+KWMPO0peiroO1VOn+99guh+64bb6ttnJM0zZN6MDoUrOqIVyp
         bktyJBvYkWj0QKaGRQdaJilNsx3sp6UNASRn5sC2kRcfkRFm1RazCAgGC0BbPJTh1ziT
         0UEq3e3UPouig1DYvUySbdzhcylnDek9olZJdvFDiszHZVGP7V6UmjPsF5ryiTrnIvMK
         fiQg==
X-Gm-Message-State: AOAM53143Uhq5zxfCpWzMI5k0TJCUgxgHdyfesfor0ib5dE2DWV4h3eY
        mSUylFTrJsDkLBcQ0o7ALXN3HhICJH7uTsDJBLb7XEt+zKPeH5rKZ0ZkiJeRjAuBbWMwIH2Ks2w
        kwhviEpavzkZv3rR7efh9kGZtP/eMEvz9l6/7TZo=
X-Received: by 2002:ae9:e814:: with SMTP id a20mr1055523qkg.429.1601322068309;
        Mon, 28 Sep 2020 12:41:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBA6WBZckJy7kZjWRAWb689M8EKQjEoeknhtRETX1nEtcnJayXhB4xg6s28/SAKnluKw4ySA==
X-Received: by 2002:ae9:e814:: with SMTP id a20mr1055502qkg.429.1601322067986;
        Mon, 28 Sep 2020 12:41:07 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id u15sm2360222qtj.3.2020.09.28.12.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:41:07 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>
Subject: [RFC PATCH v4 0/4] ext4/jbd2: data=journal: write-protect pages on transaction commit
Date:   Mon, 28 Sep 2020 16:40:59 -0300
Message-Id: <20200928194103.244692-1-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey Jan,

This series implements your suggestions for the RFC PATCH v3 set [1].

That addressed the issue you confirmed with block_page_mkwrite() [2].
There's no "JBD2: Spotted dirty metadata buffer" message in over 72h
runs across 3 VMs (it used to happen within a few hours.) *Thanks!*

I added Reviewed-by: tags for the patches/changes you mentioned.
The only changes from v3 are patch 3 which is new, and contains
the 2 fixes to ext4_page_mkwrite(); and patch 4 changed 'struct
writeback_control.nr_to_write' from ~0ULL to LONG_MAX, since it
is signed long (~0ULL overflows to -1; kudos, kernel test robot!)

It looks almost good on fstests: zero regressions on data=ordered,
and two apparently flaky tests data=journal (generic/347 _passed_
1/6 times with the patch, and generic/547 failed 1/6 times.)

I'll have more fstests runs on original/patched kernel to confirm
if they are flaky on both, or hit corner cases with patches only,
and will follow up with results. (and basic testing w/ ocfs2 too.)

Thanks again!
Mauricio

[1] https://lore.kernel.org/linux-ext4/20200910193127.276214-1-mfo@canonical.com/
[2] https://lore.kernel.org/linux-ext4/20200916161538.GK3607@quack2.suse.cz/

Mauricio Faria de Oliveira (4):
  jbd2: introduce/export functions
    jbd2_journal_submit|finish_inode_data_buffers()
  jbd2, ext4, ocfs2: introduce/use journal callbacks
    j_submit|finish_inode_data_buffers()
  ext4: data=journal: fixes for ext4_page_mkwrite()
  ext4: data=journal: write-protect pages on
    j_submit_inode_data_buffers()

 fs/ext4/inode.c      | 62 ++++++++++++++++++++++++++++-----
 fs/ext4/super.c      | 82 ++++++++++++++++++++++++++++++++++++++++++++
 fs/jbd2/commit.c     | 58 +++++++++++++++++--------------
 fs/jbd2/journal.c    |  2 ++
 fs/ocfs2/super.c     |  5 +++
 include/linux/jbd2.h | 29 +++++++++++++++-
 6 files changed, 203 insertions(+), 35 deletions(-)

-- 
2.17.1

