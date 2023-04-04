Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D63B6D6640
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Apr 2023 16:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjDDO4q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Apr 2023 10:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjDDO4T (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Apr 2023 10:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158CC5270
        for <linux-ext4@vger.kernel.org>; Tue,  4 Apr 2023 07:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680620119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1DCV/M5yyrM1g1B6cxt9ZQ7HQFDQ1socxlG7tzRHhCM=;
        b=MIoNtCWP/jcj6q6nPDolJTWOYgwmR5AkQbVljTKrAAhxqJt67pC7K86JCdEhKaV28VkZ2l
        aUb8aGT8rLEldJfPkvJsRnw1s9MmUEKjErPlShEFVUsY3JeIkTt0TqVcs99QTFLpjZx/AJ
        6tzl62lt8jmrZSnVgFBu7JtU77wZZCI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-z2ysWyX-OS2B3l9ulak7IQ-1; Tue, 04 Apr 2023 10:55:17 -0400
X-MC-Unique: z2ysWyX-OS2B3l9ulak7IQ-1
Received: by mail-qt1-f200.google.com with SMTP id v7-20020a05622a188700b003e0e27bbc2eso22246289qtc.8
        for <linux-ext4@vger.kernel.org>; Tue, 04 Apr 2023 07:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DCV/M5yyrM1g1B6cxt9ZQ7HQFDQ1socxlG7tzRHhCM=;
        b=QfhQyo/5//2mfjGeHeD6yc5SP5zZLO+SUig/Q/gsTAzT9y5CtnPF0vKTUHizBJ8khi
         inUwaNFvqsYGCaYBOVtbNn5EBdY2ZjwzibsaEt4Ra7L3ImlAf4KW/rQ/F1zkrWPIjpzF
         UQfL4z4QfCTgMA77Jy9v9f9XZ04a759k6DfpGo254DTF0+DKw9ZA2vPyG/HWqe0B5sjF
         /VBGQUOhefKK+fs8fWlqgAai3BI0yuLuR8gN9BlCwZBUH43mAWPG7BGzl0CLte1ekAmR
         JLbJ+pSu0rBrRq+xucfGmsdPxPLaUg1zvcomFZLkojIre7nXoR0QgM1WHLb7UFSuPInP
         43Og==
X-Gm-Message-State: AAQBX9fzIoMj6llvogFMqMeQSSbJn04s9VHitux9XJfEatatyuHvfxf0
        Wnx4UNWuh6SZKNeaBbq1rkLWvgiDbDCpOquV33DY6+wEamdOfIyjg5WV0+OQtXxIMmg9ljS0fkN
        Um+GboRGJhfKN9fj9SF0G
X-Received: by 2002:a05:622a:1002:b0:3e3:8ebe:ce17 with SMTP id d2-20020a05622a100200b003e38ebece17mr3401475qte.43.1680620115381;
        Tue, 04 Apr 2023 07:55:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZeTsqSdwXkQooxtkxa5UspUTLXqFsUhIKZ9BZk1HmO99VPevTQAHz0NwCmfjyQvtO6XB3OTQ==
X-Received: by 2002:a05:622a:1002:b0:3e3:8ebe:ce17 with SMTP id d2-20020a05622a100200b003e38ebece17mr3401445qte.43.1680620115062;
        Tue, 04 Apr 2023 07:55:15 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:14 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 10/23] xfs: add XBF_VERITY_CHECKED xfs_buf flag
Date:   Tue,  4 Apr 2023 16:53:06 +0200
Message-Id: <20230404145319.2057051-11-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The meaning of the flag is that value of the extended attribute in
the buffer was verified. The underlying pages have PageChecked() ==
false (the way fs-verity identifies verified pages), as page content
will be copied out to newly allocated pages in further patches.

The flag is being used later to SetPageChecked() on pages handed to
the fs-verity.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_buf.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 549c60942208..8cc86fed962b 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -24,14 +24,15 @@ struct xfs_buf;
 
 #define XFS_BUF_DADDR_NULL	((xfs_daddr_t) (-1LL))
 
-#define XBF_READ	 (1u << 0) /* buffer intended for reading from device */
-#define XBF_WRITE	 (1u << 1) /* buffer intended for writing to device */
-#define XBF_READ_AHEAD	 (1u << 2) /* asynchronous read-ahead */
-#define XBF_NO_IOACCT	 (1u << 3) /* bypass I/O accounting (non-LRU bufs) */
-#define XBF_ASYNC	 (1u << 4) /* initiator will not wait for completion */
-#define XBF_DONE	 (1u << 5) /* all pages in the buffer uptodate */
-#define XBF_STALE	 (1u << 6) /* buffer has been staled, do not find it */
-#define XBF_WRITE_FAIL	 (1u << 7) /* async writes have failed on this buffer */
+#define XBF_READ		(1u << 0) /* buffer intended for reading from device */
+#define XBF_WRITE		(1u << 1) /* buffer intended for writing to device */
+#define XBF_READ_AHEAD		(1u << 2) /* asynchronous read-ahead */
+#define XBF_NO_IOACCT		(1u << 3) /* bypass I/O accounting (non-LRU bufs) */
+#define XBF_ASYNC		(1u << 4) /* initiator will not wait for completion */
+#define XBF_DONE		(1u << 5) /* all pages in the buffer uptodate */
+#define XBF_STALE		(1u << 6) /* buffer has been staled, do not find it */
+#define XBF_WRITE_FAIL		(1u << 7) /* async writes have failed on this buffer */
+#define XBF_VERITY_CHECKED	(1u << 8) /* buffer was verified by fs-verity*/
 
 /* buffer type flags for write callbacks */
 #define _XBF_INODES	 (1u << 16)/* inode buffer */
-- 
2.38.4

