Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8746C3F4DAD
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 17:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhHWPml (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 11:42:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37264 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhHWPmf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 11:42:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 350122001E;
        Mon, 23 Aug 2021 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629733312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWqVGol3xOLXL+hyFeYak7eDnLICc8Il/RD60SkZBls=;
        b=O7THIV2YdV2KzUV8hVOECql0qMz7vlHevvhsAIqUfUbMnbcN9Oh5zngL/7+8n9fbBksOKK
        41SUku2LwFfZupJxMPImQoWADOxIO5D/281vMbqRNwtc4QGoSzmEVliG06AQnbkucT6J15
        YAJA7NIt2bKwPzOEIgasTDXwVwoq/XQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629733312;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWqVGol3xOLXL+hyFeYak7eDnLICc8Il/RD60SkZBls=;
        b=yYNJaO4m2Zh2kAaaXLNgRj0/oIGpkJ44Bcns60isPaiWO0wxwyHxKoIBiGOVV7UwnJpQ2k
        u3Vc9PCURXVHVlAQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 29FF7A3BBF;
        Mon, 23 Aug 2021 15:41:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E69D91F2CD4; Mon, 23 Aug 2021 17:41:51 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 7/8] debugfs: Fix headers for quota commands
Date:   Mon, 23 Aug 2021 17:41:27 +0200
Message-Id: <20210823154128.16615-8-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210823154128.16615-1-jack@suse.cz>
References: <20210823154128.16615-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4088; h=from:subject; bh=DMtVDsyxwY63aIschGhsYoFtaRzgKdcoj+H6ag3wBwA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhI8GmjMKrGf+RnVrgOxdjhO+t478ULkN2q+GNTt0j Guy1xK+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYSPBpgAKCRCcnaoHP2RA2QAlB/ 9TcSu83oYIMfsnjdrDQJRJLdaWiCSP5A5IET00b2JGlqWkSjTLUhcJUHPWq5ZB9q2hLp8z4V4DoTBT dsDPDPqSS6PmG5jdbjU29Gz/iOmUSnNl1IDCHhO/HJwg5DA+fbwpIC1tbNfw6XpvvqpTi6yYJ6B1LP byj3D2PLrvqQDtoxc+V90n59U/irl9HqVh6BJOBlhyYvOdbAkvunt6LIsQZvuVmjcpL+TYhcI+S6Ey fkyC3hebYfeKTg/ZQunW3bJkhso+XRQqUPGDTU393G3SFn5lywV2pMhhupdW7Rek0BjymcqDEqyhDS VRa3oN+/KSiVWg1qy2JAM+ErlZu5fU
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

list_quota and get_quota commands have 'blocks' header while what they
actually show is a used space in bytes. Fix the header to state 'space'
instead.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 debugfs/quota.c         |  4 ++--
 tests/f_orphquot/expect |  4 ++--
 tests/f_quota/expect.0  | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/debugfs/quota.c b/debugfs/quota.c
index f792bd738781..1da1e03c6d88 100644
--- a/debugfs/quota.c
+++ b/debugfs/quota.c
@@ -123,7 +123,7 @@ void do_list_quota(int argc, char *argv[], int sci_idx EXT2FS_ATTR((unused)),
 
 	printf("%7s %2s   %8s %8s %8s    %8s %8s %8s\n",
 	       quota_type[type], "id",
-	       "blocks", "quota", "limit", "inodes", "quota", "limit");
+	       "space", "quota", "limit", "inodes", "quota", "limit");
 	qh = current_qctx->quota_file[type];
 	retval = qh->qh_ops->scan_dquots(qh, list_quota_callback, NULL);
 	if (retval) {
@@ -158,7 +158,7 @@ void do_get_quota(int argc, char *argv[], int sci_idx EXT2FS_ATTR((unused)),
 
 	printf("%7s %2s   %8s %8s %8s    %8s %8s %8s\n",
 	       quota_type[type], "id",
-	       "blocks", "quota", "limit", "inodes", "quota", "limit");
+	       "space", "quota", "limit", "inodes", "quota", "limit");
 
 	qh = current_qctx->quota_file[type];
 
diff --git a/tests/f_orphquot/expect b/tests/f_orphquot/expect
index f1f0b446c5d1..0f75decd16bd 100644
--- a/tests/f_orphquot/expect
+++ b/tests/f_orphquot/expect
@@ -8,9 +8,9 @@ Pass 5: Checking group summary information
 test_filesystem: ***** FILE SYSTEM WAS MODIFIED *****
 test_filesystem: 11/512 files (9.1% non-contiguous), 1070/2048 blocks
 Exit status is 0
-   user id      blocks   quota    limit      inodes    quota    limit
+   user id      space    quota    limit      inodes    quota    limit
          0      20480        0        0           2        0        0
       1000          0     5000     6000           0       50       60
-  group id      blocks   quota    limit      inodes    quota    limit
+  group id      space    quota    limit      inodes    quota    limit
          0      20480        0        0           2        0        0
        100          0     6000     7000           0       60       70
diff --git a/tests/f_quota/expect.0 b/tests/f_quota/expect.0
index eb5294ee2288..26454856699d 100644
--- a/tests/f_quota/expect.0
+++ b/tests/f_quota/expect.0
@@ -1,21 +1,21 @@
 debugfs: list_quota user
-   user id     blocks    quota    limit      inodes    quota    limit
+   user id      space    quota    limit      inodes    quota    limit
          0      13312        0        0           2        0        0
         34       1024        0        0           1        0        0
        100       2048       32       50           2       20       30
 debugfs: list_quota group
-  group id     blocks    quota    limit      inodes    quota    limit
+  group id      space    quota    limit      inodes    quota    limit
          0      16384        0        0           5        0        0
 debugfs: get_quota user 0
-   user id     blocks    quota    limit      inodes    quota    limit
+   user id      space    quota    limit      inodes    quota    limit
          0      13312        0        0           2        0        0
 debugfs: get_quota user 100
-   user id     blocks    quota    limit      inodes    quota    limit
+   user id      space    quota    limit      inodes    quota    limit
        100       2048       32       50           2       20       30
 debugfs: get_quota user 34
-   user id     blocks    quota    limit      inodes    quota    limit
+   user id      space    quota    limit      inodes    quota    limit
         34       1024        0        0           1        0        0
 debugfs: get_quota group 0
-  group id     blocks    quota    limit      inodes    quota    limit
+  group id      space    quota    limit      inodes    quota    limit
          0      16384        0        0           5        0        0
 debugfs: 
-- 
2.26.2

