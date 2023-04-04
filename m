Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8916D662A
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Apr 2023 16:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjDDO40 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Apr 2023 10:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjDDO4I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Apr 2023 10:56:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D7549FF
        for <linux-ext4@vger.kernel.org>; Tue,  4 Apr 2023 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680620104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z32N0rKUyphSVMSofzw3CVH4IfYQ7TTzuKWmER1MJ68=;
        b=Rw1vzl5/evwdKwq/fqTjlQxkjQ0jIUXJGzA6TDibzuLWIIm2FM4o7vxoS6KkyAIdccUa9S
        zrt2ID5zqH8fL5n27XfcPX/TzspksyP0swUH8IWovKWKH+DTH2CiHUkX09obL9qBnP6T7F
        LxIDcEV0vySqkdOkOFSnzPHldxNs+Vo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-qMB5lGWON8-LMIJca_ZSvA-1; Tue, 04 Apr 2023 10:55:03 -0400
X-MC-Unique: qMB5lGWON8-LMIJca_ZSvA-1
Received: by mail-qk1-f200.google.com with SMTP id s2-20020a37a902000000b0074a28a891baso4313893qke.18
        for <linux-ext4@vger.kernel.org>; Tue, 04 Apr 2023 07:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z32N0rKUyphSVMSofzw3CVH4IfYQ7TTzuKWmER1MJ68=;
        b=TdTc0TDZlbkPfLXbTKQTV1q8wYAm7cDP8FsfcONyT6gkoO9fTzxhbUB4DcqH9J3iJF
         oIhWSdU2WwPdVZ4I46nemJ8+fo+SimDijF2KazD+3ARfiNUV34MAbZ+/s5k0HWKcWMpB
         aJAkKnjfi0jG6ZBQOBEXo1koa0i8GOR3AGlNqWiquHyDXxESIu1BUtuuCLaSqfPbU+Jv
         JGR0DeakaNmd03CfLV60Nn7jWUFsVtCFDxxEyi4qSPB2V1I/P17UK37rFMINkW0lCjiL
         Mtml3Dz3iXubZrUoCIF4UUyaY0JtJRaYIMieKO7IktuNkaw8avoSvbfCeWACh2jf/Vw2
         yDRw==
X-Gm-Message-State: AAQBX9cChrBXm31hjzFJncF9vJ+ysUrszmPWcAJ2A7PFI7zK/Lfcpe+9
        Bkj4ChKSIqIUKZzGUeKG5Z/ML4Y0vRxvuShxtSQPTnSOXxr+91Q58LcdNdeqwwxX4zuy3zQKjCg
        w0wqjgkWnEzGbFEhe78nv
X-Received: by 2002:a05:622a:106:b0:3e4:ed0d:6a87 with SMTP id u6-20020a05622a010600b003e4ed0d6a87mr3825559qtw.32.1680620102977;
        Tue, 04 Apr 2023 07:55:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zp0JOhVAHhC6Iyf8k/1+phPOce9sQ42GmA8VSWN8AvlHBpCO2hspsjGFg8IADdMrX46OgtcA==
X-Received: by 2002:a05:622a:106:b0:3e4:ed0d:6a87 with SMTP id u6-20020a05622a010600b003e4ed0d6a87mr3825521qtw.32.1680620102599;
        Tue, 04 Apr 2023 07:55:02 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:02 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 06/23] fsverity: add drop_page() callout
Date:   Tue,  4 Apr 2023 16:53:02 +0200
Message-Id: <20230404145319.2057051-7-aalbersh@redhat.com>
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

Allow filesystem to make additional processing on verified pages
instead of just dropping a reference. This will be used by XFS for
internal buffer cache manipulation in further patches. The btrfs,
ext4, and f2fs just drop the reference.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/btrfs/verity.c         | 12 ++++++++++++
 fs/ext4/verity.c          |  6 ++++++
 fs/f2fs/verity.c          |  6 ++++++
 fs/verity/read_metadata.c |  4 ++--
 fs/verity/verify.c        |  6 +++---
 include/linux/fsverity.h  | 10 ++++++++++
 6 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index c5ff16f9e9fa..4c2c09204bb4 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -804,10 +804,22 @@ static int btrfs_write_merkle_tree_block(struct inode *inode, const void *buf,
 			       pos, buf, size);
 }
 
