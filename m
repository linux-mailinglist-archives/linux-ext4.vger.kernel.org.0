Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F7D2FDE07
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 01:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393236AbhAUAdT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jan 2021 19:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733184AbhATVb6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jan 2021 16:31:58 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6FFC0617BC
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 13:27:03 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q7so16087868pgm.5
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 13:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ouaMzCoxp6ONUY2FJ85kwqbl7hDqgCoxdYUkYa46hyo=;
        b=Za/8GIx19csJQu5X9xvR7oAGsWq8HtcZ9aTnTjMGX+Ly2A0naW3jltotRmLQ1mQnpX
         i+aCxdpGli3DKfW8jjy9C7RECrBMHLmbm/LB03e3Y/rDayYLgL7AANPRKmGB49592Vpa
         9p8ZyihI7r7s0lHAjzjCxY9FBw/90OGwQsVi/UTGTM74Lmz9cCdJSa6PGcmHemShjyPd
         NfPjqQ35eDm4gQrc5to++FbMmUkDpQzE2QHB3PpRpLS3WJ7RSGc4AYb+it10RMDi2O3C
         HPJ21gMvM7awwpkCif0Enp7jzB8sPj2/FL9b88lMmvS2wb1AybdQyLRkUGBdDZBl8yoD
         z3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ouaMzCoxp6ONUY2FJ85kwqbl7hDqgCoxdYUkYa46hyo=;
        b=RhvI/Kbs3tRqegEoUZFyv6tvLB1+diw7eLQKCgHC5o/vU3Bxy00Evft+rVeEwSf2E8
         9msTFcxS74YBQ4ZP7l7lV+YYJiZhzpaBrcMsk0PccX4RouXbn+vlzJ9PanFb6UGkep51
         tkuqIl6WAL89AbaSDADzzpv+NwZ2cXvojdJ42TMxnzXo24xRlRke9qgO6DUo1T3SDRq1
         0iENiCgibVpWYUh3IcuRqyPsObvsVCfDiE2pbTDro4qvayJ4a5743M7SX7mykTORQv0V
         6GKEJ3IbEBcj6I+1WLffmba76W8tJ7po+UDStloaHYoEb8nGmYu1PKuZA1DSaaLKEF2F
         osCQ==
X-Gm-Message-State: AOAM533iXANxPTDhzlNd07WPI8Brcd62oszSPp8CyMVnvV5hNq+ekXl0
        0jEuIiFzUyFgr8HP9icxjSi8yTwPF9U=
X-Google-Smtp-Source: ABdhPJwnm2pjBPef5ysI1BK/jcY1g2RQwViMnP4HIsb08U4p0vv1okucBtQneMY+QtiM5nerO9fpWw==
X-Received: by 2002:a62:3503:0:b029:1aa:6f15:b9fe with SMTP id c3-20020a6235030000b02901aa6f15b9femr10957166pfa.65.1611178022793;
        Wed, 20 Jan 2021 13:27:02 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id w1sm3396758pjt.23.2021.01.20.13.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:27:01 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <--global>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 14/15] tests: add fast commit recovery tests
Date:   Wed, 20 Jan 2021 13:26:40 -0800
Message-Id: <20210120212641.526556-15-user@harshads-520.kir.corp.google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
References: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Add j_recover_fast_commit test that ensure that e2fsck is able to
recover a disk from fast commit log.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 tests/j_recover_fast_commit/commands |   4 ++++
 tests/j_recover_fast_commit/expect   |  23 +++++++++++++++++++++++
 tests/j_recover_fast_commit/image.gz | Bin 0 -> 3595 bytes
 tests/j_recover_fast_commit/script   |  26 ++++++++++++++++++++++++++
 4 files changed, 53 insertions(+)
 create mode 100644 tests/j_recover_fast_commit/commands
 create mode 100644 tests/j_recover_fast_commit/expect
 create mode 100644 tests/j_recover_fast_commit/image.gz
 create mode 100755 tests/j_recover_fast_commit/script

diff --git a/tests/j_recover_fast_commit/commands b/tests/j_recover_fast_commit/commands
new file mode 100644
index 00000000..74e20e4e
--- /dev/null
+++ b/tests/j_recover_fast_commit/commands
@@ -0,0 +1,4 @@
+ls
+ls a/
+ex a/new
+ex a/data
diff --git a/tests/j_recover_fast_commit/expect b/tests/j_recover_fast_commit/expect
new file mode 100644
index 00000000..2fc1e53f
--- /dev/null
+++ b/tests/j_recover_fast_commit/expect
@@ -0,0 +1,23 @@
+test_filesys: recovering journal
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 14/256 files (14.3% non-contiguous), 1365/2048 blocks
+Exit status is 0
+debugfs: ls
+ 2  (12) .    2  (12) ..    11  (20) lost+found    12  (968) a   
+debugfs: ls a/
+ 12  (12) .    2  (12) ..    13  (12) data    14  (976) new   
+debugfs: ex a/new
+Level Entries       Logical      Physical Length Flags
+ 0/ 0   1/  1     0 -     0  1107 -  1107      1 
+debugfs: ex a/data
+Level Entries       Logical      Physical Length Flags
+ 0/ 1   1/  1     0 -   255  1618            256
+ 1/ 1   1/  5     0 -    15  1619 -  1634     16 
+ 1/ 1   2/  5    16 -    31  1601 -  1616     16 
+ 1/ 1   3/  5    32 -    63  1985 -  2016     32 
+ 1/ 1   4/  5    64 -   127  1537 -  1600     64 
+ 1/ 1   5/  5   128 -   255  1793 -  1920    128 
diff --git a/tests/j_recover_fast_commit/image.gz b/tests/j_recover_fast_commit/image.gz
new file mode 100644
index 0000000000000000000000000000000000000000..b7357afc46bec8a0154d5746fa2fce86c2341efc
GIT binary patch
literal 3595
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
HWGCd`W!a1I

literal 0
HcmV?d00001

diff --git a/tests/j_recover_fast_commit/script b/tests/j_recover_fast_commit/script
new file mode 100755
index 00000000..6bdb8258
--- /dev/null
+++ b/tests/j_recover_fast_commit/script
@@ -0,0 +1,26 @@
+#!/bin/bash
+
+FSCK_OPT=-fy
+IMAGE=$test_dir/image.gz
+CMDS=$test_dir/commands
+
+gunzip < $IMAGE > $TMPFILE
+
+# Run fsck to fix things?
+EXP=$test_dir/expect
+OUT=$test_name.log
+
+cp $TMPFILE /tmp/debugthis
+$FSCK $FSCK_OPT -E journal_only -N test_filesys $TMPFILE 2>&1 | head -n 1000 | tail -n +2 > $OUT
+echo "Exit status is $?" >> $OUT
+
+$DEBUGFS -f $CMDS $TMPFILE >> $OUT 2>/dev/null
+
+# Figure out what happened
+if cmp -s $EXP $OUT; then
+	echo "$test_name: $test_description: ok"
+	touch $test_name.ok
+else
+	echo "$test_name: $test_description: failed"
+	diff -u $EXP $OUT >> $test_name.failed
+fi
-- 
2.30.0.284.gd98b1dd5eaa7-goog

