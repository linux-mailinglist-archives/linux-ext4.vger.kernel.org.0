Return-Path: <linux-ext4+bounces-6224-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E1EA19FCB
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 09:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B439516DF54
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 08:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFB120C46E;
	Thu, 23 Jan 2025 08:23:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81681EEE0;
	Thu, 23 Jan 2025 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620626; cv=none; b=WCAmTbckIBZMh76tKqW1/LDGVAAHI02uSnNABpdNPqxDl5fDWIPVHdt65daAkwANjI6n4Jx8Q9wUFD03YyBRH8RWe1vMTJOLVXqxc6ZNiiSQUVon09nMA8wPywsUTjjarRX9jxoCZwyRaXIPLa7f7fjj7tgcOK5f+uhAaZCLF0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620626; c=relaxed/simple;
	bh=H7NDqKr80LWAP+4mhvPZE9julSilRF+LPydCHIs9Ra8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A5p08o0Hk1iPPA06WLIq07bF3rurZljQteYbmGh0lpi7WqnKxU6KIEzv4/TciWu9fnJGNfNPja9gbSN9Rf3jSZ9J54Z00NHwJH3CBMNchjlycfW9sJ98oyw8KjK70jGOsiw/UpyotdVuAdd+9bk/MXMR1++LDOxkQ9r69k5hHXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ydv8s2zDkz4f3jt0;
	Thu, 23 Jan 2025 16:23:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DB9B81A083F;
	Thu, 23 Jan 2025 16:23:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCH7GCL_JFnxur_Bg--.47357S3;
	Thu, 23 Jan 2025 16:23:40 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	ojaswin@linux.ibm.com,
	yi.zhang@huaweicloud.com
Cc: akpm@osdl.org,
	shaggy@austin.ibm.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ext4: add missing brelse() for bh2 in ext4_dx_add_entry()
Date: Fri, 24 Jan 2025 00:20:48 +0800
Message-Id: <20250123162050.2114499-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250123162050.2114499-1-shikemeng@huaweicloud.com>
References: <20250123162050.2114499-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH7GCL_JFnxur_Bg--.47357S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF15tF17ZF4DtF1rJFy3twb_yoW8urW3pr
	W5Gas7ZFyxCF129FsxZ3WUXFya9w4xCry7X3y7GrySk347Xrn5Gasrtw1FkF4DJay8W3W5
	XF4UKryj9a12yrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
	z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AK
	xVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRS4EZUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Add missing brelse() for bh2 in ext4_dx_add_entry().

Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/namei.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 1012781ae9b4..adec145b6f7d 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2580,8 +2580,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 		BUFFER_TRACE(frame->bh, "get_write_access");
 		err = ext4_journal_get_write_access(handle, sb, frame->bh,
 						    EXT4_JTR_NONE);
-		if (err)
+		if (err) {
+			brelse(bh2);
 			goto journal_error;
+		}
 		if (!add_level) {
 			unsigned icount1 = icount/2, icount2 = icount - icount1;
 			unsigned hash2 = dx_get_hash(entries + icount1);
@@ -2592,8 +2594,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 			err = ext4_journal_get_write_access(handle, sb,
 							    (frame - 1)->bh,
 							    EXT4_JTR_NONE);
-			if (err)
+			if (err) {
+				brelse(bh2);
 				goto journal_error;
+			}
 
 			memcpy((char *) entries2, (char *) (entries + icount1),
 			       icount2 * sizeof(struct dx_entry));
@@ -2612,8 +2616,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 			dxtrace(dx_show_index("node",
 			       ((struct dx_node *) bh2->b_data)->entries));
 			err = ext4_handle_dirty_dx_node(handle, dir, bh2);
-			if (err)
+			if (err) {
+				brelse(bh2);
 				goto journal_error;
+			}
 			brelse (bh2);
 			err = ext4_handle_dirty_dx_node(handle, dir,
 						   (frame - 1)->bh);
@@ -2638,8 +2644,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 				       "Creating %d level index...\n",
 				       dxroot->info.indirect_levels));
 			err = ext4_handle_dirty_dx_node(handle, dir, frame->bh);
-			if (err)
+			if (err) {
+				brelse(bh2);
 				goto journal_error;
+			}
 			err = ext4_handle_dirty_dx_node(handle, dir, bh2);
 			brelse(bh2);
 			restart = 1;
-- 
2.30.0


