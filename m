Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6EB36AF4
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2019 06:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfFFEcl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Jun 2019 00:32:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39087 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfFFEcl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Jun 2019 00:32:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id g9so387144plm.6
        for <linux-ext4@vger.kernel.org>; Wed, 05 Jun 2019 21:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6VGeFWDwZ/nZmDtAUAKo1D8i/FDQgyo2Ba2O/wBzjF8=;
        b=XIqpRJ38g3lY6ATanmo95XAYJKxovAq5CH66gOtB0rYT0U7z6KgGh/38sTqKpnU/Bp
         4uoxHUyJqBlIaYlW8R7TJBqBaPS7qch47kqasFqQPwe/oIgpivoqjjUUkhcvflWAbgxB
         IMHLQjyki/MCwv1iLZQlTcmozof8oH+w1I0GaE3ZCzibbZaPxkN4b3zTeB1GPExfzVch
         730LDgaMIqQ1bYCL+xIp4mARX9FpaavGiwKiQsASB1fcQ6CGvcAiTcoglvOMz+gxHoIT
         z0GpNxVZM70zLZeRdzGxRUm1g57HSSAewXp/3y2MA4CBvfcrVrIx6f41W2jqO14dtw4Q
         DMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6VGeFWDwZ/nZmDtAUAKo1D8i/FDQgyo2Ba2O/wBzjF8=;
        b=poLGh8ne/CQypsot3559KVJC0nM+3ayna2/cHOjH9TkIYAI2wXILceWs5HIChhpLOk
         O0pMzs3i/Frqs4OI1mVQ21bbc3RowOQIL08L11uBNHKtbrDRhnZGG2k6vEcVdG1sG65g
         3x2KT8+4rRT99zwqfuCuUu3Roa61kpWw359zZJnaTvLEJ8RVOkenO26RAuOYtEsymnhN
         XMy3qUgA9E4OlU5hCua60jmcoa6vc1rnPHOI1yZaKVc0DTnRg1Syt9+//gVpqLXekppu
         Zc+Tyw6pU4xD83Ps/gxUrMvA3xh5xntTZ3z8p3EX+y4MZMC5wRrsRYgOs9dbN3RCz7rV
         nL9w==
X-Gm-Message-State: APjAAAXDfhvGp3TcSf6cnMGV1bguTHhpFZla0gAS0u8zNtIdBJU5v99z
        1pALBu+9SdJMRgWbABCmAx7tD4cs
X-Google-Smtp-Source: APXvYqxbVFMLvRzVYn5guvYTtAttm+xzbz12k64+4uGw3RSkgkrdcX5j8BI+r7Xdkpc/xIqkAuegLA==
X-Received: by 2002:a17:902:7891:: with SMTP id q17mr49226674pll.236.1559795560603;
        Wed, 05 Jun 2019 21:32:40 -0700 (PDT)
Received: from localhost.localdomain (fs276ec80e.tkyc203.ap.nuro.jp. [39.110.200.14])
        by smtp.gmail.com with ESMTPSA id f17sm445069pgv.16.2019.06.05.21.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 21:32:39 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
X-Google-Original-From: Wang Shilong <wshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc:     Wang Shilong <wshilong@ddn.com>, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 2/2] f2fs: only set project inherit bit for directory
Date:   Thu,  6 Jun 2019 13:32:25 +0900
Message-Id: <1559795545-17290-2-git-send-email-wshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

It doesn't make any sense to have project inherit bits
for regular files, even though this won't cause any
problem, but it is better fix this.

Cc: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 fs/f2fs/f2fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 06b89a9862ab..f02ebecb68ea 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2370,7 +2370,8 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 			   F2FS_PROJINHERIT_FL)
 
 /* Flags that are appropriate for regular files (all but dir-specific ones). */
-#define F2FS_REG_FLMASK		(~(F2FS_DIRSYNC_FL | F2FS_TOPDIR_FL))
+#define F2FS_REG_FLMASK 	(~(F2FS_DIRSYNC_FL | F2FS_TOPDIR_FL |\
+				   F2FS_PROJINHERIT_FL))
 
 /* Flags that are appropriate for non-directories/regular files. */
 #define F2FS_OTHER_FLMASK	(F2FS_NODUMP_FL | F2FS_NOATIME_FL)
-- 
2.21.0

