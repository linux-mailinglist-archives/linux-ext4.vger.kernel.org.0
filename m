Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 596BC155996
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2020 15:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgBGO3W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Feb 2020 09:29:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42326 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgBGO3V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Feb 2020 09:29:21 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so1941235qtq.9
        for <linux-ext4@vger.kernel.org>; Fri, 07 Feb 2020 06:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ob8LMJIgHREieW7v5VpNTe6LGjki+Z74qiQN/Nlho0c=;
        b=pb3Y74pi3lZVvc3oxQ1abdVRmotAOyZScCC4DPEAu5h41971WvnWH2o5qC/+f+aETX
         BIH+f6r4IHYTbgCcfmvY0PLZskUc2zb0rocxExU+bp2e713prRPEgZaD98lhKht9J3qh
         Zyfiub1SI3E2PoKwwPpRUpNNofTYKS6jqvLWhT8hfL9YNG089ouFJodnPqpq1+yni92p
         RlZ/8dH3aPtDF8vwrjJCK+9ejlpn+NhQSVY20Lcqg35hUMgIlYbtA+DylP5S/6RhIvC2
         U3mhKNiR6GHFDrJe9S7KBeSsw2xiaY5gN0PuRRi4L78r2dEHaJzmAZMRTY6z/IXWEQWc
         QntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ob8LMJIgHREieW7v5VpNTe6LGjki+Z74qiQN/Nlho0c=;
        b=LXyqGuZbp+a6Mfmagqkr60RSpR+/6ECVhw6LVqj/2IZd4G4AEwACx8cIwSh1pTjD9/
         QF4AGYDlprJTmMjRstIv2e4KMZ6IpIjr+u2ZcGza29X/lI6nArHK4G0txOV1aRdr2dJr
         KxPlWED9AMU0Uu1aTwVTEZCkkaaPeft9pxdDm4uiNTJ6Umui76hnc6Bw8kkhDjyFbzJD
         ZO9juDn0Hr328d/U0Uqov2qGIBjuC5GNfCv1KM6XJhqWZmixYRzMy1NlxxVe1NADCdgh
         igRwB09X12oTK96H3DUsGH/o8Ro3Xt4pKBa2fIo3bzZFzEJb++oAC006NMkwDCwb4qgb
         7ejg==
X-Gm-Message-State: APjAAAUpjnQ5R9JHBxKSp7r7lMbUC/3TOMaJhVQTCEURcCawn1SytCbK
        o3Z58dXWYz4Sie9shrRB2SwnEulPL/6Ymg==
X-Google-Smtp-Source: APXvYqzpd3Db2br7DxtUODyzXXz278wZfSTFhPjCil80LjOtBc15JgjZFRqtSxcueF06u0VhpA8Kzg==
X-Received: by 2002:aed:2d01:: with SMTP id h1mr7654931qtd.239.1581085760587;
        Fri, 07 Feb 2020 06:29:20 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 65sm1438279qtc.4.2020.02.07.06.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 06:29:20 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, elver@google.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] ext4: fix a data race in EXT4_I(inode)->i_disksize
Date:   Fri,  7 Feb 2020 09:29:11 -0500
Message-Id: <1581085751-31793-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

EXT4_I(inode)->i_disksize could be accessed concurrently as noticed by
KCSAN,

 BUG: KCSAN: data-race in ext4_write_end [ext4] / ext4_writepages [ext4]

 write to 0xffff91c6713b00f8 of 8 bytes by task 49268 on cpu 127:
  ext4_write_end+0x4e3/0x750 [ext4]
  ext4_update_i_disksize at fs/ext4/ext4.h:3032
  (inlined by) ext4_update_inode_size at fs/ext4/ext4.h:3046
  (inlined by) ext4_write_end at fs/ext4/inode.c:1287
  generic_perform_write+0x208/0x2a0
  ext4_buffered_write_iter+0x11f/0x210 [ext4]
  ext4_file_write_iter+0xce/0x9e0 [ext4]
  new_sync_write+0x29c/0x3b0
  __vfs_write+0x92/0xa0
  vfs_write+0x103/0x260
  ksys_write+0x9d/0x130
  __x64_sys_write+0x4c/0x60
  do_syscall_64+0x91/0xb47
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

 read to 0xffff91c6713b00f8 of 8 bytes by task 24872 on cpu 37:
  ext4_writepages+0x10ac/0x1d00 [ext4]
  mpage_map_and_submit_extent at fs/ext4/inode.c:2468
  (inlined by) ext4_writepages at fs/ext4/inode.c:2772
  do_writepages+0x5e/0x130
  __writeback_single_inode+0xeb/0xb20
  writeback_sb_inodes+0x429/0x900
  __writeback_inodes_wb+0xc4/0x150
  wb_writeback+0x4bd/0x870
  wb_workfn+0x6b4/0x960
  process_one_work+0x54c/0xbe0
  worker_thread+0x80/0x650
  kthread+0x1e0/0x200
  ret_from_fork+0x27/0x50

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 37 PID: 24872 Comm: kworker/u261:2 Tainted: G        W  O L 5.5.0-next-20200204+ #5
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
 Workqueue: writeback wb_workfn (flush-7:0)

Since only the read is operating as lockless (outside of the
"i_data_sem"), load tearing could introduce a logic bug. Fix it by
adding READ_ONCE() for the read and WRITE_ONCE() for the write.

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: also add WRITE_ONCE() which is recommended even for fixing load tearing.

 fs/ext4/ext4.h  | 2 +-
 fs/ext4/inode.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9a2ee2428ecc..8329ccc82fa9 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3029,7 +3029,7 @@ static inline void ext4_update_i_disksize(struct inode *inode, loff_t newsize)
 		     !inode_is_locked(inode));
 	down_write(&EXT4_I(inode)->i_data_sem);
 	if (newsize > EXT4_I(inode)->i_disksize)
-		EXT4_I(inode)->i_disksize = newsize;
+		WRITE_ONCE(EXT4_I(inode)->i_disksize, newsize);
 	up_write(&EXT4_I(inode)->i_data_sem);
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3313168b680f..6f9862bf63f1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2465,7 +2465,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 	 * truncate are avoided by checking i_size under i_data_sem.
 	 */
 	disksize = ((loff_t)mpd->first_page) << PAGE_SHIFT;
-	if (disksize > EXT4_I(inode)->i_disksize) {
+	if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
 		int err2;
 		loff_t i_size;
 
-- 
1.8.3.1

