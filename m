Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A5924009E
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Aug 2020 03:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHJBCW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 9 Aug 2020 21:02:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36769 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgHJBCW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 9 Aug 2020 21:02:22 -0400
Received: from mail-qv1-f71.google.com ([209.85.219.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1k4wCh-000707-Cn
        for linux-ext4@vger.kernel.org; Mon, 10 Aug 2020 01:02:19 +0000
Received: by mail-qv1-f71.google.com with SMTP id z10so6332184qvm.0
        for <linux-ext4@vger.kernel.org>; Sun, 09 Aug 2020 18:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d3yDKo9vJf9G43nEc3BI2IxvP5t3stpY+dybWJvQ24k=;
        b=LlwovZEfcWmO3ef1vsjhCJblFid0I+7DKNMMuQ0N+oAiENgYQdVKXz7WUGxrWNK65a
         ZpCWsfFPhmeEhVxnYG5DgmrQjXlrMw25NXG6nS6LNIEazxHEgBX4vF/B5Fb9FfwsoPrG
         bUWQ+7AvYJ50tY017HIzFVQWUOV7lyOtuWiDZZWoML2WnLyqbEFKPuWSLf8FS2HSk49K
         24jycubmMFCF88e4sUZ/7gGSDO6jAI/JZWluNu2w03K8iKLtmHVFReBf4iRy4C7IUjEJ
         NXlFrkt1dzRIbhgOmkrdGj0hiQ/4+B0CILoU+CyGVPd11m3pZDjJjClRYX1RiVBLTAq5
         gUog==
X-Gm-Message-State: AOAM531ZqtYSJaDtQXy2U3qUs7fisrx4nw2OGiH+X/hF66SCGrHnr3Bj
        xRGdH4VYyPdAsIq2OvXHQA0OWALsbxG+TQU3LXPHlR0i6qUA/Y3MUkWP+N1SzHY4XcuvVQvgwup
        13JrHdwNYscFRJNK7At/roMMeK0QHpUNs2TqxLmw=
X-Received: by 2002:a05:6214:13b0:: with SMTP id h16mr25203745qvz.207.1597021338241;
        Sun, 09 Aug 2020 18:02:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWW307K6Dhef/KbsJp9Ec5pys3C5hXSa4G+GHhj0G5wBEVREBKK3KSMKtxVkckfKONdGnlpQ==
X-Received: by 2002:a05:6214:13b0:: with SMTP id h16mr25203721qvz.207.1597021338000;
        Sun, 09 Aug 2020 18:02:18 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id 95sm44815qtc.29.2020.08.09.18.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 18:02:17 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>,
        Jan Kara <jack@suse.com>
Subject: [RFC PATCH v2 1/5] jbd2: test case for ext4 data=journal/mmap() journal corruption
Date:   Sun,  9 Aug 2020 22:02:04 -0300
Message-Id: <20200810010210.3305322-2-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810010210.3305322-1-mfo@canonical.com>
References: <20200810010210.3305322-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This checks during journal commit, right after calculating the
checksum of a buffer head, whether its contents match the 'BUG'
string (the cookie string in the test case userspace part.)

If so, it sleeps 5 seconds for such contents to change (i.e.,
so that the actual checksum changes from what was calculated.)

And if it changed, set a flag to panic after committing to disk.

Then, on filesystem remount/journal recovery there is an invalid
checksum error, and recovery fails:

  $ sudo mount -o data=journal,journal_checksum $DEV $MNT
  [ 100.832223] EXT4-fs: Warning: mounting with data=journal disables
  delayed allocation, dioread_nolock, and O_DIRECT support!
  [ 100.837488] JBD2: Invalid checksum recovering data block 8706 in log
  [ 100.842010] JBD2: recovery failed
  [ 100.843045] EXT4-fs (loop0): error loading journal
  mount: /ext4: can't read superblock on /dev/loop0.
---
 fs/jbd2/commit.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 6d2da8ad0e6f..51f713089e35 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -26,6 +26,11 @@
 #include <linux/bitops.h>
 #include <trace/events/jbd2.h>
 
+#include <linux/printk.h>
+#include <linux/delay.h>
+
+static journal_t *force_panic;
+
 /*
  * IO end handler for temporary buffer_heads handling writes to the journal.
  */
@@ -331,14 +336,35 @@ static void jbd2_block_tag_csum_set(journal_t *j, journal_block_tag_t *tag,
 	__u32 csum32;
 	__be32 seq;
 
+	// For the testcase
+	__u32 csum32_later;
+	__u8 *bh_data;
+
 	if (!jbd2_journal_has_csum_v2or3(j))
 		return;
 
 	seq = cpu_to_be32(sequence);
 	addr = kmap_atomic(page);
 	csum32 = jbd2_chksum(j, j->j_csum_seed, (__u8 *)&seq, sizeof(seq));
+	csum32_later = csum32; // Copy csum32 to check again later
 	csum32 = jbd2_chksum(j, csum32, addr + offset_in_page(bh->b_data),
 			     bh->b_size);
+
+	// Check for testcase cookie 'BUG' in the buffer_head data.
+	bh_data = addr + offset_in_page(bh->b_data);
+	if (bh_data[0] == 'B' &&
+	    bh_data[1] == 'U' &&
+	    bh_data[2] == 'G') {
+		pr_info("TESTCASE: Cookie found. Waiting 5 seconds for changes.\n");
+		msleep(5000);
+		pr_info("TESTCASE: Cookie eaten. Resumed.\n");
+	}
+
+	// Check the checksum again for changes/panic after commit.
+	csum32_later = jbd2_chksum(j, csum32_later, addr + offset_in_page(bh->b_data), bh->b_size);
+	if (csum32 != csum32_later)
+		force_panic = j;
+
 	kunmap_atomic(addr);
 
 	if (jbd2_has_feature_csum3(j))
@@ -885,6 +911,9 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		blkdev_issue_flush(journal->j_dev, GFP_NOFS);
 	}
 
+	if (force_panic == journal)
+		panic("TESTCASE: checksum changed; commit record done; panic!\n");
+
 	if (err)
 		jbd2_journal_abort(journal, err);
 
-- 
2.17.1

