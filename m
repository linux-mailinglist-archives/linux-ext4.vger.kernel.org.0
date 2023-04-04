Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25FF6D660E
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Apr 2023 16:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjDDOz5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Apr 2023 10:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjDDOz4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Apr 2023 10:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFD35245
        for <linux-ext4@vger.kernel.org>; Tue,  4 Apr 2023 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680620089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EljYz9VZ7nVcMno61oSjo4fgwJueEqLgTdTvZAW6Ojc=;
        b=JnwgKaSwwyWuucjtkK6Wfn+G2iAvl0im/3ibO4J2+S6oRcvHrC514oEcRbM81xg5/7+NcK
        kK4m0i/RvMHfKFEjSICFP/e+Ex7x2QIIsq3xgvyYtao7SAjJT37Zvaaetekvec2a/rSONC
        t9WUMGPJtmLSND9r+Ls5caNcJEk6rzo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-_PhtAISFNOWCnpafjfJ88w-1; Tue, 04 Apr 2023 10:54:48 -0400
X-MC-Unique: _PhtAISFNOWCnpafjfJ88w-1
Received: by mail-qk1-f198.google.com with SMTP id 72-20020a37044b000000b0074694114c09so14711160qke.4
        for <linux-ext4@vger.kernel.org>; Tue, 04 Apr 2023 07:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EljYz9VZ7nVcMno61oSjo4fgwJueEqLgTdTvZAW6Ojc=;
        b=gYlFDG5KtM7FkI+5nZhomfV3yeedyoJ+GGdc+eoF8jOk1LQP02ijREYhytoK1YTwyH
         +gdGaZeQJw/5k3wOnujprHhAVxFUt+52sjivQ7qGmluZGx69ZpYQDXjwsIoCuf5ZTT9x
         U0fK6ovXxNwkeBaNk988OiiX05WNpR2mRChUQLNeT2xzXHIIUFJdx/4YpmWS2lfCxESy
         RmfVcdqJHxLUZKBsAonY6p5GCJilTSwC4wEbol8Xdqk9cbE06rnXTMBMBZjTDTCE7AaO
         iXoCvKYJqlHxbYl3yTRgLVnmxHjP3KN4PvAfvHVnI3GDp1pLYDC1ynJqV1TqSvpHbvCi
         9yFg==
X-Gm-Message-State: AAQBX9ck4ncVNUxylfApzq185djVfnDtBZrwK/oUFNxxmmV3qOOgrhEn
        XajmtgUigk1nvdaZrvdA1lrWG41ZjAFfMyctG0zwlq12+ijG5NrKbSAlDgJrOGYzYRAMM2Ph/Bj
        p9u4vaqwoa1RQjw2LiYlt
X-Received: by 2002:ad4:5be5:0:b0:5df:4d41:954d with SMTP id k5-20020ad45be5000000b005df4d41954dmr4197893qvc.3.1680620087794;
        Tue, 04 Apr 2023 07:54:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350awxiwQj29WkT4ggcZAS6daFPDjxiKszMVMUv7HrI39sj994HHwSVJ4OpAB2k+VsVfNFDI7fw==
X-Received: by 2002:ad4:5be5:0:b0:5df:4d41:954d with SMTP id k5-20020ad45be5000000b005df4d41954dmr4197864qvc.3.1680620087448;
        Tue, 04 Apr 2023 07:54:47 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:54:47 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com,
        Allison Henderson <allison.henderson@oracle.com>,
        Mark Tinguely <tinguely@sgi.com>
Subject: [PATCH v2 02/23] xfs: add parent pointer support to attribute code
Date:   Tue,  4 Apr 2023 16:52:58 +0200
Message-Id: <20230404145319.2057051-3-aalbersh@redhat.com>
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

From: Allison Henderson <allison.henderson@oracle.com>

Add the new parent attribute type. XFS_ATTR_PARENT is used only for parent pointer
entries; it uses reserved blocks like XFS_ATTR_ROOT.

Signed-off-by: Mark Tinguely <tinguely@sgi.com>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_attr.c       | 4 +++-
 fs/xfs/libxfs/xfs_da_format.h  | 5 ++++-
 fs/xfs/libxfs/xfs_log_format.h | 1 +
 fs/xfs/scrub/attr.c            | 2 +-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index b1dbed7655e8..101823772bf9 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -976,11 +976,13 @@ xfs_attr_set(
 	struct xfs_inode	*dp = args->dp;
 	struct xfs_mount	*mp = dp->i_mount;
 	struct xfs_trans_res	tres;
-	bool			rsvd = (args->attr_filter & XFS_ATTR_ROOT);
+	bool			rsvd;
 	int			error, local;
 	int			rmt_blks = 0;
 	unsigned int		total;
 
+	rsvd = (args->attr_filter & (XFS_ATTR_ROOT | XFS_ATTR_PARENT)) != 0;
+
 	if (xfs_is_shutdown(dp->i_mount))
 		return -EIO;
 
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 25e2841084e1..3dc03968bba6 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -688,12 +688,15 @@ struct xfs_attr3_leafblock {
 #define	XFS_ATTR_LOCAL_BIT	0	/* attr is stored locally */
 #define	XFS_ATTR_ROOT_BIT	1	/* limit access to trusted attrs */
 #define	XFS_ATTR_SECURE_BIT	2	/* limit access to secure attrs */
+#define	XFS_ATTR_PARENT_BIT	3	/* parent pointer attrs */
 #define	XFS_ATTR_INCOMPLETE_BIT	7	/* attr in middle of create/delete */
 #define XFS_ATTR_LOCAL		(1u << XFS_ATTR_LOCAL_BIT)
 #define XFS_ATTR_ROOT		(1u << XFS_ATTR_ROOT_BIT)
 #define XFS_ATTR_SECURE		(1u << XFS_ATTR_SECURE_BIT)
+#define XFS_ATTR_PARENT		(1u << XFS_ATTR_PARENT_BIT)
 #define XFS_ATTR_INCOMPLETE	(1u << XFS_ATTR_INCOMPLETE_BIT)
-#define XFS_ATTR_NSP_ONDISK_MASK	(XFS_ATTR_ROOT | XFS_ATTR_SECURE)
+#define XFS_ATTR_NSP_ONDISK_MASK \
+			(XFS_ATTR_ROOT | XFS_ATTR_SECURE | XFS_ATTR_PARENT)
 
 /*
  * Alignment for namelist and valuelist entries (since they are mixed
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index ae9c99762a24..727b5a858028 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -967,6 +967,7 @@ struct xfs_icreate_log {
  */
 #define XFS_ATTRI_FILTER_MASK		(XFS_ATTR_ROOT | \
 					 XFS_ATTR_SECURE | \
+					 XFS_ATTR_PARENT | \
 					 XFS_ATTR_INCOMPLETE)
 
 /*
diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 31529b9bf389..9d2e33743ecd 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -441,7 +441,7 @@ xchk_xattr_rec(
 	/* Retrieve the entry and check it. */
 	hash = be32_to_cpu(ent->hashval);
 	badflags = ~(XFS_ATTR_LOCAL | XFS_ATTR_ROOT | XFS_ATTR_SECURE |
-			XFS_ATTR_INCOMPLETE);
+			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT);
 	if ((ent->flags & badflags) != 0)
 		xchk_da_set_corrupt(ds, level);
 	if (ent->flags & XFS_ATTR_LOCAL) {
-- 
2.38.4

