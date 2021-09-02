Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6D53FF6E2
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Sep 2021 00:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhIBWKf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Sep 2021 18:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhIBWK3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Sep 2021 18:10:29 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B699C061575;
        Thu,  2 Sep 2021 15:09:30 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:104d:444a:d152:279d:1dbb])
        by ms.lwn.net (Postfix) with ESMTPA id 5D6A561C7;
        Thu,  2 Sep 2021 22:09:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5D6A561C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1630620569; bh=l1dnA7POZ9SG5u4+MMSNjNA3JdFATzQVZzAiyW78yEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MeSdkyf5+SfF4ja1WxPh8FqdCz5hHKRatKVve4nq5gKI/+WiZqKIHCZI2Sh4ZlSmi
         P1MWl+SHjzTo8DY4PEBOCQ/DKxjndGZrsiRpgOkplHXV+Iiekg/p6Ue/gxMCXN4WMc
         yEeWThtfVtwTNfyK7/cH71dDRfNwqdkDx0SOi2m6KWt/TP7Jz5ZvmKEB/Cvgmgq/R6
         vHgAT+qomi9fEMXFkQ2sDZfC/ADM4rmx/qIsN5LnsKbWIF/U/YjodbE4VsDlsnwIJw
         lU2Rl0aa9t+AqawcJ6j0U+hFbJLWUwCCFT2InwXc+fOEf3ueCTFf/vS3vE9txpYP26
         k91g5XjaI99Aw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/2] ext4: docs: Take out unneeded escaping
Date:   Thu,  2 Sep 2021 16:08:54 -0600
Message-Id: <20210902220854.198850-3-corbet@lwn.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210902220854.198850-1-corbet@lwn.net>
References: <20210902220854.198850-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The new file Documentation/orphan/ext4.rst escapes underscores ("\_")
throughout.  However, RST doesn't actually require that, so the escaping
only succeeds in making the document less readable.  Remove the unneeded
escapes.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/filesystems/ext4/orphan.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/ext4/orphan.rst b/Documentation/filesystems/ext4/orphan.rst
index d096fe0ba19e..03cca178864b 100644
--- a/Documentation/filesystems/ext4/orphan.rst
+++ b/Documentation/filesystems/ext4/orphan.rst
@@ -12,31 +12,31 @@ track the inode as orphan so that in case of crash extra blocks allocated to
 the file get truncated.
 
 Traditionally ext4 tracks orphan inodes in a form of single linked list where
-superblock contains the inode number of the last orphan inode (s\_last\_orphan
+superblock contains the inode number of the last orphan inode (s_last_orphan
 field) and then each inode contains inode number of the previously orphaned
-inode (we overload i\_dtime inode field for this). However this filesystem
+inode (we overload i_dtime inode field for this). However this filesystem
 global single linked list is a scalability bottleneck for workloads that result
 in heavy creation of orphan inodes. When orphan file feature
-(COMPAT\_ORPHAN\_FILE) is enabled, the filesystem has a special inode
-(referenced from the superblock through s\_orphan_file_inum) with several
+(COMPAT_ORPHAN_FILE) is enabled, the filesystem has a special inode
+(referenced from the superblock through s_orphan_file_inum) with several
 blocks. Each of these blocks has a structure:
 
 ============= ================ =============== ===============================
 Offset        Type             Name            Description
 ============= ================ =============== ===============================
-0x0           Array of         Orphan inode    Each \_\_le32 entry is either
-              \_\_le32 entries entries         empty (0) or it contains
+0x0           Array of         Orphan inode    Each __le32 entry is either
+              __le32 entries   entries         empty (0) or it contains
 	                                       inode number of an orphan
 					       inode.
-blocksize-8   \_\_le32         ob\_magic       Magic value stored in orphan
+blocksize-8   __le32           ob_magic        Magic value stored in orphan
                                                block tail (0x0b10ca04)
-blocksize-4   \_\_le32         ob\_checksum    Checksum of the orphan block.
+blocksize-4   __le32           ob_checksum     Checksum of the orphan block.
 ============= ================ =============== ===============================
 
 When a filesystem with orphan file feature is writeably mounted, we set
-RO\_COMPAT\_ORPHAN\_PRESENT feature in the superblock to indicate there may
+RO_COMPAT_ORPHAN_PRESENT feature in the superblock to indicate there may
 be valid orphan entries. In case we see this feature when mounting the
 filesystem, we read the whole orphan file and process all orphan inodes found
 there as usual. When cleanly unmounting the filesystem we remove the
-RO\_COMPAT\_ORPHAN\_PRESENT feature to avoid unnecessary scanning of the orphan
+RO_COMPAT_ORPHAN_PRESENT feature to avoid unnecessary scanning of the orphan
 file and also make the filesystem fully compatible with older kernels.
-- 
2.31.1

