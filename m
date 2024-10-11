Return-Path: <linux-ext4+bounces-4570-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA7999A138
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Oct 2024 12:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E8D28557C
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Oct 2024 10:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3986321265D;
	Fri, 11 Oct 2024 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n8isfaSX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D48210C2C
	for <linux-ext4@vger.kernel.org>; Fri, 11 Oct 2024 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642300; cv=none; b=YvMO+w2oWtSawWk0Q/FmYvg8RiBOCSGEtQ+PuFMMah1sO4UxwrdVWiMCEvFFIh6bexCmc+0bhC4LdkxI9dOMc8F8tfIlZfDV3yrbe+Wbv68nVExPYiJEAmZuoWvU0eGfF5LP1orr6UwcsEDXJISMksWl2yr6octy4dTuuPH5OOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642300; c=relaxed/simple;
	bh=lNmpjyy3NbJcexF0zfFZIhkhxowSBnVHLFNaeSt/6QU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XRehJfHl3+I+2pzFFKF8xTBzYGmgv1JUeS9hBgZXnc3aEJ6125o6Gbrz63V6iyxgMPKaisAyLZBpqogElhQLbyzrfBTcidAr1yr7Xt0K3DDSvsJF0ybp7s888Nu+Ah1WnmA8GmJJG9ej3ZGK87HV+nV0bEJ/c1cEgD7hQ8uiJmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n8isfaSX; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728642295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OPU/lolIfM/2nS2HuFVcR3b/p8zFVUIDLipi7/SZskY=;
	b=n8isfaSXaEpZcvLvJbBh9V/W7aNpxzht3LjGPjDhU6QskNsvtivWkDc/y1t9ndT6MGbZjE
	zHPz0nUa6cYus+wMpHrsD984iDLXics9C6wKiu7vue47N1ihicrlu0wbQj7peHOH5a+qUr
	2VBZpS8qsTGTnfLBE1XP+5B+osLkYew=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [RFC PATCH] ext4: don't wipe data when reading inode with inlined data
Date: Fri, 11 Oct 2024 11:24:45 +0100
Message-ID: <20241011102445.13305-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When a filesystem has inlined data feature enabled, the ->read_folio()
callback will need to check if the read is being done within the range where
the inline data actually is.  Since the inline data can only occur on the
first page, this verification is done by checking if the folio index is
zero.

However, if the index isn't zero, this callback is also zero'ing the folio,
effectively wiping the data that was there.  This is a bug reported in the
link bellow, and the reproducer described there can easily trigger it in a
filesystem created with inline_data and a small block size (e.g. 1024).

This patch fixes this issue by falling back to a regular readpages when the
folio index isn't zero.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200681
Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ext4/inline.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..d2e519920252 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -516,22 +516,18 @@ int ext4_readpage_inline(struct inode *inode, struct folio *folio)
 	int ret = 0;
 
 	down_read(&EXT4_I(inode)->xattr_sem);
-	if (!ext4_has_inline_data(inode)) {
-		up_read(&EXT4_I(inode)->xattr_sem);
-		return -EAGAIN;
-	}
 
 	/*
-	 * Current inline data can only exist in the 1st page,
-	 * So for all the other pages, just set them uptodate.
+	 * Current inline data can only exist in the 1st page; for all the
+	 * other pages simply revert to regular readpages
 	 */
-	if (!folio->index)
-		ret = ext4_read_inline_folio(inode, folio);
-	else if (!folio_test_uptodate(folio)) {
-		folio_zero_segment(folio, 0, folio_size(folio));
-		folio_mark_uptodate(folio);
+	if (!ext4_has_inline_data(inode) || folio->index) {
+		up_read(&EXT4_I(inode)->xattr_sem);
+		return -EAGAIN;
 	}
 
+	ret = ext4_read_inline_folio(inode, folio);
+
 	up_read(&EXT4_I(inode)->xattr_sem);
 
 	folio_unlock(folio);

