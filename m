Return-Path: <linux-ext4+bounces-9659-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EA9B36EA5
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A20980A1A
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0AC369993;
	Tue, 26 Aug 2025 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xpekYlcu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A836934F
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222901; cv=none; b=DznyHOKi1774GjKa/EYJjPZU8PDM5jo7/jThOvgZXcM9T+Gap7O0V4yEe/IkAxP9gcgA5Hee0H48EEgc0Xj6qxcoQyUCupJTVOxQ6RjemBoIC+ohsAKLg8TSg0J1UNlwA+4VH9YvUFZxcRMv+FcIq4lOW29WRR6yyivNCt2yiCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222901; c=relaxed/simple;
	bh=sLtWG4tBwYzFayC8el4qA8KAx3MpBYf6WBWbOygRAvQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYpcZio8662jA/FD4zMZsP1BloZY30qiwvf8vT7R/OSML69sVBgXKq3uISZqIZ+Hz65ASmWPrsm7Oxj7+TLAaTnunleN8FfVBNQenGY9fDfCGilPLyseXBsEGOujHxUj5oeTjTpbHTcK0domlP6LcD96nzRIq4EOGS/3zNGanZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xpekYlcu; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-72019872530so23006537b3.1
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222898; x=1756827698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kMEWwVY5zqmZ8rO1Ng8kME7oWtjO/CBjlFvprNCTeU=;
        b=xpekYlcupzksEPwfTAr3kLtByk1OmAAg2qRR+9hPoBCjq48w6teVYU1+bGy1ngIHtQ
         pS3JCgiGYSNooy4fC38/ecutCCbMOjpqwKwNThPu7bWur6lunTlXmpiEyt/uumFPVL1M
         DM7+VOFKcPnwWDbL+JULui3OtXjDt3U/N+cOT2wfto4W0H1URPi4Ep67HkSNMBZgq+32
         Uq1rcHzlnQm7PIXxj46rtjEJK+E6+YqyHvDLNb5siK1Vw4WEtR4N+2uhwmTV8eE7/RHm
         IZDKT4xAG+9PCuWHQtwChrxqbS5QI4hNoGd5E37ZyaHgnG6VBsRZiQQhJc1wxlLg2k5b
         BLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222898; x=1756827698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kMEWwVY5zqmZ8rO1Ng8kME7oWtjO/CBjlFvprNCTeU=;
        b=KItVxjavZKSjEeRaeaDsBV9tYVUaaPgM1HoPu0VMRuCb09z/MPylUQd9wQD/p+jsQH
         yF5xtt+EVpr7mvNzf86R+mufJ1J4cPBaVPOnonpE++0gL60L9DzxSdjXCUy8EUsfPz3U
         bZl3ryZKofBkPLml/3NTGYPeyYAHz4tlEbOWrTXoWy8oHWp6NmpvrODQ+ulPsBhiZI9c
         /4XV1K5NTwbdHvk6DQuHiZPdh9vKofL9C3MfVSFoUNewyfJDeK0BRs4d7BF8gB1oiK1x
         Kp1ugDYpQ6OHCjTp6dNIYNb4hmMEGuJDGODes6LM6MdvcDbBlPbi1SQ1imx0xuurxj0m
         bh7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVv4MS6BQ6i7yeHBTXYoKUc98IEypr6IsngDWDehabfKp9HvotYksegPZlcUkKGuyyN4Os623ezU/P8@vger.kernel.org
X-Gm-Message-State: AOJu0YyRkE2G0MkaXNNao5vaR0kB8NZk6rIvAjQ/YMLk/o4XF52FaTaD
	lpwC3/Zvs1K3k+oFhD0jcFuQNqy5THawxgQNeJGzkVtKIF4O02t5ta/7jEi8lGWECN0=
X-Gm-Gg: ASbGnculsV4bd0sQl9lBYFKKpnxxohjDbrrF3wkYjTKYKZaEIe9ODzRtZTrxa0Th2wZ
	NJyebUpbOadso72iQ4+F6xQXUOv23KO4l+7UIhY1gNkN4NtNyxDLScj2SFDOGkMtZXIUhFKsqCJ
	5iepOICRD+z/ZSjuxaE4VAuvlKIBXP1jQ+I+B1vD+tMCqTrplCx2M3sOnjU9sJKvu4THFdJ6MVt
	aYA13kAu9hvOxcmomSAM5ntRShHE9RbFHeXhyg4qZXHtjxVDC81RrHFjXJMfpQCBcWmFr32Mche
	rcQARJM+bdQCF0j8oF5mpVOAkU4NPiVnfl45HX9OLqX5XZYNTWFW1Bc0VGW6JGtpUEZa68QETJy
	1AGt6oSf2gNX7hd/4tSaxekISEg3XS1GF3/xRMmJrCRYPCnDiwh6kVc0CIuqZSHzYU7K7939EmK
	hufqDk
X-Google-Smtp-Source: AGHT+IEh6w4J98zHKB0KJJey1JZ+RYFPa+jSq6TTzIF+srA6iK+yY8jmdv8EqkOy5QUDc4KAmX6MNA==
X-Received: by 2002:a05:690c:968b:b0:71b:f56a:d116 with SMTP id 00721157ae682-71fdc2d2454mr170681447b3.2.1756222898334;
        Tue, 26 Aug 2025 08:41:38 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18821e5sm25327457b3.44.2025.08.26.08.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:37 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 34/54] fs: use igrab in drop_pagecache_sb
Date: Tue, 26 Aug 2025 11:39:34 -0400
Message-ID: <b46f72a94ae09aa801b3bc2a80d331ffe0648534.1756222465.git.josef@toxicpanda.com>
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

Just use igrab to see if the inode is valid instead of checking
I_FREEING|I_WILL_FREE.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/drop_caches.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 019a8b4eaaf9..852ccf8e84cb 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -23,18 +23,15 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		/*
-		 * We must skip inodes in unusual state. We may also skip
-		 * inodes without pages but we deliberately won't in case
-		 * we need to reschedule to avoid softlockups.
-		 */
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode->i_state & I_NEW) ||
 		    (mapping_empty(inode->i_mapping) && !need_resched())) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&sb->s_inode_list_lock);
 
 		invalidate_mapping_pages(inode->i_mapping, 0, -1);
-- 
2.49.0


