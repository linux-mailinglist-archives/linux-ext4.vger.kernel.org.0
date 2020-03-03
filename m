Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8B1B17718F
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2020 09:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgCCIvM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Mar 2020 03:51:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36996 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbgCCIvM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Mar 2020 03:51:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id q4so1024522pls.4;
        Tue, 03 Mar 2020 00:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=Q5VfVmQdgg9p+OFp/l0un3xaUEDV8bc7/C90UdhrYow=;
        b=lfVWG1zTLXyJsgrUAAZZDBmHWh76xwXI0h459ycitFK75x9l2PjFRQ4zZUAeKSAka1
         Sars18D+gIky6FBflMkZsf7k1amtba5q5hPR3hAdl4mQfjh6j9MZm55IzZIEc/CBchIw
         XhTrjTxaHB6nZR5th5r65ikWHVEF9sfOjJ6MPWweynQ6SQaCFlwXSc+UavYDuaOYMIoF
         BmdbtJG8uqf5+OOZ9w9GRHdmoD/gtII+rYP8nMypw2HQllSphp5IU+FH0NO1v3DgqFNB
         IsH3dsWosSw09c/XQ8IHx/RX38l/03BFuKKIbs/Zi1QJugndwboJcWf+hL0CsOD/ytU3
         0j6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=Q5VfVmQdgg9p+OFp/l0un3xaUEDV8bc7/C90UdhrYow=;
        b=t81UfKx0TeN3yt8wxcDwtfEKvJ14E2BV4vpuWFYLjvuNON7akZ5fAo9ckd7otgxO50
         T7g+wTuSi0vEFi539XnXSmNE3RKEcZZbhc6ipgBuiDFCXA+LvmESw/9W5LDxIOeTTpyv
         Qwa4ISqXGc/hdckDlEEC+3YvVHAT5qdhl1ztqynQ8No+IW3/QH6J0woehqq5lvHRpQcV
         qkRYuK90wyEBvDGMytHybhP3859HQ9dUKs1/dmYK4ZIo8bTJnL8wp2tnuo30ErvlGX3/
         MDKnNnzb7PS+7si4a+PlyuRHXLCWupR5Oz3Xoy+iAWV+3M/XTLc9ez0i29gFGNX1Qx6Y
         iicA==
X-Gm-Message-State: ANhLgQ2KNBKIZW/b5/Dz98Ux+ZPWKhj3KBRZk+zr2kpapeuqE+KpGDsn
        p8uR3Nr+Xa8n1nUUXOp2/orUAv1c
X-Google-Smtp-Source: ADFU+vuQMZQD+h00eScJp0xk94cQ+VFN3uqIz2iiWUPMWpdktm6s61EryURJK4I+3jpmSI6wQmKq3w==
X-Received: by 2002:a17:902:eb52:: with SMTP id i18mr3320901pli.125.1583225471091;
        Tue, 03 Mar 2020 00:51:11 -0800 (PST)
Received: from [10.80.50.61] ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id jx10sm1558821pjb.33.2020.03.03.00.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 00:51:10 -0800 (PST)
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH] ext4: mark extents index blocks as dirty to avoid information
 leakage
Message-ID: <e988a1db-3105-07a0-6399-38af80656af1@gmail.com>
Date:   Tue, 3 Mar 2020 16:51:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

In the scene of deleting a file, the physical block information in the
extent will be cleared to 0, the buffer_head contains these extents is
marked as dirty, and then managed by jbd2, which will clear the
buffer_head's dirty flag by clear_buffer_dirty. However, when the entire
extent block is deleted, it is revoked from the jbd2, but  the extents
block is not redirtied.

Not quite reasonable here, for the following concerns:

1. This has the risk of information leakage and leads to an interesting
phenomenon that deleting the entire file is no more secure than truncate
to 1 byte, because the whole extents physical block clear to zero in cache
will never written back as the page is not redirtied.

2. For large files, the number of index block is usually very small.
Ignoring index pages not get much more benefit in IO performance. But if
we remark the page as dirty, the page is then written back by the system
writeback mechanism asynchronously with little performance impact. As a
result, the risk of information leakage can be avoided. At least not wrose
than truncate file length to 1 byte

Therefore, when the index block is released, we need to remark its page
as dirty, so that the index block on the disk will be updated and the
data is more security.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/ext4.h      | 1 +
 fs/ext4/ext4_jbd2.c | 8 ++++++++
 fs/ext4/extents.c   | 3 ++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 61b37a0..f9a4d97 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -644,6 +644,7 @@ enum {
 #define EXT4_FREE_BLOCKS_NOFREE_FIRST_CLUSTER    0x0010
 #define EXT4_FREE_BLOCKS_NOFREE_LAST_CLUSTER    0x0020
 #define EXT4_FREE_BLOCKS_RERESERVE_CLUSTER      0x0040
+#define EXT4_FREE_BLOCKS_METADATA_INDEX        0x0080
 
 /*
  * ioctl commands
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 1f53d64..7974c62 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -275,7 +275,15 @@ int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
         ext4_set_errno(inode->i_sb, -err);
         __ext4_abort(inode->i_sb, where, line,
                "error %d when attempting revoke", err);
+    } else  {
+        /*
+         * we dirtied index block to ensure that related changes to
+         * the index block will be stored to disk.
+         */
+        if (is_metadata & EXT4_FREE_BLOCKS_METADATA_INDEX)
+            mark_buffer_dirty(bh);
     }
+
     BUFFER_TRACE(bh, "exit");
     return err;
 }
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 954013d..2ee0df0 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2431,7 +2431,8 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
     trace_ext4_ext_rm_idx(inode, leaf);
 
     ext4_free_blocks(handle, inode, NULL, leaf, 1,
-             EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
+             EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET |
+             EXT4_FREE_BLOCKS_METADATA_INDEX);
 
     while (--depth >= 0) {
         if (path->p_idx != EXT_FIRST_INDEX(path->p_hdr))
-- 
1.8.3.1

