Return-Path: <linux-ext4+bounces-10488-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1453FBA9767
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 16:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89481C2E96
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 14:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6D13090C4;
	Mon, 29 Sep 2025 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGRcIS/3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C34308F3B
	for <linux-ext4@vger.kernel.org>; Mon, 29 Sep 2025 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154446; cv=none; b=rgpUFkGTUxAvL8KxpRBhvW86SItMycxCRfzcvGiytF/uOq/jNk0ixbxqAY6Ak36RAtr1B/BUpUDNg4+m+njAcMCVFNHbjJLGR3f7bVM/+HbcII10Y+TD1g9DlsEFXpzy6Wq0gj+NUc17HEVbq2sg0LseWBr8R8MPZdsmO/6VP7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154446; c=relaxed/simple;
	bh=L3hhvqA/El0jd36qHGLM1VYJVkRhpNs+PRg1E92fOMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tp+fWc9TcSSY4h43c6Ir2a1l/Y13cPKRRYZmXQjE6W2B0Dd5dMpzoKqDOrPegkT8ue+yDlZ7QvPW/sYpDmRxHMpYlJ9Tuw1ZtusvuOChLyw/6OhaHHwtoaB7Lb1FWi0qC8dIc0QXtG9r17JZqrQ7lovRmAKD/gTudONDFUZuzxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGRcIS/3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-781010ff051so3184253b3a.0
        for <linux-ext4@vger.kernel.org>; Mon, 29 Sep 2025 07:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759154445; x=1759759245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aR+9721anmN0NfZgwpWwYRBIe5Rks3tZnJySwmuBqqs=;
        b=GGRcIS/38DrR1WOnQv7EdIINFaQDXqav3Lau5cQGrkW8UdP5NNXwwxt8W3aHBG/zhD
         qfUWc9Twk3pmncBZqsCW13dcqMqzykdaTpeiSpZkfDoq7v7qjJ4ydYwx7hMnGVQ+MhBj
         H6kysqnWU27J8TmDqpb+EdY2AGx0s4y6uBlK1SLZViAQXglfRJ72oj54wmROT5q8NUxg
         cPt26feDWjgJvwPJqpGo/S0CIR+2h+Q5+SWCXzZJjDp896G27nPD9axr9gF95+8jLhB+
         u75V/hJbf2TdfGcBKCG4i7DeaxtxNt427B1xkN1iNdEHOwoTlIc+JvCxvqpu0nMe8XXo
         dwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154445; x=1759759245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aR+9721anmN0NfZgwpWwYRBIe5Rks3tZnJySwmuBqqs=;
        b=jKh3d0mQERpusbawKDt68rA0RyO1mTdoo+skWdixTj68NsF4wNFmQDwAJ4VzpJxDeC
         LB0bBMQrBRV/bF4RPV5G5xMzXYON2JvIGv6aeHGw3OQHAxJrS+kPbdRZ3Q4MRRCu/R6+
         XNOIgyiEHEc6c6PdWuywpuWD50rxvLiTcJiQovFD80RaEGdC6D4nslSgOFY4REI7atfh
         nG9m6phelpXtvXlxdICj75hxjAE7N6l0a3oHGVMBKG25bpCjOqgcSdRvfs8UjPSnDeHP
         R7mAVrLL1v8IDGBbsxyKOk+R+9XFX8wLd94JpeBNbGQgyMu3kJt7EWSRtyI3fHPrBsqu
         CL3A==
X-Gm-Message-State: AOJu0Yxpoo7yiyEVnJH9+y0SIQf8weaYDQvdOVkoxXqkdjch432Gk6oa
	4fUXWN3mKsnglNVD9U3kR5nM5l8OeGPRqluQ7pcDX3CiuqF+gvGKyvpL
