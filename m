Return-Path: <linux-ext4+bounces-10223-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1425B7F319
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 15:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA4D7AD99C
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 03:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D332F7462;
	Wed, 17 Sep 2025 03:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzpLhge5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D0258ED7;
	Wed, 17 Sep 2025 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079397; cv=none; b=nfxz/RjrDWDb385jsNe32OxBddOjR1uPN+ftHnjPxjsPzxyHoc0UjKUQd7Bqp7VKgITbNWnDEU+b+K0uhrhqumM3LoQ/CMXpLBQIG4JGH9DB51XICvTnJHYr3jiUSZGM4AamXjkzJmWQGGHYiSsKsowLmbLVRBCNRg2/RBGRFkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079397; c=relaxed/simple;
	bh=s+Ah/AAHowwzNuuce/f6c/Q+zdGsP5DuTh81rmB8SBY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EOwPCwsnQwJ83eSswwcG/cT/c9zKm48Owj6YitipNzv4b5ssmDDZDusyyx7hRiVjl0HAY6X0vRbPuAOqH1VV6a5lLq26k2tFp4FI17oUwRPbS3ZOn0uFoSG3UoL1c4cQi/S7FdcYE0uVvlzDW9a4VMtF6n8BIBoCO8ZnHJo/TBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzpLhge5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F0FBC4CEEB;
	Wed, 17 Sep 2025 03:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758079397;
	bh=s+Ah/AAHowwzNuuce/f6c/Q+zdGsP5DuTh81rmB8SBY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=kzpLhge5r2L72RZTlSC0Z4wFQ3CexEEasITaBc1BLgPmd21JW5o71p6AGXCQQ9/Nq
	 76zoj0hNNExfPvJ+/uXeAykbrRFFfAgKqjAUVqeK1eVYccVYUo/FKzC3FVbB9qZsch
	 fD9/H9Lo4sgbZU0d3raP19CxICiDEfun3kKOg8slkFr0rruknXsNf71eaF0zYHMLlD
	 9NqBMbVueWVwOA0Xx7wf3ywd6uJcEV87WXIsIiEfyb66roE5OWymA36BfSkZQqfVez
	 MQb8oB2ZCmmnPREVv35WqZGmMEulYulL4cdayYUzcIfJMI4FqjWDp0YE41I0HVeKPT
	 03AhHKECsyJHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0A3CAC59A;
	Wed, 17 Sep 2025 03:23:17 +0000 (UTC)
From: Theodore Ts'o via B4 Relay <devnull+tytso.mit.edu@kernel.org>
Subject: [PATCH v2 0/3] ext4: Add support for mounted updates to the
 superblock via an ioctl
Date: Tue, 16 Sep 2025 23:22:46 -0400
Message-Id: <20250916-tune2fs-v2-0-d594dc7486f0@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIYpymgC/z3MQQ6CMBCF4auQWVtTOhaoK+9hWIBMZRYW05ZGQ
 3p3KyYu/5eXb4NAninAudrAU+LAiyuhDhXc5sHdSfBUGpRUWnYoRVwdKRsEYtuMNLbqJBHK++n
 J8muXrn3pmUNc/HuHU/1df4aR3d9ItZCCcGiMMhZR68uD45GmFfqc8wfvNwsPnAAAAA==
X-Change-ID: 20250830-tune2fs-3376beb72403
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-api@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1459; i=tytso@mit.edu;
 h=from:subject:message-id;
 bh=s+Ah/AAHowwzNuuce/f6c/Q+zdGsP5DuTh81rmB8SBY=;
 b=owEBbQGS/pANAwAIAfL5WVaVDYGjAcsmYgBoyimjM4Q785OEKu5sS5LIuhYhQqyZ/H7GzG6P4
 nHx/gaBbaCJATMEAAEIAB0WIQQrablU2/4IeSiBN8ny+VlWlQ2BowUCaMopowAKCRDy+VlWlQ2B
 o3dRB/9NpXGyTbbc0Uf8y4v3AtNFRwxLY/srg37XORX9wOm/lAn2ZpAfIWhMGSFmPLzSpJgkTen
 8suE4uFvY+v+NLMDq3EPOFzVETckm+rjGTXU+m9FtD/TZKTfhQUiZcItf1CmBQ23ZcQplXuq00n
 crc4oUdEKw6ikCXCyQSQUXEVld0idq2Siknairp57zCZRIgP4pjj3HIKDNGb2ycWoTDV/nmT/lW
 Ui8QGlDk4wHSvX1g/BqWmAR/wMi1RBdaYinnODJKmIEsoNzBU7AJzpv8Wgxr7FPzTNIHwKmJ4j7
 PUioF0yqeJu/MG9ZvEHFcYNaP8XshrCLHQaYZJCwsS5qDACy
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
Changes in v2:
- fix bugs that were detected using sparse
- remove tune (unsafe) ability to clear certain compat faatures
- add the ability to set the encoding and encoding flags for case folding
- Link to v1: https://lore.kernel.org/r/20250908-tune2fs-v1-0-e3a6929f3355@mit.edu

---
Theodore Ts'o (3):
      ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()
      ext4: add support for 32-bit default reserved uid and gid values
      ext4: implemet new ioctls to set and get superblock parameters

 fs/ext4/ext4.h            |  16 +++-
 fs/ext4/ioctl.c           | 312 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/ext4/super.c           |  25 +++----
 include/uapi/linux/ext4.h |  53 +++++++++++++
 4 files changed, 382 insertions(+), 24 deletions(-)
---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250830-tune2fs-3376beb72403

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>



