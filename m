Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 129B917D921
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 06:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgCIF7w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 01:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCIF7w (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Mar 2020 01:59:52 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC9DF20727;
        Mon,  9 Mar 2020 05:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583733592;
        bh=S4XLLB0u7ZrovlJVWMX+h/jJbJG8MDh37MbRley/rR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pmPSswZ2vGgU8If1BI7OFSZ6GWcpwVvgwiBSM+aK21bouP1Ych0a9sf7i1j+FRvAU
         5iP1oGe48nvls1HTGErJ6MsWwTemo1jRjq1NIhPSXtC5ClszMwGFXS+M8PTiPOdOYk
         Fjdaw/PH2e7uQI8lXzLGshTFnTxphXb4m7YjHQwg=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-cifs@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] cifs: clear PF_MEMALLOC before exiting demultiplex thread
Date:   Sun,  8 Mar 2020 22:58:20 -0700
Message-Id: <20200309055820.272703-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309055621.GA272474@sol.localdomain>
References: <20200309055621.GA272474@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Leaving PF_MEMALLOC set when exiting a kthread causes it to remain set
during do_exit().  That can confuse things.  For example, if BSD process
accounting is enabled and the accounting file has FS_SYNC_FL set and is
located on an ext4 filesystem without a journal, then do_exit() can end
up calling ext4_write_inode().  That triggers the
WARN_ON_ONCE(current->flags & PF_MEMALLOC) there, as it assumes
(appropriately) that inodes aren't written when allocating memory.

This was originally reported for another kernel thread, xfsaild() [1].
cifs_demultiplex_thread() also exits with PF_MEMALLOC set, so it's
potentially subject to this same class of issue -- though I haven't been
able to reproduce the WARN_ON_ONCE() via CIFS, since unlike xfsaild(),
cifs_demultiplex_thread() is sent SIGKILL before exiting, and that
interrupts the write to the BSD process accounting file.

Either way, leaving PF_MEMALLOC set is potentially problematic.  Let's
clean this up by properly saving and restoring PF_MEMALLOC.

[1] https://lore.kernel.org/r/0000000000000e7156059f751d7b@google.com

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v3: improved commit message
v2: added missing include

 fs/cifs/connect.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 4804d1df8c1cf..97b8eb585cf9d 100644
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

