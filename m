Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 093972D24B
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2019 01:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfE1XNs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 May 2019 19:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfE1XNs (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 May 2019 19:13:48 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87F8B20989
        for <linux-ext4@vger.kernel.org>; Tue, 28 May 2019 23:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559085226;
        bh=OyLfWHPPXzaZzqmIC/KJdKCkAaN0fDnemk19P19bgd8=;
        h=From:To:Subject:Date:From;
        b=zghF678uWBkG6d60sdlywb4nxnIe3xfg79ZRsw19XugTb18M0upqnE6++ve7eSHY0
         W08a7gUp3lqo4xLD0h6Qpqhq9W/AP08Ww0Vp3he5QRBXwWMVNIx36Z4L0Jjcd5MtTy
         8k0wEBazZz1CjRxLV7weTdST3U+7C4OA73J9AgYo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH e2fsprogs] tests: add test for e2fsck of verity file
Date:   Tue, 28 May 2019 16:12:30 -0700
Message-Id: <20190528231230.234342-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Test that e2fsck doesn't report errors when an inode with the 'verity'
flag has blocks past i_size.

This is a regression test for commits 3baafde6a8ae ("e2fsck: allow
verity files to have initialized blocks past i_size") and 43466d039689
("e2fsck: handle verity files in scan_extent_node()").

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/f_verity/expect.1   |   7 +++++++
 tests/f_verity/image.gz   | Bin 0 -> 2247 bytes
 tests/f_verity/mkimage.sh |  28 ++++++++++++++++++++++++++++
 tests/f_verity/name       |   1 +
 tests/f_verity/script     |   2 ++
 5 files changed, 38 insertions(+)
 create mode 100644 tests/f_verity/expect.1
 create mode 100644 tests/f_verity/image.gz
 create mode 100755 tests/f_verity/mkimage.sh
 create mode 100644 tests/f_verity/name
 create mode 100644 tests/f_verity/script

diff --git a/tests/f_verity/expect.1 b/tests/f_verity/expect.1
new file mode 100644
index 00000000..07059677
--- /dev/null
+++ b/tests/f_verity/expect.1
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 12/128 files (8.3% non-contiguous), 58/128 blocks
+Exit status is 0
diff --git a/tests/f_verity/image.gz b/tests/f_verity/image.gz
new file mode 100644
index 0000000000000000000000000000000000000000..72dfd8169ace0e2a2ace35f5d2c010601623b168
GIT binary patch
literal 2247
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

literal 0
HcmV?d00001

diff --git a/tests/f_verity/mkimage.sh b/tests/f_verity/mkimage.sh
new file mode 100755
index 00000000..565083e2
--- /dev/null
+++ b/tests/f_verity/mkimage.sh
@@ -0,0 +1,28 @@
+#!/bin/bash
+
+# This is the script that was used to create the image.gz in this directory.
+
+set -e -u
+
+mkdir -p mnt
+umount mnt &> /dev/null || true
+
+dd if=/dev/zero of=image bs=4096 count=128
+mke2fs -O 'verity,extents' -b 4096 -N 128 image
+mount image mnt
+
+# Create a verity file, but make it fragmented so that it needs at least one
+# extent tree index node, in order to cover the scan_extent_node() case.
+for i in {1..80}; do
+	head -c 4096 /dev/zero > mnt/tmp_$i
+done
+for i in {1..80..2}; do
+	rm mnt/tmp_$i
+done
+head -c $((40 * 4096)) /dev/zero > mnt/file
+fsverity enable mnt/file
+rm mnt/tmp_*
+
+umount mnt
+rmdir mnt
+gzip -9 -f image
diff --git a/tests/f_verity/name b/tests/f_verity/name
new file mode 100644
index 00000000..f43910fc
--- /dev/null
+++ b/tests/f_verity/name
@@ -0,0 +1 @@
+verity file
diff --git a/tests/f_verity/script b/tests/f_verity/script
new file mode 100644
index 00000000..8ab2b9c6
--- /dev/null
+++ b/tests/f_verity/script
@@ -0,0 +1,2 @@
+ONE_PASS_ONLY="true"
+. $cmd_dir/run_e2fsck
-- 
2.22.0.rc1.257.g3120a18244-goog

