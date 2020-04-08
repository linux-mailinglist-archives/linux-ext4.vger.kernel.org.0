Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F121A1EFE
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgDHKqR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36462 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgDHKqR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2so2379563plo.3
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZyNjlIWNHpE31ut2Vmi9YHAxUycDDQCE45FYLqLhvWI=;
        b=sCS64mnDEvuSFJjuUIBr1uxJ733903AnE32HVF3Ot2omgSwiqMidPAieYVjs0G9doL
         Ph5X9jc/1jR4Z6+pQsmO57SCwe9XYnTMEGinFJ9N6FEsVCRVn1Hzzv3E2/0M3ABOypGO
         7s8taaMIVbuLfUMRMNnujIYrLOoFh+YlUuTn4P/HgmVvpyl5C/T+cYe8yF0gnmatibIr
         hXNe4NkWxgyy4Asc2A23OCgbzdyIO/FGbmngS/W8MfpADxWTYsgtYpbnHL96fW0axDPS
         G67C6xrd73kQxRmPSxxkRGlvq1rjBVPOfoc5fyk0UBQBFqdHj/WtOYS6ABcyD/vYN3V7
         8FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZyNjlIWNHpE31ut2Vmi9YHAxUycDDQCE45FYLqLhvWI=;
        b=C7zlL/AUSwT4TgRl1kzkxOeE8GYZZh2f9/H9ccgAPVtBRwcqAT7M+9sCJfiw0CH2q6
         CTdRsI7bQSB3VpXpU/ylijGUcADQaoArDn0N7zE2fpjbB8vt09iteiLbMPkvaQtY535U
         bsRQa9Mx9JBNItNUW5Em+t+IKKraWaGf01vRqBhkIvON5HJ2kKjuNmCRLIkgPVcHTpsO
         iCFv4DDK/Ohg11fVVEYA69Pk2O0OnOdWgYvyIG/FVmQjZck4NOj1Mz++AVYC37wYpAoD
         pxzzeQ8yZGRBdOcY14XhbEEuqP8e+RVAVre6ezDiHhXOKWIUA5l/31YeGfs0n3x9NwRy
         cNWQ==
X-Gm-Message-State: AGi0PuYnn/xPa/oqvFZusK//svrkSxXMguJC8VmtBcx9huabWSe+BjYd
        jIG0R1RVERCFFny/UcPu63nOQT42Oxg=
X-Google-Smtp-Source: APiQypLRfOAdJEvbP298f1A+j4Oq8D//e+pkm0dnXmVqEInKiekU0keJwoby/ueqo+YhSI3P8UboXg==
X-Received: by 2002:a17:90a:a40d:: with SMTP id y13mr4560676pjp.82.1586342775873;
        Wed, 08 Apr 2020 03:46:15 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:15 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 20/46] e2fsck: rbtree bitmap for dir
Date:   Wed,  8 Apr 2020 19:44:48 +0900
Message-Id: <1586342714-12536-21-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
index ccba4427..78384e20 100644
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
2.25.2

