Return-Path: <linux-ext4+bounces-3974-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5B59656F9
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 07:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36251F22D3A
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 05:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E9914D2B4;
	Fri, 30 Aug 2024 05:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvcXudcd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFC54683;
	Fri, 30 Aug 2024 05:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724996269; cv=none; b=fslpivhv6Dby8ArU7nvU+wLR1EIaaAB/wYXTlrTkpEIWp9PZ+e9gvbup1mL3rFFassEI2eoaFYgB9bDNhITysA+iKwNR2qa7AGIsjkgu2oc8pKGVOhfD4/XPVUu+J/ilNtZImy+dL82k+fkMfCY9uCON6dYe5BSpGsdlwLOjcEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724996269; c=relaxed/simple;
	bh=YIqTEY53Dydj7lrzD+Z8xZQeTDoC27uAIz99CEHIE0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Se/VLy3gqaNCiopQE3MTeVWz/Lq7nklR4o9sFMF4Ey4ArdntKFgcDFrKSKGX0Od0n9oduPOuLzs8J1NAPhoH/w8vG7LOYU//LjPhN9SDjWYJ9sUPBCfFbYEb6XtCLfmelAN7jUJSQFZde9ozEmtlXSwIT3jnCCV8YUehFLNH/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvcXudcd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20219a0fe4dso12426145ad.2;
        Thu, 29 Aug 2024 22:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724996266; x=1725601066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIv2atOMB0cIykPfF8uzzPRCW3JUYYFtqphvX1v4wFo=;
        b=PvcXudcdP+7CmdDFzGoVX1xtw0QpkLCBau2AWYvRv0XJwFsk+0uc2+k7Wf2lkdGQNy
         5tNKIFq6/9HDIlPpb5tPu1fhU6g5ZT0GVtKxIkn7+IvUxgCPX6b1FcIvbbiuRf02J+N/
         cvsy+7cl13MCi62utuVTnHLAxshFcIxKQ2A90Hi49J15wzBUu0OIFQfS0yhP7mZidULV
         bPNeAHvIHM0Aoe6dbX3jvsGP6oLqGM/X6zSEul1YZbxd/aXI6swjq7Fs3YDEPAEPg1kX
         lyNhLwcPeE75e0VgZmccfbY9CKEgmWRovg4gXjFlLCzcbe9WjnBmC6O1XFLxBiaCyYi0
         UJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724996266; x=1725601066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIv2atOMB0cIykPfF8uzzPRCW3JUYYFtqphvX1v4wFo=;
        b=hgnVgZMWJMmG9MH1vlrtB6wYap6d9c6sIAN84HZL2+MQM/3OI2nnMmJAB1zzP4ahBC
         MGvT+FpS9p3y+57z3eT8Iw0XT89KKZA8nMQ/V7846UKAunnIUVe6VFDHXSBsMNSZOHXU
         8KsTp3swwhikgMjchLRV9IZJ5TbmOpo7pD7ZoMA81zXQRBEvrS20Edl65rz/aoLVDqlX
         QHC8irZ8RghyVeCr4d6fcgN/mCQ0WBXbDuvxspOtna/D7eq7eFuElaJAbDWdDJkSFoSs
         2A4g6tq3HCP/x7My68yqCSPbnbLNc9WtstkO3CHkOZkYkvKIl4KCA3xK+gbFI8HkYfQk
         qArQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgKA+PNq1XfU5FBNApXFL8uguoSa+jl8UxV8UNFnY9UyYmNVu1FRhDWxBwaCznpvU8gOGK2VPWSbLFiHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhmDgP6CTjbhroiQPvg0RCyiGxS5sachBF9zLLAi6qVrYixj4E
	5aUANGo6Ld30G2knD+dTCJcAaXcE3dVtXMCUVo2KaMidV1AV+aED9YtuDX3X
X-Google-Smtp-Source: AGHT+IGpNW3eN39MKqqr2OXO5DlhRncT3JKekINbOmFmXuDtynLW4yLwufYGsr0JPHumk6YxLolUog==
X-Received: by 2002:a17:902:f543:b0:1fa:fc24:afa5 with SMTP id d9443c01a7336-2050c350429mr57616415ad.27.1724996266167;
        Thu, 29 Aug 2024 22:37:46 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515534801sm19784075ad.154.2024.08.29.22.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 22:37:45 -0700 (PDT)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com,
	ebiggers@kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v6 0/4] Fix an error caused by improperly dirtied buffer
Date: Fri, 30 Aug 2024 13:37:35 +0800
Message-Id: <20240830053739.3588573-1-zhangshida@kylinos.cn>
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
1.Fix a small bug for ext4_journalled_zero_new_buffers first.(patch 1)
2.Replace the __block_write_begin with the hoisted
  ext4_block_write_begin().(patch 2)
3.Trace the user data dirtying in ext4_block_write_begin().(patch 3)
4.Clean up some extra things.(patch 4)

Changes since v5: 
- Moved a hunk inside the if (buffer_new(bh)) check in patch 3.
- Add a cleanup in patch 4. 

[5] Version 5:
https://lore.kernel.org/linux-ext4/20240829085407.3331490-1-zhangshida@kylinos.cn/
Changes since v4: 
- At first, we fix a bug in ext4_journalled_zero_new_buffers, as suggested
  by Jan.
- In patch 2, clean up the related comment. And remove the #ifdef in  
  ext4_block_write_begin(), as suggested by Eric. 
- Add some comments in patch 3.

[4] Version 4:
https://lore.kernel.org/linux-ext4/20240823013329.1996741-1-zhangshida@kylinos.cn/
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


Shida Zhang (4):
  ext4: persist the new uptodate buffers in
    ext4_journalled_zero_new_buffers
  ext4: hoist ext4_block_write_begin and replace the __block_write_begin
  ext4: fix a potential assertion failure due to improperly dirtied
    buffer
  ext4: remove the special buffer dirty handling in
    do_journal_get_write_access

 fs/ext4/ext4.h   |  3 ++
 fs/ext4/inline.c | 11 ++++---
 fs/ext4/inode.c  | 80 +++++++++++++++++++++++-------------------------
 3 files changed, 47 insertions(+), 47 deletions(-)

-- 
2.33.0


