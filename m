Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95284292436
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Oct 2020 11:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgJSJCw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 05:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbgJSJCv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Oct 2020 05:02:51 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CB0C0613CE
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:02:51 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t4so2030303plq.13
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OedUPmF7/A4PIBRmhVl3v8GbYgX7GmC+T8sMcHl04l0=;
        b=X2GfLteBc2yW6kKSEefBI0P5mI1AuWSF7ZAig1pLESq6gMVVCtF2btl3koWjSGrqg2
         mwCdBmKdJ4OwVGyOo748QwagCg6UMhKPhWI8FtB+N7eMl6x8O+uIJlOH6kB9H9nParap
         NF+Aayfk6o+9UyBUTO86t5aanqvlkn2Mm0HkzXPPYaBkM9Jpyc2GrmCIdTleiGPtFVsi
         Iwa6zN3tHsOHS+8BbxJLSHUcTKxavP6EtqRRNRA3hit+PB61dKST/wQqbrTWo090xd1i
         jlG+8iPWnyiJ68TYnpIFwuAUai0iQQ5t+lGY39Hwsv03GEovZqvL22NzO5ziTS4ovwe7
         pR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OedUPmF7/A4PIBRmhVl3v8GbYgX7GmC+T8sMcHl04l0=;
        b=e/qI1HJ6+R67ZkeWY+BQG+Efm/H+e8ujC6U1afeOqcdMXsUHTY21cg74ZQ3XueqWqU
         2t4uchnU6gJq+8yogacJU0NBCuvbRGWUE0C3OY2T88pmTKkx7y7ClV1UMS/xC60ca9N6
         poaJ8+G6vQBB4pU3nPMK/fnZzhpJ7Tu/rDbrZgaDOHPCPBRXv1Dq0n7nm2BjQQYkm/16
         0x/FDuPhOIf/YsxEKg9nz0LhnIZFPs+MSro/JhZUThc2ZCMKXzJD6FLzeewpHrSLm3rQ
         hyqYaXuDWWVls5LGIAJfr90vwh6lvDWll7nb+dMCHNo/6UCruTMO2h/A51yn3oVQ5eSn
         dieg==
X-Gm-Message-State: AOAM530jM+Y/Y/cI6H9N/gfP8+iSGp8G3t7wWQTST1DRXQVIs/L4RNeR
        ++Y/lWptRPPHyEwMaFgUxsM=
X-Google-Smtp-Source: ABdhPJxnXGFhPHWLCuZU+MqsKSCLTOCB4Zji/rmD+RxkXQM1qP+jPlmLzKpkpEXKTUzUzyTg9zXx4g==
X-Received: by 2002:a17:902:9b89:b029:d2:42a6:88f with SMTP id y9-20020a1709029b89b02900d242a6088fmr16123575plp.71.1603098171568;
        Mon, 19 Oct 2020 02:02:51 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id 14sm11422880pjn.48.2020.10.19.02.02.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 02:02:51 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH v2 8/8] ext4: fix a memory leak of ext4_free_data
Date:   Mon, 19 Oct 2020 17:02:38 +0800
Message-Id: <1603098158-30406-8-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
References: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

When freeing metadata, we will create an ext4_free_data and
insert it into the pending free list. After the current
transaction is committed, the object will be freed.

ext4_mb_free_metadata() will check whether the area to be
freed overlaps with the pending free list. If true, return
directly. At this time, ext4_free_data is leaked. Fortunately,
the probability of this problem is relatively small, maybe we
should fix this problem.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e0a4265..aa6732a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5015,6 +5015,7 @@ static void ext4_try_merge_freed_extent(struct ext4_sb_info *sbi,
 				ext4_group_first_block_no(sb, group) +
 				EXT4_C2B(sbi, cluster),
 				"Block already on to-be-freed list");
+			kmem_cache_free(ext4_free_data_cachep, new_entry);
 			return 0;
 		}
 	}
-- 
1.8.3.1

