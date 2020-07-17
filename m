Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A2D223902
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jul 2020 12:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgGQKLX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jul 2020 06:11:23 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:60821 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgGQKLW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jul 2020 06:11:22 -0400
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 2BA6B24001F;
        Fri, 17 Jul 2020 10:10:02 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     linux-ext4@vger.kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        matthew.weber@rockwellcollins.com, thomas.petazzoni@bootlin.com,
        adilger@dilger.ca
Subject: [PATCH v2] create_inode: set xattrs to the root directory as well
Date:   Fri, 17 Jul 2020 12:08:46 +0200
Message-Id: <20200717100846.497546-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

populate_fs do copy the xattrs for all files and directories, but the
root directory is skipped and as a result its extended attributes aren't
set. This is an issue when using mkfs to build a full system image that
can be used with SElinux in enforcing mode without making any runtime
fix at first boot.

This patch adds logic to set the root directory's extended attributes.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---

Since v1:
  - Moved the set_inode_xattr logic for the root directory
    from __populate_fs to populate_fs2.

 misc/create_inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/misc/create_inode.c b/misc/create_inode.c
index e8d1df6b55a5..fe66faf1b53d 100644
--- a/misc/create_inode.c
+++ b/misc/create_inode.c
@@ -1050,9 +1050,17 @@ errcode_t populate_fs2(ext2_filsys fs, ext2_ino_t parent_ino,
 	file_info.path_max_len = 255;
 	file_info.path = calloc(file_info.path_max_len, 1);
 
+	retval = set_inode_xattr(fs, root, source_dir);
+	if (retval) {
+		com_err(__func__, retval,
+			_("while copying xattrs on root directory"));
+		goto out;
+	}
+
 	retval = __populate_fs(fs, parent_ino, source_dir, root, &hdlinks,
 			       &file_info, fs_callbacks);
 
+out:
 	free(file_info.path);
 	free(hdlinks.hdl);
 	return retval;
-- 
2.26.2

