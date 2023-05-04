Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573E36F6AF7
	for <lists+linux-ext4@lfdr.de>; Thu,  4 May 2023 14:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjEDMPf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 May 2023 08:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjEDMPe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 May 2023 08:15:34 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA3C5FDC
        for <linux-ext4@vger.kernel.org>; Thu,  4 May 2023 05:15:32 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ac70c975fcso4800171fa.3
        for <linux-ext4@vger.kernel.org>; Thu, 04 May 2023 05:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683202531; x=1685794531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbxMsDcOZE4VwLeDeJW+M4J9LqpR7B1fpo6aQT2cmic=;
        b=jspw81xKm59iS7w4VcNG5gI0Yyetq4FlOofbCDrKq8odSqkWHtkr1ah4cZ9B/b52i4
         Nk222L3v/Lod/7QzBTv8JnbCx8Rv2LXDGCNBn5yWpcYY4NgABqDeytbuUf3XrAETw7b0
         ig8Izq89jnuQaFl5kV3ViYpmVoJRBSVvMjSkHw6q1WqHhXWQSN/fsC/vGfNKgdWL/wMz
         F1AvzPSjhznyrMMQqLIQBrrm+DcjMTK5WRDejAYhRsVBgcf+9UWjuljHQJYO/puKwIw9
         gx+P7aSNv1VpObac/ubGChQcgdtuSELzm3ptyo1YDiaC6CoIbn7kB6/xev3GmpvxhQMN
         JBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683202531; x=1685794531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbxMsDcOZE4VwLeDeJW+M4J9LqpR7B1fpo6aQT2cmic=;
        b=TlPuL+vx/+XeYCVQCJWI5bTdY8pKKFtu2sK5fQc16HiNIJyuJ4Hg1sSsFT+fyGW7vm
         GJEOGh9bu9ws8VIZ9x2DjL8b07qVEVRhhhUEpXOeyxZkKiV67XKPU+rPk4SnYd3PLYHo
         da6iVQ9SFj//W5e/gb5t3XWx6MsXgR1m59R5dVV/AeX3kOZMGB7j2iKCFV0ddkaaRmm9
         z1qwPAMzR4307T4JOBEn0+tmxw10aN6puiNFXIFCPEzZqWf4tKWJIIMtsTvbZhFVZGAi
         g8GSU89UDLaKRfZ1EwRG8hq3Y8O3V7C2jYCKcbcx1rxFNlGPEmqrY/1mVIPU4o/kSQ7Q
         M2hA==
X-Gm-Message-State: AC+VfDxU7Oo8DywNX/ZQXHliOo6qV+SLkz/uU2olTGItG7Ll30FSfvXv
        flbXamtsYHtwxqYFhX2UXa/PPA==
X-Google-Smtp-Source: ACHHUZ5yPI9iw9bNdmmjFwVoHRv6zajiSyc1ZjGqq5RJjyAHKX2ZJJJakrpg85W4Y3QW4VSEKw24eg==
X-Received: by 2002:a2e:93c3:0:b0:29c:783d:9241 with SMTP id p3-20020a2e93c3000000b0029c783d9241mr844169ljh.23.1683202530822;
        Thu, 04 May 2023 05:15:30 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id v3-20020a2e9f43000000b002a8d01905f7sm1861755ljk.101.2023.05.04.05.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 05:15:30 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu, jack@suze.cz
Cc:     adilger.kernel@dilger.ca, cmm@us.ibm.com,
        aneesh.kumar@linux.vnet.ibm.com, mathur@us.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joneslee@google.com, Tudor Ambarus <tudor.ambarus@linaro.org>,
        syzbot+fc51227e7100c9294894@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: [PATCH] ext4: Avoid a potential slab-out-of-bounds in ext4_group_desc_csum
Date:   Thu,  4 May 2023 12:15:25 +0000
Message-ID: <20230504121525.3275886-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When modifying the block device while it is mounted by the filesystem,
syzbot reported the following:

BUG: KASAN: slab-out-of-bounds in crc16+0x206/0x280 lib/crc16.c:58
Read of size 1 at addr ffff888075f5c0a8 by task syz-executor.2/15586

CPU: 1 PID: 15586 Comm: syz-executor.2 Not tainted 6.2.0-rc5-syzkaller-00205-gc96618275234 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:306
 print_report+0x107/0x1f0 mm/kasan/report.c:417
 kasan_report+0xcd/0x100 mm/kasan/report.c:517
 crc16+0x206/0x280 lib/crc16.c:58
 ext4_group_desc_csum+0x81b/0xb20 fs/ext4/super.c:3187
 ext4_group_desc_csum_set+0x195/0x230 fs/ext4/super.c:3210
 ext4_mb_clear_bb fs/ext4/mballoc.c:6027 [inline]
 ext4_free_blocks+0x191a/0x2810 fs/ext4/mballoc.c:6173
 ext4_remove_blocks fs/ext4/extents.c:2527 [inline]
 ext4_ext_rm_leaf fs/ext4/extents.c:2710 [inline]
 ext4_ext_remove_space+0x24ef/0x46a0 fs/ext4/extents.c:2958
 ext4_ext_truncate+0x177/0x220 fs/ext4/extents.c:4416
 ext4_truncate+0xa6a/0xea0 fs/ext4/inode.c:4342
 ext4_setattr+0x10c8/0x1930 fs/ext4/inode.c:5622
 notify_change+0xe50/0x1100 fs/attr.c:482
 do_truncate+0x200/0x2f0 fs/open.c:65
 handle_truncate fs/namei.c:3216 [inline]
 do_open fs/namei.c:3561 [inline]
 path_openat+0x272b/0x2dd0 fs/namei.c:3714
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1396
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f72f8a8c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f72f97e3168 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f72f8bac050 RCX: 00007f72f8a8c0c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000280
RBP: 00007f72f8ae7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd165348bf R14: 00007f72f97e3300 R15: 0000000000022000

Replace
	le16_to_cpu(sbi->s_es->s_desc_size)
with
	sbi->s_desc_size

It reduces ext4's compiled text size, and makes the code more efficient
(we remove an extra indirect reference and a potential byte
swap on big endian systems), and there is no downside. It also avoids the
potential KASAN / syzkaller failure, as a bonus.

Reported-by: syzbot+fc51227e7100c9294894@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=b85721b38583ecc6b5e72ff524c67302abbc30f3
Link: https://lore.kernel.org/all/000000000000ece18705f3b20934@google.com/
Fixes: 717d50e4971b ("Ext4: Uninitialized Block Groups")
Cc: stable@vger.kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 fs/ext4/super.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d39f386e9baf..e3d0d3c04785 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3238,11 +3238,9 @@ static __le16 ext4_group_desc_csum(struct super_block *sb, __u32 block_group,
 	crc = crc16(crc, (__u8 *)gdp, offset);
 	offset += sizeof(gdp->bg_checksum); /* skip checksum */
 	/* for checksum of struct ext4_group_desc do the rest...*/
-	if (ext4_has_feature_64bit(sb) &&
-	    offset < le16_to_cpu(sbi->s_es->s_desc_size))
+	if (ext4_has_feature_64bit(sb) && offset < sbi->s_desc_size)
 		crc = crc16(crc, (__u8 *)gdp + offset,
-			    le16_to_cpu(sbi->s_es->s_desc_size) -
-				offset);
+			    sbi->s_desc_size - offset);
 
 out:
 	return cpu_to_le16(crc);
-- 
2.40.1.495.gc816e09b53d-goog

