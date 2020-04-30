Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7E21BF7A3
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Apr 2020 14:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgD3MAS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Apr 2020 08:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727073AbgD3MAQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 30 Apr 2020 08:00:16 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD0AC08E859
        for <linux-ext4@vger.kernel.org>; Thu, 30 Apr 2020 05:00:16 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d15so6176736qkl.10
        for <linux-ext4@vger.kernel.org>; Thu, 30 Apr 2020 05:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dcBMNhJyVF3JG7u2k+hpIfX5J5/+YNOMhft7o2B+Ju4=;
        b=WVjua0boMZFfyXRxNHxXtkkQlvtsd9hMr76JSeSRnGAS4i4rb0v5hyP/xpU/t08yAU
         8iFqQJRhyAkwJFM1oK1XZBTqXHm3CqsdLruIVMn/pVnKPy3fC4DShhJRinGldvR/S/PE
         BRJ35yKgDNYU78xLeadViChpObrcGpoomH0GOf1yWskNC6xGjTXCQ70zRp3w8mJsEov1
         wnopsVuB0htL7AZ3eqUvciTbLOa1LCZTKOiayOWzgpDf/NefzgdtHrk8kZ6h2I0f2Ln0
         gH8rvRj4IA4NAJmjknAgox3uK+dYnH04ADDO1Fq1XchcZcytltv69jWbnlNIl/trv1Tn
         lHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dcBMNhJyVF3JG7u2k+hpIfX5J5/+YNOMhft7o2B+Ju4=;
        b=kxCLctay15WoX+CuQGaK4S2jQVyLG+kgRf26DIcIMooS5m5gct9IeEaSqX6nRP5/EK
         lzS/bKVXvb6NmFRCTzHBipyW9BJuh9Qe4Fjn87M8vfoZOtGJ8g6WE5kUvLmRgfqRo2Ya
         o0RWIV28IhZAGjw0CrvkgMviepi1uE1G0sck0orvNz38GJvaMH5Un9L9qW/h3pGvLmUY
         e3rW3uaVPewYnt6um0xnYUadBTOF+6TIYGzyhcJKZPeOTtJ7wtYKl6uHhuWZ+9OWhN9Q
         ZS9+p864AeV/EXJfX1wMd7uP0pECGbfqua00IJvYXuHbrcoBEZWXe9FXTyZJgdo+BjeM
         /XbQ==
X-Gm-Message-State: AGi0Puai4zINzgm7pI1Smj7cQihYzzKajTMLP6/k7TkEtOnvcbU+ZheH
        v8MFoScJdmHYRequV+gydcmcKJuKL3U=
X-Google-Smtp-Source: APiQypIqTjtVoRaD2OhqjnO9XpfMgccnF/80vIjLwCBdsxgR6aNsuU+7iyNxHrHcnYjkH2WPjyT1Rf+7CFc=
X-Received: by 2002:a05:6214:1804:: with SMTP id o4mr2636288qvw.10.1588248015930;
 Thu, 30 Apr 2020 05:00:15 -0700 (PDT)
Date:   Thu, 30 Apr 2020 11:59:56 +0000
In-Reply-To: <20200430115959.238073-1-satyat@google.com>
Message-Id: <20200430115959.238073-10-satyat@google.com>
Mime-Version: 1.0
References: <20200430115959.238073-1-satyat@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v12 09/12] fs: introduce SB_INLINECRYPT
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Introduce SB_INLINECRYPT, which is set by filesystems that wish to use
blk-crypto for file content en/decryption. This flag maps to the
'-o inlinecrypt' mount option which multiple filesystems will implement,
and code in fs/crypto/ needs to be able to check for this mount option
in a filesystem-independent way.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/proc_namespace.c | 1 +
 include/linux/fs.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 273ee82d8aa97..8bf195d3bda69 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
 		{ SB_DIRSYNC, ",dirsync" },
 		{ SB_MANDLOCK, ",mand" },
 		{ SB_LAZYTIME, ",lazytime" },
+		{ SB_INLINECRYPT, ",inlinecrypt" },
 		{ 0, NULL }
 	};
 	const struct proc_fs_info *fs_infop;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f6f59b4f22a8..38fc6c8d4f45b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1376,6 +1376,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NODIRATIME	2048	/* Do not update directory access times */
 #define SB_SILENT	32768
 #define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
 #define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
 #define SB_I_VERSION	(1<<23) /* Update inode I_version field */
 #define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
-- 
2.26.2.303.gf8c07b1a785-goog

