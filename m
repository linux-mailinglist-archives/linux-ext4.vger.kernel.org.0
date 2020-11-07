Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3AA2AA680
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Nov 2020 16:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgKGP6w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Nov 2020 10:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbgKGP6v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Nov 2020 10:58:51 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2688C0613CF
        for <linux-ext4@vger.kernel.org>; Sat,  7 Nov 2020 07:58:51 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id t22so2392526plr.9
        for <linux-ext4@vger.kernel.org>; Sat, 07 Nov 2020 07:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EuMKHOGVtCHy/SsM/4YamOXvYmvC13aMqqVm5IpN+b4=;
        b=lrnIhRNDAjvq3fh6Oe0E9VSQIpU4pyVKGoImQeOwEEPfVkCIx3h0ZiXN9OVQlBgZZ9
         wwVtji9ErejmcKxwZFvBQz2N5BnIHNeN2+UgGuOjbtoZTxtl/tBNvxoIUfGHndJX0U/n
         qhpiTsuzHCWwaNj9aKc3z36cbFjgRz63sSSIRg/N5JUFlyMtW21xP7r/X9rXyzFK6/lw
         2M4kH2Oxw38hug4DjiU+g3nYiYUu4hFZ+ZCQ3zNFDI+HY5cXdoykyNP5YDDB9vRtRzUS
         P7TYnM21kBVShfqD8EURnKbE8gPshKi2BPd5qUflecCs9PsCwrbN5+7RyvXTQq8onzth
         1jVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EuMKHOGVtCHy/SsM/4YamOXvYmvC13aMqqVm5IpN+b4=;
        b=MsTVL0c6anwWKTzfjo0Knw4SkRHdWpbyZB+Oi8Gz8juhm52phN/LdGDsH+YdDfg+A5
         s4MMgby8CT6jb9hbZwayHRyO+OuXxbxg5ZGMJU7AVEbXkluAvzNhIm73AvhppwJZlTu2
         igt5/bDanCYnlTi3NCKJtWyF5DO+lMDuB98O6HOhSnHpYkqXe3C6vWYdMzuFOxmH1B7D
         5qYUxUQyFhcvYpFX5mPHYu9EPZom3e1CaIrovtZ3+QJ/D0vrdz/eEjzZoLscrWnYbsDI
         Hq3ipdb3lMXLFgLOJRp5SmpMiPZ+GOlHp1bIGg2UL5PA3FsYYGL2QRvhxhE0cQZIoc6h
         ixTw==
X-Gm-Message-State: AOAM530+RBBBkDKOiIpZ+o8ihwKVvVsaN4qOaxsxESWgI0qyZFfpNw2w
        8K4sSK+6fSwNj9uHp2S2tUQ=
X-Google-Smtp-Source: ABdhPJykmxjfApXbvpqDIYJcuBYdCvI4JaA5zYAngMsSpOeUlclEp8+Bj3suoZ+b9FJbERRxv4Hp2A==
X-Received: by 2002:a17:902:b7c4:b029:d6:855a:df2c with SMTP id v4-20020a170902b7c4b02900d6855adf2cmr5974971plz.26.1604764731245;
        Sat, 07 Nov 2020 07:58:51 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id e81sm6049956pfh.104.2020.11.07.07.58.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 07:58:50 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH RESEND 8/8] ext4: fix a memory leak of ext4_free_data
Date:   Sat,  7 Nov 2020 23:58:18 +0800
Message-Id: <1604764698-4269-8-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
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
index d8704fe..03b4522 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5146,6 +5146,7 @@ int ext4_metadata_block_overlaps(struct super_block *sb,
 				ext4_group_first_block_no(sb, group) +
 				EXT4_C2B(sbi, cluster),
 				"Block already on to-be-freed list");
+			kmem_cache_free(ext4_free_data_cachep, new_entry);
 			return 0;
 		}
 	}
-- 
1.8.3.1