+/*
+ * fsverity op that releases the reference obtained by ->read_merkle_tree_page()
+ *
+ * @page:  reference to the page which can be released
+ *
+ */
+static void btrfs_drop_page(struct page *page)
+{
+	put_page(page);
+}
+
 const struct fsverity_operations btrfs_verityops = {
 	.begin_enable_verity     = btrfs_begin_enable_verity,
 	.end_enable_verity       = btrfs_end_enable_verity,
 	.get_verity_descriptor   = btrfs_get_verity_descriptor,
 	.read_merkle_tree_page   = btrfs_read_merkle_tree_page,
 	.write_merkle_tree_block = btrfs_write_merkle_tree_block,
+	.drop_page		 = &btrfs_drop_page,
 };
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index e4da1704438e..35a2feb6fd68 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -388,10 +388,16 @@ static int ext4_write_merkle_tree_block(struct inode *inode, const void *buf,
 	return pagecache_write(inode, buf, size, pos);
 }
 
+static void ext4_drop_page(struct page *page)
+{
+	put_page(page);
+}
+
 const struct fsverity_operations ext4_verityops = {
 	.begin_enable_verity	= ext4_begin_enable_verity,
 	.end_enable_verity	= ext4_end_enable_verity,
 	.get_verity_descriptor	= ext4_get_verity_descriptor,
 	.read_merkle_tree_page	= ext4_read_merkle_tree_page,
 	.write_merkle_tree_block = ext4_write_merkle_tree_block,
+	.drop_page		= &ext4_drop_page,
 };
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 4fc95f353a7a..019c7a6c6bcf 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -283,10 +283,16 @@ static int f2fs_write_merkle_tree_block(struct inode *inode, const void *buf,
 	return pagecache_write(inode, buf, size, pos);
 }
 
+static void f2fs_drop_page(struct page *page)
+{
+	put_page(page);
+}
+
 const struct fsverity_operations f2fs_verityops = {
 	.begin_enable_verity	= f2fs_begin_enable_verity,
 	.end_enable_verity	= f2fs_end_enable_verity,
 	.get_verity_descriptor	= f2fs_get_verity_descriptor,
 	.read_merkle_tree_page	= f2fs_read_merkle_tree_page,
 	.write_merkle_tree_block = f2fs_write_merkle_tree_block,
+	.drop_page		= &f2fs_drop_page,
 };
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index 2aefc5565152..cab1612bf4a3 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -56,12 +56,12 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 		virt = kmap_local_page(page);
 		if (copy_to_user(buf, virt + offs_in_page, bytes_to_copy)) {
 			kunmap_local(virt);
-			put_page(page);
+			inode->i_sb->s_vop->drop_page(page);
 			err = -EFAULT;
 			break;
 		}
 		kunmap_local(virt);
-		put_page(page);
+		inode->i_sb->s_vop->drop_page(page);
 
 		retval += bytes_to_copy;
 		buf += bytes_to_copy;
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index f50e3b5b52c9..c2fc4c86af34 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -210,7 +210,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		if (is_hash_block_verified(vi, hpage, hblock_idx)) {
 			memcpy_from_page(_want_hash, hpage, hoffset, hsize);
 			want_hash = _want_hash;
-			put_page(hpage);
+			inode->i_sb->s_vop->drop_page(hpage);
 			goto descend;
 		}
 		hblocks[level].page = hpage;
@@ -248,7 +248,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 			SetPageChecked(hpage);
 		memcpy_from_page(_want_hash, hpage, hoffset, hsize);
 		want_hash = _want_hash;
-		put_page(hpage);
+		inode->i_sb->s_vop->drop_page(hpage);
 	}
 
 	/* Finally, verify the data block. */
@@ -259,7 +259,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 	err = cmp_hashes(vi, want_hash, real_hash, data_pos, -1);
 out:
 	for (; level > 0; level--)
-		put_page(hblocks[level - 1].page);
+		inode->i_sb->s_vop->drop_page(hblocks[level - 1].page);
 
 	return err == 0;
 }
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 6d7a4b3ea626..3e923a8e0d6f 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -120,6 +120,16 @@ struct fsverity_operations {
 	 */
 	int (*write_merkle_tree_block)(struct inode *inode, const void *buf,
 				       u64 pos, unsigned int size);
+
+	/**
+	 * Release the reference to a Merkle tree page
+	 *
+	 * @page: the page to release
+	 *
+	 * This is called when fs-verity is done with a page obtained with
+	 * ->read_merkle_tree_page().
+	 */
+	void (*drop_page)(struct page *page);
 };
 
 #ifdef CONFIG_FS_VERITY
-- 
2.38.4

