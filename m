Return-Path: <linux-ext4+bounces-3580-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D199440C0
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 04:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F431F23901
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 02:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991EA1A7F8A;
	Thu,  1 Aug 2024 01:41:00 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D281A7219;
	Thu,  1 Aug 2024 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476460; cv=none; b=W13/2BVPZGIckpUamvoMi11w2J2wIiXUOevr5GS90TRoyMSiBCAFcQZdeQ9eDlD+Cfu4E/CK5xc8324J5XPqhqHqgIWvbcLlBRasVPdSj+yKJUuKffApYMeH8bOPcDPK06NUQnxz5qBnp1lfpBxE20fbv0pPOLaxMW9oQOmcSD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476460; c=relaxed/simple;
	bh=5Wn4WTyZNpU1evVyc6lLbhOjWfKhsTNhU1HkXjEyg0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gX7fWUEsq09+gczy4Ohb3+gHLJaQNHa7dnpiKOQjrd5dTYky9blvVCLVQ4g3pWnTkWzqaKuJqNfKCpAJ3t2r0jccgo7oVqn84wZGvlRGHuJGaacdslWi9S0fyYrJ5dM+YruGWXMCaY4x8XdL8Muc4v0yv+0ulAQZGb1s0MUUT0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WZBVx47JCz4f3kvg;
	Thu,  1 Aug 2024 09:40:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8DD0C1A018D;
	Thu,  1 Aug 2024 09:40:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgBnnr2l56pmr3OyAQ--.24249S5;
	Thu, 01 Aug 2024 09:40:55 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/8] jbd2: remove unused return value of jbd2_fc_release_bufs
Date: Thu,  1 Aug 2024 09:38:10 +0800
Message-Id: <20240801013815.2393869-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240801013815.2393869-1-shikemeng@huaweicloud.com>
References: <20240801013815.2393869-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnnr2l56pmr3OyAQ--.24249S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tryxXFyfAFy8Zry8Xw48Crg_yoW8Xw1rpa
	4fG340kr95uryUAw1kWFs8JFW09F4IkryUWFsF9wnYkw43GrsFqrsrtwn2yr9YyrZ5Kw4Y
	vry8Kw48C340grJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxU2ApnDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unused return value of jbd2_fc_release_bufs.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
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


