Return-Path: <linux-ext4+bounces-9661-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D72B36EAF
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1098E5851
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F5236C08E;
	Tue, 26 Aug 2025 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="pwylTXvZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38F936C071
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222904; cv=none; b=sg8ov3dcQbGJ3kjruBxtz3GbrMMpZclhtuAJrh71QqUqLAzDY2Kx+FmyIetk+sOTQOqWTbkN+N4ogfNBS9IXXMsoBPF2SvZoMpyh+WXSt5Ih1JJCN8Z1GgaVFb92ItvhfjFzRWDrzPEGxNnTYfv7m57wZ4EbvWjXZn0BJR9x/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222904; c=relaxed/simple;
	bh=I8tiOyv+oMFkzRzMCj4c/X0bwN+yK3mHwtJz9daUlt4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMD4051V6Dw10nwfuZ7KQKGx4udiEOXBFEiY1fvUIf9Bf4zyVv6J6FGlemKAHqFL0hB5qoQbbovARa2eHvleK7Ev3lNbkmQsyhNsJIIRlbPR+1YQO57JJONIMKkHQXtgXic/91nh8oMI/5xq455pU+5rvVAWI/S6jngyRgDnP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=pwylTXvZ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d608e34b4so45878147b3.3
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222902; x=1756827702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7tCn6brW2Zw7rSbRSTNv27z2ReNHNSMYcuiTIB2+/A=;
        b=pwylTXvZIek9rC+cjh+rUvWRMGRxPPKY/12OEde/F2n52BIvEfVk77wjSelJ03Ul8H
         Fve2hGzxBxhUJFEt/rUiBuMfdMC6mi2cUiTUlzlrLLkHgntPWMVE3CUuMiVWHw30gei/
         i8eVFnU9D+j2N12TcTZ5rawZJM9V+zQZW/pypw7vN22u+JOca8YudhpXRMn7GaRToIyu
         3mnNOd7oTCK8GUXVM4Be0GqypQlFAfwyKMfR8ksNkOixcU0XAUIfg0IawAQ3nPEdtwxI
         my7ELj73tIKtEytDRIhjG3qWe+kRGCAnI0ry9llwWvEn730sFEOM1iYClkG9EfzB1On7
         ua6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222902; x=1756827702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7tCn6brW2Zw7rSbRSTNv27z2ReNHNSMYcuiTIB2+/A=;
        b=iJd/Kp7wxsQtdumH2gPgainWz7hFhrTjXrIH5RflNj5wMiebbJ9gQTbV0otJVcQtkZ
         cL/H/CwYmWeGNt8cDTR1Wt58bsK3asJacqUbd7EEWkAkTiYStuW2RYVqvHjxnZYmw7C0
         X3/xoUXHa2YZVxqNeBhguxehCwLDf3Q4V0NmskbBsC3/F7Hzzmwl9+UPX0D1etboscBs
         y/fuWj+CAjgFmAaqac1yOGet+PVbD/SDmTgBhJad7MV63qXENqaF8EYc1gjeDIwqkiUE
         AyK/xUU1o45DO/mh4fbH6LbibxrGPK2eKoZEpjqmhVVnnLbynTrWqwy+CzULGHHNC+Wg
         vzBw==
X-Forwarded-Encrypted: i=1; AJvYcCWV8zPeD6WznZxZfpWvA2v7MXlIfRY/tgqY1KgDklEgn3n1cAltWykqlE8IySoW48pNyqAWd56GyllH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp42a6osF1T4NoPLZQB6TGCEhn6HpE1qQ0srnz2xw+U3G/rURP
	IxtPzREl0wYczJqOHz8GKf0jUiroU+A+Hb3iC74GMbIKQFEF0/4sGvpJ1v1mBe+VrEA=
X-Gm-Gg: ASbGncuacbPZmo8CzsAfCxMl5tsyBQz2iWpO27LAwF+Kv5z+PLO2XP/HGc2wzPhYLKd
	bwrvQJIUNB4xER4SzRzjcdC7jeRprVFfGz7i0rhYps6WMaTsts65JyEZE8MaWSI3u9wa8wdix0Z
	53N3tizGpKwTtW30eDmx5p8NdBKgz80jmx4JX6gMxNVtiZSD5HsgEI+qpCAZp9ZGqJlcLfyOCLQ
	f3syjPUT2WAy6we5JDRVypO0QJ2xyACVBVmquH6cFYumJCeqP41ekL3/N4P+j6QpOb4Jim8PjHy
	s+UJEznfaNQcyEdCxZA2YiLVUxV9KJ7fyVWQdYkPxPPbW1x2MLZFSoM9xCq+B7Xggc2PkmrrTzs
	yRK5RY/85PbPHlhHnR+wjNgzYy6JYTEzXg9sZpqwvLvKELACqffOdPB7UkPM=
X-Google-Smtp-Source: AGHT+IGBAJPmxte5sNeC5FD2oABugwlxmnWPA9F/dg7GKYcMncBw9P2DHou91Bjzh8qPzrObW8jwHQ==
X-Received: by 2002:a05:690c:4889:b0:71f:f24f:ccd9 with SMTP id 00721157ae682-71ff24fcd8amr158166887b3.36.1756222901377;
        Tue, 26 Aug 2025 08:41:41 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18fc8f4sm25008697b3.77.2025.08.26.08.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:40 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 36/54] ext4: stop checking I_WILL_FREE|IFREEING in ext4_check_map_extents_env
Date: Tue, 26 Aug 2025 11:39:36 -0400
Message-ID: <716903e50725460894cd1b2591f9bb2cac90a2e2.1756222465.git.josef@toxicpanda.com>
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

Instead check the refcount to see if the inode is alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..2c777b0f225b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -425,7 +425,7 @@ void ext4_check_map_extents_env(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) ||
 	    IS_NOQUOTA(inode) || IS_VERITY(inode) ||
 	    is_special_ino(inode->i_sb, inode->i_ino) ||
-	    (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) ||
+	    ((inode->i_state & I_NEW) || !icount_read(inode) ||
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
 	    ext4_verity_in_progress(inode))
 		return;
-- 
2.49.0


