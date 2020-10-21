Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381B1294A53
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 11:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437572AbgJUJQW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 05:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437538AbgJUJQV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 05:16:21 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FAFC0613CF
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 02:16:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h2so890971pll.11
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 02:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7kggVtH7GurY0g+oTU6IbXHwke3vNpqmW+8LOm34gBE=;
        b=gx1qsd8sDJt5RTHl6zkqAQbbhY4SrLGzxtn8kYtue5wPARnR3t2XkHb7oSG3VOeDdA
         CswTzBaoqK3GOfA6umxhWo6oGveCOWNF0eyzXTFGELD80GzdnRJNAOFQCZuB10hFSgYD
         fx+vKKKu2KJ4EH1zjGnMIO4vSNZGYR6O7UBnboBR5j3+mqvo1rJJIl1FcESWZFbq6ukH
         634DuHa3sl/KrDb77O4F/IoooOVL9e9VGflBxxKf7RCvZzjOgebPd58pfsIeIcahbeHa
         gfV9NFMRnZMU0vw8E7RFDy4N4+AfSovbFAIayXMtXzE0ET5zZq/ABBo9+Jo1TLungU+U
         TNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7kggVtH7GurY0g+oTU6IbXHwke3vNpqmW+8LOm34gBE=;
        b=MgFSznKnbt9m8WYIQcE7v7PLePVEJ4wiJCv7CuBsKv0oI9N4+aprWP8pJqDyuvBgjG
         jP5VFvUdIQJGs8wRYALJ4tEYGeEKPGkkV8XtseEYJgyBAog2nQaXLI+qBLgPSc0EhZ+I
         /FdrypE1zDrlQAC9gvZKbpfB1bHWiNmj78qDsmuiONkBd2ESvo+o4dbkWa6GdRB9ZxJQ
         GKWS0SlxjDAUCTIH+J5bpGjXhoX4G3nHQZfXaGJjFQRorv3qN3CFx634tXNUanVmo3Ua
         gUcKxfJkBACAceruPVi17Sh1/fGy+18GLW/7UK7S/tCDYYQJdvkYWq5jZ/qmpHY7KK4X
         HbAw==
X-Gm-Message-State: AOAM533/+1ZLe0YAm63/f1CiAfZE4c3XdkfooMkM9XP1NfkwrZi5SpYU
        FqsSmY9DjtSwa1nifaQwWPQ=
X-Google-Smtp-Source: ABdhPJwppnAfEvyHJQ/6ufxfu2RiLbUdGwjUS/oZp5h0PUbSo8NfpQoAuiqBnGKFNPpQve03gOEWow==
X-Received: by 2002:a17:902:9a89:b029:d5:ad3c:cf53 with SMTP id w9-20020a1709029a89b02900d5ad3ccf53mr2528088plp.8.1603271781183;
        Wed, 21 Oct 2020 02:16:21 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id x16sm1573002pff.14.2020.10.21.02.16.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 02:16:20 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 8/8] ext4: fix a memory leak of ext4_free_data
Date:   Wed, 21 Oct 2020 17:15:28 +0800
Message-Id: <1603271728-7198-8-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
References: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
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
index 2b1bc6c..3af4903 100644
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

