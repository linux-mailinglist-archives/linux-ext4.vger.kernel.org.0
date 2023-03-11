Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826B26B59A0
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Mar 2023 10:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjCKJGw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 11 Mar 2023 04:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCKJGs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 11 Mar 2023 04:06:48 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E661011E6EB;
        Sat, 11 Mar 2023 01:06:46 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PYcVT0wGdz4f3jHm;
        Sat, 11 Mar 2023 17:06:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHu+mhRAxkx4BgFA--.7403S3;
        Sat, 11 Mar 2023 17:06:42 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH 1/2] ext4: fix typos in mballoc
Date:   Sun, 12 Mar 2023 01:09:48 +0800
Message-Id: <20230311170949.1047958-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230311170949.1047958-1-shikemeng@huaweicloud.com>
References: <20230311170949.1047958-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHu+mhRAxkx4BgFA--.7403S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1fGw4rXFy3Gw1fAF1rXrb_yoW8Gr4rpr
        s7XF1akwsxWryY9an2k3Wjqw1fG397Cr15Gr1Ygw15ZFW3JrWIkF4DtryrGFyrC39rXF1a
        vFs0vr13uwsruaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
        C7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWU
        JVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjTRN189UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

pa_plen -> pa_len
pa_start -> pa_pstart

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 85d5e219933f..13dce6f07fa4 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4146,7 +4146,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	 * provide gurantee on number of contiguous blocks allocation since that
 	 * depends upon free space left, etc).
 	 * In case of inode pa, later we use the allocated blocks
-	 * [pa_start + fe_logical - pa_lstart, fe_len/size] from the preallocated
+	 * [pa_pstart + fe_logical - pa_lstart, fe_len/size] from the preallocated
 	 * range of goal/best blocks [start, size] to put it at the
 	 * ac_o_ex.fe_logical extent of this inode.
 	 * (See ext4_mb_use_inode_pa() for more details)
@@ -4298,7 +4298,7 @@ static void ext4_mb_use_group_pa(struct ext4_allocation_context *ac,
 	ac->ac_status = AC_STATUS_FOUND;
 	ac->ac_pa = pa;
 
-	/* we don't correct pa_pstart or pa_plen here to avoid
+	/* we don't correct pa_pstart or pa_len here to avoid
 	 * possible race when the group is being loaded concurrently
 	 * instead we correct pa later, after blocks are marked
 	 * in on-disk bitmap -- see ext4_mb_release_context()
-- 
2.30.0

