Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB41193672
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Mar 2020 04:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgCZDIa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Mar 2020 23:08:30 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:32945 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgCZDIa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Mar 2020 23:08:30 -0400
Received: by mail-pj1-f73.google.com with SMTP id ng13so5083287pjb.0
        for <linux-ext4@vger.kernel.org>; Wed, 25 Mar 2020 20:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5Pqv0B5ke8kbkLCKzahA1ADTWdbJkwiiM3DJVPre+r0=;
        b=X3USqXR4qL98zoBR5xm+r5Iwa8B7XKg984qzqZUkzeS1r3XKmdcWL9n1SgvI9HghUg
         nM8y2dYeRcEviKJjMBvmdiOP1aLGK4HVl0FuTl7SS5gwdoicJBrE5nU+5T8si6fpwKaL
         Pq2J6FlR6VjJQjL40Ew3CkSMLuaYGSEO+ESNDhAkZjjWKGbWtNCtMOdYNRrN46eBHN6o
         RzVNmzzi9/0AKhFVuWRe+DrZKodOlN8Dsv+LrnR1WFteaMcrajtDGhf/gnb2Ie0WVl1q
         /xPclDdF1ylxfkyQpubwsHb5lYmzOnNcSQrPbfoGClrnii8UPWG7EKZ8yHC4qXoA9hsW
         ASMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5Pqv0B5ke8kbkLCKzahA1ADTWdbJkwiiM3DJVPre+r0=;
        b=lXN40btBMjt+2xdy3IcVqr2CTAJMX07FtIkIdo2OMExqOy8CI22ahg3QiQSM9I+CA+
         K8jFaYZoe3rRdMls6L40etmjzpMwpuOGQyn2USVM6uToc1u752phV49F3TUF5YZry08N
         iO4upvqx+MaocDfows283Wc4Da91nBFAjJV4kRRrO79yichEZjlrSdejJBfznKDefa77
         jLyoHWxLAnXrniLhasB/IjHzGr7gemyqXnORMVeR2sjp/EXXL/bNHD/KbhGNoEeVCbOd
         o+QzT5PB1rukXkQuSmI6fChxaj1kfYW4BOAeZIXPFE2z3LK+j2gGJy1hXSslni7pdEq9
         Kn0g==
X-Gm-Message-State: ANhLgQ24F6ZMx75jYemyoj9SaU/3fMlRjNv050yWNBqNSAnppn6aWwZ6
        sep8AtMDzD+yOLHJIxevGPPi5mQUQ+E=
X-Google-Smtp-Source: ADFU+vvhE8/SSERvu33TE10DeCwz8+fW0QlS4JPaKhBx2Csq6iMcHH1qpy7Lzsv9wgwCkHL4I3oJP3dAAhY=
X-Received: by 2002:a17:90a:9501:: with SMTP id t1mr777236pjo.108.1585192108842;
 Wed, 25 Mar 2020 20:08:28 -0700 (PDT)
Date:   Wed, 25 Mar 2020 20:06:59 -0700
In-Reply-To: <20200326030702.223233-1-satyat@google.com>
Message-Id: <20200326030702.223233-9-satyat@google.com>
Mime-Version: 1.0
References: <20200326030702.223233-1-satyat@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v9 08/11] fs: introduce SB_INLINECRYPT
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
blk-crypto for file content en/decryption.

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
index abedbffe2c9e4..5c758a765923d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1371,6 +1371,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NODIRATIME	2048	/* Do not update directory access times */
 #define SB_SILENT	32768
 #define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
 #define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
 #define SB_I_VERSION	(1<<23) /* Update inode I_version field */
 #define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
-- 
2.25.1.696.g5e7596f4ac-goog

