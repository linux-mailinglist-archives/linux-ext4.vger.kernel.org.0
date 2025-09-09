Return-Path: <linux-ext4+bounces-9852-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3DCB49FD7
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 05:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B444E2A84
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 03:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBFD27056B;
	Tue,  9 Sep 2025 03:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPZK+sFd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7266D49620;
	Tue,  9 Sep 2025 03:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387751; cv=none; b=u29B2hkSgBAZBNaq5yTT9qMzCthDovmMKoHL0Omj9TqFDsVY66bAr35AgXwiHonZ/B4SVwWHIQxnPY53rhdP0nRxdKXUT8WayK2Pw3EdCBOfX44SKqi/b6Enls8+1K4vlrzTn0ebvwYJUE/OpN6HcBmdXKONocyVRw7Olne186A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387751; c=relaxed/simple;
	bh=1fjgACFxa8qJDM7j3UWs9Km/opZNhb3lTBI8Xu1OGyg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iAEM3ZpSt4Gfdl3iZN4qloUgSTqyOvhA+81F+roxI9i3r/VNZrCkjwzxjd9UVgZwoefEnOHii+kTz91QI82LJBxx025zVJgYUUVK9u8PB8FvFowVnqvPtKyXk3YQvcMB9SkccEDysyd2RJ/bakguexo6MBqL5xMyfE077T0u03o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPZK+sFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12E20C4CEF1;
	Tue,  9 Sep 2025 03:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757387751;
	bh=1fjgACFxa8qJDM7j3UWs9Km/opZNhb3lTBI8Xu1OGyg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lPZK+sFdmWCt2gdXkWFz5T0bIvYG5qWPPOST4BppZrLBULjNX84ZIIkTUTQBOcBOx
	 j2/mavPbrNTfXHdBBoYgIxuhA2bK3Y8/Xzs4+PEI7Nqtpcj2JQ3U2hdgPaTWarzXBo
	 WBjd9G4jVp5c/2VYV/nzfh4U+nsPUvFGjjH8cDjeVuqKegvoQMAhV6iEPPUmTRIZId
	 wZXP5+3A1VXAB/pdc56/4HZZwWse8374DQ1OOO/Ym3zx7hj6k8BotCLjxmLMQY94fd
	 O3vq+tiSnTZAnzIvtP6EeF0u1InwDHDCHtFtJ+kqniT0LNEBw+hJvDIxADReThyv+c
	 H4J2bNrCMlOAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001BCCAC583;
	Tue,  9 Sep 2025 03:15:50 +0000 (UTC)
From: Theodore Ts'o via B4 Relay <devnull+tytso.mit.edu@kernel.org>
Subject: [PATCH 0/3] ext4: Add support for mounted updates to the
 superblock via an ioctl
Date: Mon, 08 Sep 2025 23:15:47 -0400
Message-Id: <20250908-tune2fs-v1-0-e3a6929f3355@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOObv2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC2MD3ZLSvFSjtGJdY2Nzs6TUJHMjEwNjJaDqgqLUtMwKsEnRsbW1AC8
 hKOBZAAAA
X-Change-ID: 20250830-tune2fs-3376beb72403
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-api@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=tytso@mit.edu;
 h=from:subject:message-id;
 bh=1fjgACFxa8qJDM7j3UWs9Km/opZNhb3lTBI8Xu1OGyg=;
 b=owGbwMvMwMH46Wdk2FTexsWMp9WSGDL2z37amhR5d7YIL+9tpcoppX+bO1z80w/2n7PLnzexJ
 SqUefrOTkZjFgZGDgZZMUUW7cydIbf/cVRqNJqfhBnEygQyhYGLUwAmwuDO/j/uTsW951WVn5d4
 fz1s0nN9tuzjaS9VRL8bRmw7u/DHrfLY5rl95qXrP78V+BW45nKWUPpe7cnbk1dkvK8Q/b/3jsy
 ZB/wKnD2CjgzfQvWSCvXUZzDP+JgaopYYEMmjtMBw+aGo8Hl9zGnuy531n60qCkmsTed7kzQxuU
 bjYKOq2Wq1utJCkRW2R+7Yn27OcnvIdbji/y2ml7dWqEu+njs1WSo1J6LEIt4/7r8U64U9obVt3
 VevagvHqx6Kaf3pxaS76cQcnzSddVccLXOSNkbZB6b616+/7Su756mNgg67o/oB7v8HVv7ozpfx
 EUk1l5yu/NEo5MdDhi9m2v2N90TucqtPv3Oi59X07xquAA==
X-Developer-Key: i=tytso@mit.edu; a=openpgp;
 fpr=3AB057B7E78D945C8C5591FBD36F769BC11804F0
X-Endpoint-Received: by B4 Relay for tytso@mit.edu/default with auth_id=517
X-Original-From: Theodore Ts'o <tytso@mit.edu>
Reply-To: tytso@mit.edu

This patch series enables a future version of tune2fs to be able to
modify certain parts of the ext4 superblock without to write to the
block device.

The first patch fixes a potential buffer overrun caused by a
maliciously moified superblock.  The second patch adds support for
32-bit uid and gid's which can have access to the reserved blocks pool.
The last patch adds the ioctl's which will be used by tune2fs.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
Theodore Ts'o (3):
      ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()
      ext4: add support for 32-bit default reserved uid and gid values
      ext4: implemet new ioctls to set and get superblock parameters

 fs/ext4/ext4.h            |  16 ++++-
 fs/ext4/ioctl.c           | 256 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/ext4/super.c           |  25 +++-----
 include/uapi/linux/ext4.h |  75 ++++++++++++++++++++++
 4 files changed, 348 insertions(+), 24 deletions(-)
---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250830-tune2fs-3376beb72403

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>



