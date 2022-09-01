Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6D75AA2CC
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Sep 2022 00:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiIAWUr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Sep 2022 18:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiIAWUF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Sep 2022 18:20:05 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C049A00C9
        for <linux-ext4@vger.kernel.org>; Thu,  1 Sep 2022 15:18:50 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 281MIkeB007490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 18:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1662070727; bh=1fmy4JMdWMLWBkOKbFdOvVqFlrib50Te/L4WBYdpgWE=;
        h=From:To:Cc:Subject:Date;
        b=LbwxqvSHDMWeFFSOPQyIMvzvBoZBKqZYv2jvLTo2cTsBSM7B/nnWN+Sgd66LD39xV
         Sd/n23ZRZ5+myfQZpQ0jo1hKy9Is06JQVFt7Y0atD7/6uvD8TpC+hvD7afivXeZrcJ
         yxkhb/01Hs1aH9SJWP/Fu/Q1kmp1Gy3luS6AKWxBGdyA8/qWE6VJjt2ntWakE93Obs
         L1fXP9z/oGYx8DSycUkMU689lTuba1/inzOfYvbFAjIbryAPpQO+nmfVhyJwNQH3B7
         EbHLyyr7yCkr2lDky6N/oXMFP6GWxL/ZgIIKn4hKo81GOTJO/VFe3AphxsPPiNMzg1
         +KH34rHC2SMMg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id AE9D815C525C; Thu,  1 Sep 2022 18:18:46 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [RFC PATCH] ext4: limit the number of retries after discarding preallocations blocks
Date:   Thu,  1 Sep 2022 18:18:45 -0400
Message-Id: <20220901221845.1753773-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch avoids threads live-locking for hours when a large number
threads are competing over the last few free extents as they blocks
getting added and removed from preallocation pools.  From our bug
reporter:

   A reliable way for triggering this has multiple writers
   continuously write() to files when the filesystem is full, while
   small amounts of space are freed (e.g. by truncating a large file
   -1MiB at a time). In the local filesystem, this can be done by
   simply not checking the return code of write (0) and/or the error
   (ENOSPACE) that is set. Over NFS with an async mount, even clients
   with proper error checking will behave this way since the linux NFS
   client implementation will not propagate the server errors [the
   write syscalls immediately return success] until the file handle is
   closed. This leads to a situation where NFS clients send a
   continuous stream of WRITE rpcs which result in ERRNOSPACE -- but
   since the client isn't seeing this, the stream of writes continues
   at maximum network speed.

   When some space does appear, multiple writers will all attempt to
   claim it for their current write. For NFS, we may see dozens to
   hundreds of threads that do this.

   The real-world scenario of this is database backup tooling (in
   particular, github.com/mdkent/percona-xtrabackup) which may write
   large files (>1TiB) to NFS for safe keeping. Some temporary files
   are written, rewound, and read back -- all before closing the file
   handle (the temp file is actually unlinked, to trigger automatic
   deletion on close/crash.) An application like this operating on an
   async NFS mount will not see an error code until TiB have been
   written/read.

   The lockup was observed when running this database backup on large
   filesystems (64 TiB in this case) with a high number of block
   groups and no free space. Fragmentation is generally not a factor
   in this filesystem (~thousands of large files, mostly contiguous
   except for the parts written while the filesystem is at capacity.)

[ DO NOT APPLY: This patch has only been lightly tested, although it
  does appear to avoid NFS write threads from getting tied up for
  *hours* before the system recovers.  Sending to the linux-ext4
  mailing list for comments only. -- Ted ]

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/mballoc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index bd8f8b5c3d30..8ab8ab8b0f42 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5565,6 +5565,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	ext4_fsblk_t block = 0;
 	unsigned int inquota = 0;
 	unsigned int reserv_clstrs = 0;
+	int retries = 0;
 	u64 seq;
 
 	might_sleep();
@@ -5667,7 +5668,8 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 			ar->len = ac->ac_b_ex.fe_len;
 		}
 	} else {
-		if (ext4_mb_discard_preallocations_should_retry(sb, ac, &seq))
+		if (++retries < 3 &&
+		    ext4_mb_discard_preallocations_should_retry(sb, ac, &seq))
 			goto repeat;
 		/*
 		 * If block allocation fails then the pa allocated above
-- 
2.31.0

