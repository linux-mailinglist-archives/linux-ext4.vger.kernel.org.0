Return-Path: <linux-ext4+bounces-7534-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE5DAA0964
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 13:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E261A85030
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 11:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4A22BD5B0;
	Tue, 29 Apr 2025 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/lr6bi5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E6A1E515;
	Tue, 29 Apr 2025 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745925447; cv=none; b=ls5tVzxi/7eOJ1Enz3B69kIMxAfri2aAik3LUctnk5bTYhL6XMdV6Nc48DAHAdY3bwKlKKA4phf9ugA2B9cmtLJlORBBWxBQ6CCylUVhtSxQfYCt9nVdN1pXTsxjLf1hlJfLfr6MzKMT65lZrcPBw8T7AqjuLt+ZKxnhHAcmzO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745925447; c=relaxed/simple;
	bh=wS+kZb5XdPpO92yeSr7T7CAW1gR9Y4RtpOS4qgkAl0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWHlZkdtPHBxjJ7WEVFoUVwSsVJYwr+NB0ByYBtDOL24VM4S/atVML2P8O2e4e35X9UMmV9VEr/k7m6YGjKTIaQpsy9AMWYI9Dvk0A/oQAReVv9wsJe4Py+AskuzA/ZJv9Zzfco/Qt6i7h6cCa1NV1TkX6HMf/tDFk7SccOWiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/lr6bi5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22423adf751so58066275ad.2;
        Tue, 29 Apr 2025 04:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745925445; x=1746530245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDj+YHGSgEin/gvHkYs0MK30VoXW5locsP1Inn6bkdU=;
        b=O/lr6bi5Mh7KaWBrKGgZPA3KLBy3qnUpARAZIFOldK0FX7b2YyaiEsCzln+UnxJVkQ
         3yUlQNMNWJsEit1xTMy0rYFcb3b1Vwpb/cK6+FBoncmmTHJ3wO910a8QUJxKHOAtNzBM
         PyIAa31J8s2pr9/CU+Up/vPoQPmSs/S/CE/a4OZE+3kLsKroAKKQpV5JTJlDMkMZFSfr
         qkLXZ3ETL0qLvsmsJ6wMANjoMq44dCBLzK7pDrkwtQbHHuR3VoyDtRMd8FkFLpH1krtJ
         2fW57ybidbSbdsaBMOZX9YC16+ZXdTHxnUtm/ODOnh8WT6ReEqagsuukMzPFPe+ncMmy
         auGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745925445; x=1746530245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDj+YHGSgEin/gvHkYs0MK30VoXW5locsP1Inn6bkdU=;
        b=hl+8KnlqV9NhQ3DK7JWhYF8ViGj2+Ev1QAlwsJmMlwqBkLKwh83tQ5ngYwci/kbHyn
         YSoqCkUz5I9CmfIqrgF1fNslV3sqgM4y3F6Gt5PeMz/b6JbeW8dgYD9+Vb0CmP+IrZl4
         smCmnSHo2hlpxJ9c7OhLq6+vqKzcbbWf8OANOcRnZ80OFmcCJVytcQieZTppiWAS/q7s
         MzH+lO/6cFVgjzn7lDhpMBnK54hIaXmuXB0JYejZ/3saxnUC1RMu/0eT6MlvYiJVmZvh
         sGugOxNzlK0Zt+Jl5taGYhRMKe9fD1Kolm0NcegAMJfG6pR7TRaF1Ba7iyyCQI61n5Hu
         ZWCA==
X-Forwarded-Encrypted: i=1; AJvYcCXo4w3qUZHENrgvcEs0/2VZRBoSBvvHueNKaq6r1woaI2Jc08s/h6TrgLILkxtstxG9xAur2YYMYQus8PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCeSIFLgAHFdC3XKxsKU5cft9zH1jm3PU9g4WA5UDgFaiAQ1Wa
	LlA/jsdn1Gk+cKILntH9/8jHDTErTFlB0dlpgNxCIjiOL34FhLyw
X-Gm-Gg: ASbGncvcUG81FhF09wd5TpDR6WhNAXEqX3kYuhoTa8xD3qTY/fJ0MN46LC5Sxue4M8x
	/CZ55O384bPpOTupjyLywlI5rXnQo+zN7IZSqBEqyoDziQ+mMYWo07kDiGMaPB3lsa3rbEiOc8Q
	KBEg85gATw/K7vsDd0N8ZcHLMTokkaH2WlQQ3VUCMskq7Qs7CRuQN+eKZhDIkxzhYxDSnJ5qvhX
	J5gbch/B80CwNt+m7Il2BSwtGpxyD4WI5fas6YlP+lux9JbyUtM+GoRGIcfov8zb6MjUKB4UXML
	4gnlzCl4pBxuqqQs3JCMQOPMVGNcZrta5CwEzmjrzIhTtwanCssWeMDPnakm6A==
X-Google-Smtp-Source: AGHT+IEmHFakLf+kh+tFQbmBSRHtSeSUIBpP4jjV3qVkqeSJv0J3lZp61vywhSvnlkL2IxlBEuUdFA==
X-Received: by 2002:a17:903:1948:b0:22c:3609:97ed with SMTP id d9443c01a7336-22de6eb552bmr32869095ad.30.1745925445591;
        Tue, 29 Apr 2025 04:17:25 -0700 (PDT)
Received: from VM-16-38-fedora.. ([43.135.149.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5104cd5sm99581105ad.199.2025.04.29.04.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 04:17:25 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	yi.zhang@huawei.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [RESEND PATCH] ext4: remove duplicate check for EXT4_FC_REPLAY
Date: Tue, 29 Apr 2025 19:17:22 +0800
Message-ID: <20250429111722.294975-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

EXT4_FC_REPLAY will be checked in ext4_es_lookup_extent(). If it is
set, ext4_es_lookup_extent() will return 0.

Remove the repeated check for EXT4_FC_REPLAY in ext4_map_blocks()
to simplify the code.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
Just resend, and the first send email is:
- https://lore.kernel.org/linux-ext4/20241113044158.1609384-1-alexjlzheng@tencent.com/
---
 fs/ext4/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d828a6..c87dd4ed39f0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -623,8 +623,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		return -EFSCORRUPTED;
 
 	/* Lookup extent status tree firstly */
-	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) &&
-	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
+	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
 		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
 			map->m_pblk = ext4_es_pblock(&es) +
 					map->m_lblk - es.es_lblk;
-- 
2.49.0


