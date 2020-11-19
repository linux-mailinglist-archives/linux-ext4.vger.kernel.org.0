Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587C72B9C3A
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Nov 2020 21:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgKSUqq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Nov 2020 15:46:46 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48460 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725890AbgKSUqq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Nov 2020 15:46:46 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AJKkgsw005554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 15:46:42 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DC7F7420107; Thu, 19 Nov 2020 15:46:41 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     harshads@google.com
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: drop fast_commit from /proc/mounts
Date:   Thu, 19 Nov 2020 15:46:37 -0500
Message-Id: <20201119204638.666812-1-tytso@mit.edu>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The options in /proc/mounts must be valid mount options --- and
fast_commit is not a mount option.  Otherwise, command sequences like
this will fail:

    # mount /dev/vdc /vdc
    # mkdir -p /vdc/phoronix_test_suite /pts
    # mount --bind /vdc/phoronix_test_suite /pts
    # mount -o remount,nodioread_nolock /pts
    mount: /pts: mount point not mounted or bad option.

And in the system logs, you'll find:

    EXT4-fs (vdc): Unrecognized mount option "fast_commit" or missing value

Fixes: 995a3ed67fc8 ("ext4: add fast_commit feature and handling for extended mount options")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/super.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6633b20224d5..94472044f4c1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2638,10 +2638,6 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 	} else if (test_opt2(sb, DAX_INODE)) {
 		SEQ_OPTS_PUTS("dax=inode");
 	}
-
-	if (test_opt2(sb, JOURNAL_FAST_COMMIT))
-		SEQ_OPTS_PUTS("fast_commit");
-
 	ext4_show_quota_options(seq, sb);
 	return 0;
 }
-- 
2.28.0

