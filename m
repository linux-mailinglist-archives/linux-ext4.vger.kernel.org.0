Return-Path: <linux-ext4+bounces-3549-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DB0942692
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 08:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D799C1F239D7
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 06:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E1716C866;
	Wed, 31 Jul 2024 06:25:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF431494A9;
	Wed, 31 Jul 2024 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407131; cv=none; b=Yyduqe9Vdph7rO+6gl9JqqCwkdeSEhs3/43+XCDGnHw7b0Ia0Vtua5Px76yiCiGzX58F8bMkOaoH5o0k1kWC7wphNuxEbREag3Dq3r5IOoOwmno2jaD8gcIMwKkk2/RzKby51fTlzjC2KX1pTOwC+b6DNk1mFcYV9jxZSLQtUhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407131; c=relaxed/simple;
	bh=UZqZpd+4FFEgbJSburvPHFQH65vv4VdG0WcaVQ+/sdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WV4gB8z5u3VDN6XD7GopY8L+eD2pzqtcfhkLCkG04LryrWFbo/io3Usk5MyBNBBivQzEncF4QvYhEUN2EkLbEKYhd1jHL7+/VsiG+EzQHTr5dycprCe6QfbtVoBaDhxyi0yfY6dl1yTDwSLOs7IQmodmyU0Ajp5HYu85gTreZfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYhsh133Rz4f3kv5;
	Wed, 31 Jul 2024 14:25:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 171821A07B6;
	Wed, 31 Jul 2024 14:25:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3jE7T2KlmaFNcAQ--.8748S5;
	Wed, 31 Jul 2024 14:25:25 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] jbd2: remove unused return value of jbd2_fc_release_bufs
Date: Wed, 31 Jul 2024 14:22:42 +0800
Message-Id: <20240731062247.2380440-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240731062247.2380440-1-shikemeng@huaweicloud.com>
References: <20240731062247.2380440-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3jE7T2KlmaFNcAQ--.8748S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tryxXFW8CrWUXrykJr45Awb_yoW8XF1rpa
	4xG340kr95uryUAw1kWFs8JFW09F4IkFyUWFsF9wnYkw43GrsFqrsrtwn2yryFyrZ5Kw4Y
	vry8Kw48C3y0grJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07jec_-UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unused return value of jbd2_fc_release_bufs.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c    | 4 +---
 include/linux/jbd2.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b5d02de1ffff..312c7575b54f 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -903,7 +903,7 @@ int jbd2_fc_wait_bufs(journal_t *journal, int num_blks)
 }
 EXPORT_SYMBOL(jbd2_fc_wait_bufs);
 
-int jbd2_fc_release_bufs(journal_t *journal)
+void jbd2_fc_release_bufs(journal_t *journal)
 {
 	struct buffer_head *bh;
 	int i, j_fc_off;
@@ -917,8 +917,6 @@ int jbd2_fc_release_bufs(journal_t *journal)
 		put_bh(bh);
 		journal->j_fc_wbuf[i] = NULL;
 	}
-
-	return 0;
 }
 EXPORT_SYMBOL(jbd2_fc_release_bufs);
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index b900c642210c..735229e8ad17 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1665,7 +1665,7 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out);
 int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode);
 int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode);
 int jbd2_fc_wait_bufs(journal_t *journal, int num_blks);
-int jbd2_fc_release_bufs(journal_t *journal);
+void jbd2_fc_release_bufs(journal_t *journal);
 
 /*
  * is_journal_abort
-- 
2.30.0


