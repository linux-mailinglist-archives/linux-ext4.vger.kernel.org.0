Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF773194C7
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 21:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhBKU4W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 15:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBKU4V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Feb 2021 15:56:21 -0500
X-Greylist: delayed 444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 Feb 2021 12:55:41 PST
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D92C061574
        for <linux-ext4@vger.kernel.org>; Thu, 11 Feb 2021 12:55:41 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1613076492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=c4Wcx89Je3Uyh5vlkehb7v06vZrgZvS4mV95BGLipYs=;
        b=jkpzQw6Nq/Ud9ah8xIdGQnESsKFk8Je/aBywYafv9yPIzLbq9JZXtZxCXKT7CYaM0ztZY8
        j5AASr2QC5vEGOZzmJh8q2xtLP46MVndMalIK5pKwCxOWZTaOB/ryKL3i+TzYStAD87mAS
        3qSotv32DO9yMDYer/rwcqoBIIfFZtRNc7oO3bRA6/xeDbfkB6qvcFK9uTCTKWxhf1iarx
        8sj7yXchDJzLyPcaw8Eu6nlgr59OdW1GQOwOC4A75V8Ga6TNgukk/iHnY4TGq3hYCD2myv
        QmytkCEutLONHpe0yD7ssklInufLYZBaI3TD4mgHGLJHAFtt3Lc3P3F4YQe2RQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 11 Feb 2021 15:48:11 -0500
Message-Id: <C96ZW60NLAQF.1JF09JLHKR51M@taiga>
Subject: j_recover_fast_commit: : failed on musl-riscv64
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     <linux-ext4@vger.kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hiya! I'm not really sure how to interpret this test failure with
e2fsprogs 1.46.1. Any ideas?

$ cat src/e2fsprogs-1.46.1/tests/j_recover_fast_commit.log
Journal checksum error found in test_filesys
Pass 1: Checking inodes, blocks, and sizes
Inode 14, i_blocks is 0, should be 2.  Fix? yes

Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Unattached inode 14
Connect to /lost+found? yes

Inode 14 ref count is 2, should be 1.  Fix? yes

Pass 5: Checking group summary information
Block bitmap differences:  +1107
Fix? yes

Free blocks count wrong for group #0 (941, counted=3D940).
Fix? yes

Free blocks count wrong (942, counted=3D940).
Fix? yes

Free inodes count wrong (245, counted=3D242).
Fix? yes


test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
test_filesys: 14/256 files (7.1% non-contiguous), 1108/2048 blocks
Exit status is 0
debugfs: ls
 2  (12) .    2  (12) ..    11  (20) lost+found    12  (968) a
debugfs: ls a/
 12  (12) .    2  (12) ..    13  (988) old
debugfs: ex a/new
debugfs: ex a/data
$ cat src/e2fsprogs-1.46.1/tests/j_recover_fast_commit.failed
--- j_recover_fast_commit/expect	2021-02-09 23:36:32.000000000 +0000
+++ j_recover_fast_commit.log	2021-02-11 20:39:26.306134217 +0000
@@ -1,22 +1,35 @@
+Journal checksum error found in test_filesys
 Pass 1: Checking inodes, blocks, and sizes
+Inode 14, i_blocks is 0, should be 2.  Fix? yes
+
 Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
 Pass 4: Checking reference counts
+Unattached inode 14
+Connect to /lost+found? yes
+
+Inode 14 ref count is 2, should be 1.  Fix? yes
+
 Pass 5: Checking group summary information
-test_filesys: 14/256 files (14.3% non-contiguous), 1365/2048 blocks
+Block bitmap differences:  +1107
+Fix? yes
+
+Free blocks count wrong for group #0 (941, counted=3D940).
+Fix? yes
+
+Free blocks count wrong (942, counted=3D940).
+Fix? yes
+
+Free inodes count wrong (245, counted=3D242).
+Fix? yes
+
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 14/256 files (7.1% non-contiguous), 1108/2048 blocks
 Exit status is 0
 debugfs: ls
  2  (12) .    2  (12) ..    11  (20) lost+found    12  (968) a
 debugfs: ls a/
- 12  (12) .    2  (12) ..    13  (12) data    14  (976) new
+ 12  (12) .    2  (12) ..    13  (988) old
 debugfs: ex a/new
-Level Entries       Logical      Physical Length Flags
- 0/ 0   1/  1     0 -     0  1107 -  1107      1
 debugfs: ex a/data
-Level Entries       Logical      Physical Length Flags
- 0/ 1   1/  1     0 -   255  1618            256
- 1/ 1   1/  5     0 -    15  1619 -  1634     16
- 1/ 1   2/  5    16 -    31  1601 -  1616     16
- 1/ 1   3/  5    32 -    63  1985 -  2016     32
- 1/ 1   4/  5    64 -   127  1537 -  1600     64
- 1/ 1   5/  5   128 -   255  1793 -  1920    128
