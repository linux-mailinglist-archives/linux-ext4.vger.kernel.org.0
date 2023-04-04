Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D20A6D664E
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Apr 2023 16:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbjDDO47 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Apr 2023 10:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjDDO4a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Apr 2023 10:56:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570E349F5
        for <linux-ext4@vger.kernel.org>; Tue,  4 Apr 2023 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680620126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mf1FPmX34sPBqBJ1RqvZnmanS11JhvTJ+HM36CjFqII=;
        b=hXUwnpVOoZRgvuq01tAF1D/CKBAMdI+vFnftbN9IBw4zTGaCeqKNjVM+IB0Y/zFgKEefUp
        I+WqKbu4tomEmBW2Y2lJoBnK8Yv/IvqB1zMb3rOAEi9Nx7VSmKa1Tn6X73hMERP7NgMhA/
        tyU+GCzk9XH7QWjThFIYxOHNOPIyY7E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-bq9lOvmKPRGkxFEWlCqNLw-1; Tue, 04 Apr 2023 10:55:24 -0400
X-MC-Unique: bq9lOvmKPRGkxFEWlCqNLw-1
Received: by mail-qv1-f69.google.com with SMTP id px9-20020a056214050900b005d510cdfc41so14826924qvb.7
        for <linux-ext4@vger.kernel.org>; Tue, 04 Apr 2023 07:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf1FPmX34sPBqBJ1RqvZnmanS11JhvTJ+HM36CjFqII=;
        b=ib41BtzBjGIGl1iuof7mUOZhdH3FttqcmuvsGnbS6vHOkN04kLqauTuh2s6qm11MYY
         R5cU+hx6ZS128f94MJNwFBd2e/KmA2krGc/JQB+DxwRH59QfUhtFPGyQqQcOPBUrXxPy
         ksiatVjZK47r1w4tU4Pf7xDw+dmWsncQhIc7KLPEEHhpSSdHxaOyipomAm1ql90h3Xk0
         RNsMcN3NIkvxQalnPVlh3xau++u318wGeMt7W+hks4XHwNPcCUZPK9AzTn+lDxuPydlS
         U2BlKtkHRg5N8Y5H0ttksMR24NoiEVw2xQMU47uPWkaLnFZ5XCkFAQQrHIObYu0zJRX1
         5hgQ==
X-Gm-Message-State: AAQBX9c4WNR01h/0Nrk/e8P6WDzV5ko6993rQ0aKXQAl6acZubat3keE
        S4HZhP83c3to5z2vbnZVYN871hmeq7Olgd45anZFx4AgIy5D4mrsvhzDcbbg4XJvu7vWzI2nmLa
        n8oJk1Yj6mXZ/GTkDNURl
X-Received: by 2002:a05:622a:586:b0:3e4:df94:34fa with SMTP id c6-20020a05622a058600b003e4df9434famr4035265qtb.37.1680620124167;
        Tue, 04 Apr 2023 07:55:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350bRYRoH4ADtP4T/X8Xk7AmNG3QGNTCPUhw/3V50RQPtNVC1H25ltfcQUL3M/obCpWJOFk1Kng==
X-Received: by 2002:a05:622a:586:b0:3e4:df94:34fa with SMTP id c6-20020a05622a058600b003e4df9434famr4035211qtb.37.1680620123789;
        Tue, 04 Apr 2023 07:55:23 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:23 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 13/23] xfs: add iomap's readpage operations
Date:   Tue,  4 Apr 2023 16:53:09 +0200
Message-Id: <20230404145319.2057051-14-aalbersh@redhat.com>
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

The read IO path provides callout for configuring ioend. This allows
filesystem to add verification of completed BIOs. The
xfs_prepare_read_ioend() configures bio->bi_end_io which places
verification task in the workqueue. The task does fs-verity
verification and then call back to the iomap to finish IO.

This patch add callouts implementation to verify pages with
fs-verity. Also implements folio operation .verify_folio for direct
folio verification by fs-verity.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_aops.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_iomap.c | 11 +++++++++++
 fs/xfs/xfs_linux.h |  1 +
 3 files changed, 57 insertions(+)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index daa0dd4768fb..2a3ab5afd665 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -548,6 +548,49 @@ xfs_vm_bmap(
 	return iomap_bmap(mapping, block, &xfs_read_iomap_ops);
 }
 
+static void
+xfs_read_work_end_io(
+	struct work_struct *work)
+{
+	struct iomap_read_ioend *ioend =
+		container_of(work, struct iomap_read_ioend, work);
+	struct bio *bio = &ioend->read_inline_bio;
+
+	fsverity_verify_bio(bio);
+	iomap_read_end_io(bio);
+	/*
+	 * The iomap_read_ioend has been freed by bio_put() in
+	 * iomap_read_end_io()
+	 */
+}
+
+static void
+xfs_read_end_io(
+	struct bio *bio)
+{
+	struct iomap_read_ioend *ioend =
+		container_of(bio, struct iomap_read_ioend, read_inline_bio);
+	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
+
+	WARN_ON_ONCE(!queue_work(ip->i_mount->m_postread_workqueue,
+					&ioend->work));
+}
+
+static void
+xfs_prepare_read_ioend(
+	struct iomap_read_ioend	*ioend)
+{
+	if (!fsverity_active(ioend->io_inode))
+		return;
+
+	INIT_WORK(&ioend->work, &xfs_read_work_end_io);
+	ioend->read_inline_bio.bi_end_io = &xfs_read_end_io;
+}
+
+static const struct iomap_readpage_ops xfs_readpage_ops = {
+	.prepare_ioend		= &xfs_prepare_read_ioend,
+};
+
 STATIC int
 xfs_vm_read_folio(
 	struct file			*unused,
@@ -555,6 +598,7 @@ xfs_vm_read_folio(
 {
 	struct iomap_readpage_ctx	ctx = {
 		.cur_folio		= folio,
+		.ops			= &xfs_readpage_ops,
 	};
 
 	return iomap_read_folio(&ctx, &xfs_read_iomap_ops);
@@ -566,6 +610,7 @@ xfs_vm_readahead(
 {
 	struct iomap_readpage_ctx	ctx = {
 		.rac			= rac,
+		.ops			= &xfs_readpage_ops,
 	};
 
 	iomap_readahead(&ctx, &xfs_read_iomap_ops);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 285885c308bd..e0f3c5d709f6 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -27,6 +27,7 @@
 #include "xfs_dquot_item.h"
 #include "xfs_dquot.h"
 #include "xfs_reflink.h"
+#include "xfs_verity.h"
 
 #define XFS_ALLOC_ALIGN(mp, off) \
 	(((off) >> mp->m_allocsize_log) << mp->m_allocsize_log)
@@ -83,8 +84,18 @@ xfs_iomap_valid(
 	return true;
 }
 
+static bool
+xfs_verify_folio(
+	struct folio	*folio,
+	loff_t		pos,
+	unsigned int	len)
+{
+	return fsverity_verify_folio(folio, len, pos);
+}
+
 static const struct iomap_folio_ops xfs_iomap_folio_ops = {
 	.iomap_valid		= xfs_iomap_valid,
+	.verify_folio		= xfs_verify_folio,
 };
 
 int
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index e88f18f85e4b..c574fbf4b67d 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -63,6 +63,7 @@ typedef __u32			xfs_nlink_t;
 #include <linux/rhashtable.h>
 #include <linux/xattr.h>
 #include <linux/mnt_idmapping.h>
+#include <linux/fsverity.h>
 
 #include <asm/page.h>
 #include <asm/div64.h>
-- 
2.38.4

