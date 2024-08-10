Return-Path: <linux-ext4+bounces-3692-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D2994DB69
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Aug 2024 10:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB10E2823D3
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Aug 2024 08:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0898914B95B;
	Sat, 10 Aug 2024 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIKH7LIO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92D41C28E;
	Sat, 10 Aug 2024 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723278505; cv=none; b=XF9nfJK1bUnD6t+frFUAc0WTBsvG5f+zT6BLXjX2HSG/qUbJoG77KcQsmlOo2j28ZsoyYCe4AHi5Rnke69oxqnQKgMRxcyogEKAXKAhlswTdmvNcP5GfaBUd2uBZQPOoST1DkXRoQkTgWZXtsZ6AjBTtzyXeMmtRFgqgwQpeUTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723278505; c=relaxed/simple;
	bh=tgvChdqFcbG93zFoVASyNV9P7tBf+MDssFR3I1icJDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RppVR8JMHSUD+3Zr9YZuw0Op5UOfnlITeT146DnC+hUWVQCR6mmumOZxP+4RFQ8WRekGPPFyrSbSOnL8R8jYRC2Vwv39QTPBGxqKV9WTxH1qxYAamPffAvsoJ99NPxscPQoAC7F18jjTRaJslBNGzprVAkHDo5LpjFTo+JeMEUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIKH7LIO; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db1657c0fdso1930372b6e.1;
        Sat, 10 Aug 2024 01:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723278503; x=1723883303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eVi24F7BOm+woApTsUtzfxGKjOUe1mrgm5itsbG0ZJA=;
        b=CIKH7LIO+BAIM9NwkDicpEMiRA7msrvA3IJ0VE/KLuNBOQpLQ43fNbGE8x2BIRflCY
         ec1jb4ulFF3sQiXp/kqFfXkTNs9PWziwWfvj6PnAE/0Wq6F/07gBDXOpBUn7cpi+0ug2
         gRdKeRpfXDo0P7/u3Au2IdccVbd7IUGftFFQHpgSNHg8al2yoDxQoeIrp27AbKMC9lhf
         wzp7VEMXbNdbS96q5q2rK/FQ5MDtO/YU24TBXKioM/mK8tm86HOGZcmqaH82obHxngBF
         aFGVLfiTjYKakxma1jIHYSxZq5L0ofQUUF2FVjmaAt1TDaMOJOcVszaRDBH4Rue7Rnui
         intg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723278503; x=1723883303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVi24F7BOm+woApTsUtzfxGKjOUe1mrgm5itsbG0ZJA=;
        b=d2gJXMC/3Sirl0lZeCMOeW8hdIR5xutuGK9vg/WiVkl19JXR4rFZDpLxhsIdC9jmIq
         L/se5m/Mq/Q9mws+D9JP6ufbKVDMq9vt/Ry309c3kl8AxK5GDc7dwlD76p561yqFTiJv
         ATIS4aPeHTk9cY9jbX/f6DsJSHNsc0pu75qKGclxFSNy53Ub4qC8kBR8ZMsj1SwCgni1
         d8AuaHm5r8yGesCjGscNwz+L8GVj5zVZhTP3jfnWFyTPNPw42S+kLYv3SOru3tvWLmwC
         90HrZKVTEt/wkZrwaqk9EoQA4gUkEv0TdLYY8tyVpz3B06zvFtXhwOpVLei/KSg5ja7i
         jf4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpa6m2p/92kQNy17BtR+SWy2wm+Pz9vCTroHaW2rBST2000nKWcfZE7fgzBG+2pctVpW2F4wESFPJRtkreDm4i0BONlFLeo5kMLtCu
X-Gm-Message-State: AOJu0YzVPoiu6dYlP9F8UqFglaJiIGLf3V0tjJGP2SXYLcU2ETv9W58U
	NVDYoOYwgPAfSnFKILuYH0zqxazpI8MY9S33UHM4gQ2sHhTtwES+
X-Google-Smtp-Source: AGHT+IFtWOipOrFqGkJ0YyAdDgA2K+LnzEbLt4cY+ckXaks0zPIaSGS+0YEod1ECw2JrPeNIWmAqDA==
X-Received: by 2002:a05:6808:21a2:b0:3db:17b6:1ea4 with SMTP id 5614622812f47-3dc417058f7mr5224065b6e.42.1723278502709;
        Sat, 10 Aug 2024 01:28:22 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a8c454sm854092b3a.180.2024.08.10.01.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 01:28:22 -0700 (PDT)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v3 0/3] Fix an error caused by improperly dirtied buffer 
Date: Sat, 10 Aug 2024 16:28:11 +0800
Message-Id: <20240810082814.3709867-1-zhangshida@kylinos.cn>
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

On an old kernel version(4.19, ext3, journal=data, pagesize=64k),
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
3.Remove some superfluous things.(patch 3)

Changes since v2:
- Adjust the applied order of patch 1 and patch 2 in v1.
- Reword the commit message.
- Remove some superfluous logic in patch 2 and patch 3.

[2] Version 2:
https://lore.kernel.org/linux-ext4/20240809064606.3490994-1-zhangshida@kylinos.cn/T/#m5da94f8299ef9e491e03f4d0cd19581ef5f13288
Changes since v1:
- v1 use a hack into jbd2 to fix the bug while v2 choose to journal
  the dirty data in *_block_write_begin.

[1] Version 1:
https://lore.kernel.org/linux-ext4/CANubcdVHbbq=WsTXU4EWAUPUby5--CLe5rf1GPzNPv+Y0a9VzQ@mail.gmail.com/T/#m19d3b9357f5dff050f75edc863e47f3cb018d778

Shida Zhang (3):
  ext4: hoist ext4_block_write_begin and replace the __block_write_begin
  ext4: fix a potential assertion failure due to improperly dirtied
    buffer
  ext4: remove the superfluous things left by __block_write_begin

 fs/ext4/ext4.h   |  3 ++
 fs/ext4/inline.c | 11 ++++----
 fs/ext4/inode.c  | 71 ++++++++++++++++++++----------------------------
 3 files changed, 39 insertions(+), 46 deletions(-)

-- 
2.33.0


