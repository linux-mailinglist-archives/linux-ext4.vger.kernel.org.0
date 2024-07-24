Return-Path: <linux-ext4+bounces-3436-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AE693B734
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 21:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369E91C210E1
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 19:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19AF15F403;
	Wed, 24 Jul 2024 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDOhogHA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4D315667B;
	Wed, 24 Jul 2024 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848032; cv=none; b=RmYy7z8r8WeiAjtZ96gRyVh8hqLhTs7R82Jy9h1D4zvU5D6fgLHNjG4maYUIrBWdAZzP0Yw10kvZKyRdxscTsZE3onMwzRh7dQQGba0O2awz2q4O9aomYRbC6lOmo424IE+AqvFdBq+X3up/00r9vAofEgHVFCiKkWoigfpbwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848032; c=relaxed/simple;
	bh=KuUPeMyDvwC7MuSmAeXi/1iMqP7uEsayTyngz5IKoIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNJLzb20KsqUd/0ZW+Ou8bRcLpr5wTnJBPkHqDyAeS4AixHk0enLdQLklbdkvrS4v6YpCYqdlg6btB9mhupLqzRfb3p5Tj/uLe1Ehbu6S7zpAhF1lmJ0hoGDBEUYtFa0vAaX0pVTx9psPHlgMmjKUeztbxU7ovXD9wjG30gnzD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDOhogHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B13C32781;
	Wed, 24 Jul 2024 19:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721848032;
	bh=KuUPeMyDvwC7MuSmAeXi/1iMqP7uEsayTyngz5IKoIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDOhogHAl9egr+v/I6d5wMOJp80fa4Vv451537jEgr4G/XyrOabLvVqD9PRWipMKJ
	 tYEt0B4c5frX5jdk3xklrkjI9sXuf8YpJYq2QBOQfS+AaOh+qTjNISJRsrt6lnc216
	 /QeOUG8IS/X1P7u+SY6ddXQDAMcKMc/R9GWxZfVXRvpwHxWZx5OWjd5todDYA+nNXE
	 sjF/M4rX7Pxq9ihgmyG0ko5oKTwQkieFwGeK5UpX+K3tQtacbBg8jtOFHYwsH5WMG2
	 jLNIT1eEzS8K8A2t5LlSCGMhA6ZPMhKNxKvXSrututDBlDNJON71xbO+PcItcG3o9/
	 UR+Jp5ATQlTuA==
From: cel@kernel.org
To: amir73il@gmail.com,
	krisman@collabora.com
Cc: gregkh@linuxfoundation.org,
	jack@suse.cz,
	sashal@kernel.org,
	stable@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v5.15.y 4/4] Add gitignore file for samples/fanotify/ subdirectory
Date: Wed, 24 Jul 2024 15:06:23 -0400
Message-ID: <20240724190623.8948-5-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724190623.8948-1-cel@kernel.org>
References: <20240724190623.8948-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit c107fb9b4f8338375b3e865c3d2c1d98ccb3a95a ]

Commit 5451093081db ("samples: Add fs error monitoring example") added a
new sample program, but didn't teach git to ignore the new generated
files, causing unnecessary noise from 'git status' after a full build.

Add the 'fs-monitor' sample executable to the .gitignore for this
subdirectory to silence it all again.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 samples/fanotify/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 samples/fanotify/.gitignore

diff --git a/samples/fanotify/.gitignore b/samples/fanotify/.gitignore
new file mode 100644
index 000000000000..d74593e8b2de
--- /dev/null
+++ b/samples/fanotify/.gitignore
@@ -0,0 +1 @@
+fs-monitor
-- 
2.45.2


