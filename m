Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF2D817D20B
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Mar 2020 07:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgCHGRZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Mar 2020 01:17:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgCHGRZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 8 Mar 2020 01:17:25 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3264E206D5;
        Sun,  8 Mar 2020 06:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583648244;
        bh=9ame7aB+gFjGXSnQ7vpAtpsVY6w+4/FfqozW1g4Cd+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jpf30BGdmS+h5tKyDyU5YYG0AeLi7uZRjya69QEId/i/FFgx8lds/q+qxLi/uCXyU
         cG6Hv4YpgVGuLvvhwSsygu893iLaDzZxS7+LfbEk2J4IxDWAjKg0+xfgGaVN7RXIWr
         42DmzulKd0SkHRMWLYrtz4e+HPBv46g6MNMStg3Y=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-cifs@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] cifs: clear PF_MEMALLOC before exiting demultiplex thread
Date:   Sat,  7 Mar 2020 22:16:11 -0800
Message-Id: <20200308061611.1185481-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200308043645.1034870-1-ebiggers@kernel.org>
References: <20200308043645.1034870-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Leaving PF_MEMALLOC set when exiting a kthread causes it to remain set
during do_exit().  That can confuse things.  For example, if BSD process
accounting is enabled, then it's possible for do_exit() to end up
calling ext4_write_inode().  That triggers the
WARN_ON_ONCE(current->flags & PF_MEMALLOC) there, as it assumes
(appropriately) that inodes aren't written when allocating memory.

This case was reported by syzbot at
https://lkml.kernel.org/r/0000000000000e7156059f751d7b@google.com.

Fix this in cifs_demultiplex_thread() by using the helper functions to
save and restore PF_MEMALLOC.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2: added missing include of <linux/sched/mm.h>
    (I missed that I didn't actually have CONFIG_CIFS set...)

 fs/cifs/connect.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 4804d1df8c1c..97b8eb585cf9 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -21,6 +21,7 @@
 #include <linux/fs.h>
 #include <linux/net.h>
 #include <linux/string.h>
+#include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/list.h>
 #include <linux/wait.h>
@@ -1164,8 +1165,9 @@ cifs_demultiplex_thread(void *p)
 	struct task_struct *task_to_wake = NULL;
 	struct mid_q_entry *mids[MAX_COMPOUND];
 	char *bufs[MAX_COMPOUND];
+	unsigned int noreclaim_flag;
 
-	current->flags |= PF_MEMALLOC;
+	noreclaim_flag = memalloc_noreclaim_save();
 	cifs_dbg(FYI, "Demultiplex PID: %d\n", task_pid_nr(current));
 
 	length = atomic_inc_return(&tcpSesAllocCount);
@@ -1320,6 +1322,7 @@ cifs_demultiplex_thread(void *p)
 		set_current_state(TASK_RUNNING);
 	}
 
+	memalloc_noreclaim_restore(noreclaim_flag);
 	module_put_and_exit(0);
 }
 
-- 
2.25.1

