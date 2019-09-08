Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D45DCAD042
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Sep 2019 19:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfIHRv0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Sep 2019 13:51:26 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39488 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfIHRv0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 8 Sep 2019 13:51:26 -0400
Received: by mail-io1-f68.google.com with SMTP id d25so23689653iob.6;
        Sun, 08 Sep 2019 10:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=XetzNUYbniOZ6Af7Q3Cl4LlL+EZ3+sdepj4c/tskqUQ=;
        b=ENwRMQ79kVyLASpfx5qsOGgWmSoOQCC3CjMv0h93JRCsv6asVgPwhNePnUauZplvtJ
         +TmvWOe0PDRp3INhbrs0NtniNHtPdpRnm2nBDqCGggW5UltP6jmgB4b2jOdeR4valsyN
         cW+IDDQi08zKeZ1GUi8YsdxjjBgV0lZjw4IMTG6CPI+GTSW4b1xGog6ZAa6WepEd5Pug
         Uw5NMCL8cnBiVWaEQCjzSrcP+jpUSQDAs3f+NZQ0XzqQqT1SLwnhG7oNPv97dEjqLn/t
         vMhyJIJOaKrX4TFjt31hgXicB9/PSOXwa260epPU+3523Ic/0pEAaEL4ID5wU9stA4hV
         vALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=XetzNUYbniOZ6Af7Q3Cl4LlL+EZ3+sdepj4c/tskqUQ=;
        b=DKlvBKSjoBDH6Imqn/40c4TYPmiSgDXMOXozRRIXEzgpXmD4/R4Lgo3rD5B8BlPY3V
         x36lQQRPv7axZ5CaYcyu1FxbHCI6tbSzqTw+dkOiDUsU2hJU4X8QXBXIoRR0GJYXLM0v
         kCm4cEu7EkWlywW2jD5x7L8Fi6s5xXjV8BfsrZU2mwuD3R6jbma2FzjJBTwYT80gonlz
         XESGD148e7SUV+576VOM0O+AZitvE4EYpCeYP4k0m2oio6i7PR6lOffb90COOC57B8i9
         ALQeXTopsampVTRijUlWWmryMuAsa8YpGBUKQTtc3icBYt8IxipLwcnGGN/EzAuNWOTe
         iTeA==
X-Gm-Message-State: APjAAAUfu4gaWQzDommCkpBOjT7PgQLfqPRfzOj/NksQxCvibduFqgNF
        bFDIUXjLUb4G0L56SWE20yBLEo4SccU=
X-Google-Smtp-Source: APXvYqw9LgovXRvHjqmLu2RfEcYbkrVFPLZtSSEeRPuo6p9FqQRCcU56lm/2t2OxVPPrfxNwLL0EXQ==
X-Received: by 2002:a6b:6e0a:: with SMTP id d10mr7833585ioh.141.1567965084446;
        Sun, 08 Sep 2019 10:51:24 -0700 (PDT)
Received: from fa19-cs241-404 ([192.17.168.68])
        by smtp.gmail.com with ESMTPSA id t15sm10745100ioc.68.2019.09.08.10.51.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Sep 2019 10:51:23 -0700 (PDT)
From:   Ayush Ranjan <ayush.ranjan98@gmail.com>
X-Google-Original-From: Ayush Ranjan <ayushr2@illinois.edu>
Date:   Sun, 8 Sep 2019 12:51:23 -0500
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Ext4 Documentation: Add missing quota section.
Message-ID: <20190908175123.GA14145@fa19-cs241-404.cs.illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There were a few broken links for quota. The page
https://ext4.wiki.kernel.org/index.php/Quota was not migrated into
the current documentation sources. This patch adds the contents of that
missing page as a new section in the overview page. Also fixes those
broken links by replacing them with cross document links to this new
quota section.

Signed-off-by: Ayush Ranjan <ayushr2@illinois.edu>
---
 Documentation/filesystems/ext4/overview.rst |  1 +
 Documentation/filesystems/ext4/quota.rst    | 53 +++++++++++++++++++++
 Documentation/filesystems/ext4/super.rst    |  6 +--
 3 files changed, 57 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/filesystems/ext4/quota.rst

