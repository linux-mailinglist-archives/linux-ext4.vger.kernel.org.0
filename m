Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952611AAA3F
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Apr 2020 16:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894372AbgDOOit (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Apr 2020 10:38:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394080AbgDOOdD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Apr 2020 10:33:03 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9150121D7E;
        Wed, 15 Apr 2020 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961171;
        bh=8XWaSPQEn2foEpJeuRzmwtKfRSy0jcH1jiL1DK6qlto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AP+f0GmvQ6G0JBFmdKJqZshPjHodSus0vbl5J9sBS9owW+n7b0zrdxk8xFyNAesV5
         h+xIAakhmIVrieT1xjBycxZzwICap5J9XK9ksadIen6XF85K70JTbLtXmKazT593He
         r7jVCWLjqIEsinUQiPR5uZO5srTuMjowi/fCqq0A=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOj5t-006kOe-DB; Wed, 15 Apr 2020 16:32:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Subject: [PATCH 12/34] docs: filesystems: convert dax.txt to ReST
Date:   Wed, 15 Apr 2020 16:32:25 +0200
Message-Id: <71b1f910b2c3569a9fdaa8778378dd734f4f0091.1586960617.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586960617.git.mchehab+huawei@kernel.org>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

- Add a SPDX header;
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/ext4.rst             | 2 +-
 Documentation/filesystems/{dax.txt => dax.rst} | 9 +++++++--
 Documentation/filesystems/ext2.rst             | 2 +-
 Documentation/filesystems/index.rst            | 1 +
 4 files changed, 10 insertions(+), 4 deletions(-)
 rename Documentation/filesystems/{dax.txt => dax.rst} (97%)

diff --git a/Documentation/admin-guide/ext4.rst b/Documentation/admin-guide/ext4.rst
index 9443fcef1876..103bcc345bad 100644
--- a/Documentation/admin-guide/ext4.rst
+++ b/Documentation/admin-guide/ext4.rst
@@ -392,7 +392,7 @@ When mounting an ext4 filesystem, the following option are accepted:
 
   dax
         Use direct access (no page cache).  See
-        Documentation/filesystems/dax.txt.  Note that this option is
+        Documentation/filesystems/dax.rst.  Note that this option is
         incompatible with data=journal.
 
 Data Mode
diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.rst
similarity index 97%
rename from Documentation/filesystems/dax.txt
rename to Documentation/filesystems/dax.rst
index 735f3859b19f..5838144f80f0 100644
--- a/Documentation/filesystems/dax.txt
+++ b/Documentation/filesystems/dax.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
 Direct Access for files
------------------------
+=======================
 
 Motivation
 ----------
@@ -46,6 +49,7 @@ stall the CPU for an extended period, you should also not attempt to
 implement direct_access.
 
 These block devices may be used for inspiration:
+
 - brd: RAM backed block device driver
 - dcssblk: s390 dcss block device driver
 - pmem: NVDIMM persistent memory driver
@@ -55,6 +59,7 @@ Implementation Tips for Filesystem Writers
 ------------------------------------------
 
 Filesystem support consists of
+
 - adding support to mark inodes as being DAX by setting the S_DAX flag in
   i_flags
 - implementing ->read_iter and ->write_iter operations which use dax_iomap_rw()
@@ -127,6 +132,6 @@ by adding optional struct page support for pages under the control of
 the driver (see CONFIG_NVDIMM_PFN in drivers/nvdimm for an example of
 how to do this). In the non struct page cases O_DIRECT reads/writes to
 those memory ranges from a non-DAX file will fail (note that O_DIRECT
-reads/writes _of a DAX file_ do work, it is the memory that is being
+reads/writes _of a DAX ``file_`` do work, it is the memory that is being
 accessed that is key here).  Other things that will not work in the
 non struct page case include RDMA, sendfile() and splice().
diff --git a/Documentation/filesystems/ext2.rst b/Documentation/filesystems/ext2.rst
index d83dbbb162e2..fa416b7a5802 100644
--- a/Documentation/filesystems/ext2.rst
+++ b/Documentation/filesystems/ext2.rst
@@ -24,7 +24,7 @@ check=none, nocheck	(*)	Don't do extra checking of bitmaps on mount
 				(check=normal and check=strict options removed)
 
 dax				Use direct access (no page cache).  See
-				Documentation/filesystems/dax.txt.
+				Documentation/filesystems/dax.rst.
 
 debug				Extra debugging information is sent to the
 				kernel syslog.  Useful for developers.
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index c4f95f76ba6a..8e3ccb4ed483 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -24,6 +24,7 @@ algorithms work.
    splice
    locking
    directory-locking
+   dax
 
    automount-support
 
-- 
2.25.2

