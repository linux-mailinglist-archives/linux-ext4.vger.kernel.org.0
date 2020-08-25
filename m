Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBB5251BB9
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Aug 2020 17:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgHYPAh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Aug 2020 11:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgHYPA2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Aug 2020 11:00:28 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703B6C061574
        for <linux-ext4@vger.kernel.org>; Tue, 25 Aug 2020 08:00:27 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id q4so1706849eds.3
        for <linux-ext4@vger.kernel.org>; Tue, 25 Aug 2020 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EBvMikOTlgp4iHmq2ikAXfpylQFNImhiHDDTAi/6CgA=;
        b=r6U4Absd22DuKSqY5QKdrJsNL0Cqobha1iosRwta2QU51jGwuyHKrZMfZ4GB8VkCQK
         DRSE7UbkuV7Pw9R9Icv+wCMBIDGxfvlIq5o/7u3xzm5hWS2JS/RBtt6nNabf1r4TnBKe
         MNcV2pr7XvVreTNTLqxfHcr8OMBZxKw90yjxnquwyC+8mWR8yyW9tKauHi3UZOqoS3kY
         5F2CcreGSyJMjGND4lST42BnMVXmJUWwKLlKWmdFVXkcrI5CM8XCL7QdGB7Hc6wUh7Oz
         PS1LGkUVCruweYBurHOUXPVRsY2WikyRLXYiiiQAMd8A3FwUK2eZlujfs56vpi9cqrjt
         ZaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EBvMikOTlgp4iHmq2ikAXfpylQFNImhiHDDTAi/6CgA=;
        b=Cgs6kbGSEsk1+yPSpBUl2GsLRaMp+U0Ln7544puNJhx/7hRDLmb6fryAG9S6S0sdUN
         s4BZz8p0pnHJKp2FELYDk3HPsG27ufvnEQWQLUIsGglGgpPkU7GDx4Sapa7otA5ykRwE
         9A5fgRElRaE8hTjvWDAoeiSHI1ZMG5ZLlzdiTncxFQNhhxU5GGT+3oVXRDacgtm5kC8w
         3tZd2hPQvupGhMepQrDr5uDp44CHhR5cYHCgRE5xv6Ef/fBUBoyHTpCjki9DFHTnZ3Wx
         ISahbGkxw+ANf8CF/qkPhXpvl+4mbH8bP4O1ncLIhWw39DHCjnjcE4ybIsee8fghu6S1
         PJ/g==
X-Gm-Message-State: AOAM533Q6ocs8McDCUYbvbBYkYAG+TDDwpcY3ytKz259HdzikhzTSDhZ
        gzes8894TCkAXWIEWdepD8dLjA9tBBdunw==
X-Google-Smtp-Source: ABdhPJx/Tp3UIUwcuBtUTtpok9g/CZUHcORxTwbZGSrHElm1rkcxc6N6Xc6Smlf2GPOPFMHJ+0Apcw==
X-Received: by 2002:a50:ba8c:: with SMTP id x12mr10959282ede.319.1598367625754;
        Tue, 25 Aug 2020 08:00:25 -0700 (PDT)
Received: from ntb.petris.klfree.cz (snat2.klfree.cz. [81.201.48.25])
        by smtp.googlemail.com with ESMTPSA id ci27sm14454886ejc.23.2020.08.25.08.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 08:00:25 -0700 (PDT)
From:   Petr Malat <oss@malat.biz>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, tytso@mit.edu, Petr Malat <oss@malat.biz>
Subject: [PATCH] ext4: Do not interpret high bytes if 64bit feature is disabled
Date:   Tue, 25 Aug 2020 17:00:16 +0200
Message-Id: <20200825150016.3363-1-oss@malat.biz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fields s_free_blocks_count_hi, s_r_blocks_count_hi and s_blocks_count_hi
are not valid if EXT4_FEATURE_INCOMPAT_64BIT is not enabled and should be
treated as zeroes.

Signed-off-by: Petr Malat <oss@malat.biz>
---
 fs/ext4/ext4.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 523e00d7b392..eafb92fe7735 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3012,22 +3012,24 @@ static inline int ext4_has_group_desc_csum(struct super_block *sb)
 	return ext4_has_feature_gdt_csum(sb) || ext4_has_metadata_csum(sb);
 }
 
+#define ext4_read_incompat_64bit_val(es, name) \
+	(((es)->s_feature_incompat & cpu_to_le32(EXT4_FEATURE_INCOMPAT_64BIT) \
+		? (ext4_fsblk_t)le32_to_cpu(es->name##_hi) << 32 : 0) | \
+		le32_to_cpu(es->name##_lo))
+
 static inline ext4_fsblk_t ext4_blocks_count(struct ext4_super_block *es)
 {
-	return ((ext4_fsblk_t)le32_to_cpu(es->s_blocks_count_hi) << 32) |
-		le32_to_cpu(es->s_blocks_count_lo);
+	return ext4_read_incompat_64bit_val(es, s_blocks_count);
 }
 
 static inline ext4_fsblk_t ext4_r_blocks_count(struct ext4_super_block *es)
 {
-	return ((ext4_fsblk_t)le32_to_cpu(es->s_r_blocks_count_hi) << 32) |
-		le32_to_cpu(es->s_r_blocks_count_lo);
+	return ext4_read_incompat_64bit_val(es, s_r_blocks_count);
 }
 
 static inline ext4_fsblk_t ext4_free_blocks_count(struct ext4_super_block *es)
 {
-	return ((ext4_fsblk_t)le32_to_cpu(es->s_free_blocks_count_hi) << 32) |
-		le32_to_cpu(es->s_free_blocks_count_lo);
+	return ext4_read_incompat_64bit_val(es, s_free_blocks_count);
 }
 
 static inline void ext4_blocks_count_set(struct ext4_super_block *es,
-- 
2.20.1

