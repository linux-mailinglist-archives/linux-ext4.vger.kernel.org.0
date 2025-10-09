Return-Path: <linux-ext4+bounces-10703-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B11BC7DCF
	for <lists+linux-ext4@lfdr.de>; Thu, 09 Oct 2025 10:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB203B9398
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Oct 2025 08:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6CA2D7DCC;
	Thu,  9 Oct 2025 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E55vTmMQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50002D24A0
	for <linux-ext4@vger.kernel.org>; Thu,  9 Oct 2025 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996791; cv=none; b=Gt1BpjVZYbiXFlOXGs8PAVps93V1OYPkMGobIE5fMJwfBonTFF2uiqIEWIpyg1FPSI7h2gmGI7yub8eBAj3shN1KB5rqyPG09F3uWH+rGRRPA1P0ap247dx+O65SgzTPqaY8Dm9MvxTfliFsKglcg78F/Z8HIYtB8JfqZ9ZyQyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996791; c=relaxed/simple;
	bh=JAU4oetIKsiFFQoxD4BOLbL092tRs1Y5zrd0wB8hP3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OimUgwbTsLCulQulWiqkc45MFt5KCONT4EKF0nPZ9s+hSuhNPCrdqGrTpxI+xmAe2Y4OCfHyQ7OXcxuei0qjRiBiwHk49g9hQV5V4jkn7kkx05P4qtte4M/zMGkdbnXmZDRfhPGDXmms5nxQGtXJ07rGp7sL82Q0FONb9SS3qWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E55vTmMQ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-637e74e9104so888609a12.1
        for <linux-ext4@vger.kernel.org>; Thu, 09 Oct 2025 00:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996785; x=1760601585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BImMKCDjo8UcgLF4QMJ2SKqY3V/e7t3G8DgvFQjtsv4=;
        b=E55vTmMQPuIsBWpR+wSLdHpUA7OJu+0uKgWLiQNF7rZ53zbtjoDnxV2lDTzB98VXPs
         PmpMv1T+jJCUb0JKHj88embadcVYrbbICu5CdZWG/sa7KKeeHGTw8i5qx1j0JVeq2w2k
         qP76iVEv3J5a8CzP1VQJzd7AoIHyt+hCzYdmXhyAIi9fkjVhuzdUm8qap8UGoiCY0YD/
         cMZk0Joo8VFVz1XRUEgMZaFVWsIf7+6olS82P7R8EsbLGiqrnfLbK4RYvy0ceXHBlOhv
         a5XRmPQcERwzNZ5AZTbprOCXLAa31uQhgT96YekXlD0932f7tL+XC7IQ/wLfR2ovJqyI
         8veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996785; x=1760601585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BImMKCDjo8UcgLF4QMJ2SKqY3V/e7t3G8DgvFQjtsv4=;
        b=PPxGE7vjC/90YHPkSDYGmqv9NUtcxrwSObWmGsX+wLL0ybCfotxBmkCFQhVAzwrMgW
         cP9Mc1P72rXjPjhsXfMM0xqYHY4Vo7YVU+HEvAPwaE99hUSufovo8WhXe0UMaj+Y5lB/
         br6yfEisfINv9UNv8jT0GMyIJQEZYyVH5byac29ptRPR0EXg8Gc3RajU3QoiciD97Rcx
         ChAihgGvUgytBkt3ZGIhDNc4E/m6f3xNPr20uU260UzfRHfmTJ8TfgRSyyWckA368fUE
         izcO5HqoBwJrMMM6+gyZLPSQNHnOXdXk/bQwKSeedewB7nmK93ABIOpRoiF6+UCsOQYt
         U1qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxAIav2LwJ8R+y0Ol+ixb9O1mpFXPU0MgCajZZwkX8RfKWySNbTY2wMMkq7FB0ZcfI9k+sLHWfM2hq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd5MThu3GsO8SS6sjdvfgcxeMLXZr61p7pAUh6mAr3Apoz40Pl
	jA794EkkiEfVUn003Lu9trK6EN6WTbZ+H9FZeu8Wp0ynZsfxeU+AEFeR
