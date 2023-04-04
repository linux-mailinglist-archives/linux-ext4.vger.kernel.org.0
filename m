Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E1F6D661C
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Apr 2023 16:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjDDO4J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Apr 2023 10:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjDDO4D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Apr 2023 10:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61CB40F9
        for <linux-ext4@vger.kernel.org>; Tue,  4 Apr 2023 07:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680620093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=395KBh5jpp5sBhV7lwrvunRnw3iYM/DZo2HMst97yLA=;
        b=Y4RA0WgobOmo0sGYWOTGlcHFDQzPwebdKVoVzgF7Z1ANQjGG4xFVWtmMfMPB4TxF9kLz7i
        HfoauSkpCSeTRyUbsPYmPo0iZhS+zvU+Qzjhp0RV1p9E4QHTRFItJuOHdiH9fmY+wBYSLh
        B2D/zmTetPkfaOH0G/MK8hkhP3s4IKE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-Egc-MkPDMTugkMQpooz69A-1; Tue, 04 Apr 2023 10:54:52 -0400
X-MC-Unique: Egc-MkPDMTugkMQpooz69A-1
Received: by mail-qt1-f200.google.com with SMTP id e4-20020a05622a110400b003e4e915a164so17888768qty.4
        for <linux-ext4@vger.kernel.org>; Tue, 04 Apr 2023 07:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=395KBh5jpp5sBhV7lwrvunRnw3iYM/DZo2HMst97yLA=;
        b=OvJMioFOPXbtbdMxFgFehNdIjOh8DNvPGNEE8UU40AEFLZORLyVVuvoFQ6OTljqHcP
         h/XwhygQ30d21GrlNDpAVWKboRT6ebQecply8umfzYbgnGU1w9NYrjXrJTAp8PlkCT7O
         0EXWGJHMJKZccN2fpZHDVqargoZlYHXQhoa3LltrDB7mil3BmfNRjsH52JP11Sy8mvgi
         L4hG7oYKPdB8togOOVu6ptpHP4doNtvFiDM0xfkPCohKeF3fTOHyZPjodvlz4XstRwFt
         CFQKx2+gRWlRJ4hUtTA/MAWWXKVLJn60nzqKrqkupvJhuMOWGSMwMZ41j4bvOQMp1K2x
         I5+g==
X-Gm-Message-State: AAQBX9dDiYJV7uDjnMPS0FWNetDNTEKdBtEv9uRUCwlqSXWD+9xA44RZ
        R0BFdLouNY98LWGA6rj5TB6rSCiRDm1F1zGDUGFK59ltT4PPHbfhNhUJv9s3PJKulO6SgaZ52Hk
        HuvCeOSjh9HmsNLdxEaOe
X-Received: by 2002:a05:622a:1495:b0:3e3:86d4:5df0 with SMTP id t21-20020a05622a149500b003e386d45df0mr3709070qtx.55.1680620092097;
        Tue, 04 Apr 2023 07:54:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350aPi48zuTVxqlQ2ykuKHu8ozrnZJsbxnbJpjnRK3ke426WVAPqcsUdJYViMl9WXPC5V56cQ2g==
X-Received: by 2002:a05:622a:1495:b0:3e3:86d4:5df0 with SMTP id t21-20020a05622a149500b003e386d45df0mr3709024qtx.55.1680620091642;
        Tue, 04 Apr 2023 07:54:51 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:54:51 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com,
        Allison Henderson <allison.henderson@oracle.com>
Subject: [PATCH v2 03/23] xfs: define parent pointer xattr format
Date:   Tue,  4 Apr 2023 16:52:59 +0200
Message-Id: <20230404145319.2057051-4-aalbersh@redhat.com>
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

We need to define the parent pointer attribute format before we start
adding support for it into all the code that needs to use it. The EA
format we will use encodes the following information:

        name={parent inode #, parent inode generation, dirent offset}
        value={dirent filename}

The inode/gen gives all the information we need to reliably identify the
parent without requiring child->parent lock ordering, and allows
userspace to do pathname component level reconstruction without the
kernel ever needing to verify the parent itself as part of ioctl calls.

By using the dirent offset in the EA name, we have a method of knowing
the exact parent pointer EA we need to modify/remove in rename/unlink
without an unbound EA name search.

By keeping the dirent name in the value, we have enough information to
be able to validate and reconstruct damaged directory trees. While the
diroffset of a filename alone is not unique enough to identify the
child, the {diroffset,filename,child_inode} tuple is sufficient. That
is, if the diroffset gets reused and points to a different filename, we
can detect that from the contents of EA. If a link of the same name is
created, then we can check whether it points at the same inode as the
parent EA we current have.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_da_format.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 3dc03968bba6..b02b67f1999e 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -805,4 +805,29 @@ static inline unsigned int xfs_dir2_dirblock_bytes(struct xfs_sb *sbp)
 xfs_failaddr_t xfs_da3_blkinfo_verify(struct xfs_buf *bp,
 				      struct xfs_da3_blkinfo *hdr3);
 
+/*
+ * Parent pointer attribute format definition
+ *
+ * EA name encodes the parent inode number, generation and the offset of
+ * the dirent that points to the child inode. The EA value contains the
+ * same name as the dirent in the parent directory.
+ */
+struct xfs_parent_name_rec {
+	__be64  p_ino;
+	__be32  p_gen;
+	__be32  p_diroffset;
+};
+
+/*
+ * incore version of the above, also contains name pointers so callers
+ * can pass/obtain all the parent pointer information in a single structure
+ */
+struct xfs_parent_name_irec {
+	xfs_ino_t		p_ino;
+	uint32_t		p_gen;
+	xfs_dir2_dataptr_t	p_diroffset;
+	const char		*p_name;
+	uint8_t			p_namelen;
+};
+
 #endif /* __XFS_DA_FORMAT_H__ */
-- 
2.38.4

