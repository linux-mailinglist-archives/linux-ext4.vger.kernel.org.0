Return-Path: <linux-ext4+bounces-10303-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD7B8A674
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 17:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B9B1C858C5
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 15:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FA6320386;
	Fri, 19 Sep 2025 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfEdrCTF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E37D31E8A3
	for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296960; cv=none; b=WMjg0dfR/7jQJ4hTKHkAOx/2omagzoxmWxbNNh+1eBqq5HziBIYw9W2pjKz8/nyDhROe0qdx9Yeu3bRfGJuHmWSYHiW9d6rUDtilnB6iZ7qsYcycC2DTm0nN+0LB2EyQEtQEeaDuu6NBZu/lmc+iAqN5E2NdMG+VQYWgq13Dgdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296960; c=relaxed/simple;
	bh=4iwo/4hETyrGGvwl7DvWSV1pIW8nOTgSDeRa6KhBnMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dxx5p5qkDHb5VUp/4M575yP8Wg0/1ovLT2ZmTGWb3y4e1EZpcQrzv1fszIAaOvWcF4iJDhgLfhi/fQOV8EgmTCQDHcAARC5bRZAQBgXpFDU13cgFQ/ld8VNLV1LWln9dSKh3NX8tB8h3VOdvmtu+pTryHfRBg9NPxa/0KbzOidA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfEdrCTF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f2c4c3853so8272935e9.2
        for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 08:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758296955; x=1758901755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6Nz4rZ6SPAY+5NRu1bbLzqkYF61IrDASgyLTr6XAmg=;
        b=DfEdrCTFo6rdzFYhld/JgF+qNufolUKLhbGDNtTgYPHDlacnV21osF/hPH9BqVco5A
         u/5u4Hbmx0xc4EcCChq8CAsPF8ecogqsmc6iaUBgL4tAtBjeqwoEGgmxGdou+gxqgL05
         nIAHEFYmokCTym8WnaPjHyGpKKlpxHw+2xKrezfoYo+yO7H9iXRToVdJIrnEwm3D1XR3
         LAJnYPnere9sfucV1mHf5UOYtTa7rJTLka3HATCQNY+2O7xu6QnPMRlcRFExIMulsXu+
         uejrcrNBwLoL3TBm5OaeM1hCaOlnvddNEb7j0U9ugsmxZNQhkFpZaevx2pNJwPBg64nW
         pz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296955; x=1758901755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6Nz4rZ6SPAY+5NRu1bbLzqkYF61IrDASgyLTr6XAmg=;
        b=bYKC9jmmsV9u4OqF2qJpWYZE29pVG/6cpz0RuCHgCHsgN1brPn/W6PaRD2A9muEEWG
         QZ5QdCz4Etgs1Qv0XdJgAZ8xa4dgGkdjW2Sh1CbFzErQiEZOBOxBdj7vacm+ULN3dkp8
         tsZbcz6o9815/NArs4ShU4c9zS/3/isSCo7dg+6jhLA4iZxctnOkg3qFsy9pxY53IwJl
         tFJLo9K1cwu4x+ANTgkfqp1IrXXVmJ71WFsRTZ2Ej7H17+OikcKLdUobbdYUSan/Zk8d
         JUqGLLjqKCKmZgMFkCrTjZq3F3q+a40MPsIth9lhmPtQbCd+j64KdCGMG7fR2+IPdV7T
         KRTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZisxxoPEKqlWTFcx0m5/d6TqJCtkAWtEi0DO14YIWYcCp2kYzfTI0KxZsLRC+fRir9FUjYe3tp9jn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdv62MYRxRbJTCIugnrf6gh2dke6bMgg6CFA0NChHSFXy5XkwO
	TKLrv2cUTaI6b4SJecmv3qTybsKQ+KXo22BtwfPQXficH0u+MEyQDnrS
X-Gm-Gg: ASbGncsqeYc0WACM/oc+fV2DfIkS82uo1ktUaJCPlZThjbgt0e7xBp1QIeKS5W+HcE/
	/fVcYFRnu/xWajjtTB4A7RGTxVEsBnwtcJe2Gc/n0tHnCnovmO8LKFMP78ngXZBYLqQRc0jwmIR
	7bc2XTepb1zrwmoig/81htISdTDymZzLR2r8KwEu2w89LyvRRHRha8MrSC81qBNBdGzW2aP525H
	oUF5UVb/bSO9cLO3yuWyZOKnlk4og0cvZq82hTxDYLx2oyPjYotlN+lSpVhcnOpdSiUucgyZhf9
	8PHF0N22bRHcIonagxxOIyyXztRAaI9cfAdcEDG3YwAxj9uBBuJEYYTWL1V3c4A5WMIG290x5o6
	xBNCoh3/gINdRm5JZRvMzssunwGtJ6wXh0MxB13dhoxFd9miTrxOVeZe0pJ6X1eQXkBhy9sjN
X-Google-Smtp-Source: AGHT+IFi3Qiw2JmDbZ5JtfHacDK+pNgJNUdMyHN8bx8JLqrebQREXbPs43I+kD+9QA6IwdllVAvzbw==
X-Received: by 2002:a05:600c:1d12:b0:45d:cff6:733f with SMTP id 5b1f17b1804b1-467ebacab73mr28722625e9.11.1758296954944;
        Fri, 19 Sep 2025 08:49:14 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f53c4sm8446746f8f.3.2025.09.19.08.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:49:14 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v5 1/4] fs: provide accessors for ->i_state
Date: Fri, 19 Sep 2025 17:49:01 +0200
Message-ID: <20250919154905.2592318-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919154905.2592318-1-mjguzik@gmail.com>
References: <20250919154905.2592318-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Open-coded accesses prevent asserting they are done correctly. One
obvious aspect is locking, but significantly more can checked. For
example it can be detected when the code is clearing flags which are
already missing, or is setting flags when it is illegal (e.g., I_FREEING
when ->i_count > 0).

Given the late stage of the release cycle this patchset only aims to
hide access, it does not provide any of the checks.

Consumers can be trivially converted. Suppose flags I_A and I_B are to
be handled, then:

state = inode->i_state  	=> state = inode_state_read(inode)
inode->i_state |= (I_A | I_B) 	=> inode_state_add(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_del(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_set(inode, I_A | I_B)

Note open-coded access compiles just fine until the last patch in the
series.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c4fd010cf5bf..a4e93fcd4b44 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -756,7 +756,7 @@ enum inode_state_bits {
 	/* reserved wait address bit 3 */
 };
 
-enum inode_state_flags_t {
+enum inode_state_flags_enum {
 	I_NEW			= (1U << __I_NEW),
 	I_SYNC			= (1U << __I_SYNC),
 	I_LRU_ISOLATING         = (1U << __I_LRU_ISOLATING),
@@ -840,7 +840,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	enum inode_state_flags_t	i_state;
+	enum inode_state_flags_enum i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -899,6 +899,35 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
+/*
+ * i_state handling
+ *
+ * We hide all of it behind helpers so that we can validate consumers.
+ */
+static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
+{
+	return READ_ONCE(inode->i_state);
+}
+
+static inline void inode_state_add(struct inode *inode,
+				   enum inode_state_flags_enum addflags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state | addflags);
+}
+
+static inline void inode_state_del(struct inode *inode,
+				   enum inode_state_flags_enum delflags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state & ~delflags);
+
+}
+
+static inline void inode_state_set(struct inode *inode,
+				   enum inode_state_flags_enum setflags)
+{
+	WRITE_ONCE(inode->i_state, setflags);
+}
+
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
 	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
-- 
2.43.0


