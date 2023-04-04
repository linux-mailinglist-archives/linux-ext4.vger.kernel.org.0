Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1194A6D6657
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Apr 2023 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbjDDO5F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Apr 2023 10:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbjDDO4g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Apr 2023 10:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF8D40CD
        for <linux-ext4@vger.kernel.org>; Tue,  4 Apr 2023 07:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680620141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhiCGxChrVJlRUkYdDGuEzFvZQCsRtVvsPA45L+6JnY=;
        b=f2G0Z3NoYUTclLp29evJnMjp/9bXT0X2tibeQxl3A5YeOtPg5dFQcrA5Bx/HvDTC7P/+NH
        /fwKYvEmXDrViPPIpgO3gDfODe9qRyNuyQl3ZkY+vSXyCgYUJ8Cj0ezLebFbFoWRAgQgqE
        3G8LSwdGd822SJtOhlGzgtG4h7KCnd8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-9DXLlvigOueJOVtJYva8DQ-1; Tue, 04 Apr 2023 10:55:39 -0400
X-MC-Unique: 9DXLlvigOueJOVtJYva8DQ-1
Received: by mail-qk1-f199.google.com with SMTP id 203-20020a370ad4000000b00746981f8f4bso14908467qkk.13
        for <linux-ext4@vger.kernel.org>; Tue, 04 Apr 2023 07:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhiCGxChrVJlRUkYdDGuEzFvZQCsRtVvsPA45L+6JnY=;
        b=UlExMVnMbsswa7VqRi2tGYII+4znsPgtNRGvL83lXWYjotlGhp0KDI0KlI+qquYu+Y
         MNmQLGNzxsP15VFlxtp2QxJQ7Mp9TCq7qii3Mgx7iR80hnJz0WSXQVdLJi53SOSxLRfa
         NSonxPDRg5tFczuPL+9F1NyowYUcfU7TpKZs1AmbFBJIfxkfmTIpMfIu8CHK70leN0Hi
         E0Iyc/wv3aUBvXmEB8I2u7YFFyuOdSkSR/ClehCo9b6syN0ctubvLfaBoTejWbpPuf/i
         yeIFygDjDsNY5IAB0SbPgrH6JnsUhSISfwjPFbcmo3SI2tcIz0q8q9slFX/M73p1ed1R
         a5Lg==
X-Gm-Message-State: AAQBX9dPr/2wJjxwkhzDfRcUeAAjvvCB9G7WGEOyd2dR9quDpGHuyhI6
        arweObz8iQ8A0Vb4rxZ797W2v1Dc+MCvdVMh0ndguUBvVZXlUjUypAvTU4yuNvMXP2by9BTOFqw
        knaQ1cDs055LtuZgJ8YJ/
X-Received: by 2002:a05:6214:f05:b0:571:13c:6806 with SMTP id gw5-20020a0562140f0500b00571013c6806mr3972715qvb.33.1680620137282;
        Tue, 04 Apr 2023 07:55:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z8MfugNU6YKVlXuq75L3kQ3utmgGFoqTKtMHqOCvYgrWH2c48gYF9y20EeEoB2IWzu0Fdckw==
X-Received: by 2002:a05:6214:f05:b0:571:13c:6806 with SMTP id gw5-20020a0562140f0500b00571013c6806mr3972665qvb.33.1680620136915;
        Tue, 04 Apr 2023 07:55:36 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:36 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 17/23] xfs: initialize fs-verity on file open and cleanup on inode destruction
Date:   Tue,  4 Apr 2023 16:53:13 +0200
Message-Id: <20230404145319.2057051-18-aalbersh@redhat.com>
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

fs-verity will read and attach metadata (not the tree itself) from
a disk for those inodes which already have fs-verity enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_file.c  | 8 ++++++++
 fs/xfs/xfs_super.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 705250f9f90a..947b5c436172 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -31,6 +31,7 @@
 #include <linux/mman.h>
 #include <linux/fadvise.h>
 #include <linux/mount.h>
+#include <linux/fsverity.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -1169,9 +1170,16 @@ xfs_file_open(
 	struct inode	*inode,
 	struct file	*file)
 {
+	int		error = 0;
+
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC;
+
+	error = fsverity_file_open(inode, file);
+	if (error)
+		return error;
+
 	return generic_file_open(inode, file);
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d6f22cb94ee2..d40de32362b1 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -46,6 +46,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsverity.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -667,6 +668,7 @@ xfs_fs_destroy_inode(
 	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 	XFS_STATS_INC(ip->i_mount, vn_rele);
 	XFS_STATS_INC(ip->i_mount, vn_remove);
+	fsverity_cleanup_inode(inode);
 	xfs_inode_mark_reclaimable(ip);
 }
 
-- 
2.38.4