X-Gm-Gg: ASbGncutMAhGrwi9iz1E8kHSNbRgwcI1JaGDPIokni04Az2kbhFSSxr+zxWRD1DG2Eo
	FeM1F/S778GyCgFQe1mlQuU1F8MPf06cYgovOUISxMBNMvACsndigaATD+/oGogjITvThrAQ247
	+ls9eWf7RCa0dYHUKj22GfzAwV/1uyQnnMbwqnmqXlMoyOQ8jeXaTQw6e+KuM2ii9JLOuXyU1Un
	+qIfBQKrpPJcHGDINs3a+1WgA6lxoDl6BxJ4LkPyH0BKz7ATk/6rvNZJ1V/aMiZOIejVN5FkYXe
	HbIew4Unoksr1cnwgaxGzelHkivZtrVIJoq/NXhEbFa7bvXW7BPVzDznrx9k9AjrGGeZmkwJ/LP
	BxP16JRrYPDaxzEK608obYPRamhBmsuA2H4OPeQnk9hv/FAynxES+ZqS2/ZOO2FHwHE1L33Xh8Y
	coOaGQFhR75VT/Pw==
X-Google-Smtp-Source: AGHT+IFyEzVLBvCaooSzhsbGe6NUtoHLRegynxWuFI3ToSvZIgdKofrC23BninBk1aBm7R4wrSgf0A==
X-Received: by 2002:a05:6a21:b95:b0:2f5:e435:4066 with SMTP id adf61e73a8af0-2f5e43564b0mr13284239637.44.1759154443044;
        Mon, 29 Sep 2025 07:00:43 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:2b82:239a:7350:ef6b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c8aebsm11165375b3a.28.2025.09.29.07.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:00:41 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: validate extent entries before caching in ext4_find_extent()
Date: Mon, 29 Sep 2025 19:30:36 +0530
Message-ID: <20250929140037.354258-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zhang Yi,

Thank you for pointing out the validation issue and your concerns about redundant checks. Let me provide a complete explanation of what's happening.

## Initial Problem
The reproducer triggers a BUG_ON in ext4_es_cache_extent() when opening a verity file on a corrupted ext4 filesystem. The issue occurs because the extent tree contains out-of-order extents that cause integer underflow when calculating hole sizes.

## Why ext4_ext_check_inode() Doesn't Catch This
You correctly asked why the existing validation in __ext4_iget() doesn't catch this corruption. After investigation with debug code, I found:

DEBUG: verity inode 15, inline=0, extents=1, test_inode_flag_inline_data=1
DEBUG: First time check inode 15 - flag=1, i_inline_off=0, has_inline=0  
DEBUG: Second time check inode 15 - flag=1, i_inline_off=164, has_inline=1
DEBUG: Skipping validation for inode 15 (has inline data)

The corrupted filesystem has inode 15 with:
1. EXT4_INODE_INLINE_DATA flag set (test_inode_flag returns 1)
2. EXT4_INODE_VERITY flag set (it's a verity file)
3. i_inline_off containing value 164 (from corrupted on-disk data)
4. Out-of-order extents in the extent tree

## The Validation Bypass Mechanism
The validation code in __ext4_iget():
} else if (!ext4_has_inline_data(inode)) {
    /* validate the block references in the inode */

The ext4_has_inline_data() function returns:
return ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) && 
       EXT4_I(inode)->i_inline_off;

Initially i_inline_off=0, so ext4_has_inline_data() returns false (1 && 0 = 0). But by the time validation check happens, i_inline_off=164 (loaded from corrupted on-disk data), making ext4_has_inline_data() return true (1 && 164 = 1), which skips validation.

## Proper Solution
You're correct that we should avoid redundant checks. The proper fix is to detect this invalid combination early in ext4_iget():

if (ext4_test_inode_flag(inode, EXT4_INODE_VERITY) &&
    ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA)) {
    ext4_error_inode(inode, __func__, __LINE__, 0,
                     "inode has both verity and inline data flags");
    ret = -EFSCORRUPTED;
    goto bad_inode;
}

This addresses the root cause without adding overhead to the extent lookup path. I'll prepare a v2 patch implementing this approach instead of adding validation in ext4_find_extent().

Thank you for the thorough review that led to finding the actual root cause.

Best regards,
Deepanshu

