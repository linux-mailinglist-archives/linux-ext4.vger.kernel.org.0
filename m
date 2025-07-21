Return-Path: <linux-ext4+bounces-9142-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCD0B0CB58
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 22:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5A0543070
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 20:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD8E239561;
	Mon, 21 Jul 2025 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="fPG11xrl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D662AD0F
	for <linux-ext4@vger.kernel.org>; Mon, 21 Jul 2025 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128567; cv=none; b=YB5kGIyQ/gvU4c78W13igeNVyy0DVn9NJkbX9xcQwj4raMwvKNSOGiVHE6JKCgkn5t71S9Lz1koMs/EkXwWxbeIm5tsTB1Hxz4V+oVwFiU8gYJfnFNBDStUcSGUiT32YXX7F3MEjdQI6OUeIc0wJzNDtrd4dy6VtV30z2/T7TfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128567; c=relaxed/simple;
	bh=UgbRbU78VULMY4Zk7ex9jsDU0QC//suZHUaLaAFZd2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TaPFUwHhf7hNj9M14++60inx83YpFJwQ5KXWvT4JAAu7fXgIat4KxyWNVf+oHEJOkU3zOHHqdkBqtWAI4prRO16wOGPQfQnIpNoQvueThakg+t81klcuUNhARuD8eVRtK/q8Sy/v/y5DU/lwk2b8pmc94x2YmCsLC7CooBe5sIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=fPG11xrl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d7b50815so36408965e9.2
        for <linux-ext4@vger.kernel.org>; Mon, 21 Jul 2025 13:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1753128564; x=1753733364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=boxcVCFVXQCw05Le0ALM5EQoC4kcXl1MGhhnWNQf+2g=;
        b=fPG11xrlfDujq9xgwI/Jso0sX68+xwhpLKtZRmzOvUyc08l4KfMG+5Jyyy+er8HByD
         5fdzfbDQYtmHuAbkXj9wSI/k0w99w1my3utD/70YF0pWiuAlxoYDudHdJ0um7IRuvKC3
         xF9kuP4WYGKKPW0JLgXDL/m+6DEnxXn9RbXz1GFWBwFVvgs8dI8slf7Sq/7Baj5XK7km
         mwiYZKHRMGbj1jRptdUbX4IXkhiuE2jNbq21AnWJwanyLW05dLkrwAetI48lUPLPFdqR
         5k93omQkgXatFgW6yjKepCsKjlMW5XJkUfW854/LIvMi5XA7USgC6q0frcaFyN0LRcPf
         ls7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753128564; x=1753733364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=boxcVCFVXQCw05Le0ALM5EQoC4kcXl1MGhhnWNQf+2g=;
        b=vaeEitUgA8CX0FAA6E6N67hS55bMXNV9ap/aO8nvoWh5D4AiUkXp96Ygi0ezgvwBkm
         g80U2zkJKljyMMCdbcA+vnQul+/BVQTepYBpC2oKdQr8YNIhauHVpBljn7wNMENykxcM
         tBM8W4ozbu+w/PSQTxBHQIeR2aeUAuiz5ZM1aAj6VEU5aNBhzehB6Z00JaQcYLv7jURp
         5HcsQlfOlp4Onvtzyg2KwqQA51AvH6wB+/PqLERuHEV86rV+sRotb9Wa9s8ri9d51kXn
         PwpDlpXGeCZkKtNwy+4ZnwsUZPho0hUoPxKbVtUdke5sfiSXck+5ofRduHCcF6lR3Kfc
         6gGQ==
X-Gm-Message-State: AOJu0YyEmyxn1qdAdc3CGtIp0vBi0rHYcS1DMLgnfeve+Hj004CCx5vy
	7gKbx1nbibmPpHPPF3F0K/+yYmrgf/AYcnaI5l4O4ElDNiFJx1LkcefOadX6BWEn2fqKfD8ZUzV
	Skk3uHbM=
X-Gm-Gg: ASbGncvKIUjwfDyHdl7nw1jHLhmZR7kI9Gh6POlnRmW30gegl6NbY9uY5fLOohGKqOg
	Z5usT/CbeMwsYWoRCF3AD8gfkU94Zykn1YkTeytz0m2cJoAJCYzfLm+FYzZt/Vv+Ge39zYD0D89
	BoSkEE8+8TtNJxqktKytOlFZGya6Y8jI3C/MxKRLDj5zKnlrlIFN62T9vPdjJk9f9mZ7Jkqqdj9
	qw27r9oWB1q8A4BaJlsyXPtTXPTWmZVWwtOXQuRMJ3QlTI+okumHYK0f5Tki1A+V8z+HVMxvYuD
	tKsJFj3c5a2fjyn5OMBMCNwtIBSReICNTzEUeESCFIOXDLlmFxh6ZbRXZ1LzIukz2HUFiFbYHVy
	JMbCCMsPoPdlZg+N2epwVqMcHjCsUpHTh1eUwPwoIlpCAL0rw
X-Google-Smtp-Source: AGHT+IEOAPLU+icRAA58I0s12u/XlM59cJWhr6wfkK8EL3ke+GGSKZLTI6upfQYKrYACAFwPz6xrBg==
X-Received: by 2002:a05:600c:3b29:b0:456:2ac6:cca4 with SMTP id 5b1f17b1804b1-4562e34bad0mr201588945e9.13.1753128563781;
        Mon, 21 Jul 2025 13:09:23 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:834d:bc8d:cdb5:bc29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45862cf0fc0sm1512075e9.1.2025.07.21.13.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 13:09:23 -0700 (PDT)
From: Antonio Quartulli <antonio@mandelbit.com>
To: linux-ext4@vger.kernel.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Subject: [PATCH] ext4: remove useless if check
Date: Mon, 21 Jul 2025 22:09:02 +0200
Message-ID: <20250721200902.1071-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This if branch is only jumping to 'out' which
is defined just after the branch itself.
Hence this is if-check is a no-op and can be removed.

Address-Coverity-ID: 1647981 ("Incorrect expression  (IDENTICAL_BRANCHES)")
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 fs/ext4/namei.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d83f91b62317..01f379f5fd04 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2984,8 +2984,6 @@ int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 		return PTR_ERR(dir_block);
 	de = (struct ext4_dir_entry_2 *)dir_block->b_data;
 	err = ext4_init_dirblock(handle, inode, dir_block, dir->i_ino, NULL, 0);
-	if (err)
-		goto out;
 out:
 	brelse(dir_block);
 	return err;
-- 
2.49.1


