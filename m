Return-Path: <linux-ext4+bounces-8505-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88128ADDDA5
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Jun 2025 23:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B81617D08C
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Jun 2025 21:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98E72F003E;
	Tue, 17 Jun 2025 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvbrbrnZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAF92EAB62;
	Tue, 17 Jun 2025 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194605; cv=none; b=UmXmDUf5xbKRSisZwI8y+5XramLV0PtMaTe5nPzRYkINmWjUqVXCYa8GCOZW2BBAywfdNE/tMU2hS2iuYQHhKq0DLqwKd4NVXmMYCfVGfKuiDM+WqlbRAQ3awb/34Roeoo6CicKvRkI/0Rc8bcz8sYCZaRNexsJGgSqGB+kxFFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194605; c=relaxed/simple;
	bh=B+C8J8IOVaZwKajOz3Ws5jl+Aguhlx98tLdoDzimFpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nr4J7YRHTIVXou1uKkZdok9IwUTYf1xqaTmmpiL+UyupaEMpU/yxxWd7uccCqxkHvCdLOE40etW+KAd26WWflvp8+PgyLJJJVqS7X+3mSrCZw/wg9IE9XcOzpCZClOPrs7IP8WTSi1JNM7YymuFVZVax62KZW8G3HjJfeqdwW3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvbrbrnZ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so10557590a12.2;
        Tue, 17 Jun 2025 14:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750194602; x=1750799402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGOhOaoNynJQibc/xR/GYR4UEekv8Eq1ZlNCGupiLCY=;
        b=dvbrbrnZLyTPsDfdBc78V+YBxEMl0a2x6F36hNUc7cvm/5DCYPYLZn681n64rXZX8r
         PusxLVfrjDSs5Pu/2aYTiEWZnn1G8XoEhvqRDQk7rq0ZK983gsAmONSVSmbW4JDm81D4
         VD8J7J10BUwodOxYqac9l8H+/nSpXWvhDbFopnIcLl+piogcmeq6j7D2jRyTCq4UEJsx
         QWR0OUtEgmwwF0veeVDEKRNc7DnImlXoOb9mJt4XnBffO2BIBLUgV2VKb/ri2gDj3ILn
         2MQrAgdtzvByEDdtL7JdHC31qWEwGYWiNOz2L5KMrv1clGPBqoX6P8NZjlpWhDFULZmc
         sJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750194602; x=1750799402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGOhOaoNynJQibc/xR/GYR4UEekv8Eq1ZlNCGupiLCY=;
        b=wd5DvRSXHFGf2YHb2cSD5gK/LcOpnW3XvgWixYDp4k97oxB2UOia9eMHhwL3nxwaSL
         QgynqHdBCJoTXt07ztvC77z5D1mKlYWTKlNRWItX71TgcKQudJPGxSxRYVVb5FCdfcE7
         VOjg2Eg1XpH5RDgj8QvdV08VqmLP4Io3Rdp+F3Lah7BZOcaTSDRr0nskGTvi49YlZp2Z
         mxqCGFCEWOjLuhPtrs2HD/yvMqZvnpeetPdeCwtx8pq4vhgxmnpgCIlrz7XjoqGsoE6e
         DXjp0Uns7akyEZZ2TChuxnQJxPg+hQB79kVhBQMRZwHBKwTufxArYeZE+JASnOzq20uj
         MWfw==
X-Forwarded-Encrypted: i=1; AJvYcCU1stFQJFaguwgRo8h3ndOYswRMTltkGzReTOuwXwwtRUXN1Qs+/ZEK00+5SAjv7RE2NyOt@vger.kernel.org, AJvYcCWrg2ndq/kMQr2Zh7Tm4VmFEAUSQhNR4jMIafbEF9BRC4Sz6QrR8z/VJBx2YK+MJSpaMM9AB1jM@vger.kernel.org, AJvYcCXbDq6t2UeqF4R1mAyNT9zTkJuqjQQTjoIXrc9L1lG4wjFApoVLwupKzyhMAPRDqcqo9CjMaoSbzWKY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+xtJ7FuLBfIRQ5I3FaOcWjhhXlo3LjJX4pHJvC262dEs645k
	Y1PQbDh8VGPmBWZnuWrWt9tn/c+ibHR7yXe07QW1XZOQRjsaNLM4Vj7TpFHvqqXV
