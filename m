Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BEB3E82B5
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Aug 2021 20:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbhHJSR3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Aug 2021 14:17:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59357 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238751AbhHJSO6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Aug 2021 14:14:58 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17AIEVb5021949
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 14:14:32 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DEE5E15C37C1; Tue, 10 Aug 2021 14:14:30 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH 1/2] jbd2: fix clang warning in recovery.c
Date:   Tue, 10 Aug 2021 14:14:25 -0400
Message-Id: <20210810181426.13162-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remove unused variable store which was never used.

This fix is also in e2fsprogs commit 99a2294f85f0 ("e2fsck: value
stored to err is never read").

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/jbd2/recovery.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 4c4209262437..ba979fcf1cd3 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -760,7 +760,6 @@ static int do_one_pass(journal_t *journal,
 				 */
 				jbd_debug(1, "JBD2: Invalid checksum ignored in transaction %u, likely stale data\n",
 					  next_commit_ID);
-				err = 0;
 				brelse(bh);
 				goto done;
 			}
-- 
2.31.0

