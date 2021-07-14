Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458593C7E4F
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jul 2021 08:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbhGNGCz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jul 2021 02:02:55 -0400
Received: from out0.migadu.com ([94.23.1.103]:42281 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237921AbhGNGCz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 14 Jul 2021 02:02:55 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1626242392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vgFj1qhJhUzKaaf2VmU6hhsMPALVHBqq5tIRM5o9xPc=;
        b=jZ+vrzUDdoyzClatSmL01wP7aQs+Qm5x8vv7T1r/au2XN7zwbRpR8ejcc4Z1QwgMOlYcbg
        sxbHLjR9m3Ns1E5wIh50xGNWTAsGdrJtJ7+Ty6wlwxsQ4bBK6E3b+UwstoythbhbkpSEtu
        OJrLsCpApZ4GDNi0bELnBmxk4Pz1uTM=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: remove conflict comment from __ext4_forget
Date:   Wed, 14 Jul 2021 13:59:40 +0800
Message-Id: <20210714055940.1553705-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: guoqing.jiang@linux.dev
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Guoqing Jiang <jiangguoqing@kylinos.cn>

We do a bforget and return for no journal case, so let's remove this
conflict comment.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>
---
Change from RFC: add Jan's Reviewed-by.

 fs/ext4/ext4_jbd2.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index be799040a415..6e224b19eae7 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -244,9 +244,6 @@ int __ext4_journal_get_write_access(const char *where, unsigned int line,
  * "bh" may be NULL: a metadata block may have been freed from memory
  * but there may still be a record of it in the journal, and that record
  * still needs to be revoked.
- *
- * If the handle isn't valid we're not journaling, but we still need to
- * call into ext4_journal_revoke() to put the buffer head.
  */
 int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
 		  int is_metadata, struct inode *inode,
-- 
2.25.1