X-Gm-Gg: ASbGnctJ8UeYQsGrRkEwv2Tl8GOaz9HTPxb/95M67FO5eES22UZb9T5LLDOvsBlv4vT
	uFazAs6BrePKbbg1My8ayrmk+mPQ2L8PwU79RQZoAPXWycNjInems6dcC9+SyXoMxQC0N35UtM/
	Sk1WVsegRnFQ+8RiUXfpaa1aQIecE1smv6lmvv+z7UgUwW8ZUkZ1B0BRcF6VImPx6CzIBaxen7E
	loWqmrfeBPWPRiRI7w54JJOVcPsflyRuXHoQL0WzIXTOWPASbtd2R9tmX2MK5MRvFbmbx8QN/kd
	ntN8RC2SeeTrksuoF0L8f35/WQs0Y84wgpIriR8jFvAVoZ5HI3YABfvSfhG+4Oqme72J2DKS2Zk
	oyPBb2kxweL2Xkj2GDNYVTFKXDXi+1hmXoN8EGuFaJ3piz8A8OIV765sGMiY=
X-Google-Smtp-Source: AGHT+IGD+smS/uhjJ/LPrH3PljB+/U54l/D01AGW0iE6jLL0g9DFaW9bJcz1vzNJIlXg+m6h4aPEpg==
X-Received: by 2002:a05:6402:1ecd:b0:607:7851:33b4 with SMTP id 4fb4d7f45d1cf-608d0834a08mr13825361a12.7.1750194601843;
        Tue, 17 Jun 2025 14:10:01 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b4a93a01sm8506711a12.65.2025.06.17.14.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 14:10:01 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-ext4@vger.kernel.org,
	ltp@vger.kernel.org,
	stable@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>
Subject: [PATCH 5.15 2/2] ext4: avoid remount errors with 'abort' mount option
Date: Tue, 17 Jun 2025 23:09:56 +0200
Message-ID: <20250617210956.146158-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617210956.146158-1-amir73il@gmail.com>
References: <20250617210956.146158-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 76486b104168ae59703190566e372badf433314b ]

[amir: backport to 5.15.y pre new mount api]

When we remount filesystem with 'abort' mount option while changing
other mount options as well (as is LTP test doing), we can return error
from the system call after commit d3476f3dad4a ("ext4: don't set
SB_RDONLY after filesystem errors") because the application of mount
option changes detects shutdown filesystem and refuses to do anything.
The behavior of application of other mount options in presence of
'abort' mount option is currently rather arbitary as some mount option
changes are handled before 'abort' and some after it.

Move aborting of the filesystem to the end of remount handling so all
requested changes are properly applied before the filesystem is shutdown
to have a reasonably consistent behavior.

Fixes: d3476f3dad4a ("ext4: don't set SB_RDONLY after filesystem errors")
Reported-by: Jan Stancek <jstancek@redhat.com>
Link: https://lore.kernel.org/all/Zvp6L+oFnfASaoHl@t14s
Signed-off-by: Jan Kara <jack@suse.cz>
Tested-by: Jan Stancek <jstancek@redhat.com>
Link: https://patch.msgid.link/20241004221556.19222-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/ext4/super.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7ce25cdf9334..4d270874d04e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5849,9 +5849,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		goto restore_opts;
 	}
 
-	if (test_opt2(sb, ABORT))
-		ext4_abort(sb, ESHUTDOWN, "Abort forced by user");
-
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
 
@@ -6027,6 +6024,14 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	 */
 	*flags = (*flags & ~vfs_flags) | (sb->s_flags & vfs_flags);
 
+	/*
+	 * Handle aborting the filesystem as the last thing during remount to
+	 * avoid obsure errors during remount when some option changes fail to
+	 * apply due to shutdown filesystem.
+	 */
+	if (test_opt2(sb, ABORT))
+		ext4_abort(sb, ESHUTDOWN, "Abort forced by user");
+
 	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s. Quota mode: %s.",
 		 orig_data, ext4_quota_mode(sb));
 	kfree(orig_data);
-- 
2.47.1


