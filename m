Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E21E1FF6B8
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbgFRP3H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731531AbgFRP3E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12331C0613ED
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 64so2925285pfv.11
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pj3QnV1F9sep4avLnVMWVNXOW1kFyUq+/zRTjNJYlyI=;
        b=Ng8suadeZ0Uja+8pfDVundngIPULO/tnKSqI45SqAbX3BdJSREwHnH1VG30sqEaOWw
         8FnXJruUMvTPlvE1F1gQt7xq36B+N7q9CT/qvyxRgc2V2oP2k+D6eMDNauImtNSDZKId
         IDyGZHLKiNuJIGkybrYHpzGh21WZXfLIc6g3Mw/jSZoe8nkFTT21jCHBzZyYjrvkpvZC
         UQmNOY+0L0CbrACxc3yQp5DpiAkKau09n3H5t1KqVnKUnc+7mabrE5QPgOPeJUldteg+
         H6U9aCSrVf/ucGD+NqD/QQfHIwzNhqakr5/uDZDxFWFdEe/1qZyDXi9o/ks4P38xyLbQ
         E/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pj3QnV1F9sep4avLnVMWVNXOW1kFyUq+/zRTjNJYlyI=;
        b=LTx6OQQnrrxvb++u/HFuFlHtYMroWCnnLhKk6QEuyfyWCY6BS5SQN0e+R9eeouZqVx
         9qeZrlKnS4RJ+33I17FpSizHI7X+t1eMRENh+uAF13TRgAScR7JVCO1GIbu5OBrNedFx
         ckljtY2fwsluK3XPOUCOzJ/A/MZn8QSmqdhUz3sa9CXSm2CPKvEZTd5F7xaRqy2yGVdq
         ubnVkyQ685lcRNAUJQRVrgsZfX3Oz1srecZ7pT4XK73nAesAanUb20be4BaEfZutfqw+
         cDToA4lv15UXIC80ldDKChVO0ozl5k1uR5coAnf1HMwZuldejmnJikHt0J+WfmLSw07G
         ZvHQ==
X-Gm-Message-State: AOAM532CjtB05zJQigLwlebrAzNPd/zhhR2fHF56S7LAwSNROdAZE6+0
        BPn0pw6k/CIilLCEZRyHzvr8oJSdLn8=
X-Google-Smtp-Source: ABdhPJxU6L3Vbxwj2Om4ZVvod9sO+FacwuK8nJJ/JqPlBnLINxghECmqUUHJgNSgMp9jBuozlzLQ1w==
X-Received: by 2002:a63:f502:: with SMTP id w2mr3699768pgh.321.1592494143166;
        Thu, 18 Jun 2020 08:29:03 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:02 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 21/51] e2fsck: rbtree bitmap for dir
Date:   Fri, 19 Jun 2020 00:27:24 +0900
Message-Id: <1592494074-28991-22-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

Only rbtree supports merge, so use it for all bitmaps.

Change-Id: I863687ce275f9c891cd2d18c115cb75c6e24f4e4
Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 lib/ext2fs/gen_bitmap64.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index 2617ac22..7bae443f 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -86,7 +86,6 @@ static void warn_bitmap(ext2fs_generic_bitmap_64 bitmap,
 #define INC_STAT(map, name) ;;
 #endif
 
-
 errcode_t ext2fs_alloc_generic_bmap(ext2_filsys fs, errcode_t magic,
 				    int type, __u64 start, __u64 end,
 				    __u64 real_end,
@@ -109,11 +108,7 @@ errcode_t ext2fs_alloc_generic_bmap(ext2_filsys fs, errcode_t magic,
 		ops = &ext2fs_blkmap64_rbtree;
 		break;
 	case EXT2FS_BMAP64_AUTODIR:
-		retval = ext2fs_get_num_dirs(fs, &num_dirs);
-		if (retval || num_dirs > (fs->super->s_inodes_count / 320))
-			ops = &ext2fs_blkmap64_bitarray;
-		else
-			ops = &ext2fs_blkmap64_rbtree;
+		ops = &ext2fs_blkmap64_rbtree;
 		break;
 	default:
 		return EINVAL;
-- 
2.25.4

