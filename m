Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99486D94DD
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Apr 2023 13:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbjDFLQj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Apr 2023 07:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237205AbjDFLQi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Apr 2023 07:16:38 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A5B7EEA
        for <linux-ext4@vger.kernel.org>; Thu,  6 Apr 2023 04:16:36 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id o20so37415211ljp.3
        for <linux-ext4@vger.kernel.org>; Thu, 06 Apr 2023 04:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680779795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kqrTTFUw5jhbnIJzwUt5+WbmAoaABO4HowWEX8FOmUA=;
        b=Fy3Be1ZW870RKME2mz/II9IZkV2GAbDzqTsrzlgK5tcByiOQB1qWSDJ74fl2QMK5uc
         jupsONHrNKs8J2/W1xwEKHLkUrFJcYjJhhp201sw119JFUs+Qx3pgBPvj1f3m9eAWk4L
         tt/vF8vXRlYWiDmBMgHq0p+Px6KkSuGhxB/YO9pJwSVJj+/DKSqTVQ/bqgz0sYvGoV77
         Eo1Py037WBxa5P+wfmBxXjpsX9ur+wkUnjBnPtKlycGZaGHqKCH8oJznf5sE0aeVOfXb
         2cXwfXGr7JFOiAphhqtp8mUsexzXR959y4UIDEh6XvX5/altkjK9MrVRo2mABPzcXJjQ
         E6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680779795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqrTTFUw5jhbnIJzwUt5+WbmAoaABO4HowWEX8FOmUA=;
        b=YmBjymrqI+zzgzDpURb373UkXB89B6Pw+GbPQtvqU2Pe+EtxzS0QaRvcJaLbvT2Iha
         1f2+xtosMBTZlSeroCaQNAXe1RFa99yodEbqk6a0KspIYsaT2fm8uQ4eDSvyrgrRhaHe
         MzAgvYI1ozyH6VobDG4fjOy0FLm7bArYq1a9abDCaF0uEDosqG9gfU4JYfB31yAmdomH
         APDPOOKd5mOJWrh1vxttSfXnHOD6Z5w16KlBg6j1FcATZvzN995t/Qc8xi7NrlzekXv9
         CwTfDGlPEH5WsOUlHEVIMpYvrUgM9LXo0aXXWumoGrPLFZ6EcKRRPyEakrerR5/F+esW
         uHnA==
X-Gm-Message-State: AAQBX9cQ/nAv6dcQjAEB61Ve4iSCbhhMLCEdfti9opnyeAF4+8+htz2X
        NtKXz0ZorRZeyPKDSgIu/svX1Q==
X-Google-Smtp-Source: AKy350br4WJxfZop0nas6YjL9sBW/LF8aFIt+5ebcVQjRmf0C7LboWIpCU/qY4dsNYCE0OrVMTsmuQ==
X-Received: by 2002:a2e:8082:0:b0:2a4:1ecf:6342 with SMTP id i2-20020a2e8082000000b002a41ecf6342mr2570993ljg.25.1680779795132;
        Thu, 06 Apr 2023 04:16:35 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id w12-20020a05651c102c00b0029b32a40934sm241292ljm.113.2023.04.06.04.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:16:33 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, yebin10@huawei.com,
        jack@suse.cz
Cc:     enwlinux@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, joneslee@google.com,
        syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [RESEND PATCH] ext4: fix use-after-free Read in ext4_find_extent for bigalloc + inline
Date:   Thu,  6 Apr 2023 11:16:27 +0000
Message-Id: <20230406111627.1916759-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Syzbot found the following issue:
loop0: detected capacity change from 0 to 2048
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: none.
==================================================================
BUG: KASAN: use-after-free in ext4_ext_binsearch_idx fs/ext4/extents.c:768 [inline]
BUG: KASAN: use-after-free in ext4_find_extent+0x76e/0xd90 fs/ext4/extents.c:931
Read of size 4 at addr ffff888073644750 by task syz-executor420/5067

CPU: 0 PID: 5067 Comm: syz-executor420 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:306
 print_report+0x107/0x1f0 mm/kasan/report.c:417
 kasan_report+0xcd/0x100 mm/kasan/report.c:517
 ext4_ext_binsearch_idx fs/ext4/extents.c:768 [inline]
 ext4_find_extent+0x76e/0xd90 fs/ext4/extents.c:931
 ext4_clu_mapped+0x117/0x970 fs/ext4/extents.c:5809
 ext4_insert_delayed_block fs/ext4/inode.c:1696 [inline]
 ext4_da_map_blocks fs/ext4/inode.c:1806 [inline]
 ext4_da_get_block_prep+0x9e8/0x13c0 fs/ext4/inode.c:1870
 ext4_block_write_begin+0x6a8/0x2290 fs/ext4/inode.c:1098
 ext4_da_write_begin+0x539/0x760 fs/ext4/inode.c:3082
 generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3772
 ext4_buffered_write_iter+0x122/0x3a0 fs/ext4/file.c:285
 ext4_file_write_iter+0x1d0/0x18f0
 call_write_iter include/linux/fs.h:2186 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4b7a9737b9
RSP: 002b:00007ffc5cac3668 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4b7a9737b9
RDX: 00000000175d9003 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00007f4b7a933050 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000079f R11: 0000000000000246 R12: 00007f4b7a9330e0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Above issue is happens when enable bigalloc and inline data feature. As
commit 131294c35ed6 fixed delayed allocation bug in ext4_clu_mapped for
bigalloc + inline. But it only resolved issue when has inline data, if
inline data has been converted to extent(ext4_da_convert_inline_data_to_extent)
before writepages, there is no EXT4_STATE_MAY_INLINE_DATA flag. However
i_data is still store inline data in this scene. Then will trigger UAF
when find extent.
To resolve above issue, there is need to add judge "ext4_has_inline_data(inode)"
in ext4_clu_mapped().

Fixes: 131294c35ed6 ("ext4: fix delayed allocation bug in ext4_clu_mapped for bigalloc + inline")
Reported-by: syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
Signed-off-by: Ye Bin <yebin10@huawei.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Tested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
The patch was proposed 3 months ago, resend it as it probably got lost:
https://lore.kernel.org/all/20230104071559.2051847-1-yebin@huaweicloud.com/#t

 fs/ext4/extents.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3559ea6b0781..74251eebf831 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5802,7 +5802,8 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
 	 * mapped - no physical clusters have been allocated, and the
 	 * file has no extents
 	 */
-	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
+	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) ||
+	    ext4_has_inline_data(inode))
 		return 0;
 
 	/* search for the extent closest to the first block in the cluster */
-- 
2.40.0.348.gf938b09366-goog

