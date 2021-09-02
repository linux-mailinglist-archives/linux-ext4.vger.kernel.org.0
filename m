Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2E73FF6E1
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Sep 2021 00:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbhIBWKd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Sep 2021 18:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbhIBWK3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Sep 2021 18:10:29 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61852C061757
        for <linux-ext4@vger.kernel.org>; Thu,  2 Sep 2021 15:09:30 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:104d:444a:d152:279d:1dbb])
        by ms.lwn.net (Postfix) with ESMTPA id F04F06178;
        Thu,  2 Sep 2021 22:09:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F04F06178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1630620569; bh=z4YQ2bKbvh9iJKRv/z6HGC9spuoWG4zBUH4fxjKo/PI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6j8FaOwLfolXHBWVrZvr7VP7fhDjyotq24w638rSjDLx2aTuqq2DqIan8hlhYF4D
         vr2nHtLx12OKutIkRr/uMK/LbuKvWk2vAmKsQYyhzXgM+zeTAJZ5jSQu8M4oKWOFAG
         01Scv9F6QO9mNAFiL2kFubk3g1sdOHZoh6CogTEOY4wFy66BO6OhohrM+Ld+Ir5ARQ
         /sEvQg42GeRpQwioivHW4YcWuIDfuNwr7vvAnf7ZZubqJxF4eRVNX7hwRrZnYvZdNx
         fF6SIggzOIkCRcCXDN1/3Ys0627zwITy6Bq+29yeRv6teP3qDmcaBgguruGlH42HOC
         Asl5nFKCRXdSg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/2] ext4: docs: switch away from list-table
Date:   Thu,  2 Sep 2021 16:08:53 -0600
Message-Id: <20210902220854.198850-2-corbet@lwn.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210902220854.198850-1-corbet@lwn.net>
References: <20210902220854.198850-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Commit 3a6541e97c03 (Add documentation about the orphan file feature) added
a new document on orphan files, which is great.  But the use of
"list-table" results in documents that are absolutely unreadable in their
plain-text form.  Switch this file to the regular RST table format instead;
the rendered (HTML) output is identical.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/filesystems/ext4/orphan.rst | 32 ++++++++---------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/Documentation/filesystems/ext4/orphan.rst b/Documentation/filesystems/ext4/orphan.rst
index bb19ecd1b626..d096fe0ba19e 100644
--- a/Documentation/filesystems/ext4/orphan.rst
+++ b/Documentation/filesystems/ext4/orphan.rst
@@ -21,27 +21,17 @@ in heavy creation of orphan inodes. When orphan file feature
 (referenced from the superblock through s\_orphan_file_inum) with several
 blocks. Each of these blocks has a structure:
 
-.. list-table::
-   :widths: 8 8 24 40
-   :header-rows: 1
-
-   * - Offset
-     - Type
-     - Name
-     - Description
-   * - 0x0
-     - Array of \_\_le32 entries
-     - Orphan inode entries
-     - Each \_\_le32 entry is either empty (0) or it contains inode number of
-       an orphan inode.
-   * - blocksize - 8
-     - \_\_le32
-     - ob\_magic
-     - Magic value stored in orphan block tail (0x0b10ca04)
-   * - blocksize - 4
-     - \_\_le32
-     - ob\_checksum
-     - Checksum of the orphan block.
+============= ================ =============== ===============================
+Offset        Type             Name            Description
+============= ================ =============== ===============================
+0x0           Array of         Orphan inode    Each \_\_le32 entry is either
+              \_\_le32 entries entries         empty (0) or it contains
+	                                       inode number of an orphan
+					       inode.
+blocksize-8   \_\_le32         ob\_magic       Magic value stored in orphan
+                                               block tail (0x0b10ca04)
+blocksize-4   \_\_le32         ob\_checksum    Checksum of the orphan block.
+============= ================ =============== ===============================
 
 When a filesystem with orphan file feature is writeably mounted, we set
 RO\_COMPAT\_ORPHAN\_PRESENT feature in the superblock to indicate there may
-- 
2.31.1

