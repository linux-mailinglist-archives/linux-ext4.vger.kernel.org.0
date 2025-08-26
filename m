Return-Path: <linux-ext4+bounces-9664-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E000CB36EB0
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075544615ED
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D696236CC9A;
	Tue, 26 Aug 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uGC5UlYj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D591E36CC76
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222908; cv=none; b=uefnDSmO6bRzs/waOgwzA/4FDrfWZ0SR2v5YC3WJsvttZmE4UyngVX7Ey+wTGLE+A5LSOczO5cmEDfiDJarr30O9XIDN2xAuXEIGfSQr9fLM5FmLt+oR7CwBgehXyhJNDLtKudTSK4ahf6U4xaLd/JRs9X8DD0YzmSXg8fOd8E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222908; c=relaxed/simple;
	bh=GaKmvGab+0a2RrIuxhv8XqHzko9SenWylGMpW6UIOW4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yr/VPuPDCJMKohGDIntppHEvUchwtVx6wqEAI/bPoIVik/EH/sAFAk8TWB2M7RquqoqIcb9aFCl9TO7g7+vOpzLWKd74AdpH5DdQvPRplbFOOXhGbRFbDLhn9RDUPbDK0uX9OYQzlVHXXSFu5P8buuA171QOD8sy0EFPrkCZZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=uGC5UlYj; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e96e1c82b01so467396276.1
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222906; x=1756827706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTOjoTpV6m7hLv/F0NHjQx0Ply5AcqoXgmnK8+LDP5A=;
        b=uGC5UlYjbB6rOseH9rP9MBsmDrcW30L2b2JfgIYz8Eyj3xR/rQwJmfyyU66fGoMvZd
         YIn1TRYIdFSV0VIFkfvJv0Y5xYinUBAW72kL9idKUi+wb0zTYCBo08c3pOGQrl3SHnH9
         vxnF5uYsccZbcvX9GNwpv0/djWeDtHVRSa5Rz3Uu5EFHcpmCsexCUXNdQWgH+hTiw2kj
         VGL2vVIQfEfXhMWUQAVfWEBK1kyEfBiNFS6a4c1WOmK2x/Zw3eXkvzoZrOe8uhHAs5td
         Hh0qDI46iRuFdj4JGFQTJ4/oAy2+e21u+KIat1IEqO+Z6mbnDl7hhYAeweAmG3iwJoz1
         Qv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222906; x=1756827706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTOjoTpV6m7hLv/F0NHjQx0Ply5AcqoXgmnK8+LDP5A=;
        b=Izg2JNuzDAeFZ/KnWgar6Qk9VNk0kEZN0Rn66NxK5pRcxx+iG+a/gPlSvx87GxXOoN
         2IcotLI475H4f15yzQ9J6EcDX31ZWr+7qSO/FlxzCGmNj3oKEBYOKZ8fvS3gae+78Ngo
         C6dOD5Yc7FKbuCHnGqBA2OFe8FQJkfWdrjpYJYzuDDH/GSNZjrIQfwZLbCPbWLJq/n1x
         hPQbPE42y035jk5dJvgiub+bVEycmXimPQmUzYHPEKm1LH6ArryXHeQIVJG/u16TEjl6
         iznRf4iX10n9lQh81LGCi6qC9Jtt/DMLpeqYwia95MAbH641vUai670Jat5wVTp5Iwje
         shXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTf7wRG9WfdHfgPqGOV8zqbZ/gNuFXyMv3KMVjfnwIMGdbiUhsy37WqtDbSAkUO4Ff6KtaOT0CWqFF@vger.kernel.org
X-Gm-Message-State: AOJu0YxlY/woSVzHqGH+tED/jyddq/0S7AqsI934dLZfd2ZRxh8kme4U
	lLBRLXmNo+pASZRoYbZBgmNO5RDcvCm33kFjoZyejTfKWA7ebGDUtZlH48zYXAhQDUQ=
X-Gm-Gg: ASbGnctD7nMbPvkoc8U+YEXkVr6jFa7TT2bzWwlVaVHBp1vtmFjrQxoL5Di7NS6eT/D
	ZTI7OsjdkZzNbPzouhzIanVJb61DRoMnJy598vXFduVBoUQWgXena2gink34s13HamXcOxbvv90
	MWs9FAGmMTMQAprfFJOcINNqo60KTO3V7TNSIo9cZAnMUMhNs0omN+W5Yw5SenlXTTPL8h8FzEL
	/xTlVUaRaLrnPezH2ok4kCZwQBLBg68neFl5UbfMHFDooAX2IN5pUo+2P/xaYC94innzr43a5rD
	o29TNAaVUVoxKnj766CHjzET/ZRnSjIVFPEnyFsLKTx/+V5j2XZeup57wwkklpPxJS5Ded0rNI9
	cf5Asq76nEgqqNGcwsSvxcI3sZG1V+stpwH5RtjMzrA9LRSFepS2BTYLesB243z+IU86gNQ==
X-Google-Smtp-Source: AGHT+IFjze0r20/WCdIbB5fda9LnJE1jWaThHGsQzBCPZUwgD9yRzYM9e2CgIgaMhoLiVnPc0UCoRA==
X-Received: by 2002:a05:6902:150a:b0:e95:3e67:90de with SMTP id 3f1490d57ef6-e953e6797fdmr9650941276.27.1756222905943;
        Tue, 26 Aug 2025 08:41:45 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96eb3c35cdsm121586276.11.2025.08.26.08.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:45 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 39/54] fs: remove I_WILL_FREE|I_FREEING check from dquot.c
Date: Tue, 26 Aug 2025 11:39:39 -0400
Message-ID: <e2c8fe9fa28fb6e52d0e47e38d2ef93c9527b84f.1756222465.git.josef@toxicpanda.com>
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

We can use the reference count to see if the inode is live.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/quota/dquot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index df4a9b348769..90e69653c261 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1030,14 +1030,16 @@ static int add_dquot_ref(struct super_block *sb, int type)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode->i_state & I_NEW) ||
 		    !atomic_read(&inode->i_writecount) ||
 		    !dqinit_needed(inode, type)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&sb->s_inode_list_lock);
 
 #ifdef CONFIG_QUOTA_DEBUG
-- 
2.49.0


