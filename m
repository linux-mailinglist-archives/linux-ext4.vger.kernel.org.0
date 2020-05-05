Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3EA1C5BEB
	for <lists+linux-ext4@lfdr.de>; Tue,  5 May 2020 17:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbgEEPnh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 May 2020 11:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbgEEPne (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 May 2020 11:43:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6763C061A0F;
        Tue,  5 May 2020 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FjLsVY4oiIT6N5wKPlMoatlbWvR11FFrIPGES+qoa5c=; b=J8FKraApUwOQLCBoyanOqldW4b
        8mC3f8zcpToVMGEh28ygw/6ik2wWBw+ryuDLSLtWAMQxkcFbcx+cX/FL7609SVlvh2V2xy7bOfAK6
        pwTV8bF51O/+fYR4pcCsuUcp/s+h7+cGNMA7cDRVsz071Z/nXlEQB0gyxlUUPavM6FWAKH2NPLnQ6
        5ssELrf1SEG+fSMfttTt0QQ3L7IzZot6sGyUbBkZjV1pOsAmU50/hdEstvZieGC59yjhoIlnfOram
        895zpGrjsSZmuN6mmSgoeK6o2/9NsuVADNBdbo0Lbxt8aLd8TagBLZDedQzzA5nBYSladYIzGRz2C
        X6E+UcFA==;
Received: from [2001:4bb8:191:66b6:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVzjK-0003yV-90; Tue, 05 May 2020 15:43:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 02/11] ext4: fix fiemap size checks for bitmap files
Date:   Tue,  5 May 2020 17:43:15 +0200
Message-Id: <20200505154324.3226743-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505154324.3226743-1-hch@lst.de>
References: <20200505154324.3226743-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add an extra validation of the len parameter, as for ext4 some files
might have smaller file size limits than others.  This also means the
redundant size check in ext4_ioctl_get_es_cache can go away, as all
size checking is done in the shared fiemap handler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/extents.c | 31 +++++++++++++++++++++++++++++++
 fs/ext4/ioctl.c   | 33 ++-------------------------------
 2 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f2b577b315a09..2b4b94542e34d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4832,6 +4832,28 @@ static const struct iomap_ops ext4_iomap_xattr_ops = {
 	.iomap_begin		= ext4_iomap_xattr_begin,
 };
 
+static int ext4_fiemap_check_ranges(struct inode *inode, u64 start, u64 *len)
+{
+	u64 maxbytes;
+
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		maxbytes = inode->i_sb->s_maxbytes;
+	else
+		maxbytes = EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
+
+	if (*len == 0)
+		return -EINVAL;
+	if (start > maxbytes)
+		return -EFBIG;
+
+	/*
+	 * Shrink request scope to what the fs can actually handle.
+	 */
+	if (*len > maxbytes || (maxbytes - *len) < start)
+		*len = maxbytes - start;
+	return 0;
+}
+
 static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			__u64 start, __u64 len, bool from_es_cache)
 {
@@ -4852,6 +4874,15 @@ static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (fiemap_check_flags(fieinfo, ext4_fiemap_flags))
 		return -EBADR;
 
+	/*
+	 * For bitmap files the maximum size limit could be smaller than
+	 * s_maxbytes, so check len here manually instead of just relying on the
+	 * generic check.
+	 */
+	error = ext4_fiemap_check_ranges(inode, start, &len);
+	if (error)
+		return error;
+
 	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
 		fieinfo->fi_flags &= ~FIEMAP_FLAG_XATTR;
 		error = iomap_fiemap(inode, fieinfo, start, len,
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index bfc1281fc4cbc..0746532ba463d 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -733,29 +733,6 @@ static void ext4_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
 		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
 }
 
-/* copied from fs/ioctl.c */
-static int fiemap_check_ranges(struct super_block *sb,
-			       u64 start, u64 len, u64 *new_len)
-{
-	u64 maxbytes = (u64) sb->s_maxbytes;
-
-	*new_len = len;
-
-	if (len == 0)
-		return -EINVAL;
-
-	if (start > maxbytes)
-		return -EFBIG;
-
-	/*
-	 * Shrink request scope to what the fs can actually handle.
-	 */
-	if (len > maxbytes || (maxbytes - len) < start)
-		*new_len = maxbytes - start;
-
-	return 0;
-}
-
 /* So that the fiemap access checks can't overflow on 32 bit machines. */
 #define FIEMAP_MAX_EXTENTS	(UINT_MAX / sizeof(struct fiemap_extent))
 
@@ -765,8 +742,6 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 	struct fiemap __user *ufiemap = (struct fiemap __user *) arg;
 	struct fiemap_extent_info fieinfo = { 0, };
 	struct inode *inode = file_inode(filp);
-	struct super_block *sb = inode->i_sb;
-	u64 len;
 	int error;
 
 	if (copy_from_user(&fiemap, ufiemap, sizeof(fiemap)))
@@ -775,11 +750,6 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 	if (fiemap.fm_extent_count > FIEMAP_MAX_EXTENTS)
 		return -EINVAL;
 
-	error = fiemap_check_ranges(sb, fiemap.fm_start, fiemap.fm_length,
-				    &len);
-	if (error)
-		return error;
-
 	fieinfo.fi_flags = fiemap.fm_flags;
 	fieinfo.fi_extents_max = fiemap.fm_extent_count;
 	fieinfo.fi_extents_start = ufiemap->fm_extents;
@@ -792,7 +762,8 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
 		filemap_write_and_wait(inode->i_mapping);
 
-	error = ext4_get_es_cache(inode, &fieinfo, fiemap.fm_start, len);
+	error = ext4_get_es_cache(inode, &fieinfo, fiemap.fm_start,
+			fiemap.fm_length);
 	fiemap.fm_flags = fieinfo.fi_flags;
 	fiemap.fm_mapped_extents = fieinfo.fi_extents_mapped;
 	if (copy_to_user(ufiemap, &fiemap, sizeof(fiemap)))
-- 
2.26.2

