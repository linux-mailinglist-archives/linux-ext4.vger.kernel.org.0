Return-Path: <linux-ext4+bounces-4581-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A8F99C7EC
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Oct 2024 13:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E641C23845
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Oct 2024 11:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94121A724C;
	Mon, 14 Oct 2024 11:00:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407BD19D062;
	Mon, 14 Oct 2024 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903601; cv=none; b=CVmTu8QbpgCf+ZoiFLfrg0QZzzp8cGHT0hUojEwJo0fqsyf0SJrkUwDEt7+/ZyTwlwvyel0vQpV2jUcYle9JMghNLHQrDgo+mqnAs+Yg264a77WeVmd684BWSf1KBvBMP5uRUrDy70Kq07an/y89InKEyOCt6x7WtvVF0++24xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903601; c=relaxed/simple;
	bh=vfJwjToLALeeCjImxT2qgvgczni/pAelp8cETW25/gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvEPLtDCCJQhB2htmy4MoT/s1Xq4Tc/y7w4fS2Cv0TZkZ/K9PgUR5pwS6RHkQrAzcabpei2U4COw8NIezvUVO2Jd6SHs5visMDLDVwdG8hUlG2CVwmk8P5xkQILU2jpWcNvW0O0aSfvR9M8nClSRvmbg6/3hGETiPq3hXLjhAMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 432CD1684;
	Mon, 14 Oct 2024 04:00:28 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D33E63F51B;
	Mon, 14 Oct 2024 03:59:55 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 10/57] fs/ext4: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:17 +0100
Message-ID: <20241014105912.3207374-10-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Convert CPP PAGE_SIZE conditionals to C if/else. For compile-time page
size, the compiler will strip the dead part, and for boot-time page
size, the condition will be evaluated at run time.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 fs/ext4/ext4.h | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 08acd152261ed..1a6dbd925024a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2415,31 +2415,31 @@ ext4_rec_len_from_disk(__le16 dlen, unsigned blocksize)
 {
 	unsigned len = le16_to_cpu(dlen);
 
-#if (PAGE_SIZE >= 65536)
-	if (len == EXT4_MAX_REC_LEN || len == 0)
-		return blocksize;
-	return (len & 65532) | ((len & 3) << 16);
-#else
-	return len;
-#endif
+	if (PAGE_SIZE >= 65536) {
+		if (len == EXT4_MAX_REC_LEN || len == 0)
+			return blocksize;
+		return (len & 65532) | ((len & 3) << 16);
+	} else {
+		return len;
+	}
 }
 
 static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
 {
 	BUG_ON((len > blocksize) || (blocksize > (1 << 18)) || (len & 3));
-#if (PAGE_SIZE >= 65536)
-	if (len < 65536)
+	if (PAGE_SIZE >= 65536) {
+		if (len < 65536)
+			return cpu_to_le16(len);
+		if (len == blocksize) {
+			if (blocksize == 65536)
+				return cpu_to_le16(EXT4_MAX_REC_LEN);
+			else
+				return cpu_to_le16(0);
+		}
+		return cpu_to_le16((len & 65532) | ((len >> 16) & 3));
+	} else {
 		return cpu_to_le16(len);
-	if (len == blocksize) {
-		if (blocksize == 65536)
-			return cpu_to_le16(EXT4_MAX_REC_LEN);
-		else
-			return cpu_to_le16(0);
 	}
-	return cpu_to_le16((len & 65532) | ((len >> 16) & 3));
-#else
-	return cpu_to_le16(len);
-#endif
 }
 
 /*
-- 
2.43.0


