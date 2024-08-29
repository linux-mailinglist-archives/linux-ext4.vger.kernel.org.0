Return-Path: <linux-ext4+bounces-3956-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D301963F2E
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 10:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52302283B2F
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 08:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E790618CBF9;
	Thu, 29 Aug 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8nuR4Or"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128CD18C34D;
	Thu, 29 Aug 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921655; cv=none; b=AEE30Na7naWvnm9pT03EcxZaigKM4CTyUIFxeTZb023JOp6p/cV2HiuIpZ/U6cdQ3BcJcIP+EiS/dNEMHPNBdmpOWg8KbwCV86poQ8I06bKZkNPnKdrDk/dN1bugVawR1VyiCRZe5cvhbbWOyxv+0pZ7ZUWwf2ZjcNsRoKQSK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921655; c=relaxed/simple;
	bh=dHOZLSgLMyo2D8kfwsTslShszWCmy4MJr7WOG/PkSYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iOAtdF2d698EX+d3MQUdO0L4s6lLWHlTVaQO6JRly7yTuVz9K136pBvlfhIXggn2+sQbSHef3M2qT0k54N9+qTMFmqwl/lqgvoapHjxWIdlkIn+FoYWKeUXBI3GhVQdR7mZiQ+18J80mV+CbMD6wprFyl3rhm2/dduQYb/NhspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8nuR4Or; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-714302e7285so343813b3a.2;
        Thu, 29 Aug 2024 01:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724921653; x=1725526453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CLbJlF/gcNEjNg69xddZrFl8GxuNdQX6zPhlClI03qc=;
        b=Q8nuR4Ork4RfAhfWUFrioBLB+C89zMCdjW4AihiuNuNdf6okTj4AVmf3AuKZmutgg1
         nbIRSKJlWGmuWG+z9Qx9cnL3DKySQuawgENf5/2He0q0QIBj6ON9BbN4ksSCojj2Bm/I
         ogvTu/F6lSlnpMvGGCFLZAuSpThNPc/F2uNETDiMMBjCPpCk1VKt0vCCHXlMvcjF7Ix3
         GwMqbPSFUMpOJTNJvHnBhLRdrWFGEEbhj1SLBm32VBQbwWxG43Ec7Hl+MRCexYgKx6M/
         aB9WdLUf7Z1a/DR/kL7a0Hvz1o2sLDsUwrBgWO09afkHBUBKah+fI0mNgg5Yt2YPcJ2h
         4KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921653; x=1725526453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLbJlF/gcNEjNg69xddZrFl8GxuNdQX6zPhlClI03qc=;
        b=iY8a2uLqkJMs7ensSOM/4a3TTeZdJrajFK+9PlTa4BTwf5wvr0SVNgtuaA18DvEvCy
         szOYnWF45W0CCPrR7mR9NLoIKyfFi+G/LyYc/i67eJzbTKKYCDmZc04OIWefcC9HNcO5
         15g8aLzZDsuFiDK+eucce5uVtl5piPpHgFDd2dCnIIh+tFHsKbfy4mDDmvWgiChg4tYj
         WVqkL1YEjUWH03BBXHcJgQuwy3prnVPOpmHppj6H8TX9PY3+J3obKP5mwaam6AxjRrQ1
         LAlCvPEMHjMoQmXpdeunsatqLfYxH1WtmXLIgUcnG/UV5FrZrT8pvUscC9fN/MpcKvA5
         YzEw==
X-Forwarded-Encrypted: i=1; AJvYcCWqnW4W2+vukL5uAlxZtMMpEow7yF6aFaE5AFosXBRY2xJlfu3tWVbHRQGM72azNWHBYDaP6KZ/8s2QEpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaNs3EiaZlFU1dDYCc5S28ri6smeREG48j4f2nfxA/4DcKmx1n
	3cPjv/b4/AsVwHCUJyYah9HXJ1Z1pnTbtxotr3X+us/gQW01MXPC
X-Google-Smtp-Source: AGHT+IETJFr4R8/6hYzDGGumV1CgrGkRxPAgN841vz28zclnopVzt7xW55/jQowHh3mTeZvCiGrLYA==
X-Received: by 2002:a05:6a00:3c86:b0:710:4d08:e094 with SMTP id d2e1a72fcca58-715dfba79c7mr2520212b3a.2.1724921653157;
        Thu, 29 Aug 2024 01:54:13 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56e3f95sm708789b3a.176.2024.08.29.01.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:54:12 -0700 (PDT)
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
Subject: [PATCH v5 0/3] Fix an error caused by improperly dirtied buffer
Date: Thu, 29 Aug 2024 16:54:04 +0800
Message-Id: <20240829085407.3331490-1-zhangshida@kylinos.cn>
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


Shida Zhang (3):
  ext4: persist the new uptodate buffers in
    ext4_journalled_zero_new_buffers
  ext4: hoist ext4_block_write_begin and replace the __block_write_begin
  ext4: fix a potential assertion failure due to improperly dirtied
    buffer

 fs/ext4/ext4.h   |  3 +++
 fs/ext4/inline.c | 11 ++++----
 fs/ext4/inode.c  | 65 ++++++++++++++++++++++++++++--------------------
 3 files changed, 47 insertions(+), 32 deletions(-)

-- 
2.33.0


