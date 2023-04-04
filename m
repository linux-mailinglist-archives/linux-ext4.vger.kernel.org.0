Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6891E6D662E
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Apr 2023 16:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjDDO43 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Apr 2023 10:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjDDO4M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Apr 2023 10:56:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676CF49C9
        for <linux-ext4@vger.kernel.org>; Tue,  4 Apr 2023 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680620108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WlIQw7/j0g439cxIh8Bf75rzXhQHTIStlmhsPCq2zc8=;
        b=bwpSL+OAQoQu7yPtghJynu5brlmYRbmJSLMRNxXgwWukii/D6c2li+d++F3YfPL9tPf4XD
        Ub2UIwrRRszgh1DOZGxM7JArWjaqu8cqduWPrK8TK0Tf3aROL8nz99t6Oyag3aeudBHLwC
        So0NCFM+MLtbdY7WVWsZPz5EpZSDsAg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-w074XrvbP7-JAXycHzr8rQ-1; Tue, 04 Apr 2023 10:55:07 -0400
X-MC-Unique: w074XrvbP7-JAXycHzr8rQ-1
Received: by mail-qk1-f200.google.com with SMTP id r197-20020a37a8ce000000b0074a59c12b10so877650qke.5
        for <linux-ext4@vger.kernel.org>; Tue, 04 Apr 2023 07:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlIQw7/j0g439cxIh8Bf75rzXhQHTIStlmhsPCq2zc8=;
        b=doHdqZb/1ofxwrzXICyqJBmH7n8mzw7Ia9J3vU+QErL5yOZ82laub/8k+nnyodF+sv
         X+iZ1qp3Vy/LWqXt+US4yIFinQkxjqMClnrAU0MbrTelNOCGJiJ7f6fVH84wLX7Uzu8c
         d29QJ2XBgyVLYvoAPZphcRLKpGsy+eWESnMKNV8gJXFOM7bEZeKVeV1jhAOGg34GaKvv
         +GfePuRs3ghxtvg0me5JZiALFyfEgJwmAPOYBnB36tfxMjMaSEwnMb+1C6bxMXgwZ2oj
         Ieqz5wnJZTbkHEGfFvkP1jEE5mKOgSnJSRRH+WlAiU+UbCPzbCozdz+KmL4zbHgJnpkD
         3O+Q==
X-Gm-Message-State: AAQBX9cSSeqwrw8E+TDXz/CBPrtznFp1yNkM8i2zRzNqS4biowNnajHm
        lajgLpCdWmP4iMwBKH1zt991e3/oRLSn7WUY4tq8UAahBmzJyzdejSxwds0xSGDeBCib95jN6S+
        7AOiV27ytXCmpHiFLAjLM
X-Received: by 2002:ac8:7c49:0:b0:3e4:db72:2fe9 with SMTP id o9-20020ac87c49000000b003e4db722fe9mr3470323qtv.36.1680620106389;
        Tue, 04 Apr 2023 07:55:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZkIqkTYw/ppN5CuEt6hgDbTeahRxMEc8GNEiOIjYIzOXDUEk9J53kAIKMBFKs3QN5nxJK1Ew==
X-Received: by 2002:ac8:7c49:0:b0:3e4:db72:2fe9 with SMTP id o9-20020ac87c49000000b003e4db722fe9mr3470285qtv.36.1680620106020;
        Tue, 04 Apr 2023 07:55:06 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:05 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 07/23] fsverity: pass Merkle tree block size to ->read_merkle_tree_page()
Date:   Tue,  4 Apr 2023 16:53:03 +0200
Message-Id: <20230404145319.2057051-8-aalbersh@redhat.com>
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

XFS will need to know size of Merkle tree block as these blocks
will not be stored consecutively in fs blocks but under indexes in
extended attributes.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/btrfs/verity.c         | 3 ++-
 fs/ext4/verity.c          | 3 ++-
 fs/f2fs/verity.c          | 3 ++-
 fs/verity/read_metadata.c | 3 ++-
 fs/verity/verify.c        | 3 ++-
 include/linux/fsverity.h  | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 4c2c09204bb4..737ad277b15a 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -713,7 +713,8 @@ int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size)
  */
 static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
 						pgoff_t index,
-						unsigned long num_ra_pages)
+						unsigned long num_ra_pages,
+						u8 log_blocksize)
 {
 	struct page *page;
 	u64 off = (u64)index << PAGE_SHIFT;
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 35a2feb6fd68..cbf1253dd14a 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -361,7 +361,8 @@ static int ext4_get_verity_descriptor(struct inode *inode, void *buf,
 
 static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
-					       unsigned long num_ra_pages)
+					       unsigned long num_ra_pages,
+					       u8 log_blocksize)
 {
 	struct page *page;
 
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 019c7a6c6bcf..63c6a1b1bdef 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -256,7 +256,8 @@ static int f2fs_get_verity_descriptor(struct inode *inode, void *buf,
 
 static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
-					       unsigned long num_ra_pages)
+					       unsigned long num_ra_pages,
+					       u8 log_blocksize)
 {
 	struct page *page;
 
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index cab1612bf4a3..d6cc58c24a2e 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -44,7 +44,8 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 		struct page *page;
 		const void *virt;
 
-		page = vops->read_merkle_tree_page(inode, index, num_ra_pages);
+		page = vops->read_merkle_tree_page(inode, index, num_ra_pages,
+						   vi->tree_params.log_blocksize);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
 			fsverity_err(inode,
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index c2fc4c86af34..9213b1e5ed2c 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -199,7 +199,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 
 		hpage = inode->i_sb->s_vop->read_merkle_tree_page(inode,
 				hpage_idx, level == 0 ? min(max_ra_pages,
-					params->tree_pages - hpage_idx) : 0);
+					params->tree_pages - hpage_idx) : 0,
+				params->log_blocksize);
 		if (IS_ERR(hpage)) {
 			err = PTR_ERR(hpage);
 			fsverity_err(inode,
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 3e923a8e0d6f..ad07a1d10fdf 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -103,7 +103,8 @@ struct fsverity_operations {
 	 */
 	struct page *(*read_merkle_tree_page)(struct inode *inode,
 					      pgoff_t index,
-					      unsigned long num_ra_pages);
+					      unsigned long num_ra_pages,
+					      u8 log_blocksize);
 
 	/**
 	 * Write a Merkle tree block to the given inode.
-- 
2.38.4

