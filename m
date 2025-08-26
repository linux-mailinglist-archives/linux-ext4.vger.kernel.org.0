Return-Path: <linux-ext4+bounces-9628-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B00EB36E0E
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE8D681C62
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CDA34DCFF;
	Tue, 26 Aug 2025 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="J1so4eIK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3B8340D80
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222857; cv=none; b=cXPv/YyFtwi3LpSjiTxmcLpDvCnbfk44QBInZbwQYDwMkxBZgWneK4tNEBY2Hsy+ToRClbWAYC4uHr4222dbpEMCsaC4H2bGP2mUDmCI+M74Hkddx1rsgJTA1rb69fpyKgvVPwTMve2NjaY58KythwmPQe9+PojgAPv5IVljkHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222857; c=relaxed/simple;
	bh=rEk3AZqPT3roP7XIofYhfeT6/+oAWZl9Iy2J4u2LZZg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rx17/EphJumati57qlrayKzsrvpHx6DlCbkAlCGltKNeWznwXZY6NENWlF+U82prw+vqzmjRNf/BCMpnDr/jpIO9f0r3V9Bl3g3MqlEWvgPb05/RO12eDCLJQ90tEu9PEKvLi9FhEY+JpdcWFU1bB7bxZWYULenar+P0kLB5s8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=J1so4eIK; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d6059fb47so45493667b3.3
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222854; x=1756827654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNJTWbhCBpFeB4mUm7efdyUMeuhG2Q/6lRSD0b4nR+w=;
        b=J1so4eIKJxzyEyHBI8Ux3pLbeaNL00NJoA3CalK/iJkuaJnbFILlphCoLEP19pD4q3
         hv+aHAc+NUiAAPSXCYbPIVNHGw5BZqPQYlj694bJJB9QEz8anTkMlLFxi1FkUsohwpC4
         McKSve5Maq5b1iMwwHblA/t18J1r5twAKmRRg8fyUmNBW0z7a0LkMM5zdvZ+hPI0K/eW
         w5uNhDH9fKmVTDNGvKEY1RzHpukgLC1xinphA7ywzHEkFP1r5Y4miJMBFQc+67fZIBwf
         7W3fwEnsGbUhqRkrpjzsmajeTb0D99t8SW0yvRXpG356dl4S1eE4LYhYz2zkYYxl14m9
         8o5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222854; x=1756827654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNJTWbhCBpFeB4mUm7efdyUMeuhG2Q/6lRSD0b4nR+w=;
        b=CXGakmgAYBCW/yMi9lgyP/T7GnjO0npWhDigrlwSMxevrGE+ZiesIsAEww2U0aQwKG
         igr2iZh5BvV1TqKnw6WQWqnEnebqVVk3/l08iM8mOWB02ZdRlo1rzzGafJVNZa7Ri0ts
         MdeBaJJ2QN+DM3X/o3F9gaLLB6onWYOIoWKM/6CprGz41p3tyO4do0k1yTv42tmTjkch
         N3r9B1O0O2adxZzptM++kauDwImkRYnXXyCHa7jPoAoR5FFqBJiwW6oXkAA76VtrOa7i
         /XasmP6IqPWmYfHSk8xYr9+5GPL2tVLfjxK+5XtZcjaiuNvz2e+l7Qk/btkhSQKHWibx
         5xtw==
X-Forwarded-Encrypted: i=1; AJvYcCUX5tfoKhABPEPTp9Nr9smHe1nZqQ7bZ/RqimmvdUS/ubX1U4O28Yzja6hbLnecL0uetRmtq7jQKp31@vger.kernel.org
X-Gm-Message-State: AOJu0YwkpJX+mxKLjxp6NKXKjwAbp0DYnlIz0uW2r78IFkn/TG6z/gBl
	aE9eItCRxANz4JI4muAuWnCiOzw4pJDJ8h1ClevWjVVJ/7j4N7sjKF02IRwPGUZ/oyk=
X-Gm-Gg: ASbGncvVHCErv69YkiFvEmYaQ7EqAp1xodSwfkW7mtBG3lb5Fnj18k1mXtFOyuxoRTN
	wq7Nn546z4CwzYFcL6g9ad96tpO+vUoJp9qqHuK6tVXJrn1kjaUrB67U56Gp46wJxo63kdwufqR
	wLLGYvcAuOvRO2d7+4V38L8gFSCBeqwQp8FjUyeXjrgbXh0gVGT4RzzeLINQbaq2EuUObDbBPbL
	+SNF/XS9qHtRjeIxpax1G6HRRP8PVKIFk3cxqZZFXLvGKZ5PGBRM6IOLqWF2ZGoo3Cs57jx8qxk
	7FPlhVuKoSa3sgXDM5oaPLm0GawQXquBDs/YHluwziCkOdrljm3RNwuokT7jWHTOCcbxykShRWt
	7rURjNvLBFj5btiI/SFKwMzbcgQtdbaaDqfPtYGooJEW0vbxCkz+b12X0tUhfoxTd9v4Uvw==
