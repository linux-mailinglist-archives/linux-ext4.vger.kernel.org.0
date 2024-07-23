Return-Path: <linux-ext4+bounces-3361-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE90939B1C
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 08:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0870B1C21BB4
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 06:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D868614B960;
	Tue, 23 Jul 2024 06:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WHY7yXFG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08EF14A635
	for <linux-ext4@vger.kernel.org>; Tue, 23 Jul 2024 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717324; cv=none; b=KFEDyGx3dcfXH288+lmS6zblsr3pEvyRgp81mXSyYDoAMYJySTP4bZUoB23Svnp21xHDhitl0Iy+2feFLQHzVBP+hsKolzmvANMjMajQjYQ3LX6KAAT/tWVykGVlk9DsZaocBpfygjCF2V5h28XRZdHnYjf1qo3ZKd6iaZZ3tXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717324; c=relaxed/simple;
	bh=0HTnSe9uE8/TueQuUxnOYGQOa29Pxmdr03hf0QlYL/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=q0Do3iWKr4rHQNIjk5fZ6baATrzGf5ezHsgPqU3S5v4NtnrcX0u2kc4j+h5SKvhem/VunH6R7cHJw8temwoogAzXt4vb7416/1cvbF5lgELm8+nVkzfub9RmGKzd5IXPQiPqu/Vb/Ns2EzRf2cNZ2vQiP8ajrpDIV41XODgoCPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WHY7yXFG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc65329979so2389145ad.0
        for <linux-ext4@vger.kernel.org>; Mon, 22 Jul 2024 23:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721717322; x=1722322122; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2ChgNmoVVY24yz+OG3mmRYW7ZSmqwZbJp6/ChgG1cTU=;
        b=WHY7yXFG/NJT9R41iqZ5LLRHAEGLO4rJGiyjH371O8ey9k6j/ylHJ0UhbCke5+fHrL
         AAcYb7vVyn/D7QYuL++xdLo3NFSZuW1Fr6vI8o4616hFI4pEy3ofVf7fbcTsc6ZAHVzr
         SbDnOgRUo3GeQdWp3LFej0ybXEisjOpvL4vTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721717322; x=1722322122;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ChgNmoVVY24yz+OG3mmRYW7ZSmqwZbJp6/ChgG1cTU=;
        b=GUYc34IK4qv/jqqnr84VjwuA6tLlDMjDtVmnUn+nkdOTtc3q1zyXIsongmEFXGRtbx
         uiGplaN1oHD0wKJirKp1Asw+IxYNDAGy2+Y2KcR097lnOjLI0iFGL632QPB6JXGER1v6
         mroRtBWuGbz8EI2zewp4m1lRDiJz3ZHIyybFjvTJD9Mscj3MzwrfheqIhnAcA1qzE8ug
         EHOIIEJB9pqi3dQPwQ2fV/FseyyH9xOxsJvglIoylXe7SDt4rKAbYhDycG7EaFCOk5Id
         PrP0bm4dNbJ2V1GVe1WakK+jPlO0vhM/eXP/2WOPEVUw346TtumoXLmzfKiMLMNTBfq/
         fClw==
X-Forwarded-Encrypted: i=1; AJvYcCXA13327+38EQwF+GZoRzCVzSUsb3YEk3dUAuOvvmMmLUHEcIJzrJisv4tpRMz1UJkOGZV0+gb/gOkFzXbXy1rNLExj3sG9HmLSbQ==
X-Gm-Message-State: AOJu0YxlK6bzfK3G/Zb9ViEl1Ir8fzfp4n0JYawxgnHYRdKUaOLyKztb
	xTpImUc1uKozO9PulP54z7IR+h54ddAUU+X8nq+/QiP0/MkHeCgoArVd8sPnOw==
X-Google-Smtp-Source: AGHT+IGFp7Hi4mZSJbMCVB2pR1JfowqAokx6klKnEEefyFpxCStLTJoLpCfGDDfk9wJ6LcHiRTFQbA==
X-Received: by 2002:a17:902:ec91:b0:1f9:d0da:5b2f with SMTP id d9443c01a7336-1fd745879femr90429865ad.39.1721717322128;
        Mon, 22 Jul 2024 23:48:42 -0700 (PDT)
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31bd90sm66950175ad.173.2024.07.22.23.48.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2024 23:48:41 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v5.10.y] ext4: Send notifications on error
Date: Tue, 23 Jul 2024 12:17:20 +0530
Message-Id: <1721717240-8786-2-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721717240-8786-1-git-send-email-ajay.kaher@broadcom.com>
References: <1721717240-8786-1-git-send-email-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

From: Gabriel Krisman Bertazi <krisman@collabora.com>

[ Upstream commit 9a089b21f79b47eed240d4da7ea0d049de7c9b4d ]

Send a FS_ERROR message via fsnotify to a userspace monitoring tool
whenever a ext4 error condition is triggered.  This follows the existing
error conditions in ext4, so it is hooked to the ext4_error* functions.

Link: https://lore.kernel.org/r/20211025192746.66445-30-krisman@collabora.com
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jan Kara <jack@suse.cz>
[Ajay: - Modified to apply on v5.10.y
       - Added fsnotify for __ext4_abort()]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 fs/ext4/super.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 18a493f..02236f2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -46,6 +46,7 @@
 #include <linux/part_stat.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
+#include <linux/fsnotify.h>
 
 #include "ext4.h"
 #include "ext4_extents.h"	/* Needed for trace points definition */
@@ -699,6 +700,7 @@ void __ext4_error(struct super_block *sb, const char *function,
 		       sb->s_id, function, line, current->comm, &vaf);
 		va_end(args);
 	}
+	fsnotify_sb_error(sb, NULL, error ? error : EFSCORRUPTED);
 	save_error_info(sb, error, 0, block, function, line);
 	ext4_handle_error(sb);
 }
@@ -730,6 +732,7 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 			       current->comm, &vaf);
 		va_end(args);
 	}
+	fsnotify_sb_error(inode->i_sb, inode, error ? error : EFSCORRUPTED);
 	save_error_info(inode->i_sb, error, inode->i_ino, block,
 			function, line);
 	ext4_handle_error(inode->i_sb);
@@ -769,6 +772,7 @@ void __ext4_error_file(struct file *file, const char *function,
 			       current->comm, path, &vaf);
 		va_end(args);
 	}
+	fsnotify_sb_error(inode->i_sb, inode, EFSCORRUPTED);
 	save_error_info(inode->i_sb, EFSCORRUPTED, inode->i_ino, block,
 			function, line);
 	ext4_handle_error(inode->i_sb);
@@ -837,7 +841,7 @@ void __ext4_std_error(struct super_block *sb, const char *function,
 		printk(KERN_CRIT "EXT4-fs error (device %s) in %s:%d: %s\n",
 		       sb->s_id, function, line, errstr);
 	}
-
+	fsnotify_sb_error(sb, NULL, errno ? errno : EFSCORRUPTED);
 	save_error_info(sb, -errno, 0, 0, function, line);
 	ext4_handle_error(sb);
 }
@@ -861,6 +865,7 @@ void __ext4_abort(struct super_block *sb, const char *function,
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
 		return;
 
+	fsnotify_sb_error(sb, NULL, error ? error : EFSCORRUPTED);
 	save_error_info(sb, error, 0, 0, function, line);
 	va_start(args, fmt);
 	vaf.fmt = fmt;
-- 
2.7.4


