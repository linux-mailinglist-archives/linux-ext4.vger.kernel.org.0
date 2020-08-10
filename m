Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3A424056F
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Aug 2020 13:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHJLpv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Aug 2020 07:45:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47276 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbgHJLpu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 10 Aug 2020 07:45:50 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 23E60CAF2948679A61FF;
        Mon, 10 Aug 2020 19:45:49 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 10 Aug 2020
 19:45:44 +0800
From:   Shijie Luo <luoshijie1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <riteshh@linux.ibm.com>
Subject: [PATCH] ext4: change to use fallthrough macro instead of fallthrough comments
Date:   Mon, 10 Aug 2020 07:44:35 -0400
Message-ID: <20200810114435.24182-1-luoshijie1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Change to use fallthrough macro in switch case.

Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
---
 fs/ext4/hash.c     |  4 ++--
 fs/ext4/indirect.c | 12 ++++++------
 fs/ext4/readpage.c |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index 3e133793a5a3..2924261226e0 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -233,7 +233,7 @@ static int __ext4fs_dirhash(const char *name, int len,
 		break;
 	case DX_HASH_HALF_MD4_UNSIGNED:
 		str2hashbuf = str2hashbuf_unsigned;
-		/* fall through */
+		fallthrough;
 	case DX_HASH_HALF_MD4:
 		p = name;
 		while (len > 0) {
@@ -247,7 +247,7 @@ static int __ext4fs_dirhash(const char *name, int len,
 		break;
 	case DX_HASH_TEA_UNSIGNED:
 		str2hashbuf = str2hashbuf_unsigned;
-		/* fall through */
+		fallthrough;
 	case DX_HASH_TEA:
 		p = name;
 		while (len > 0) {
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index be2b66eb65f7..1217f0fdcb33 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -1182,21 +1182,21 @@ void ext4_ind_truncate(handle_t *handle, struct inode *inode)
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 1);
 			i_data[EXT4_IND_BLOCK] = 0;
 		}
-		/* fall through */
+		fallthrough;
 	case EXT4_IND_BLOCK:
 		nr = i_data[EXT4_DIND_BLOCK];
 		if (nr) {
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 2);
 			i_data[EXT4_DIND_BLOCK] = 0;
 		}
-		/* fall through */
+		fallthrough;
 	case EXT4_DIND_BLOCK:
 		nr = i_data[EXT4_TIND_BLOCK];
 		if (nr) {
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 3);
 			i_data[EXT4_TIND_BLOCK] = 0;
 		}
-		/* fall through */
+		fallthrough;
 	case EXT4_TIND_BLOCK:
 		;
 	}
@@ -1436,7 +1436,7 @@ int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 1);
 			i_data[EXT4_IND_BLOCK] = 0;
 		}
-		/* fall through */
+		fallthrough;
 	case EXT4_IND_BLOCK:
 		if (++n >= n2)
 			break;
@@ -1445,7 +1445,7 @@ int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 2);
 			i_data[EXT4_DIND_BLOCK] = 0;
 		}
-		/* fall through */
+		fallthrough;
 	case EXT4_DIND_BLOCK:
 		if (++n >= n2)
 			break;
@@ -1454,7 +1454,7 @@ int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 3);
 			i_data[EXT4_TIND_BLOCK] = 0;
 		}
-		/* fall through */
+		fallthrough;
 	case EXT4_TIND_BLOCK:
 		;
 	}
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index f2df2db0786c..f014c5e473a9 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -140,7 +140,7 @@ static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
 			return;
 		}
 		ctx->cur_step++;
-		/* fall-through */
+		fallthrough;
 	case STEP_VERITY:
 		if (ctx->enabled_steps & (1 << STEP_VERITY)) {
 			INIT_WORK(&ctx->work, verity_work);
@@ -148,7 +148,7 @@ static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
 			return;
 		}
 		ctx->cur_step++;
-		/* fall-through */
+		fallthrough;
 	default:
 		__read_end_io(ctx->bio);
 	}
-- 
2.19.1