X-Google-Smtp-Source: AGHT+IFi6M6u4AJdefn0ukVMEapuRQSNry7FoPGsHO/VYazwndRMBITBiYhVeBdvqnQuAZyERpr4uQ==
X-Received: by 2002:a05:690c:9688:b0:71b:f500:70c0 with SMTP id 00721157ae682-71fdc2b1496mr144051907b3.6.1756222854039;
        Tue, 26 Aug 2025 08:40:54 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18b1b7dsm24961217b3.62.2025.08.26.08.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:40:53 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 04/54] fs: add an i_obj_count refcount to the inode
Date: Tue, 26 Aug 2025 11:39:04 -0400
Message-ID: <3f53f0e8bdd7e598740f6ebf7d96c7cec1de7269.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the inode's lifetime is controlled by it's main refcount,
i_count.  We overload the eviction of the inode (the final unlink) with
the deletion of the in-memory object, which leads to some hilarity when
we iput() in unfortunate places.

In order to make this less of a footgun, we want to separate the notion
of "is this inode in use by a user" and "is this inode object currently
in use", since deleting an inode is a much heavier operation that
deleting the object and cleaning up its memory.

To that end, introduce ->i_obj_count to the inode. This will be used to
control the lifetime of the inode object itself. We will continue to use
the ->i_count refcount as normal to reduce the churn of adding a new
refcount to inode. Subsequent patches will expand the usage of
->i_obj_count for internal uses, and then I will separate out the
tear down operations of the inode, and then finally adjust the refount
rules for ->i_count to be more consistent with all other refcounts.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c         | 20 ++++++++++++++++++++
 include/linux/fs.h | 12 ++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 13e80b434323..d426f54c05d9 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -235,6 +235,7 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
 	inode->i_flags = 0;
 	inode->i_state = 0;
 	atomic64_set(&inode->i_sequence, 0);
+	refcount_set(&inode->i_obj_count, 1);
 	atomic_set(&inode->i_count, 1);
 	inode->i_op = &empty_iops;
 	inode->i_fop = &no_open_fops;
@@ -831,6 +832,11 @@ static void evict(struct inode *inode)
 	inode_wake_up_bit(inode, __I_NEW);
 	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
 
+	/*
+	 * refcount_dec_and_test must be used here to avoid the underflow
+	 * warning.
+	 */
+	WARN_ON(!refcount_dec_and_test(&inode->i_obj_count));
 	destroy_inode(inode);
 }
 
@@ -1930,6 +1936,20 @@ void iput(struct inode *inode)
 }
 EXPORT_SYMBOL(iput);
 
+/**
+ *	iobj_put	- put a object reference on an inode
+ *	@inode: inode to put
+ *
+ *	Puts a object reference on an inode.
+ */
+void iobj_put(struct inode *inode)
+{
+	if (!inode)
+		return;
+	refcount_dec(&inode->i_obj_count);
+}
+EXPORT_SYMBOL(iobj_put);
+
 #ifdef CONFIG_BLOCK
 /**
  *	bmap	- find a block number in a file
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 56041d3387fe..84f5218755c3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -871,6 +871,7 @@ struct inode {
 #if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
 	atomic_t		i_readcount; /* struct files open RO */
 #endif
+	refcount_t		i_obj_count;
 	union {
 		const struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
 		void (*free_inode)(struct inode *);
@@ -2809,6 +2810,7 @@ extern int current_umask(void);
 
 extern void ihold(struct inode * inode);
 extern void iput(struct inode *);
+extern void iobj_put(struct inode *inode);
 int inode_update_timestamps(struct inode *inode, int flags);
 int generic_update_time(struct inode *, int);
 
@@ -3364,6 +3366,16 @@ static inline bool is_zero_ino(ino_t ino)
 	return (u32)ino == 0;
 }
 
+static inline void iobj_get(struct inode *inode)
+{
+	refcount_inc(&inode->i_obj_count);
+}
+
+static inline unsigned int iobj_count_read(const struct inode *inode)
+{
+	return refcount_read(&inode->i_obj_count);
+}
+
 /*
  * inode->i_lock must be held
  */
-- 
2.49.0