diff --git a/Documentation/filesystems/ext4/overview.rst b/Documentation/filesystems/ext4/overview.rst
index cbab18bab..f97ea68ea 100644
--- a/Documentation/filesystems/ext4/overview.rst
+++ b/Documentation/filesystems/ext4/overview.rst
@@ -24,3 +24,4 @@ order.
 .. include:: bigalloc.rst
 .. include:: inlinedata.rst
 .. include:: eainode.rst
+.. include:: quota.rst
diff --git a/Documentation/filesystems/ext4/quota.rst b/Documentation/filesystems/ext4/quota.rst
new file mode 100644
index 000000000..8964c26cb
--- /dev/null
+++ b/Documentation/filesystems/ext4/quota.rst
@@ -0,0 +1,53 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _quota:
+
+Quota Feature
+-------------
+
+The quota feature (``EXT4_FEATURE_RO_COMPAT_QUOTA``) causes the quota
+files (i.e., user.quota and group.quota which existed in the older quota
+design) to be hidden inodes, so they can not be corrupted by user space
+programs. Instead, these inodes are managed directly via e2fsprogs, and
+journaled quota will be automatically enabled by the kernel as soon as
+the file system is mounted. This way, it strongly reduces the
+possibility that the usage tracking performed by the file system will
+get out of sync.
+
+Kernel Support
+~~~~~~~~~~~~~~
+
+Support for the quota feature first appeared in the 3.6 upstream kernel
+version. There is a bug which will not be fixed until v3.8 which will
+cause ext4 to fail to mount a file system with quotas if the quota code
+is built as a module. So users who wish to experiment with this feature
+are strongly encouraged to build with the following configuration
+options:
+
+- ``CONFIG_QUOTA=y``
+- ``CONFIG_QUOTATREE=y``
+- ``CONFIG_QUOTACTL=y``
+
+E2fsprogs Support
+~~~~~~~~~~~~~~~~~
+
+Support for the quota feature first appeared in e2fsprogs 1.42, although
+it is not enabled by default. It must enabled via a compile-time
+configuration option, --enable-quota. There are bug fixes which have
+been applied in various 1.42.x maintenance branch releases, so users who
+wish to experiment with the quota feature are strongly encouraged
+upgrade to the latest e2fsprogs 1.42.x maintenance release. As of this
+writing the following bugs are still in e2fsprogs 1.42.7, which means
+use of file systems with the quota feature in production can not be
+recommended:
+
+- The e2fsck check of the on-disk quota inodes won't notice if there is
+  a missing uid record. (i.e., if some uid, say daemon owns a bunch of
+  files, but that uid record is not in the quota inode, e2fsck won't say
+  boo.)
+- If e2fsck *does* notice a discrepancy between the usage information
+  recorded in the hidden quota inodes, and the actual number of blocks
+  used by a particular user id or group id, it will overwrite the user
+  or group quota inode with all of the information it has.
+  Unfortunately, in the process it will zero out all of the current
+  quota limits set. This is unfortunate....
diff --git a/Documentation/filesystems/ext4/super.rst b/Documentation/filesystems/ext4/super.rst
index 04ff079a2..2a9e1438f 100644
--- a/Documentation/filesystems/ext4/super.rst
+++ b/Documentation/filesystems/ext4/super.rst
@@ -404,11 +404,11 @@ The ext4 superblock is laid out as follows in
    * - 0x240
      - \_\_le32
      - s\_usr\_quota\_inum
-     - Inode number of user `quota <quota>`__ file.
+     - Inode number of user :ref:`quota <quota>` file.
    * - 0x244
      - \_\_le32
      - s\_grp\_quota\_inum
-     - Inode number of group `quota <quota>`__ file.
+     - Inode number of group :ref:`quota <quota>` file.
    * - 0x248
      - \_\_le32
      - s\_overhead\_blocks
@@ -678,7 +678,7 @@ the following:
    * - 0x80
      - This filesystem has a snapshot (RO\_COMPAT\_HAS\_SNAPSHOT).
    * - 0x100
-     - `Quota <Quota>`__ (RO\_COMPAT\_QUOTA).
+     - :ref:`Quota <quota>` (RO\_COMPAT\_QUOTA).
    * - 0x200
      - This filesystem supports “bigalloc”, which means that file extents are
        tracked in units of clusters (of blocks) instead of blocks
-- 
2.23.0

