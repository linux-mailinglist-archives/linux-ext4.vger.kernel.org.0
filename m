Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094484443E3
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Nov 2021 15:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhKCOzH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Nov 2021 10:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230132AbhKCOzG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Nov 2021 10:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635951149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EwA3ck65BnklSw0Q8bTU6cLSaLcjx0hPlwL4wTRnb4E=;
        b=TwJqYhCJvu0Wtl67rpr2IM1QZ1cyqv/ArhmTLIqTxZRUKe3fQEej5CTKLAUtJ+U/NyA3dX
        95pXKY1avBjOQlfOKfkA8qdVbRbxKSrZSm0YoRvnVq1Eev2RjBnc/dpVGjJLdHulUVH1P+
        GpXPwbWCpooIPY5fwl/zUoUHeBrlnFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-YPONvtusP1ef1j8FB1Smqw-1; Wed, 03 Nov 2021 10:52:26 -0400
X-MC-Unique: YPONvtusP1ef1j8FB1Smqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5643A40D4;
        Wed,  3 Nov 2021 14:51:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B38E719741;
        Wed,  3 Nov 2021 14:51:26 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger@dilger.ca
Subject: [PATCH 1/2] ext4: Change s_last_trim_minblks type to unsigned long
Date:   Wed,  3 Nov 2021 15:51:21 +0100
Message-Id: <20211103145122.17338-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There is no good reason for the s_last_trim_minblks to be atomic. There is
no data integrity needed and there is no real danger in setting and
reading it in a racy manner. Change it to be unsigned long, the same type
as s_clusters_per_group which is the maximum that's allowed.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Suggested-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/ext4/ext4.h    | 2 +-
 fs/ext4/mballoc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3825195539d7..92a155401f61 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1660,7 +1660,7 @@ struct ext4_sb_info {
 	struct task_struct *s_mmp_tsk;
 
 	/* record the last minlen when FITRIM is called. */
-	atomic_t s_last_trim_minblks;
+	unsigned long s_last_trim_minblks;
 
 	/* Reference to checksum algorithm driver via cryptoapi */
 	struct crypto_shash *s_chksum_driver;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 72bfac2d6dce..eda550ec3956 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6374,7 +6374,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 	ext4_lock_group(sb, group);
 
 	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
-	    minblocks < atomic_read(&EXT4_SB(sb)->s_last_trim_minblks)) {
+	    minblocks < EXT4_SB(sb)->s_last_trim_minblks) {
 		ret = ext4_try_to_trim_range(sb, &e4b, start, max, minblocks);
 		if (ret >= 0)
 			EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
@@ -6475,7 +6475,7 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	}
 
 	if (!ret)
-		atomic_set(&EXT4_SB(sb)->s_last_trim_minblks, minlen);
+		EXT4_SB(sb)->s_last_trim_minblks = minlen;
 
 out:
 	range->len = EXT4_C2B(EXT4_SB(sb), trimmed) << sb->s_blocksize_bits;
-- 
2.31.1

