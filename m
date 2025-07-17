Return-Path: <linux-ext4+bounces-9039-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CA9B08E3B
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 15:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9895A07D3
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 13:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20262E542E;
	Thu, 17 Jul 2025 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUgtp7KF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA32E4995
	for <linux-ext4@vger.kernel.org>; Thu, 17 Jul 2025 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758894; cv=none; b=orsxCoudm0X//TfPpm8mLrZ4H7kEHF0RvXwmyN2KZmz30CTyzWmWXgZ2h51o9HicI8gIHKOu1Xi/nIKOXCV/IoKe7d4KN4/mdMHEjAed/+B8hF96kwDeu0zxHsJwvnjtVdYdllgQ+DH+reCsybvrxFGYD3HpOw2LXNgoY9EQY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758894; c=relaxed/simple;
	bh=tJJ7U85RGnyP9AbgmcRrLFxlZGEV2XH87oLijc2hQWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z2y4evt/fFFi/lLUCB4w9Rt6eCjggqF5jsIVKVvdgZR+2Tj0+s1yQZkVH8IalorlU1Mgdg99fYp7la9GFHxoD1o5ypQiHz33lOJtrV8/QmJ7n+S5/eBqELuD3oxx31j8fSO7ZaMLABbjAifQ8Y5r1UZRkNCjUlnoyRRMXcjvY9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUgtp7KF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so1418115a91.0
        for <linux-ext4@vger.kernel.org>; Thu, 17 Jul 2025 06:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752758892; x=1753363692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tc15awIAhSFI6KrnEFWf7aXnjLULAqSIEpO0kmcBKQ4=;
        b=DUgtp7KFdKCT1CVbiYuKeoi5iIcBXzEJQLpGJJOaHdlnU8VUqvuV3/sNHZ1ew2qENB
         HaLPdlwgzi91c+fSjT1Qim7i1rO6Z6xNovJsozZgxv2tidYiXlLKezk9Sw9h9XfvBHoh
         JqY4EJW1LpcKJ4A0Nxh7ovdv2ZiPe5iIpLJgDujJ1MkCT0h8lnPI39+xU9C0CGCuVcrM
         iWXqSO2SGrMjZYCzji5N2kUHY8txizihUIEOaSbL/OdvBjZQxJ4RF17WJttMznl4A6w0
         168SA8ZsnFOOy0km40IZpe9MCcnmos1W0G8Z+sgs/qadggh1kUP1Bi+s/CuAyskoGNKA
         shQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752758892; x=1753363692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tc15awIAhSFI6KrnEFWf7aXnjLULAqSIEpO0kmcBKQ4=;
        b=ZKgCGJ4gz8kY+LhjP0T9PBRX4gpt1TWckLZODgmsHQ+8f291MwcHAC2ifhpRiT7Qly
         ud8iHPnjXOI1wcNakANdAJYuCxgJxXUDmuDgA9m/lplXG7Yrsi7ZkPmf37vI8Q9cfsNW
         iTYLQSdTa6EhugR917BRNOneO8g3N9yn3/t9D+sMPfSJljdNv5FNpE2kKToA5Lem2XVk
         XA+jloQ5ADNmPcc2n39WdUednCnLUPmest3PpsmfYUShap/rp4A3yyqIdeu/uz9riXey
         ATNfcQJvr/pUL15PqK4bXAObJfUD0S3I53kaFMqZxTNF6KyjEmLO1AphHqvPE9GPqDSM
         JOsw==
X-Gm-Message-State: AOJu0YxGM8C0oU12M7Kj5nfpC0CcNxj/goYzJ1xPNAHNh2Sqx6aKa4yh
	6dBY+1CAq3JE0Z+jg/YYBJdYJlx67k5+4NAo+aXigRsETrEfvkJP9Zvr
X-Gm-Gg: ASbGnctqE2Ny5/0Mb6XFjp6l2WuCf0XM0khDtUYxkwKPUB2DK0yT82JCmYbKjcuxN8U
	YaW+aQ9S8X1MRCUbgfGi6K4l2bhRq1pkfC55gtr3NA4Qu556B5zSvGbiyU/HMmxJ8ua3KXMtZlj
	gCPFXNj7+MKqyPZCuYfEBR0aH5XY1NKnI3uiW0QY3mtIB+7IHiFfE71HMp+bWXMR7GoyYdORGs8
	04gs+hxn/1r5OXs+oxZRUntNA6r7unGA8nCFiuTrnMovMeO69YcT77ul1UZqvYBOcJhGBmo3u2l
	rvR/w/dKNsUinyvfI8JqArQc+hZoUMjLx2wVDslZW2Nt84+9kKGt8TZeeDduxlc2imeIfboRgAX
	HrMUiDvx4JCwjXjHnb2h75MI+qhqmAbhqWLITTc8HUKhZFvSECbWLxOnAyo6o7g==
X-Google-Smtp-Source: AGHT+IFsCWCLGjQs69eNZI0bQMGEpT9xEWcBEBroc3y+lLKtZdTtMvnAnjmHTIMYG4ibpXn+e+k3CA==
X-Received: by 2002:a17:90b:4f4d:b0:31a:8dc4:b5bf with SMTP id 98e67ed59e1d1-31caea3feaamr4777590a91.17.1752758892037;
        Thu, 17 Jul 2025 06:28:12 -0700 (PDT)
Received: from DebHP.lan (67-61-129-104.cpe.sparklight.net. [67.61.129.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf8060adsm1567888a91.35.2025.07.17.06.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:28:11 -0700 (PDT)
From: Nicolas Bretz <bretznic@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	Nicolas Bretz <bretznic@gmail.com>
Subject: [PATCH] ext4: clear extent index structure after file delete
Date: Thu, 17 Jul 2025 06:28:05 -0700
Message-ID: <20250717132805.813944-1-bretznic@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extent index structure in the top inode is not being cleared after a file
is deleted, which leaves the path to the data blocks intact. This patch clears
this extent index structure.

Extent structures are already being cleared, so this also makes the
behavior consistent between extent and extent _index_ structures.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220342

Signed-off-by: Nicolas Bretz <bretznic@gmail.com>
---
 fs/ext4/extents.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b543a46fc809..79fd3f5d4c50 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2822,6 +2822,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	int depth = ext_depth(inode);
 	struct ext4_ext_path *path = NULL;
+	struct ext4_extent_idx *ix = NULL;
 	struct partial_cluster partial;
 	handle_t *handle;
 	int i = 0, err = 0;
@@ -3060,6 +3061,10 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		 */
 		err = ext4_ext_get_access(handle, inode, path);
 		if (err == 0) {
+			ix = EXT_FIRST_INDEX(path->p_hdr);
+			if (ix && ext_inode_hdr(inode)->eh_depth > 0) {
+				ext4_ext_store_pblock(ix, 0);
+			}
 			ext_inode_hdr(inode)->eh_depth = 0;
 			ext_inode_hdr(inode)->eh_max =
 				cpu_to_le16(ext4_ext_space_root(inode, 0));
-- 
2.47.2


