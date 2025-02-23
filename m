Return-Path: <linux-ext4+bounces-6533-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B630EA41179
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Feb 2025 21:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DCC07AA004
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Feb 2025 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629BD22DFAB;
	Sun, 23 Feb 2025 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnKaQO6n"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734BA2153C1
	for <linux-ext4@vger.kernel.org>; Sun, 23 Feb 2025 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740341429; cv=none; b=goFPJB9RsZWUGg1tf63ZCPsF0WFEO9+yV6HHifarh04Wsu2kJPaDxprWecUwHu6GZs3gRe3I+tU1etIsnjnpsv1qB6ZCeoZb0aBOMCQ0HVECXeF5diuHw5xbi/P8FH5vjFuuIqhEuVjFOMbrH0dt9ScaGgJjsNW+xsKbuYrkIkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740341429; c=relaxed/simple;
	bh=1FVkUCNIQO8R1JkBqJ7ZM9cdocLTvVZmiM5BIQac9Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlEu4yNq1wD3AYAwD4V/dCsycsV3pa4pvKJ1kXhLf26pOEJsZjQmMw4ttSa1E+ZW0QrvKM9+RMleMPdDYrkCPdb7RGzQcpwxSxOXaHGWQCMevc76oHbf7cuI11jC5ZVB2Pp1Pk5q+tUtqFDt0INA/fo8A5GCpl9OtduqYQfKvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnKaQO6n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740341426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wszyp/pevv3zyY1zpfaRq4FjcODat6kmDXZcUwBhkeY=;
	b=bnKaQO6neMZV73/Xzd/1pgxxKf1IrWoP31iGdsHT5h17oAZLPA9ufOxkghDnHs/LGSOCB7
	fugihEbhSN1EHWz2SbHDOHn3PW4hbEQRjCp9Ob2psPqdc2niAxv10opfnr+EaJMGbWu5gI
	EqtLKDvrtOsujo5IKaah5/xN0/HxnDg=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-9C2tpf6ZM06kJvFyF1Vtmw-1; Sun, 23 Feb 2025 15:10:24 -0500
X-MC-Unique: 9C2tpf6ZM06kJvFyF1Vtmw-1
X-Mimecast-MFC-AGG-ID: 9C2tpf6ZM06kJvFyF1Vtmw_1740341423
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-84cdb5795b0so293233239f.2
        for <linux-ext4@vger.kernel.org>; Sun, 23 Feb 2025 12:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740341423; x=1740946223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wszyp/pevv3zyY1zpfaRq4FjcODat6kmDXZcUwBhkeY=;
        b=W611sRER+EanjVpoNfy7Yd4MjNr2tpDeCMrxnIPN9dZIRxCofWD/GCWr/W4M9WiGD2
         02A9a9zfSRyzHLiUH8x422BCvEObcTobubueW2dbFYEbvlTK+rnfWnFPvVBSk/NwdO3h
         UEepkJLE78aLZXFhRD0OZWkcmq6o+SjEk9ReMSpD3qjRvUqcw5lhzROIDZ9afvYWsAFQ
         G7KwF1rNuysItnNndbvPoXikgDneAGS3/k+OBqAno6Dh5+yq/px8I0SRVXnZkVYbDqgW
         gPf/vSngThY5scbk6/3AP3SRahDtEwlWyeGG1cL4raIdpPYMQ1415Ikw9ebdE8alK6Wn
         MYfQ==
X-Gm-Message-State: AOJu0Yy3sPPepd//53zaPSmalW7bjGGUK8efbI6Y49RZNKzSWn2Drwgu
	tmKH4U4ZbDag64kd1yf0g3lxYf77GaCOsfjadEfGWnc1iRAQIy5g9iTR2YlK2gZJt8wq9/rXkwS
	0WO08OUMDSfIbbfWULdjsxf9rrWkKV26mo2HPzduBERFsZ99XnVnwvnBclWQ=
X-Gm-Gg: ASbGncv2JmZwQ3NA2XGMmbYFDIB6gzMPl8h445BwNqUvULaNPqpmxkHD11svNvPDtGU
	q0mJqkTwy2lupByxhrXPZDlwVQVY7WEz8nbVDpMVGbbdCHI8P8jPG48DX8QIe4M1ljyrepab0E/
	WmZebBGXuuleDPUSwmXbn4bhtaK9Y5sZYzlFfj0q/GQSu9pbagqGIhOAhzy74/i5kFwcRHSawWR
	2c/m22zITo1pBSwub/qqmsOG2IKQ3cvZJqoGJoAmTDD6KvBrBg72aST+opaWMKQyO3eJziC+k5Z
	+GM4tMVBUsBCMdpVv97t49dg9fkIAVQcGq/hEKApOfDxlTFIFBEKyfLI62mCywfm
