Return-Path: <linux-ext4+bounces-1719-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3E5881A8A
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 02:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44DBE282E7A
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 01:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E3517FD;
	Thu, 21 Mar 2024 01:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+IIVEOT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A8A801
	for <linux-ext4@vger.kernel.org>; Thu, 21 Mar 2024 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710982995; cv=none; b=ZYIEDe1eqLaG4am06S5w0MCj4MkMJk7xcySF0uzqHTEsos2xdgwdJUwHV9LHN5j4whUS3GEzayR2yEjsZ2XV/9VkuQNiBxzBDIqEw2BGoCuudhy30bpLrkaLaiZRq/3XXEO2RCJI4vmvHXGsO6tD5B+W+vo5vJL43dR/3duhTDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710982995; c=relaxed/simple;
	bh=oTZLVjNj17G16khWhcjX8a2LOmunfa42yGhPvLY/2zI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rggh/ifhD4PIZqs7WqCGXYYTM6Nd8YxPG/x990qkhck5RSVRtRJM0mbyuG2G75qhWnbvCuB8Taks138EKJ5KleCUK917IOy/K5cOwWxYXu6tr4NufE7v3KsSkHILieO9IMoTD9WczWQRs1CKQAee21XoEbEPabjCA9H5vNs7Yds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e+IIVEOT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0b18e52dso6633567b3.1
        for <linux-ext4@vger.kernel.org>; Wed, 20 Mar 2024 18:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710982992; x=1711587792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X9UkrgQLCeoQxnShQdyI3KFgUp01eLLicq3jxlpdxXQ=;
        b=e+IIVEOT4IEhaHk0W8j2WhnjagK0CJJYTGebGpmveOtSu7/bZk2g2vuO1xOKqGS3rV
         bWB3+kRb8SG+PAWcxFextdpOuiFcbdgB/kbUJFeIdsFK85DD9zFcP0XucJJWhCDTXcFd
         yhlAzz8vr3ptTihmieNAgzqG8L4WE+nGZgyXO762G0gjVQ7kAAY680WWbZ+KImNAECzm
         eGlPTQdhhBIEAt/arj+8M5IsC4Y7cLyfQXUlODeEy/TGAauHi7C9eO8dTUHDY2qOyctc
         WnK2mT111BQmLvU3v7JGUE4iAICfUFFrjAV2RdlslcUsA0/PAWNY7OYLjoLbyFkdSAEU
         JYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710982992; x=1711587792;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9UkrgQLCeoQxnShQdyI3KFgUp01eLLicq3jxlpdxXQ=;
        b=MEWoySOcYj/9j2y1Zoq4C9BcV6KrFd/J5KuB//gPo4wryjMsu1j/24gw5tRqBgSQHK
         J+VgzaRgUbiJGpoEU/dyDtwYtOtDdLXb/ppKO47LexnHZ9CuR4pDGTObKUHyiIndPF2I
         t9gGMoxSjtmlVksjbQacm4Z/2gww60vF1YiXFRSy2aHS+bV4E/Opyh/wHkj6kUaEy/6+
         USV4jBTRoGKSjjtUDYo4YbCEmcjwCPYw61Aohd5K0bTtl328/oMDBwuLJ5BoD+3eF1eD
         WZrHDwvjQtOLoi9Mro7xHe6rsd5GJwB8KRwccsuwPyBMVWVEHjBJPq9MPn219IhT5lW2
         syRg==
X-Gm-Message-State: AOJu0Ywo/q1SBH7s11/7sm9QB9wU/R4YuVdZj5zimcLGCH9pLl3ZJhrc
	sZ5k6MD239gh+K/2EEyu3a2gvQWQkCac0M2na+WLfCoYIPwDcs+8NtTWjkXMGmjGu1G5sNVvBmx
	rIKB2Q1ckhScJLQQWvdB1vA==
X-Google-Smtp-Source: AGHT+IE26tgzkFs6yzMeeU33NVWXFc7CfaXTUXg+jhQNMeuLKHy8zJRlSWhSQxENXr7wEEyR+2qjAQb42Q5ysyMWyg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:a1d2:0:b0:610:e44b:acc3 with SMTP
 id y201-20020a81a1d2000000b00610e44bacc3mr343747ywg.4.1710982992619; Wed, 20
 Mar 2024 18:03:12 -0700 (PDT)
Date: Thu, 21 Mar 2024 01:03:10 +0000
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAE2H+2UC/x3MQQqAIBBA0avErBsodZFdJVqEjjUQJk5EId09a
 fkW/xcQykwCY1Mg08XCR6zo2wbctsSVkH01qE6ZTqse5czRpQeDIN2nwcA7oUNnB+2tUd5rCzV OmQLf/3ia3/cDFc2C12gAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710982991; l=4190;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=oTZLVjNj17G16khWhcjX8a2LOmunfa42yGhPvLY/2zI=; b=FDrS1Z+rRYNAN9Hvua7Fhm1vLmLL2RLx+PbkpeT/Mq6hV4/TKwK4xrvpNBoB4OPqqnaEx39WD
 /rzcJA7pozRDDXcsK3tJMLKlCTm+3bPS7Cpucf0hoMXbyI1J8vgCvra
