Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED696789543
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Aug 2023 11:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjHZJic (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Aug 2023 05:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjHZJiG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Aug 2023 05:38:06 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C84D2702;
        Sat, 26 Aug 2023 02:37:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RXsDq3Vmbz4f3jXm;
        Sat, 26 Aug 2023 17:37:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgA3E6bqx+lkNx57Bg--.59420S9;
        Sat, 26 Aug 2023 17:37:50 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/13] ext4: remove commented code in reserve_backup_gdb
Date:   Sun, 27 Aug 2023 01:37:29 +0800
Message-Id: <20230826173735.4023594-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826173735.4023594-1-shikemeng@huaweicloud.com>
References: <20230826173735.4023594-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3E6bqx+lkNx57Bg--.59420S9
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4Uur1rtr4DZF43Wr4fAFb_yoW3trgEqa
        srCr4kZrWfGrn5CFyxCr1fArWv9r1rtrn5ury7trn5W3WUtFZ5AayDXwsxCryDuF4Yy3W5
        ZF1vq3sFyay0gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC
        64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM2
        8EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0D
        M28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
        wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jstxDUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remove commented code in reserve_backup_gdb

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/resize.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index c51994e22af5..a370ca1a2bd6 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1080,9 +1080,6 @@ static int reserve_backup_gdb(handle_t *handle, struct inode *inode,
 	for (i = 0; i < reserved_gdb; i++) {
 		int err2;
 		data = (__le32 *)primary[i]->b_data;
-		/* printk("reserving backup %lu[%u] = %lu\n",
-		       primary[i]->b_blocknr, gdbackups,
-		       blk + primary[i]->b_blocknr); */
 		data[gdbackups] = cpu_to_le32(blk + primary[i]->b_blocknr);
 		err2 = ext4_handle_dirty_metadata(handle, NULL, primary[i]);
 		if (!err)
-- 
2.30.0

