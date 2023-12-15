Return-Path: <linux-ext4+bounces-471-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A66C3815404
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 23:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61AAA2871A7
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 22:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C73418EAF;
	Fri, 15 Dec 2023 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvIa+ZNx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E957C49F71
	for <linux-ext4@vger.kernel.org>; Fri, 15 Dec 2023 22:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519EEC433C7;
	Fri, 15 Dec 2023 22:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702680955;
	bh=aSom0dE1S+L0NU/gFuC6ssurIbkRtqOgp6d5ML69vLA=;
	h=Date:Subject:From:To:Cc:From;
	b=YvIa+ZNx0UQEoBA1dyKXuNIZFBhy+bjf6JqRBIc6MVpmcjWt2Ud87qp8T4ydrYXE3
	 f8k1sGSAo3YqHRloEIdegwOtlmh4Mfsy1mxOoYaxI73rV04ZgzBIzC5/cOm7jzR80A
	 ILRWK8jhRgtC7TgurN17R74uraTbnZqu2AKBhGl9GolB3GHdX1JbzOWzDMRj/c+HKT
	 UJh19nalDzMYL4Ll50FHetUuWZMykmMvpGnrH4SWOkq6eNO9PCOR0uxyPBnjbtGHY5
	 +Uo/sBsVkYaHWmPeFvYZLYqGOlYuvjLqiyp/2LVdlsnjtazysp44+0P2pdVCkqq6YT
	 REl0OvoUt3hrg==
Date: Fri, 15 Dec 2023 14:55:54 -0800
Subject: [PATCHSET] e2scrub: fix some problems
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <170268089742.2679199.16836622895526209331.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Here's a couple of fixes for online fsck: First, fix path escaping where
systemd units are involved, so that everything works consistently.
Second, add a udev rule that hints very strongly to application software
that it should not auto-mount ext filesystems without asking.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=e2scrub-fixes
---
 scrub/Makefile.in              |   12 ++++++++++--
 scrub/e2scrub@.service.in      |    4 ++--
 scrub/e2scrub_all.in           |   20 ++++----------------
 scrub/e2scrub_fail.in          |   10 +++++-----
 scrub/e2scrub_fail@.service.in |    4 ++--
 scrub/ext4.rules.in            |   13 +++++++++++++
 6 files changed, 36 insertions(+), 27 deletions(-)
 create mode 100644 scrub/ext4.rules.in