X-Received: by 2002:a05:6602:3cd:b0:855:b8c0:8639 with SMTP id ca18e2360f4ac-855daa663b4mr1331265639f.14.1740341423357;
        Sun, 23 Feb 2025 12:10:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0XZW5qqHvN1aSJ4+gQkhU/xUFCjMYqHHf6KuTfGG2AiFAc39JBC1v+KdaT23RvYUwvhqbsA==
X-Received: by 2002:a05:6602:3cd:b0:855:b8c0:8639 with SMTP id ca18e2360f4ac-855daa663b4mr1331264139f.14.1740341422966;
        Sun, 23 Feb 2025 12:10:22 -0800 (PST)
Received: from fedora-rawhide.sandeen.net (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-855b8cd2ab7sm215692039f.24.2025.02.23.12.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 12:10:22 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 2/2] ext2: create ext2_msg_fc for use during parsing
Date: Sun, 23 Feb 2025 13:57:41 -0600
Message-ID: <20250223201014.7541-3-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250223201014.7541-1-sandeen@redhat.com>
References: <20250223201014.7541-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than send a NULL sb to ext2_msg, which omits the s_id from
messages, create a new ext2_msg_fc which is able to provide this
information from the filesystem context *fc when parsing.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/ext2/super.c | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index cb6253656eb2..2a4c007972b9 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -81,6 +81,31 @@ void ext2_error(struct super_block *sb, const char *function,
 	}
 }
 
+static void ext2_msg_fc(struct fs_context *fc, const char *prefix,
+			const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+	const char *s_id;
+
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		s_id = fc->root->d_sb->s_id;
+	} else {
+		/* get last path component of source */
+		s_id = strrchr(fc->source, '/');
+		if (s_id)
+			s_id++;
+	}
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	printk("%sEXT2-fs (%s): %pV\n", prefix, s_id, &vaf);
+
+	va_end(args);
+}
+
 void ext2_msg(struct super_block *sb, const char *prefix,
 		const char *fmt, ...)
 {
@@ -92,10 +117,7 @@ void ext2_msg(struct super_block *sb, const char *prefix,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	if (sb)
-		printk("%sEXT2-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
-	else
-		printk("%sEXT2-fs: %pV\n", prefix, &vaf);
+	printk("%sEXT2-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
 
 	va_end(args);
 }
@@ -544,7 +566,7 @@ static int ext2_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx_clear_mount_opt(ctx, EXT2_MOUNT_OLDALLOC);
 		break;
 	case Opt_nobh:
-		ext2_msg(NULL, KERN_INFO, "nobh option not supported\n");
+		ext2_msg_fc(fc, KERN_INFO, "nobh option not supported\n");
 		break;
 #ifdef CONFIG_EXT2_FS_XATTR
 	case Opt_user_xattr:
@@ -555,7 +577,7 @@ static int ext2_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 #else
 	case Opt_user_xattr:
-		ext2_msg(NULL, KERN_INFO, "(no)user_xattr options not supported");
+		ext2_msg_fc(fc, KERN_INFO, "(no)user_xattr options not supported");
 		break;
 #endif
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
@@ -567,20 +589,20 @@ static int ext2_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 #else
 	case Opt_acl:
-		ext2_msg(NULL, KERN_INFO, "(no)acl options not supported");
+		ext2_msg_fc(fc, KERN_INFO, "(no)acl options not supported");
 		break;
 #endif
 	case Opt_xip:
-		ext2_msg(NULL, KERN_INFO, "use dax instead of xip");
+		ext2_msg_fc(fc, KERN_INFO, "use dax instead of xip");
 		ctx_set_mount_opt(ctx, EXT2_MOUNT_XIP);
 		fallthrough;
 	case Opt_dax:
 #ifdef CONFIG_FS_DAX
-		ext2_msg(NULL, KERN_WARNING,
+		ext2_msg_fc(fc, KERN_WARNING,
 		    "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
 		ctx_set_mount_opt(ctx, EXT2_MOUNT_DAX);
 #else
-		ext2_msg(NULL, KERN_INFO, "dax option not supported");
+		ext2_msg_fc(fc, KERN_INFO, "dax option not supported");
 #endif
 		break;
 
@@ -597,16 +619,16 @@ static int ext2_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_quota:
 	case Opt_usrquota:
 	case Opt_grpquota:
-		ext2_msg(NULL, KERN_INFO, "quota operations not supported");
+		ext2_msg_fc(fc, KERN_INFO, "quota operations not supported");
 		break;
 #endif
 	case Opt_reservation:
 		if (!result.negated) {
 			ctx_set_mount_opt(ctx, EXT2_MOUNT_RESERVATION);
-			ext2_msg(NULL, KERN_INFO, "reservations ON");
+			ext2_msg_fc(fc, KERN_INFO, "reservations ON");
 		} else {
 			ctx_clear_mount_opt(ctx, EXT2_MOUNT_RESERVATION);
-			ext2_msg(NULL, KERN_INFO, "reservations OFF");
+			ext2_msg_fc(fc, KERN_INFO, "reservations OFF");
 		}
 		break;
 	case Opt_ignore:
-- 
2.48.0


