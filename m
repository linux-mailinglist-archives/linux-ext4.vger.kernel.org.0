Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B391748437B
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jan 2022 15:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbiADOfj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jan 2022 09:35:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232904AbiADOfj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jan 2022 09:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641306938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qgoPVvQwRCznwAZYtDkT2kb0LDzcHerpueatFHJSzf0=;
        b=T8b9Y1wMRWVZhzWVQ9W4DxUqhXFRplmq1tpXS58hfaLf2Z4jwMa53J11/AUgQg4GU+DI6m
        6ZluJe4+raa2Zew6XK6vJuMa/XpvmytvQAVPxp++cefYvCzXG/5Jzy4hWPVWtdV0jCk0Hq
        x5lEJyz1FY5dW/pKaA9rjMqj1VNaofQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-O3IxDXJbOmGNmTA6KhcNkQ-1; Tue, 04 Jan 2022 09:35:37 -0500
X-MC-Unique: O3IxDXJbOmGNmTA6KhcNkQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6514D1926DA4;
        Tue,  4 Jan 2022 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FD1A1079F55;
        Tue,  4 Jan 2022 14:35:35 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] ext4: don't use kfree() on rcu protected pointer sbi->s_qf_names
Date:   Tue,  4 Jan 2022 15:35:17 +0100
Message-Id: <20220104143518.134465-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

During ext4 mount api rework the commit e6e268cb6822 ("ext4: move quota
configuration out of handle_mount_opt()") introduced a bug where we
would kfree(sbi->s_qf_names[i]) before assigning the new quota name in
ext4_apply_quota_options().

This is wrong because we're using kfree() on rcu prointer that could be
simultaneously accessed from ext4_show_quota_options() during remount.
Fix it by using rcu_replace_pointer() to replace the old qname with the
new one and then kfree_rcu() the old quota name.

Also use get_qf_name() instead of sbi->s_qf_names in strcmp() to silence
the sparse warning.

Fixes: e6e268cb6822 ("ext4: move quota configuration out of handle_mount_opt()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b72d989b77fb..acb0c58cd3d1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2633,8 +2633,10 @@ static void ext4_apply_quota_options(struct fs_context *fc,
 
 			qname = ctx->s_qf_names[i]; /* May be NULL */
 			ctx->s_qf_names[i] = NULL;
-			kfree(sbi->s_qf_names[i]);
-			rcu_assign_pointer(sbi->s_qf_names[i], qname);
+			qname = rcu_replace_pointer(sbi->s_qf_names[i], qname,
+						lockdep_is_held(&sb->s_umount));
+			if (qname)
+				kfree_rcu(qname);
 			set_opt(sb, QUOTA);
 		}
 	}
@@ -2688,7 +2690,7 @@ static int ext4_check_quota_consistency(struct fs_context *fc,
 				goto err_jquota_change;
 
 			if (sbi->s_qf_names[i] && ctx->s_qf_names[i] &&
-			    strcmp(sbi->s_qf_names[i],
+			    strcmp(get_qf_name(sb, sbi, i),
 				   ctx->s_qf_names[i]) != 0)
 				goto err_jquota_specified;
 		}
-- 
2.31.1

