Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C15182387
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Mar 2020 21:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgCKUvD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Mar 2020 16:51:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33928 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgCKUvD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Mar 2020 16:51:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id 59so2703614qtb.1
        for <linux-ext4@vger.kernel.org>; Wed, 11 Mar 2020 13:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LpSP5qu9xOiTgx4uk2C233BP1jdQdXvn6PvwcE+4Y3c=;
        b=J7PE4T3zX2nkWdw5RIjL4Qn8qqFht9Tk2cAwhmK43IlQNolAUJUgjr4VNByDHakVeT
         UVJ0VgxsFxer7BhygznfbvDnMlmG+EjIzOtFzWEU6I1TYCgIj08sIHT10vQpcMo82pM3
         XAxIBrWdIStEEIIAoBBh8kvzgYd506UkNZzs74V2ABjZwBQJCTQ2gj2TG4zdcQ0IOCMG
         tZ1zrXdCFB242vvk6cy9/umPk3vsqbCp1B+JBxD0rEfJkFjZrY6P1G2YPgel7718p5xZ
         XVqbllNL4hATLHpPpyFRznOzoH2gKfuhCfJnpg/DIDespLUjjfO9dpNsf/hL0T8R7y/h
         OXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LpSP5qu9xOiTgx4uk2C233BP1jdQdXvn6PvwcE+4Y3c=;
        b=VaFaHcpihlemjd84I71QuhyCcWLum3fUOabc4LOWp5YNvddsxr0bw3Ur1XDG0VsSXv
         P/l6VnvjUhL9dw7nJKQ5ORdIIATxq8/c6G6a/iycHm7juQRV9iARWto6qw3tPheSEdDI
         N2gajomCVwcAO9VdO/Eymns/OPTzdg+RwuWamKjTG02SZTZy7PpPO2aO+PhGjC95vJ5D
         6OkLdMgwoSsRBU/oQytCbbBiOWDGlf5HTl83Rt/szNrGS5T5Vv61xeZsdmSfr7NRajfc
         3OcNMqXjWgfHrHnnqoMJ0B2x80K2BM0vKJq+DtAfiQzPVeYKtf44pgfIDsltqkMJOaaQ
         nZqQ==
X-Gm-Message-State: ANhLgQ3ezVvCbi13l1YpneQ5IUNYQKm5aGIbChpznFZg6gcu0HwAnmU+
        6aVjMqdh37eh/nGc2httgOaSZQx0
X-Google-Smtp-Source: ADFU+vtAJYxMstT54+KrWzv3X0V5oX6PcMioUM94ryouLDxhneF4XGvHryVGYi9vC18wL/sZIUlZVg==
X-Received: by 2002:ac8:8e7:: with SMTP id y36mr4464631qth.26.1583959861297;
        Wed, 11 Mar 2020 13:51:01 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id q24sm1958766qtk.45.2020.03.11.13.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 13:51:00 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4: clean up ext4_ext_insert_extent() call in ext4_ext_map_blocks()
Date:   Wed, 11 Mar 2020 16:50:33 -0400
Message-Id: <20200311205033.25013-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now that the eofblocks code has been removed, we don't need to assign
0 to err before calling ext4_ext_insert_extent() since it will assign
a return value to ret anyway.  The variable free_on_err can be
eliminated and replaced by a reference to allocated_clusters which
clearly conveys the idea that newly allocated blocks should be freed
when recovering from an extent insertion failure.  The error handling
code itself should be restructured so that it errors out immediately on
an insertion failure in the case where no new blocks have been allocated
(bigalloc) rather than proceeding further into the mapping code.  The
initializer for fb_flags can also be rearranged for improved
readability.  Finally, insert a missing space in nearby code.

No known bugs are addressed by this patch - it's simply a cleanup.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/extents.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index bc96529d1509..c2743d024c11 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4176,7 +4176,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	struct ext4_extent newex, *ex, *ex2;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	ext4_fsblk_t newblock = 0;
-	int free_on_err = 0, err = 0, depth, ret;
+	int err = 0, depth, ret;
 	unsigned int allocated = 0, offset = 0;
 	unsigned int allocated_clusters = 0;
 	struct ext4_allocation_request ar;
@@ -4374,7 +4374,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		goto out2;
 	ext_debug("allocate new block: goal %llu, found %llu/%u\n",
 		  ar.goal, newblock, allocated);
-	free_on_err = 1;
 	allocated_clusters = ar.len;
 	ar.len = EXT4_C2B(sbi, ar.len) - offset;
 	if (ar.len > allocated)
@@ -4385,23 +4384,28 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	ext4_ext_store_pblock(&newex, newblock + offset);
 	newex.ee_len = cpu_to_le16(ar.len);
 	/* Mark unwritten */
-	if (flags & EXT4_GET_BLOCKS_UNWRIT_EXT){
+	if (flags & EXT4_GET_BLOCKS_UNWRIT_EXT) {
 		ext4_ext_mark_unwritten(&newex);
 		map->m_flags |= EXT4_MAP_UNWRITTEN;
 	}
 
-	err = 0;
 	err = ext4_ext_insert_extent(handle, inode, &path, &newex, flags);
+	if (err) {
+		if (allocated_clusters) {
+			int fb_flags = 0;
 
-	if (err && free_on_err) {
-		int fb_flags = flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE ?
-			EXT4_FREE_BLOCKS_NO_QUOT_UPDATE : 0;
-		/* free data blocks we just allocated */
-		/* not a good idea to call discard here directly,
-		 * but otherwise we'd need to call it every free() */
-		ext4_discard_preallocations(inode);
-		ext4_free_blocks(handle, inode, NULL, newblock,
-				 EXT4_C2B(sbi, allocated_clusters), fb_flags);
+			/*
+			 * free data blocks we just allocated.
+			 * not a good idea to call discard here directly,
+			 * but otherwise we'd need to call it every free().
+			 */
+			ext4_discard_preallocations(inode);
+			if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
+				fb_flags = EXT4_FREE_BLOCKS_NO_QUOT_UPDATE;
+			ext4_free_blocks(handle, inode, NULL, newblock,
+					 EXT4_C2B(sbi, allocated_clusters),
+					 fb_flags);
+		}
 		goto out2;
 	}
 
-- 
2.11.0

