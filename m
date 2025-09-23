Return-Path: <linux-ext4+bounces-10367-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BE3B957E0
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Sep 2025 12:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CE6C7B385A
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Sep 2025 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E409321F27;
	Tue, 23 Sep 2025 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMiDhOih"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4512321420
	for <linux-ext4@vger.kernel.org>; Tue, 23 Sep 2025 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624447; cv=none; b=SGQOmyJXwuilcYqITbQkgrppwwp+7oxPmStRwI9DSPXxtoqZ+1y9UtRW/I66AjrgBzgljbeYyOKk/094V3V0jbQ0/CyrUpponWJwJspTkZF/ymccFbXkeQuVRTeRFhYdzdOmkmno/Dpzd3Iah6/xU+jtYwBzN7a7NLD3BPqSDC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624447; c=relaxed/simple;
	bh=l2+XRRMMlUv38cxkDkgsNP7PrYQqTHAOPnKjsX3NKpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cvz7viiStrdaThBpo8r0a8Wh+Md5gN9fH6/C7SRlnfLgbo9gETINpOtnBognIO3wE+WnfHrKvKMGmJsdvGOsWGWjgUOr4wdS9HymincTfueXDbPvDF40VEuEw5qnbCeFW1jTvyrhz34s5nW3DUhZDSiPJbJMS8uRjYnQMhhgDsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMiDhOih; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e23a6617dso2574155e9.0
        for <linux-ext4@vger.kernel.org>; Tue, 23 Sep 2025 03:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758624444; x=1759229244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wY/sdmBMIe7/evMOyoyNDBqGuIEYNCftZNVDhHEUu68=;
        b=FMiDhOiher0WYGTvi9mlL0UHvwCKsGGmjWkge3xsWfv/uDzLFpbP40NiXIRMUUP968
         xwfEckY67Oh/E1gCkApvZxxe7wm6INY2+PfRri4sRHZaVJf4VH4MFohjjbV1yLhbrQxa
         lCOhz4kRZejjx8sWCcm9SeekQG7H+5pEgj/QwQxYDKdtPvmq51GHckIGEYdxBvp+43N4
         TQXV12quwS3Y2e3xL1iAppawPO1vf2BbQCcO3YiNEbW9LzcTsFrws8GNCQQXtkGQxfNH
         wy+seOz/vpZ2cdR+r84jaFF8A3IuG+Id/1OnsEzN5y25ZVX/k6owrKNrmSUGyBAYdfLY
         zsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758624444; x=1759229244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wY/sdmBMIe7/evMOyoyNDBqGuIEYNCftZNVDhHEUu68=;
        b=aaxbkE4v4muEndwU+Cc12PiQ8GJQXPNKAsMyd5QonQxj13itbAgJgz9JDcbB/1wWw2
         5OMest19OnjyWg2uV1O/v2uB9F+bJx/89zvmzhYNNhgUDi8xxcC/aS3ic4xWDcNhMfDE
         b595+8lpptznERQAIKqIor8k6k93IVbaLezEgYKTnbUySPlIi6ySQyWrxIY3bCFgKvx8
         KrHo1Kdq7vZI7eGDuFpYUK9mE7q1Qx41sGV4P6nBMdGcMNUDLr7VV7W1JucuETR7fJ5I
         nN8NC3EgNDmsDXcKphGG2tmo5sPxZDJWryp/K1CLu9V9cjo/Laoc+LLlTyxSMZx6RHKy
         iOew==
X-Forwarded-Encrypted: i=1; AJvYcCUfcfqmQttQl9MEwnsrISUD8loB9UW/5wLbD0ohH3V5jBAOdTiH+YqvB5egk9RdfC4XGutzVO+EpTP6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3F1v1tIW/QiwS0f+s0X1S9rxRrYgPLuVPUtsElLDDRQlxZlb4
	AQqexNyj3h61nY6Wh7phOLeNaImGiqruoFfybVMAQlpBZQLpW146Tde/8ucFuEmT
X-Gm-Gg: ASbGncvICX0GdWR9ixnjqj5nGOSXdD1fBAydz6KA0ouI05+9WBlefx5vsVbm4heqrwp
	1sdmFYn3huYDpCz6RlKpJR5QGVOIT4XYbGOQfKF5C4x+P4x/2/jitSOlFKniL5JQ5PSACVPpvmk
	Jn5khHmR4XvH1JyLl0l0yFEMDzpKOunuoZi837xbW6fI3xkCSIvTyL1xrOmxNJpXK50cEQ+EN0t
	27W7a/YWhc5bLBnHoO/6zOAA0lGNcnhwSqIFyKtF9z1hf/xcENTRTmZ2FMN/eLVP0enzFsORk7+
	pO4r0W5Xm3mO0fMTtk2hs3sSJYzAOm7lX4bwoD626lTBNS+MygO7J4/ZqZXplMjHY3EG26L977O
	YR5OtC9diD+lv3UooZkaroL1D6JBDFft3RrBAJUokyHG29EZ3taUqbPmU7X6vJnbRjoV+tHOqgd
	h9Sw2M
X-Google-Smtp-Source: AGHT+IFG/viu/Q5UoxWFmn6MCDA3PwXtIt4JmmoJtRIj8itygK9JQbD92sFVJjS9mxr6/B7iPXdZCA==
X-Received: by 2002:a05:600c:c8a:b0:46e:978:e231 with SMTP id 5b1f17b1804b1-46e1e0aec9bmr23755185e9.17.1758624443810;
        Tue, 23 Sep 2025 03:47:23 -0700 (PDT)
Received: from f.. (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e23adce1bsm9710525e9.24.2025.09.23.03.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 03:47:23 -0700 (PDT)
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
Subject: [PATCH v6 1/4] fs: provide accessors for ->i_state
Date: Tue, 23 Sep 2025 12:47:07 +0200
Message-ID: <20250923104710.2973493-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923104710.2973493-1-mjguzik@gmail.com>
References: <20250923104710.2973493-1-mjguzik@gmail.com>
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
inode->i_state |= (I_A | I_B) 	=> inode_state_set(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_clear(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_assign(inode, I_A | I_B)

Note open-coded access compiles just fine until the last patch in the
series.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c4fd010cf5bf..06bece8d1f18 100644
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
+static inline void inode_state_set(struct inode *inode,
+				   enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state | flags);
+}
+
+static inline void inode_state_clear(struct inode *inode,
+				     enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state & ~flags);
+
+}
+
+static inline void inode_state_assign(struct inode *inode,
+				      enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, flags);
+}
+
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
 	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
-- 
2.43.0


