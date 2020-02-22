Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5F8168C5A
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Feb 2020 05:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgBVEbT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Feb 2020 23:31:19 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44562 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgBVEbS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Feb 2020 23:31:18 -0500
Received: by mail-qk1-f195.google.com with SMTP id j8so3891668qka.11
        for <linux-ext4@vger.kernel.org>; Fri, 21 Feb 2020 20:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CX8IlyO2NfaoYedky7RgY9iFI5Qm9KXskMaolJPwzcE=;
        b=HURxGwm6wXjTFFfHTTe3ARqif8yoUISPdDmgETee13HaBdibZts47iyQcECyw2+uX2
         Jq+CrCoiw3KLZfhUWHsC39rSkR+puexd4NSHZFiMWpyR56vYkGVyR3uDKDPLA3TaDfqz
         NcFARAMh31DnnivAwrLoqs3hoWW9UWRV/4DYyywZUhg9JvvwDCj7BSYwQxrV0Xa31TGZ
         4LNUwq+uLEYNsNg2ENSJL4TMUJrI3JFyQiIWZLJwiH6auWnTZyJvfYVzonEOnAIFqSju
         nfbjkM6ZYqKDmX17//S2is7PQzogFZeBtY4Re2HAcIpaleWEREJXhMxbM+FUwwVMqBFO
         c1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CX8IlyO2NfaoYedky7RgY9iFI5Qm9KXskMaolJPwzcE=;
        b=bU+V6F9HOak6nmGTjtkokmgU/WszMtf3MxkBfn1CoxyRGgMq69w8H2iuGeiF1XBp3x
         acr1WVZz8kaLcsUYSJklOVL86vlJ9kbuw/+BOqS5vmOGGHS2uLOzsoT2GrPQ+CwZtjiW
         r8HpcAlvd2KmPRBsqeQ5LseVWWyVYzxj6/IawOwQAk8c4YxNqo52xLhD6HXb/0Gw4U0x
         DQLh39+d6oi9PFaaz/t8bPGQw9ACfyS1o5eJtYUzeVuoixJNhwrwvfWLtq3A7eLe26rO
         AbgbqZA+pFZ+hdes+bhTSEI2PY9K6rNCYTokNgaPw66sME37hW8/BBlESEWiWfll0jjq
         ONKQ==
X-Gm-Message-State: APjAAAVHFYyu/5MUXR0OhvARLhVHyBeY9szaoOUrHEofVsCxKK2kKWmG
        u8uQ260swJOG0EbpuYe+6e3Nag==
X-Google-Smtp-Source: APXvYqwlagE95Cmm9cuSjUVY21uZeKLdBNXVHVgFsu2VWrTbv59xsKLEJD7jAipNzxJzCnD2xFFdWg==
X-Received: by 2002:a05:620a:150a:: with SMTP id i10mr13947361qkk.407.1582345877273;
        Fri, 21 Feb 2020 20:31:17 -0800 (PST)
Received: from ovpn-120-117.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 184sm2578786qki.92.2020.02.21.20.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 20:31:16 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tytso@mit.edu, jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] fs/jbd2: fix data races at struct journal_head
Date:   Fri, 21 Feb 2020 23:31:11 -0500
Message-Id: <20200222043111.2227-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

