Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FDD65B3A4
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Jan 2023 15:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjABO7o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Jan 2023 09:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbjABO7n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Jan 2023 09:59:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC5A63F9
        for <linux-ext4@vger.kernel.org>; Mon,  2 Jan 2023 06:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672671538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FH/Lp9MlKLCKaZbT73kzq05x4X87GgNm5ap75FWZ5H4=;
        b=FVpgLhlSJkKdJ1Gvo4o2uj33PiBkFDYYxJx1F4xXM7IRAoQACJbkwDhNft7OI/4HBlZLH0
        9mqw0GxhHeqqSKvMMVnPdbJFfJUmV249DADFI29Uf1rfEW21La6n177E5IyFVIRZIwRWNG
        w0+UCB6ZLXHtvOHTaCPqTTyyCNNb5o4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-304-Ff5MF5j2PnmoEnO-GsC9Bw-1; Mon, 02 Jan 2023 09:58:57 -0500
X-MC-Unique: Ff5MF5j2PnmoEnO-GsC9Bw-1
Received: by mail-pj1-f69.google.com with SMTP id om10-20020a17090b3a8a00b002265d44b776so2584047pjb.1
        for <linux-ext4@vger.kernel.org>; Mon, 02 Jan 2023 06:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FH/Lp9MlKLCKaZbT73kzq05x4X87GgNm5ap75FWZ5H4=;
        b=P2cdw6+FCh3swIktJtDVGCjwMq4TEVFaUtzshJbTVUS/7q7XHBSlzXTGCuhjT55fMJ
         UQSj4QsJi+qT06imDEh2e3R/BpAmqseomsCFWICPGST+Ry7HBOKuZyRhkBZgLnjZzJ4u
         qsZ/IKg18695u9q8mtmJXasDJcG5fp53X6Ymz1hdvzK/Lkp+L8dQUd0QrRdSs2EGDSz5
         6Sa0ICYJ6Ijt26vH9ilrVWrzAHAuAV+8Es5643Ke/eb35niBmHn8BB6AS5hrLnHjwsXT
         DSD7MgmcgtdGLTraGywviJqzsLko+qk+3SDDU5iVos+i475E9E7rFiPK22vv+y/3s9J6
         KhXA==
X-Gm-Message-State: AFqh2krvBICwDiAZ9e6fxGi/x8kGTUjkuBaysFXH4JZJl/TE/Wj04b4c
        1JEjBZ8p0br3kSFgpglcVmmQaTIY+HfMR2Hx6gWnu0hLlY3YNFqd27Wl6YCjSZw+tftNP8r2RtW
        R8aJPYxxcB4F0kOy2LDz4ow==
X-Received: by 2002:aa7:90d9:0:b0:580:df2d:47c4 with SMTP id k25-20020aa790d9000000b00580df2d47c4mr32414668pfk.19.1672671536545;
        Mon, 02 Jan 2023 06:58:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu/jU0eyfX/7zCrMxSUEB4WmKwgUUKrVBc8mnkQozOF8ZixobVxmpjajys62AXlefjhUtgIVA==
X-Received: by 2002:aa7:90d9:0:b0:580:df2d:47c4 with SMTP id k25-20020aa790d9000000b00580df2d47c4mr32414652pfk.19.1672671536244;
        Mon, 02 Jan 2023 06:58:56 -0800 (PST)
Received: from localhost.localdomain ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id w18-20020aa79a12000000b00581816425f3sm10503683pfj.112.2023.01.02.06.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 06:58:55 -0800 (PST)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
Subject: [PATCH] ext4: Verify extent header in ext4_find_extent()
Date:   Mon,  2 Jan 2023 14:58:33 +0000
Message-Id: <20230102145833.2758-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot reported use-after-free in ext4_find_extent() [1].  If there is
a corrupted file system, this can cause invalid memory access.

This patch fixes the issue by verifying extent header.

Reported-by: syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=cd95cb722bfa1234ac4c78345c8953ee2e7170d0 [1]
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 fs/ext4/extents.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9de1c9d1a13d..79bfa583ab1d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -901,6 +901,9 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 		ret = -EFSCORRUPTED;
 		goto err;
 	}
+	ret = ext4_ext_check(inode, eh, depth, 0);
+	if (ret)
+		goto err;
 
 	if (path) {
 		ext4_ext_drop_refs(path);
-- 
2.38.1

