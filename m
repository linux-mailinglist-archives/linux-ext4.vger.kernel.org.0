Return-Path: <linux-ext4+bounces-9636-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7669B36E30
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F76F460367
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7028235A281;
	Tue, 26 Aug 2025 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="kZyAqmex"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF7A3568F6
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222871; cv=none; b=oF1KDJ7qjshkeo1/rNAyAvu3aYah3ILkFg1lTU0lwyQN/nKcR5o4HvgZ45nYXvSqCOfH8r7S5H7bY/03c2C2SCL2+B5WjY8Ch/NoL/n2A7II+niZoUcj8tGu2LRNgeIpFOwxPgIPlQkqON79DHH+RuiNhiTTrEUcTAggntNqazk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222871; c=relaxed/simple;
	bh=PneIhJNQkgVThEAsNHxm41aQCPMVns311gwXpZ3Sh8g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QB8mv2qX8wXtj1GtV1JzsHBStYLVwugvb+kjMKc02AL4CvcpR0OTOPhE9wbqGv1Z+Io/QAE4YXssfCxFGybug/9fFXurLzal9NvMz9Kf3nuHNciDzZAqNT9FhyABO441xKiEuiJzvp1cH1qvxVN7eAjc7z/NziFdHc8KXq7VF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=kZyAqmex; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e96d8722c6eso1480767276.3
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222863; x=1756827663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HD2qcaH/sr5LIXFLqeTARJ6AgNvAdAMXICDQLGRWnH4=;
        b=kZyAqmex/cesg6aAtrS67EW10x7YCxR5jJlgBDqwL2F0rktufaCU8DGALs8yUl/MI9
         J9lDkatWm13yBDt/sJScvpwuW/HKNpzrTpOXnnDzydajWsT+MZZUnB1XqOOfIAoDFQgt
         MH5nAgyxSmEcEXO29puZMz8zaPURZnUh4Lc7nXcP2n6UFYhRa5fOTx2xNJ/8Zg7i1cmO
         OHfBUbOuYVWJsFHGnU87Izcco6sC5n0qetnC0DuNH+M1d0QXLLlRcrcNpyJlqwBwGcrJ
         VjC/UyA4pjPy6/83KkdVe5Am14/6h7GAhXOudB+8adNl5tmGtv+nl7K34xR8LEZt/+XF
         BrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222863; x=1756827663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HD2qcaH/sr5LIXFLqeTARJ6AgNvAdAMXICDQLGRWnH4=;
        b=j8lEiEcbdRM6v+NYmFavevJPEU0BXdlmNWLFLt/rQsJ9aZywuZsSM2tXfE/3KUJMfi
         8oM3uJDiEIJYV9BRdQSkDcl/im68vySuskQ4mX/zM0mm87QWEKW3JNDSt9xTrPDpavB9
         FPuwcDrRjsCgOrKbhGM3p1Ut6aYDdXqhKqABrXrECIRp3PjoSMFNkrU63F0ewEn9OqQ+
         XCuG1PJcB02eUGpz2fnvv7au5fhHnxOdA+25YInCtCCDt9GKB0rHxmP5nWBtKppN7vum
         iVSQFv0xMt7s/OeofPCDWa/9P/xpR9SsIf6FYgkYAChwTSc8kqiscI1PPPDN2QdXPltu
         v1cQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7e4RwE0N584qAbv9KR0ZG3n7FFUZYDkafalRnGInruXWeV0mlbV+/uX134XqDqJK0vGzkprigG3F/@vger.kernel.org
X-Gm-Message-State: AOJu0YyX4zr7p8TdWFOwb83K/QeXtf/xekvJNu9/g6jTG2hizNZ1mZDU
	kgSxtvJ7elHuHwdBd7IFjog0WYkU+JfXru3NOt9ailszKILRGhSfADed8Sr+WFvk+Bs=
X-Gm-Gg: ASbGncusKLlCkd5BNFak5lLk4uoqnZ/JD8evuCEQgD3FjUZ2D2OQWgFEAt7tf7fS84P
	Ze6y9izWwt3OsAF3iUvE5xkGflGUT51y1IcZH79IVbLT1m5GgXZXpzECiKJgy14MYYGatRwEjE1
	ERi6bK6M+uAguSWDrxP1L5xZf0qpnUYH8IQmDfAYZM97SZyQQ0lhOIQnO8l72nTQtpd45a/v9qP
	Chtts5AyXHyrzzfKEgiw97xqp//zD28Iuly9YXGXwK5Gr54xKf2QyjKbUey2QTDrbfNwAqlV9AU
	uwYeMEhB60cyr/Z2WDkIt0cAwrSOf1ZNbJBhSwEnbi6a+iF2TOAtHivNTlCf6B8ePxMZn0Gxd/Z
	nZoocLsfPwHdSca0Vak2Ch3o/vwIF4X6P6TOxAgUkNqPyqCoUM3NzeRurYbw=
X-Google-Smtp-Source: AGHT+IFOwyxSw1QzDSHocgttZXA5ZJZK9OYg63GGlqCgEipVYEviCk6vMqE7SYxZSIRJlAFL4ZG7+Q==
X-Received: by 2002:a05:6902:100d:b0:e95:2c21:2b23 with SMTP id 3f1490d57ef6-e952c212e8dmr13585755276.19.1756222863102;
        Tue, 26 Aug 2025 08:41:03 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96e5530a72sm368624276.2.2025.08.26.08.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:02 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 10/54] fs: hold an i_obj_count reference while on the LRU list
Date: Tue, 26 Aug 2025 11:39:10 -0400
Message-ID: <f4cf75a75d4100f0a7a9d9a411fd28869dd41595.1756222465.git.josef@toxicpanda.com>
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

While on the LRU list we need to make sure the object itself does not
disappear, so hold an i_obj_count reference.

This is a little wonky currently as we're dropping the reference before
we call evict(), because currently we drop the last reference right
before we free the inode.  This will be fixed in a future patch when the
freeing of the inode is moved under the control of the i_obj_count
reference.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 0c063227d355..0ca0a1725b3c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -542,10 +542,12 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 	if (!mapping_shrinkable(&inode->i_data))
 		return;
 
-	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
+	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
+		iobj_get(inode);
 		this_cpu_inc(nr_unused);
-	else if (rotate)
+	} else if (rotate) {
 		inode->i_state |= I_REFERENCED;
+	}
 }
 
 struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
@@ -571,8 +573,10 @@ void inode_add_lru(struct inode *inode)
 
 static void inode_lru_list_del(struct inode *inode)
 {
-	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
+	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
+		iobj_put(inode);
 		this_cpu_dec(nr_unused);
+	}
 }
 
 static void inode_pin_lru_isolating(struct inode *inode)
@@ -861,6 +865,15 @@ static void dispose_list(struct list_head *head)
 		inode = list_first_entry(head, struct inode, i_lru);
 		list_del_init(&inode->i_lru);
 
+		/*
+		 * This is going right here for now only because we are
+		 * currently not using the i_obj_count reference for anything,
+		 * and it needs to hit 0 when we call evict().
+		 *
+		 * This will be moved when we change the lifetime rules in a
+		 * future patch.
+		 */
+		iobj_put(inode);
 		evict(inode);
 		cond_resched();
 	}
@@ -897,6 +910,7 @@ void evict_inodes(struct super_block *sb)
 		}
 
 		inode->i_state |= I_FREEING;
+		iobj_get(inode);
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
-- 
2.49.0


