Return-Path: <linux-ext4+bounces-10504-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (unknown [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FBCBACAE0
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Sep 2025 13:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1383213D2
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Sep 2025 11:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ACE2F744C;
	Tue, 30 Sep 2025 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdjIRcS8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B34323D7CF
	for <linux-ext4@vger.kernel.org>; Tue, 30 Sep 2025 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231701; cv=none; b=UvlviAU1ayOvTLwHLFujiJ0smUZ0X2bFgjxhun5z050jgGTzBznrPTbEta1KeV20cgICV9KEFumRztwULFlzjrGa8KDUevnCuzZxorARz2OTEmP1tvgpR1aKSU5yBXJQtX+AznoC/CKnWDSueKCv+Yq2NDNNepnn+UuWr/PFCLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231701; c=relaxed/simple;
	bh=xpGKX33HVhz8ZAPGj7PMzhiArzG7oak6FVsfs9CP4+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V26BFRVtjCWumJ9tbK2JHAQPomC3b1k4tOg6knVVCTUgANLjbmEmq/rmmXeyC2sGErsdsUDZnUHzkebHbaE6DlDbI0WoeFlXyKVYvJ9M/HDU0AdwIHHAE5BCAcDuyKpFP5RyEXLfotA9iOlWyKQ8I4jLeD2NZg8WWeaFd0RdUPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdjIRcS8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso2711193b3a.0
        for <linux-ext4@vger.kernel.org>; Tue, 30 Sep 2025 04:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759231699; x=1759836499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/VKV+nbSbRPTov6ZqvWq5yIgMw/RxhBVtFHZnlN8z5w=;
        b=gdjIRcS86c5dLPV24aoJykvbK9+gUIFdCSMRoN+6vK42Rxi7khUHUJH/11WsoWjZOK
         l6D3GxvUrJKldv9M02FYmcUZW3XAZKedo+v2gsklM+XwZ+GQvF8DKI5dDcoz5uAfky1d
         Yvn63Y8Tdmeyvnnw9GluloZmbfozsSefqK5VCqPnXG7YhFY/4HPH6qiml7+InCJn5OKY
         +0AGBMKP3O1sdgDfPoG+4eshCgO8B/MG/5PpND93+Mb9AnyuC+nytty4m5Bp+mnpcs4i
         iJ6kw46azXUDZyiPyyFKZq/nolRh8FjP8WNng5kgBdyItln4MKftqwCeV8seZb0e0+Ch
         kyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759231699; x=1759836499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VKV+nbSbRPTov6ZqvWq5yIgMw/RxhBVtFHZnlN8z5w=;
        b=qotQmRgdLCK2uzsVBGcQd/ow7YLAGd1p7rMEHwI3d8jTnqZTcSt7PQSPwOofIUWEVH
         IK10NKdA5h/HW0kYvK39WtXsBYDvwQJcv4MPFKvqibfaV6C9XrgEmT+vATifnHUBOXB5
         6vHIjQ5/Nc5YHxpqpMTz7SU3a2q37s6JiaBMR6A3UGSG+43wcMJQ5i2vcIL0c1S1x4KO
         1XtpRjkT/TympgiV8oA6iSL3Z9RB+ymGNqIEOyfz/ygKMMuh0i/d1tJe4QFE+htyRqE1
         5Hto9cugHYyKaI8ziJioOP6OPSBT+ePKQ3yn64VaIcidqam2jSKo+v1UhdYbewafcIOm
         4ycA==
X-Forwarded-Encrypted: i=1; AJvYcCWDFYa72FTHnTOEEvHQPmiXdyFneJuQ2i6zTGwyjfv0sjZxFwbZ0fMFPLT9eBkeOuhb/xX68XVYmKTT@vger.kernel.org
X-Gm-Message-State: AOJu0YxVMdLkZdnIcrO3AffyS+q65rn/XYONE2wexuTddOX03Rcz8pGk
	ARMzEMMZvZH230W5sW2kPx0juJWlyT7+0WvtY4ySahfFa1fti5/WpqeS
X-Gm-Gg: ASbGncsHdaZ0TalRNyiObFSc3TQcRxmxpkvP9qjt20cAhXJncm0p1AiRwz8S5rQenqT
	8fUGQR11gHRxPsJ4XzlefluxzbkujXs+VyZnumKiY+jQeuja2Rzq3v9DZGpPImlC+KVDO5e6uHB
	ufYmoxfI1t3spogjAv1aDV9A0v4L9ct7WgcD0VwN0MLb+moqQqQTC4AKl20wAqgfuF8/3RhoDfr
	PBTvVFXXs1qeD6F5dQ6IlRFjVXF+MhjEDnEMBM9sj1qfyrmBD8YW3telfqb61PGIFdGFt2Qt0sy
	vNxBx2f1Pgr3Gfh+T2YjLa0tt6FW/yf2oYw8GXtenLrnw4GtDCfcQLGAfAAjXa3I7jBch/zhVMs
	JJlwtnCO4yaD+cZv/vVFYCuigOzonyzrrEz3SMCATUvN8Q65H4HHCWzA2gDhKsK9WHnmdogvmCP
	y3iAj/dLTk3FDxReDbxERlyVaVHsY=
X-Google-Smtp-Source: AGHT+IHrF7KFiBFqaAo0Ir95oeKErASYOopPIaKwWlP+6zsfNJud9pHRtZvuS63LRq6/HuS4rhveLg==
X-Received: by 2002:a05:6a00:bd11:b0:77f:50df:df31 with SMTP id d2e1a72fcca58-780fced6abbmr16235788b3a.20.1759231699173;
        Tue, 30 Sep 2025 04:28:19 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:91c7:6bc1:acf5:6b87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c057e0sm13550391b3a.78.2025.09.30.04.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 04:28:18 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: yi.zhang@huaweicloud.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com,
	Zhang Yi <yi.zhang@huawei.com>
Subject: [PATCH v4] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
Date: Tue, 30 Sep 2025 16:58:10 +0530
Message-ID: <20250930112810.315095-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a BUG_ON in ext4_es_cache_extent() when opening a verity
file on a corrupted ext4 filesystem mounted without a journal.

The issue is that the filesystem has an inode with both the INLINE_DATA
and EXTENTS flags set:

    EXT4-fs error (device loop0): ext4_cache_extents:545: inode #15:
    comm syz.0.17: corrupted extent tree: lblk 0 < prev 66

Investigation revealed that the inode has both flags set:
    DEBUG: inode 15 - flag=1, i_inline_off=164, has_inline=1, extents_flag=1

This is an invalid combination since an inode should have either:
- INLINE_DATA: data stored directly in the inode
- EXTENTS: data stored in extent-mapped blocks

Having both flags causes ext4_has_inline_data() to return true, skipping
extent tree validation in __ext4_iget(). The unvalidated out-of-order
extents then trigger a BUG_ON in ext4_es_cache_extent() due to integer
underflow when calculating hole sizes.

Fix this by detecting this invalid flag combination early in ext4_iget()
and rejecting the corrupted inode.

Reported-and-tested-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
Suggested-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

---
Changes in v4:
- Move check to right after ext4_set_inode_flags() as suggested by Zhang Yi,
  since we're checking flags directly (not ext4_has_inline_data() return value)

Changes in v3:
- Fix code alignment and use existing function/line variables per Zhang Yi

Changes in v2:
- Instead of adding validation in ext4_find_extent(), detect the invalid
  INLINE_DATA + EXTENTS flag combination in ext4_iget() as suggested by
  Zhang Yi to avoid redundant checks in the extent lookup path
---
 fs/ext4/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..2fef378dbc97 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5348,6 +5348,14 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
 	ext4_set_inode_flags(inode, true);
+	/* Detect invalid flag combination - can't have both inline data and extents */
+	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) &&
+	    ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		ext4_error_inode(inode, function, line, 0,
+			"inode has both inline data and extents flags");
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
 	inode->i_blocks = ext4_inode_blocks(raw_inode, ei);
 	ei->i_file_acl = le32_to_cpu(raw_inode->i_file_acl_lo);
 	if (ext4_has_feature_64bit(sb))
-- 
2.43.0


