Return-Path: <linux-ext4+bounces-3467-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7FD93C67B
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 17:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13C91F22B94
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A70619D89A;
	Thu, 25 Jul 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQBb3mEj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340819CCF4;
	Thu, 25 Jul 2024 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921580; cv=none; b=IQ0UQvHvZ9en/tEYrNm1OX715g5jv/Sno9hJWCF+j4HdmOa0HfdmfCULkcPr+3z2Yc5MI5HxPBN/L9gHO1BWxTt/+aJ3tDOOR2e1PyXWb9Vs7/0iAqaLRdfzoQn4dBuPdcxA+eKEioHPyj5FM68ILfVdrzLnaSNk4Ih2EB73gKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921580; c=relaxed/simple;
	bh=KuUPeMyDvwC7MuSmAeXi/1iMqP7uEsayTyngz5IKoIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdnIwUwrzdMnz3dDrHGF4cGkPmHFW8RJ4x51Ekx2wCL4K49v97iMI5p+Mfn19gueZ6MonMErL6SThcbFqnKvj5DCxyGdHj0LdwdKUdKgl+rA1FdogJX9JbEd9VAp9iLYxJt7mj+W5bCB2ByB/eC4ZMqfZS/jlnrzxJ8lrExhbCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQBb3mEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366FCC116B1;
	Thu, 25 Jul 2024 15:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721921580;
	bh=KuUPeMyDvwC7MuSmAeXi/1iMqP7uEsayTyngz5IKoIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQBb3mEjh4yXkHQ7LB4goStIb94bWMODzvra4hWrerNrnV+79ieFH3JTL8hBxiiRi
	 3TMfcuK3fXARJAGDirHg/8zT+mUP+EuNf8RIcrzducSn5KcXQHpDanDCUC5hlfBMLw
	 j1oFF1llpDotMmfsO34ooVXBGe3fWB8e0MNp0kyjIHKH9djuy75t53DCR5X9aTWtNS
	 iHMr6Ivt5gmfWiriRMUqw6WkYgZL1wXvTtWn1mnQy7XaAgHwZUFV3QHVEr0AweV0nw
	 cToGNHoKUfxBUv7YkIMRMui25rHAu3mCeL8+74PjQGmnosa1+SH6CUcH+FBQQkmufc
	 7gsUiUh9nrRKg==
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
Subject: [PATCH v5.10.y 3/3] Add gitignore file for samples/fanotify/ subdirectory
Date: Thu, 25 Jul 2024 11:32:29 -0400
Message-ID: <20240725153229.13407-4-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725153229.13407-1-cel@kernel.org>
References: <20240725153229.13407-1-cel@kernel.org>
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