X-Mailer: b4 0.12.3
Message-ID: <20240321-strncpy-fs-ext4-file-c-v1-1-36a6a09fef0c@google.com>
Subject: [PATCH] ext4: replace deprecated strncpy with alternatives
From: Justin Stitt <justinstitt@google.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

in file.c:
s_last_mounted is marked as __nonstring meaning it does not need to be
NUL-terminated. Let's instead use strtomem_pad() to copy bytes from the
string source to the byte array destination -- while also ensuring to
pad with zeroes.

in ioctl.c:
We can drop the memset and size argument in favor of using the new
2-argument version of strscpy_pad() -- which was introduced with Commit
e6584c3964f2f ("string: Allow 2-argument strscpy()"). This guarantees
NUL-termination and NUL-padding on the destination buffer -- which seems
to be a requirement judging from this comment:

|	static int ext4_ioctl_getlabel(struct ext4_sb_info *sbi, char __user *user_label)
|	{
|		char label[EXT4_LABEL_MAX + 1];
|
|		/*
|		 * EXT4_LABEL_MAX must always be smaller than FSLABEL_MAX because
|		 * FSLABEL_MAX must include terminating null byte, while s_volume_name
|		 * does not have to.
|		 */

in super.c:
s_first_error_func is marked as __nonstring meaning we can take the same
approach as in file.c; just use strtomem_pad()

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/ext4/file.c  | 3 +--
 fs/ext4/ioctl.c | 3 +--
 fs/ext4/super.c | 7 +++----
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 54d6ff22585c..c675c0eb5f7e 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -844,8 +844,7 @@ static int ext4_sample_last_mounted(struct super_block *sb,
 	if (err)
 		goto out_journal;
 	lock_buffer(sbi->s_sbh);
-	strncpy(sbi->s_es->s_last_mounted, cp,
-		sizeof(sbi->s_es->s_last_mounted));
+	strtomem_pad(sbi->s_es->s_last_mounted, cp, 0);
 	ext4_superblock_csum_set(sb);
 	unlock_buffer(sbi->s_sbh);
 	ext4_handle_dirty_metadata(handle, NULL, sbi->s_sbh);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7160a71044c8..dab7acd49709 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1150,9 +1150,8 @@ static int ext4_ioctl_getlabel(struct ext4_sb_info *sbi, char __user *user_label
 	 */
 	BUILD_BUG_ON(EXT4_LABEL_MAX >= FSLABEL_MAX);
 
-	memset(label, 0, sizeof(label));
 	lock_buffer(sbi->s_sbh);
-	strncpy(label, sbi->s_es->s_volume_name, EXT4_LABEL_MAX);
+	strscpy_pad(label, sbi->s_es->s_volume_name);
 	unlock_buffer(sbi->s_sbh);
 
 	if (copy_to_user(user_label, label, sizeof(label)))
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index cfb8449c731f..de16d045ca05 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6130,8 +6130,8 @@ static void ext4_update_super(struct super_block *sb)
 			__ext4_update_tstamp(&es->s_first_error_time,
 					     &es->s_first_error_time_hi,
 					     sbi->s_first_error_time);
-			strncpy(es->s_first_error_func, sbi->s_first_error_func,
-				sizeof(es->s_first_error_func));
+			strtomem_pad(es->s_first_error_func,
+				     sbi->s_first_error_func, 0);
 			es->s_first_error_line =
 				cpu_to_le32(sbi->s_first_error_line);
 			es->s_first_error_ino =
@@ -6144,8 +6144,7 @@ static void ext4_update_super(struct super_block *sb)
 		__ext4_update_tstamp(&es->s_last_error_time,
 				     &es->s_last_error_time_hi,
 				     sbi->s_last_error_time);
-		strncpy(es->s_last_error_func, sbi->s_last_error_func,
-			sizeof(es->s_last_error_func));
+		strtomem_pad(es->s_last_error_func, sbi->s_last_error_func, 0);
 		es->s_last_error_line = cpu_to_le32(sbi->s_last_error_line);
 		es->s_last_error_ino = cpu_to_le32(sbi->s_last_error_ino);
 		es->s_last_error_block = cpu_to_le64(sbi->s_last_error_block);

---
base-commit: a4145ce1e7bc247fd6f2846e8699473448717b37
change-id: 20240321-strncpy-fs-ext4-file-c-c983d942dd39

Best regards,
--
Justin Stitt <justinstitt@google.com>


