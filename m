Return-Path: <linux-ext4+bounces-9532-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFDFB306B4
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404731D23EEA
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F58038FDF1;
	Thu, 21 Aug 2025 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KgEv9jqG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1B438FDDF
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807665; cv=none; b=aNHtGqoIDjmmCyU6IfgaNHfYKVvixPHQJUqA2yCjDt2OU3lQQpks3NKZdIXiDlLmNF1J8jzxutYyy3U+so0ZRWBq44rhkXNdKZTS/Lox+NupmJaeOM3yvI+ODVos2q+MsGbBxXZc09cV3x2IHBgLvpTOcoeciJg60ULy8yGWE68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807665; c=relaxed/simple;
	bh=to9lRi/o+/xXxHd3B0bfDtijVgiwZ6hVm+a/w2vBauM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtuIFBERFyWb1EScV7RD3noluwMXNu/X138TTINaZIgOzSYMqvRDNoGizOiFZyEk6ixq5nQxhiH4dUYSFsoLjDAS3oHogXo/kwibIeg7jH4I7GUo/bRZO1vSepFnAVBWnKqYHhMAKYLLjFhy2K383o/Ls9saev/NBc34+k7VBjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KgEv9jqG; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e95026b33eeso1473550276.1
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807663; x=1756412463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIC/ISbalbO5T/gWKTH4VAVcp4NvscnrAnAnWHhl+Qc=;
        b=KgEv9jqGg8T2pn+HpxC+hny71QYE34dJL+VJce7Q1S/o4aRViTxUd09LwfNzAPvyrg
         lrsZfsH6zs7jsPMbqlvxbCyJtTJqCIWBOBAk4avk04hBns4zQSJZCE77p0rYBfIbwTHL
         e5fsvMNJsC9hifkpsJ1jsLLjxOCJNKI5R/LU0669EiV0m5OZ4nTAYbSJETnFh0oH738k
         ng0fFPekDz7P5zFNAvwTqUQhKMKCU9sKF8B/I3w+PQ+9ehjsgMi6Lk79W0yOQSIH0T6h
         qWs/52VTV5r0IVeYHjti+1q5suE07JTd6kMDCGN21yKJNUsJ+OQLtOeQVC47IzJSr4QH
         hppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807663; x=1756412463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIC/ISbalbO5T/gWKTH4VAVcp4NvscnrAnAnWHhl+Qc=;
        b=PFB7i4EVF3fcNxAZRTdL92AYevOVrU0eKnr8h9sEs9iwp9V7E2G1c1c974WDIyElpJ
         J7YK0K/d1wJAugxMNkW0QcK50Dpo+GO37e5T0BHokVeyV/7DSTfphbJxLBwx5D7IpfaX
         /3/IWwYfDVOp60BCZjqfTyHLCyqUiLQednsD+Ar/vtynmfDDgTct0p4vUheKmE8NxssP
         tN/zebz+Rjrr44q9HLg0/Ii5M+SytME75YbBonlHgxdScCR2C+CEZp5+i3+/ABWsjLV1
         IyzbSrbYH2ki8vizetsbTRJXe85kmO79+DtyZJ5vddWwraoe4Z7PuZw1EcLakeEJt0Rp
         To0A==
X-Forwarded-Encrypted: i=1; AJvYcCWgioErD5x0Pjr+BJh7SX1FAlQumRexHeh7IoA91DHL5wrkoN+9rH27yGTZRg79+Qn/SD6DvM7FH3qP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8Dv5lYH3BgMgaAVI22bO0o16uoHHs09HNIIwTaw/PaASQdbz
	ODbv60YfIYMkPgTdDHDnJM9Td7Nj3MCRRfz9K40mO+yY/DMFuWp2YkMmxVCHxbzZvXY=
X-Gm-Gg: ASbGncvCjbhV6hSt+KHVx7c05XC9pmrQubRYSBjpdAeJ2pP/QrbLHzTc6Npf7dxs0ES
	IqwBmiwvbVkQPE12cr5kuNbIXxNewr7E4+xwl9KZuQcdUjCKjaJl9ZNzQEmANpvW6y6IGL5T63u
	5+dH2JayZpc5PDrmGJ6jSVyO4BYqGfWhTWLNUAARSajmQl38OMr1SSk3c6D9jlqR18hegOv/5aX
	MaA9sCaGZhyUN5uEiciWV41cavHNlQr+xXOsWDjCKV+J6Up62FDZZeCBq8AzxqueLlBbCTss3zK
	Em8/PFyjo1k744az675fxhH4iGI5qI0MDLFhHSIc6x+jrVM+ZvPUnpv549xvu+O81LuOskLr0sG
	NJgeuwjCidQN+P0NX+DFXQ3TDlTcG4JSVM5tJHrJwNMipudSYEWU9RbWM5gKTxwX4FiCf/Q==
X-Google-Smtp-Source: AGHT+IH46jygWYnTlpj1UoKEmKzHBIHOl1cf2I1tXvSwkzuUG5h0TlajXJST0yFzWjVJ/MCztTkBPQ==
X-Received: by 2002:a05:6902:1891:b0:e95:11d6:258 with SMTP id 3f1490d57ef6-e9511d6033cmr3195120276.16.1755807663175;
        Thu, 21 Aug 2025 13:21:03 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e951cc79b06sm121716276.33.2025.08.21.13.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:02 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 31/50] btrfs: don't check I_WILL_FREE|I_FREEING
Date: Thu, 21 Aug 2025 16:18:42 -0400
Message-ID: <a7e18e602e704e65c6e875fa84bee6c61fb36a07.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs has it's own per-root inode list for snapshot uses, and it has a
sanity check to make sure we're not overwriting a live inode when we add
one to the root's xarray. Change this to check the refcount to validate
it's not a live inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e85e38df3ea0..03fc3cbdb4af 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3860,7 +3860,7 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
 		ASSERT(ret != -ENOMEM);
 		return ret;
 	} else if (existing) {
-		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
+		WARN_ON(!refcount_read(&existing->vfs_inode.i_count));
 	}
 
 	return 0;
-- 
2.49.0


