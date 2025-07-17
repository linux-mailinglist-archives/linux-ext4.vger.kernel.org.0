Return-Path: <linux-ext4+bounces-9034-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6FEB0856E
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 08:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE55D3B8689
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 06:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DB321767C;
	Thu, 17 Jul 2025 06:51:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from omta003.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD331C8603
	for <linux-ext4@vger.kernel.org>; Thu, 17 Jul 2025 06:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735078; cv=none; b=UjcyKYuBCyB6o0qHktNWBq+ILSbHmr9tFnw6owO1UIoEvA434JR0u2FbjsOZTPB2qvVNBCGZOKZ2lw9rBbRNY8NXaW26z8euE9b0WLU7v3V8mKFLNse7y/+sIqs8gkHUmVx1Ntrlqvl1AWV5JAwHBXU8Rk/QBLvcdN1v2GHXezM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735078; c=relaxed/simple;
	bh=+3fljAVhqmaP/I/vqZ40yaZbz++E9+lF+uywIgZesc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qRSLzOsq+HLAznikJkyjAaDnhz0UAeOV/HGkVPi9Ytl4rhZkPuBKpEL7pH/n3XId2bzdaJpgt9rA8HFbaSkIXxLD0JZA4WEcbtW+Qn+eFOdIeuUB8rZ/cyp4ODszL9bIAKzIj3UzQyeyW/2FDA99VgauGEclunvt5EcIA+S6WN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; arc=none smtp.client-ip=3.97.99.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTPS
	id c7OwuFWUz9JM2cISWuQlbt; Thu, 17 Jul 2025 06:51:12 +0000
Received: from cabot.adilger.int ([70.77.200.158])
	by cmsmtp with ESMTP
	id cISVuScCzl5eGcISVuPrWQ; Thu, 17 Jul 2025 06:51:12 +0000
X-Authority-Analysis: v=2.4 cv=EO6l0EZC c=1 sm=1 tr=0 ts=68789d60
 a=0Thh8+fbYSyN3T2vM72L7A==:117 a=0Thh8+fbYSyN3T2vM72L7A==:17 a=ySfo2T4IAAAA:8
 a=lB0dNpNiAAAA:8 a=wCRtAoIVXn3TDt3nw74A:9 a=ZUkhVnNHqyo2at-WnAgH:22
 a=c-ZiYqmG3AbHTdtsH08C:22
From: Andreas Dilger <adilger@dilger.ca>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	Andreas Dilger <adilger@dilger.ca>,
	Andreas Dilger <adilger@whamcloud.com>,
	Li Dongyang <dongyangli@ddn.com>
Subject: [PATCH] ext2fs: fix fast symlink blocks check
Date: Thu, 17 Jul 2025 00:51:03 -0600
Message-ID: <20250717065111.828535-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDgzxQTMyxYAaNR3FlfAKQ3h7njkFQP4RozFcFkUg2aqikUnfeIKVc0K3wOIyER6D41nGbBNJiLPNkw8lRTlGOmPFdWDzG+tBG3q5BbllFqDVfgsJPRF
 BftMmYzXO+P4BYA91rj9/y1XeWooy0D7DlifJ0Jz3jpO8yafbhwk7cTV4P9CF/QwGwiWyoFQTzKFku0NnJHMqLwrBRMOt/z+dD1KcJVZcf0VBC3dUCD+Qjyg
 t0XsJRfJlpUbv1erX4Y8AUuV6z3ukOf25nLC8UM8MJIWnL+f9CI0kMxbUwq0ZLH5FcxS7ONeOtDeIwwg5ZSECQ==

Use ext4_inode_is_fast_symlink() in ext2fs_inode_has_valid_blocks2()
instead of depending exclusively on i_blocks == 0 to determine
if an inode is a fast symlink. Otherwise, if a fast symlink has a
large external xattr inode that increases i_blocks, it will be
incorrectly reported as having invalid blocks.

Change-Id: Ibde2348da39401601abedd603bd7e4ef97091abe
Fixes: 0684a4f33 ("Overhaul extended attribute handling")
Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Reviewed-by: Li Dongyang <dongyangli@ddn.com>
Reviewed-on: https://review.whamcloud.com/59871
Lustre-bug-id: https://jira.whamcloud.com/browse/LU-19121
---
 lib/ext2fs/valid_blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/ext2fs/valid_blk.c b/lib/ext2fs/valid_blk.c
index db5d90ae4..332e9c66a 100644
--- a/lib/ext2fs/valid_blk.c
+++ b/lib/ext2fs/valid_blk.c
@@ -43,6 +43,7 @@ int ext2fs_inode_has_valid_blocks2(ext2_filsys fs, struct ext2_inode *inode)
 			/* With no EA block, we can rely on i_blocks */
 			if (inode->i_blocks == 0)
 				return 0;
+			return !ext2fs_is_fast_symlink(inode);
 		} else {
 			/* With an EA block, life gets more tricky */
 			if (inode->i_size >= EXT2_N_BLOCKS*4)
-- 
2.43.5


