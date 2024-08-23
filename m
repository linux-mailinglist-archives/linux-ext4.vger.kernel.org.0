Return-Path: <linux-ext4+bounces-3872-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA11295C2D5
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 03:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65770B23ED7
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 01:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFB1179AD;
	Fri, 23 Aug 2024 01:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtsEQaCf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465F918026;
	Fri, 23 Aug 2024 01:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724376834; cv=none; b=a/5ohvKqKQepQyaP4dKxwMIYyKgRUrIF5DT1z865w3H2LKmxxRU0RMX/xYaY+RxHNoqDRAFhwtk1ZR7kDMiVJp+7lDu1dwqitC/fSqlu+M5EX2emwB/uWFW9qq4WvWFQpmLoCqe601hC0F32BcwSrcbaYeOzSRRggttyBwSxILY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724376834; c=relaxed/simple;
	bh=0WlnbUbywMlrOU0D+DJrGdpenE8YXpvOJj09FJ31cik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rjIlT9qz63vo3Q8bSxP9IXWV7otCmzQfkT07sclfY8T9Cra1Wx61ByTvIOTyaRp7KyuaPjGQgHlCFsezGczyvbeadrjix/BSqbuNhJETpUfhvGqmFf3x7d+Hos3lNFwcNt2YsZKw0RniAGA4iKo5cYToN5aHsqzWBimZMfsEmXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtsEQaCf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso1724769b3a.0;
        Thu, 22 Aug 2024 18:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724376832; x=1724981632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V5wuJYlgCQKhRNGnYnU1FSzag4oVX5g/GtA3GwfnsCU=;
        b=AtsEQaCfKy+4QVITGR0XfRu2i8Mak5JVrei10J3QOxQk3K+SE2lZfZzlIxug3q6HP6
         Cc6Z1KvySTcoLk0mt07eQ8vGAolrqQ6swXC1Uoe9k2Z2PgpiSEj2dspBRVgya+nNmG4a
         e9QKPCJfFkqVQUePdFuv5iF2WxoWwAlOyn3aCS0Y7kJPXufXBLgEdiyK/+MHrkszbKyk
         7/Q6Ae25yXTPGAi1OuUNo7pEwDLqeyeoL1jX/31NCC7vgnxZVCgYHhjD7v1QZU0/RkOL
         B2+y0Y2K/e2Z1DeCtucjVNcXiCoL2rh+rPDcqV5qVNB+e3iIhwV7d49IrNhmQ1q9IlzA
         jNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724376832; x=1724981632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5wuJYlgCQKhRNGnYnU1FSzag4oVX5g/GtA3GwfnsCU=;
        b=ObMS66aURc1xTs5z3rc1PT2o585ZVCQCId5O4nOBJuuKLj5AwdPL1mA8K0tnkyZkcz
         FBkaFoJ9tOEBCp9dvKCqOFRhtaFzSg65CZj8BvZ/M3pH2YO6tiAF7We1HclUwIlgj3C3
         Cq39LcxtaTxVo9sNTace/ZSpDJTXLfnPHY8a7+MCvL1UJzUf6VTtGJ1lp+iMxCBqBo6n
         CUWI6UaG8tDRspda4v/4UlmX8ngRntkwsGWRwEFzaAE2JdRxHR95qmpG+leopG5dpS1R
         2cyJwLIYZczSBhT7+1Jl5F+4EqoDfdf6t3lAE+oa2/OCoQMTe8140AqP3ZecLC29HGUt
         xpbw==
X-Forwarded-Encrypted: i=1; AJvYcCUepxAvveDWYBnwx8raQUDfNoEdhm33yNeG08L1fWqhCVYjBYk9azOs+quW9nX8eBmvV80XmoIFMCALM8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX2ekWG5nslLlaVAtw+fvl8DMCCOHJ3KeqNnygr8T3uHOdh/gg
	BTJnu4Viaxzxjd9U0NaX5kZiICJ5BtjYm0myXuF25Gg6pf06CIUR
X-Google-Smtp-Source: AGHT+IEsV2fv0g1kV6/++KzZwKJpxUNt2FiS+EG0fs0M3Fu654sbn+JVjqb+QlICvEuW5EX8O4atmw==
X-Received: by 2002:a05:6a21:398:b0:1c3:acd1:5caf with SMTP id adf61e73a8af0-1cc8a07921amr1440775637.23.1724376832290;
        Thu, 22 Aug 2024 18:33:52 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad6e334sm1735781a12.84.2024.08.22.18.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 18:33:52 -0700 (PDT)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v4 0/2] Fix an error caused by improperly dirtied buffer
Date: Fri, 23 Aug 2024 09:33:27 +0800
Message-Id: <20240823013329.1996741-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Hi all,

On an old kernel version(4.19, ext3, data=journal, pagesize=64k),
an assertion failure will occasionally be triggered by the line below:
---------
jbd2_journal_commit_transaction
{
...
J_ASSERT_BH(bh, !buffer_dirty(bh));
/*
* The buffer on BJ_Forget list and not jbddirty means
...
}
---------

The same condition may also be applied to the lattest kernel version.

This patch set fixes it by: 
1.Replace the __block_write_begin with the hoisted
  ext4_block_write_begin().(patch 1)
2.Trace the user data dirtying in ext4_block_write_begin().(patch 2)


Changes since v3: 
- Ditch the patch 3 in v3, because some other code paths can set the 
  buffer dirty:
	ext4_write_begin
		ext4_block_write_begin
			create_empty_buffers
				set_buffer_dirty 

[3] Version 3:
https://lore.kernel.org/linux-ext4/20240810082814.3709867-1-zhangshida@kylinos.cn/
Changes since v2: 
- Adjust the applied order of patch 1 and patch 2 in v1. 
- Reword the commit message.
- Remove some superfluous logic in patch 2 and patch 3.

[2] Version 2:
https://lore.kernel.org/linux-ext4/20240809064606.3490994-2-zhangshida@kylinos.cn/
Changes since v1: 
- v1 use a hack into jbd2 to fix the bug while v2 choose to journal
  the dirty data in *_block_write_begin.

[1] Version 1:
https://lore.kernel.org/linux-ext4/20240720062356.2522658-1-zhangshida@kylinos.cn/




Shida Zhang (2):
  ext4: hoist ext4_block_write_begin and replace the __block_write_begin
  ext4: fix a potential assertion failure due to improperly dirtied
    buffer

 fs/ext4/ext4.h   |  3 +++
 fs/ext4/inline.c | 11 ++++++-----
 fs/ext4/inode.c  | 51 +++++++++++++++++++++++++-----------------------
 3 files changed, 36 insertions(+), 29 deletions(-)

-- 
2.33.0


