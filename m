Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85545E4D93
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2019 16:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505405AbfJYN5z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Oct 2019 09:57:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505381AbfJYN5u (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 25 Oct 2019 09:57:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC8B821E6F;
        Fri, 25 Oct 2019 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572011869;
        bh=VxAENRe8KXE3KAQSm0XpFg7pqpD9WQdNEuOUOrj6zvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSg8ZIpkQUKp2HfodOtYBEC6rZyLMQ8jYc4wCixiicVkoOQRMBR4bv2HWsZybj8Pp
         ppIThQ3I0bkwWMqWmHlZX6LiElJUsd0vsryXKH4GP2qHv8Wt1r9Keae2PKQKIXd9gj
         RSfgaLWvzKHdgGNvuV3JZKRauXUcBmuscsL/HCsU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chandan Rajendra <chandan@linux.ibm.com>,
        Harish Sriram <harish@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 19/25] jbd2: flush_descriptor(): Do not decrease buffer head's ref count
Date:   Fri, 25 Oct 2019 09:57:07 -0400
Message-Id: <20191025135715.25468-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025135715.25468-1-sashal@kernel.org>
References: <20191025135715.25468-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chandan Rajendra <chandan@linux.ibm.com>

[ Upstream commit 547b9ad698b434eadca46319cb47e5875b55ef03 ]

When executing generic/388 on a ppc64le machine, we notice the following
call trace,

VFS: brelse: Trying to free free buffer
WARNING: CPU: 0 PID: 6637 at /root/repos/linux/fs/buffer.c:1195 __brelse+0x84/0xc0

Call Trace:
 __brelse+0x80/0xc0 (unreliable)
 invalidate_bh_lru+0x78/0xc0
 on_each_cpu_mask+0xa8/0x130
 on_each_cpu_cond_mask+0x130/0x170
 invalidate_bh_lrus+0x44/0x60
 invalidate_bdev+0x38/0x70
 ext4_put_super+0x294/0x560
 generic_shutdown_super+0xb0/0x170
 kill_block_super+0x38/0xb0
 deactivate_locked_super+0xa4/0xf0
 cleanup_mnt+0x164/0x1d0
 task_work_run+0x110/0x160
 do_notify_resume+0x414/0x460
 ret_from_except_lite+0x70/0x74

The warning happens because flush_descriptor() drops bh reference it
does not own. The bh reference acquired by
jbd2_journal_get_descriptor_buffer() is owned by the log_bufs list and
gets released when this list is processed. The reference for doing IO is
only acquired in write_dirty_buffer() later in flush_descriptor().

Reported-by: Harish Sriram <harish@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/revoke.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index f9aefcda58541..cc7d1f094393a 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -637,10 +637,8 @@ static void flush_descriptor(journal_t *journal,
 {
 	jbd2_journal_revoke_header_t *header;
 
-	if (is_journal_aborted(journal)) {
-		put_bh(descriptor);
+	if (is_journal_aborted(journal))
 		return;
-	}
 
 	header = (jbd2_journal_revoke_header_t *)descriptor->b_data;
 	header->r_count = cpu_to_be32(offset);
-- 
2.20.1

