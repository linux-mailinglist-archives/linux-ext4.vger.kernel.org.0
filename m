Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B35430C606
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Feb 2021 17:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbhBBQg4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Feb 2021 11:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbhBBQeu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Feb 2021 11:34:50 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF89FC061D7F;
        Tue,  2 Feb 2021 08:29:21 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id d6so19623703ilo.6;
        Tue, 02 Feb 2021 08:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=acTr1665vWrpkNtr60MLNyhztGeZCGtXmoVAckbTx+Y=;
        b=vaTAaaqvRwgGSpX8k2TeCxg6+UctH1IP5fl7yVZ+fUtjTNxK1p5ADAIg9xEKcAPzjH
         YOnP4O8ZQNKONgkEr8fdJsF7UE7JlJrelRcawSVxScn9hlrerRzm6YchWoQOGnJP9Xr0
         puSa6PTtrMUap7LHOPThrADpRf4Hn2BjqM3eJJArI1quNyMYZzQghx7ioqS8NHv8c0Pm
         dhmxoywyJOhpkRCcZMap0S9QJnXlfoNGHA2/v8ipQY3s4/fnsnJnKy0+OcslnqDBLmNs
         VIy9fNIpoyR317pXgOIP1jfBG/nSqe/HVwu7JsuSp5Lm7o4VOyc+NwDvA/wDD6dBrfhS
         Y2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=acTr1665vWrpkNtr60MLNyhztGeZCGtXmoVAckbTx+Y=;
        b=AorFgz7P95iHVI6FEDrIRGf9x/yGCiGQYxBYi2D+1FAxPi4yERvc0LdBuagZux7TvU
         km6S21ij1MAUHVUuALqdR/XrtZoIH/zAK7xnto1XqvZYC7idRUFDYDUsarKXJ6Ixoo5J
         YWk2RN2t5vmd6csNNj6Bmu7grDv8xnuLp+ZwNoxlQiitbtIAcz6kiSBzos43m0/a8Bt8
         ogSgd3HmQvuxUXc5ASkZZ+hcFSHNSBR/WNhbgqqc8Gwg+sFrC18D7WR6CZ4aDQ4NCzDR
         44FJSYqQ+B9wHz8blxInvJgtTeniA7lBsGgTG+uKK4Si/RYflThZ1ZiiktHjp2ofU11q
         rITA==
X-Gm-Message-State: AOAM532J9xpsIESmnOTLXX5i6yL8GHSAW/DygYjbXCZ4iIPs02zOEV2N
        96mNDRadfw7fJSKBnUZHMAU=
X-Google-Smtp-Source: ABdhPJyVkCpyhBPcGEzCX9BZlz3e2ANuVAXl3WPVurb8TqOjoOZStgOY/tpnwGS4ylRb+mKYIt7ErA==
X-Received: by 2002:a05:6e02:18c9:: with SMTP id s9mr20776364ilu.265.1612283361413;
        Tue, 02 Feb 2021 08:29:21 -0800 (PST)
Received: from llvm-development.us-central1-a.c.llvm-285123.internal (1.45.188.35.bc.googleusercontent.com. [35.188.45.1])
        by smtp.googlemail.com with ESMTPSA id k11sm10844005ilo.8.2021.02.02.08.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:29:20 -0800 (PST)
From:   Vinicius Tinti <viniciustinti@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Vinicius Tinti <viniciustinti@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v3] ext4: Enable code path when DX_DEBUG is set
Date:   Tue,  2 Feb 2021 16:28:37 +0000
Message-Id: <20210202162837.129631-1-viniciustinti@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202080508.GA3550351@infradead.org>
References: <20210202080508.GA3550351@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Clang with -Wunreachable-code-aggressive is being used to try to find
unreachable code that could cause potential bugs. There is no plan to
enable it by default.

The following code was detected as unreachable:

fs/ext4/namei.c:831:17: warning: code will never be executed
[-Wunreachable-code]
                        unsigned n = count - 1;
                                     ^~~~~
fs/ext4/namei.c:830:7: note: silence by adding parentheses to mark code as
explicitly dead
                if (0) { // linear search cross check
                    ^
                    /* DISABLES CODE */ ( )

This has been present since commit ac27a0ec112a ("[PATCH] ext4: initial
copy of files from ext3") and fs/ext3 had it present at the beginning of
git history. It has not been changed since.

This patch moves the code to a new function `htree_rep_invariant_check`
which only performs the check when DX_DEBUG is set. This allows the
function to be used in other parts of the code.

Suggestions from: Andreas, Christoph, Nathan, Nick and Ted.

Signed-off-by: Vinicius Tinti <viniciustinti@gmail.com>
---
 fs/ext4/namei.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index cf652ba3e74d..a6e28b4b5a95 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -731,6 +731,29 @@ struct stats dx_show_entries(struct dx_hash_info *hinfo, struct inode *dir,
 		       (space/bcount)*100/blocksize);
 	return (struct stats) { names, space, bcount};
 }
+
+/*
+ * Linear search cross check
+ */
+static inline void htree_rep_invariant_check(struct dx_entry *at,
+					     struct dx_entry *target,
+					     u32 hash, unsigned int n)
+{
+	while (n--) {
+		dxtrace(printk(KERN_CONT ","));
+		if (dx_get_hash(++at) > hash) {
+			at--;
+			break;
+		}
+	}
+	ASSERT(at == target - 1);
+}
+#else /* DX_DEBUG */
+static inline void htree_rep_invariant_check(struct dx_entry *at,
+					     struct dx_entry *target,
+					     u32 hash, unsigned int n)
+{
+}
 #endif /* DX_DEBUG */
 
 /*
@@ -827,20 +850,7 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 				p = m + 1;
 		}
 
-		if (0) { // linear search cross check
-			unsigned n = count - 1;
-			at = entries;
-			while (n--)
-			{
-				dxtrace(printk(KERN_CONT ","));
-				if (dx_get_hash(++at) > hash)
-				{
-					at--;
-					break;
-				}
-			}
-			ASSERT(at == p - 1);
-		}
+		htree_rep_invariant_check(entries, p, hash, count - 1);
 
 		at = p - 1;
 		dxtrace(printk(KERN_CONT " %x->%u\n",
-- 
2.25.1

