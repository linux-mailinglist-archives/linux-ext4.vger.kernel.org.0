Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC1835A7AA
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Apr 2021 22:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhDIUMb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 16:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234159AbhDIUMa (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 9 Apr 2021 16:12:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 697C461074;
        Fri,  9 Apr 2021 20:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617999137;
        bh=uJzvepm4V1IVNAEurrXgGeXB/XY0OoXDzNCdgtMXhsw=;
        h=From:To:Cc:Subject:Date:From;
        b=NmyOqkXH7C3a6k6hWjCTHR8omXfwLnmZJnOT+p/cGHc5mm6y9qo5n/68g0o+Oqoy7
         d2vgHts1gijz+TahCgZDOoEpobhGQmAzwEKaemFO3gi8pT02Sbltz8D/Kw+MlYRm9U
         Tto7QJR30NwlXkf6ghzGdZaJ4J7n0jIdIyh6GgyFRTEb08bC+neOPEBsCAIoWbAsc1
         yRQQlLGt3qrcUfWfD5zVXoB8rr+wkFnQlDRQ1VidZxyoEHM1MkygmO+IY5HYsxhWuW
         EneAR3L/VLPmy9mLMeqJU4u0I87iJWEN/kP8LS9cJ+oTfcbFa7ZgvGmNK7W0P6ZANX
         Tys7X4/3RkCqw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Yi Li <yili@winhong.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        changfengnan <fengnanchang@foxmail.com>,
        Shijie Luo <luoshijie1@huawei.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: fix debug format string warning
Date:   Fri,  9 Apr 2021 22:12:05 +0200
Message-Id: <20210409201211.1866633-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Using no_printk() for jbd_debug() revealed two warnings:

fs/jbd2/recovery.c: In function 'fc_do_one_pass':
fs/jbd2/recovery.c:256:30: error: format '%d' expects a matching 'int' argument [-Werror=format=]
  256 |                 jbd_debug(3, "Processing fast commit blk with seq %d");
      |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/ext4/fast_commit.c: In function 'ext4_fc_replay_add_range':
fs/ext4/fast_commit.c:1732:30: error: format '%d' expects argument of type 'int', but argument 2 has type 'long unsigned int' [-Werror=format=]
 1732 |                 jbd_debug(1, "Converting from %d to %d %lld",

The first one was added incorrectly, and was also missing a few newlines
in debug output, and the second one happened when the type of an
argument changed.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: d556435156b7 ("jbd2: avoid -Wempty-body warnings")
Fixes: 6db074618969 ("ext4: use BIT() macro for BH_** state bits")
Fixes: 5b849b5f96b4 ("jbd2: fast commit recovery path")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ext4/fast_commit.c | 2 +-
 fs/jbd2/recovery.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 6c4f19b0a556..feec2f3f13e9 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1729,7 +1729,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 		}
 
 		/* Range is mapped and needs a state change */
-		jbd_debug(1, "Converting from %d to %d %lld",
+		jbd_debug(1, "Converting from %ld to %d %lld",
 				map.m_flags & EXT4_MAP_UNWRITTEN,
 			ext4_ext_is_unwritten(ex), map.m_pblk);
 		ret = ext4_ext_replay_update_ex(inode, cur, map.m_len,
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 69f18fe20923..60601c5779f1 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -245,15 +245,15 @@ static int fc_do_one_pass(journal_t *journal,
 		return 0;
 
 	while (next_fc_block <= journal->j_fc_last) {
-		jbd_debug(3, "Fast commit replay: next block %ld",
+		jbd_debug(3, "Fast commit replay: next block %ld\n",
 			  next_fc_block);
 		err = jread(&bh, journal, next_fc_block);
 		if (err) {
-			jbd_debug(3, "Fast commit replay: read error");
+			jbd_debug(3, "Fast commit replay: read error\n");
 			break;
 		}
 
-		jbd_debug(3, "Processing fast commit blk with seq %d");
+		jbd_debug(3, "Processing fast commit blk with seq\n");
 		err = journal->j_fc_replay_callback(journal, bh, pass,
 					next_fc_block - journal->j_fc_first,
 					expected_commit_id);
-- 
2.29.2

