Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098D521A817
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jul 2020 21:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgGITsV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jul 2020 15:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGITsG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Jul 2020 15:48:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D36C08E6DC
        for <linux-ext4@vger.kernel.org>; Thu,  9 Jul 2020 12:48:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 205so4067729yby.19
        for <linux-ext4@vger.kernel.org>; Thu, 09 Jul 2020 12:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8aV8dCnXtWjQg88XS3xPlXLAc+zOek3bqtseJMfDQ8w=;
        b=n/RhV/jx+TfIUyZEOgxV3/59HC7DmDgP2fFHs9KJ6uT8Y/c9BmryDZ6OS48cFc2fqs
         TiR7FFxJ/P7YhcosGFO3tylYEdj+BoEQmRBg8FEQMEky9Rm7jtA+5D0rcALnSVHwXnfK
         nBDNqzuk3M3zwBj8YcFMlB0fUuQEI44285Bw8Uli43Zzasc8aEe8NzunSZGzlBeidW4X
         NocTmLAWIDEIUWqIvRzXdCKx/WROIfOofognfNWydIrK2Ct5JqacT5pfx7r7bw4OgLki
         X2JyldU8RVZfG4NyWJ1tkoQXa1aq8I7zauOqoi5d9wG5qRRu3YK/sO6rc5yYIJFmtmCv
         48lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8aV8dCnXtWjQg88XS3xPlXLAc+zOek3bqtseJMfDQ8w=;
        b=CXxhTueQptH5ot9fxNK8QxHxmbGnSAioSud8WdCZeq/zNquHAW8dTf/UtI3tgFOaKt
         F5No5L5Cofo1qIMM8eDOd17vfEsL5a0PPnu9LjoRBiSq1PClnL1oh2EH1E4mIK+T8vL2
         o9upvG95uMEM9lT2qb7GIk12D4/zHxOhT6/m+KodjxpjiPwUEmUT+A4fUOoWsb6ZkxK1
         Jb2dpgfXnQgfl0HPS7UlphcS5RdLVxF5FZ90L3YoJSKJ/S862lEAjcigwGJIMoOepSNq
         jy8vsEKy4apcBZx2mc64lVRtQDK41g2dlc9mEtegNIb5CyDGbyg2B9PrqYGE5u49WaXx
         PaUA==
X-Gm-Message-State: AOAM5312Qrn8bDoTawXF0xfhg4ahit6vdk58U6mDX7qdna9t2miF7BWb
        zMf+vLg6yXb3Bu0gd9VFf1jvW+d7Wk4=
X-Google-Smtp-Source: ABdhPJzr4fyHtEPxxGa/1oyxhYhm2fG5/oqmJ5MeTeSHxI205PX0i6Oqf4DnZTvfIEvI68X3kJYfz/lkbU0=
X-Received: by 2002:a5b:2cd:: with SMTP id h13mr57148875ybp.319.1594324084188;
 Thu, 09 Jul 2020 12:48:04 -0700 (PDT)
Date:   Thu,  9 Jul 2020 19:47:51 +0000
In-Reply-To: <20200709194751.2579207-1-satyat@google.com>
Message-Id: <20200709194751.2579207-6-satyat@google.com>
Mime-Version: 1.0
References: <20200709194751.2579207-1-satyat@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH 5/5] f2fs: support direct I/O with fscrypt using blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Wire up f2fs with fscrypt direct I/O support.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/f2fs/f2fs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b35a50f4953c..6d662a37b445 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4082,7 +4082,9 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int rw = iov_iter_rw(iter);
 
-	if (f2fs_post_read_required(inode))
+	if (!fscrypt_dio_supported(iocb, iter))
+		return true;
+	if (fsverity_active(inode))
 		return true;
 	if (f2fs_is_multi_device(sbi))
 		return true;
-- 
2.27.0.383.g050319c2ae-goog

