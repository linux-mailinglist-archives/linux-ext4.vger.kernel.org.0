Return-Path: <linux-ext4+bounces-2521-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AF98C62E3
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2024 10:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7CC1C20444
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2024 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA654D9E0;
	Wed, 15 May 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="clt3jbDv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB15E4F1F1
	for <linux-ext4@vger.kernel.org>; Wed, 15 May 2024 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715761746; cv=none; b=gANVTHzKpJWT8QMw5q5MTLVgNBbwGJe70BJX90n10f2kJ6GbfApd6m4c8XmRoJ6AYGBEG1pqdrPlklnmKGTR0kBn6Jq7Gu/Gu12b/AgHaobdHjYyZlUtOpd4Lc+86YPx2KDS+ymKq0NdhnvE75V9YkGiZTKorPBqTTvh1t//wX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715761746; c=relaxed/simple;
	bh=GRy5EBqyOSgFzYOwDEtJf45D7LNOsyCxMbOV7SdxB6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TOaliRnQgImRw1qgqhWrzfFfMTe6uABv0pfDii0+ciX5kZFD0ut3Cdo3a/kaA6Se3DDRiY/94/PtLwQa7513QLGI65jPRyXvqaBQ8WJ4aYKOKMJBX4JGxLnAMt+x6ZEVtohgyDIHZT5SN5BlYzeqDw+Y3z7pFjUYv6oLPHN1rh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=clt3jbDv; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715761741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HYBLWkWoaQKiEAZWraoUP+5u1JtAI4hFJMaHd418eeU=;
	b=clt3jbDvFUaWWMfNqOMYMVmorC+WrbeA5JAsXYDcp0eCJUBCmxzJPxNZFcjdir7H+MShfw
	gRWIgpXRYsQ64b5sOMEiHaoxe5sdwOidcKL6/b5oUZTGW2auvJZPfwRYLFvueDIM+zV9UH
	raMjX8rno7YscEUmcPRwQrif1Zk8/hg=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v2] ext4: fix infinite loop when replaying fast_commit
Date: Wed, 15 May 2024 09:28:57 +0100
Message-ID: <20240515082857.32730-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When doing fast_commit replay an infinite loop may occur due to an
uninitialized extent_status struct.  ext4_ext_determine_insert_hole() does
not detect the replay and calls ext4_es_find_extent_range(), which will
return immediately without initializing the 'es' variable.

Because 'es' contains garbage, an integer overflow may happen causing an
infinite loop in this function, easily reproducible using fstest generic/039.

This commit fixes this issue by unconditionally initializing the structure
in function ext4_es_find_extent_range().

Thanks to Zhang Yi, for figuring out the real problem!

Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ext4/extents_status.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 4a00e2f019d9..3a53dbb85e15 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -310,6 +310,8 @@ void ext4_es_find_extent_range(struct inode *inode,
 			       ext4_lblk_t lblk, ext4_lblk_t end,
 			       struct extent_status *es)
 {
+	es->es_lblk = es->es_len = es->es_pblk = 0;
+
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 