journal_head::b_transaction and journal_head::b_next_transaction could
be accessed concurrently as noticed by KCSAN,

 LTP: starting fsync04
 /dev/zero: Can't open blockdev
 EXT4-fs (loop0): mounting ext3 file system using the ext4 subsystem
 EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null)
 ==================================================================
 BUG: KCSAN: data-race in __jbd2_journal_refile_buffer [jbd2] / jbd2_write_access_granted [jbd2]

 write to 0xffff99f9b1bd0e30 of 8 bytes by task 25721 on cpu 70:
  __jbd2_journal_refile_buffer+0xdd/0x210 [jbd2]
  __jbd2_journal_refile_buffer at fs/jbd2/transaction.c:2569
  jbd2_journal_commit_transaction+0x2d15/0x3f20 [jbd2]
  (inlined by) jbd2_journal_commit_transaction at fs/jbd2/commit.c:1034
  kjournald2+0x13b/0x450 [jbd2]
  kthread+0x1cd/0x1f0
  ret_from_fork+0x27/0x50

 read to 0xffff99f9b1bd0e30 of 8 bytes by task 25724 on cpu 68:
  jbd2_write_access_granted+0x1b2/0x250 [jbd2]
  jbd2_write_access_granted at fs/jbd2/transaction.c:1155
  jbd2_journal_get_write_access+0x2c/0x60 [jbd2]
  __ext4_journal_get_write_access+0x50/0x90 [ext4]
  ext4_mb_mark_diskspace_used+0x158/0x620 [ext4]
  ext4_mb_new_blocks+0x54f/0xca0 [ext4]
  ext4_ind_map_blocks+0xc79/0x1b40 [ext4]
  ext4_map_blocks+0x3b4/0x950 [ext4]
  _ext4_get_block+0xfc/0x270 [ext4]
  ext4_get_block+0x3b/0x50 [ext4]
  __block_write_begin_int+0x22e/0xae0
  __block_write_begin+0x39/0x50
  ext4_write_begin+0x388/0xb50 [ext4]
  generic_perform_write+0x15d/0x290
  ext4_buffered_write_iter+0x11f/0x210 [ext4]
  ext4_file_write_iter+0xce/0x9e0 [ext4]
  new_sync_write+0x29c/0x3b0
  __vfs_write+0x92/0xa0
  vfs_write+0x103/0x260
  ksys_write+0x9d/0x130
  __x64_sys_write+0x4c/0x60
  do_syscall_64+0x91/0xb05
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

 5 locks held by fsync04/25724:
  #0: ffff99f9911093f8 (sb_writers#13){.+.+}, at: vfs_write+0x21c/0x260
  #1: ffff99f9db4c0348 (&sb->s_type->i_mutex_key#15){+.+.}, at: ext4_buffered_write_iter+0x65/0x210 [ext4]
  #2: ffff99f5e7dfcf58 (jbd2_handle){++++}, at: start_this_handle+0x1c1/0x9d0 [jbd2]
  #3: ffff99f9db4c0168 (&ei->i_data_sem){++++}, at: ext4_map_blocks+0x176/0x950 [ext4]
  #4: ffffffff99086b40 (rcu_read_lock){....}, at: jbd2_write_access_granted+0x4e/0x250 [jbd2]
 irq event stamp: 1407125
 hardirqs last  enabled at (1407125): [<ffffffff980da9b7>] __find_get_block+0x107/0x790
 hardirqs last disabled at (1407124): [<ffffffff980da8f9>] __find_get_block+0x49/0x790
 softirqs last  enabled at (1405528): [<ffffffff98a0034c>] __do_softirq+0x34c/0x57c
 softirqs last disabled at (1405521): [<ffffffff97cc67a2>] irq_exit+0xa2/0xc0

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 68 PID: 25724 Comm: fsync04 Tainted: G L 5.6.0-rc2-next-20200221+ #7
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019

The plain reads are outside of jh->b_state_lock critical section which result
in data races. Fix them by adding pairs of READ|WRITE_ONCE().

Signed-off-by: Qian Cai <cai@lca.pw>
---
 fs/jbd2/transaction.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 2dd848a743ed..c5f7f6d0f33b 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1152,8 +1152,8 @@ static bool jbd2_write_access_granted(handle_t *handle, struct buffer_head *bh,
 	/* For undo access buffer must have data copied */
 	if (undo && !jh->b_committed_data)
 		goto out;
-	if (jh->b_transaction != handle->h_transaction &&
-	    jh->b_next_transaction != handle->h_transaction)
+	if (READ_ONCE(jh->b_transaction) != handle->h_transaction &&
+	    READ_ONCE(jh->b_next_transaction) != handle->h_transaction)
 		goto out;
 	/*
 	 * There are two reasons for the barrier here:
@@ -2565,8 +2565,8 @@ bool __jbd2_journal_refile_buffer(struct journal_head *jh)
 	 * our jh reference and thus __jbd2_journal_file_buffer() must not
 	 * take a new one.
 	 */
-	jh->b_transaction = jh->b_next_transaction;
-	jh->b_next_transaction = NULL;
+	WRITE_ONCE(jh->b_transaction, jh->b_next_transaction);
+	WRITE_ONCE(jh->b_next_transaction, NULL);
 	if (buffer_freed(bh))
 		jlist = BJ_Forget;
 	else if (jh->b_modified)
-- 
2.21.0 (Apple Git-122.2)

