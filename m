Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C04548437C
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jan 2022 15:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiADOfm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jan 2022 09:35:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232904AbiADOfm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jan 2022 09:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641306941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+cgnYXVRUKQuCNAy4T73MbSPFMnpz7dib4MTmNOnabc=;
        b=CflNk01/8AlAzBvXB3wbhk4W6e15Nd7D9oVNd//sRWfz5q/lx+v0dKEUzs1PLRkS5nnmk9
        ItU/7MGur/iElG1ZFuHXCvtNWJsljVi90GjPiGLN6S71PPC6ObMyYKqSNkvb+/qhpLK0MJ
        aIAx329kFw9d5bEh9l9W2bFTd8O6qEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-UcxLpjgWMm2nGtaxhhbRtw-1; Tue, 04 Jan 2022 09:35:38 -0500
X-MC-Unique: UcxLpjgWMm2nGtaxhhbRtw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D3E710144EF;
        Tue,  4 Jan 2022 14:35:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7FA51079F55;
        Tue,  4 Jan 2022 14:35:36 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: [PATCH 2/2] ext4: only set EXT4_MOUNT_QUOTA when journalled quota file is specified
Date:   Tue,  4 Jan 2022 15:35:18 +0100
Message-Id: <20220104143518.134465-2-lczerner@redhat.com>
In-Reply-To: <20220104143518.134465-1-lczerner@redhat.com>
References: <20220104143518.134465-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Only set EXT4_MOUNT_QUOTA when journalled quota file is specified,
otherwise simply disabling specific quota type (usrjquota=) will also
set the EXT4_MOUNT_QUOTA super block option.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Fixes: e6e268cb6822 ("ext4: move quota configuration out of handle_mount_opt()")
---
 fs/ext4/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index acb0c58cd3d1..52e0be447b9f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2632,12 +2632,13 @@ static void ext4_apply_quota_options(struct fs_context *fc,
 				continue;
 
 			qname = ctx->s_qf_names[i]; /* May be NULL */
+			if (qname)
+				set_opt(sb, QUOTA);
 			ctx->s_qf_names[i] = NULL;
 			qname = rcu_replace_pointer(sbi->s_qf_names[i], qname,
 						lockdep_is_held(&sb->s_umount));
 			if (qname)
 				kfree_rcu(qname);
-			set_opt(sb, QUOTA);
 		}
 	}
 
-- 
2.31.1