X-Gm-Gg: ASbGnctG7+jl15RzGAfSiLc0o3FGY9BSOhqMYrw/ie9h3oWcJ5hUjwIIVOpScHeFPgS
	KeJn7Q7L4VzA6ZiviAMKX50UvNmNpMlUHB8tTxDyTq+TBmxd0YWlutr2J/8EAwN8LSod8+l5kE6
	SOUIG2lYDgbUDfxbWbO8Lz5jSrbBwYKriv4+A6ORr68req3mpZ350b+nKD10e3wciw46kzwRYc2
	D5+bSaKu3yq0bwn2tne70jJFdnEqM9YMBL5iJQ2fzT77EeuKybTOvxLzurJYsjSxWWzyh6hAkg0
	xVF5hEe3AGR047iPU3PqnqcTzmu5/2AJgxDcaelMkbNBiAWtp4ZCxGzk4IkiyKX38Jg+EIDzxoZ
	i4lB5Jxa8r0jjmUG8Zh3tReD3rw6ykc8QIoKVGsOIfzWR3nu30z5apIXTrVKRVL8KT9fh9ulAnA
	CU9OG1l6pqE9HVYbEQkcn9+w==
X-Google-Smtp-Source: AGHT+IENbCwcvaxD9DGquoigQ8tdDndKKU4pj4q2EF42sPm/388Ywdvf1nQR/63uusvC/5TSS5tPxg==
X-Received: by 2002:a17:907:3daa:b0:b46:31be:e8f0 with SMTP id a640c23a62f3a-b50a9c5b3c8mr785496066b.3.1759996784546;
        Thu, 09 Oct 2025 00:59:44 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:43 -0700 (PDT)
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
Subject: [PATCH v7 03/14] fs: provide accessors for ->i_state
Date: Thu,  9 Oct 2025 09:59:17 +0200
Message-ID: <20251009075929.1203950-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
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

In order to keep things manageable this patchset merely gets the thing
off the ground with only lockdep checks baked in.

Current consumers can be trivially converted.

Suppose flags I_A and I_B are to be handled.

If ->i_lock is held, then:

state = inode->i_state  	=> state = inode_state_read(inode)
inode->i_state |= (I_A | I_B) 	=> inode_state_set(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_clear(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_assign(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally:

state = inode->i_state  	=> state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B) 	=> inode_state_set_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_clear_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_assign_raw(inode, I_A | I_B)

The "_once" vs "_raw" discrepancy stems from the read variant differing
by READ_ONCE as opposed to just lockdep checks.

Finally, if you want to atomically clear flags and set new ones, the
following:

state = inode->i_state;
state &= ~I_A;
state |= I_B;
inode->i_state = state;

turns into:

inode_state_replace(inode, I_A, I_B);

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 78 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b35014ba681b..909eb1e68637 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -759,7 +759,7 @@ enum inode_state_bits {
 	/* reserved wait address bit 3 */
 };
 
-enum inode_state_flags_t {
+enum inode_state_flags_enum {
 	I_NEW			= (1U << __I_NEW),
 	I_SYNC			= (1U << __I_SYNC),
 	I_LRU_ISOLATING         = (1U << __I_LRU_ISOLATING),
@@ -843,7 +843,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	enum inode_state_flags_t	i_state;
+	enum inode_state_flags_enum i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -902,6 +902,80 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
+/*
+ * i_state handling
+ *
+ * We hide all of it behind helpers so that we can validate consumers.
+ */
+static inline enum inode_state_flags_enum inode_state_read_once(struct inode *inode)
+{
+	return READ_ONCE(inode->i_state);
+}
+
+static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
+{
+	lockdep_assert_held(&inode->i_lock);
+	return inode->i_state;
+}
+
+static inline void inode_state_set_raw(struct inode *inode,
+				       enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state | flags);
+}
+
+static inline void inode_state_set(struct inode *inode,
+				   enum inode_state_flags_enum flags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_set_raw(inode, flags);
+}
+
+static inline void inode_state_clear_raw(struct inode *inode,
+					 enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state & ~flags);
+}
+
+static inline void inode_state_clear(struct inode *inode,
+				     enum inode_state_flags_enum flags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_clear_raw(inode, flags);
+}
+
+static inline void inode_state_assign_raw(struct inode *inode,
+					  enum inode_state_flags_enum flags)
+{
+	WRITE_ONCE(inode->i_state, flags);
+}
+
+static inline void inode_state_assign(struct inode *inode,
+				      enum inode_state_flags_enum flags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_assign_raw(inode, flags);
+}
+
+static inline void inode_state_replace_raw(struct inode *inode,
+					   enum inode_state_flags_enum clearflags,
+					   enum inode_state_flags_enum setflags)
+{
+	enum inode_state_flags_enum flags;
+	flags = inode->i_state;
+	flags &= ~clearflags;
+	flags |= setflags;
+	inode_state_assign_raw(inode, flags);
+}
+
+static inline void inode_state_replace(struct inode *inode,
+				       enum inode_state_flags_enum clearflags,
+				       enum inode_state_flags_enum setflags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_replace_raw(inode, clearflags, setflags);
+}
+
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
 	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
-- 
2.34.1


