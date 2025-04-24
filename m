Return-Path: <linux-ext4+bounces-7464-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20067A9BA02
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A397E5A7EFD
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6101E223DD7;
	Thu, 24 Apr 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxXMODZ7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ED121E087
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530801; cv=none; b=U0vVsNoTfN5/zBcx/ce07SKJj3lKvxTp61ISc19r+5K1mqLHcf6n9koERL5t6iqAnYorRfCabvvs6YoiYB+j7BzT3cjA/tWCEciO7kwKnCLSfyz64QWUAC4CvE0034h98KKe4NKX0lBNRVDfhl0zkAWVb0lckzVb/Ji1XgafV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530801; c=relaxed/simple;
	bh=DTIpx0ArwpDw6VdkoFhXSsHuScCiEWQX7W65Ms2t1EM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOGbWu2PWIfuiIJr0FuYPsklxUUI/qwMkUPipcEXSpUUcPeof/AdIi5RzsU2+l1tf6PuNg3vAD2M5QXPIbCTRQGk+7Ku/ELn36/AbDD5bDrpYbJYBeiLZzAOSqM31J6ys4clnzbAoLLZZvggQLpAGaO/WQyA++c7hrpH2fgBzGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxXMODZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA717C4CEE3;
	Thu, 24 Apr 2025 21:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530800;
	bh=DTIpx0ArwpDw6VdkoFhXSsHuScCiEWQX7W65Ms2t1EM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AxXMODZ7f760eb1I9MZRHPwolbaBLuMSePXWSvXVeo0i9PguPz/Cy5ty0GSlkQEap
	 FnDTDkFJ6HVMaUHSaonAYGplVJEkrKaIQ3mpQLtCB74N+qWnJnJ/aeMT7gqlCZQ09i
	 WPwpU/b4DYgEAS/PsXQ8c4SojWw1JyJifW2bLry0CmYGQmxX1rZHT7+6Wya69N/7zI
	 CQziqrXJhTiI0egGKrmQij9etzS0VKnT+e1+vduZlM5kUo7aqYJZLhWby26pHgL8gk
	 WsEtRGLLtqC9nkVvx8naySXE1n0C93LfqKLoWNI4LyjjluM++YD1hd+WbMgrFjLmOi
	 KjtXuVnLzUomA==
Date: Thu, 24 Apr 2025 14:40:00 -0700
Subject: [PATCH 5/5] fuse2fs: redirect all messages when FUSE2FS_LOGFILE is
 set
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553064545.1160047.7348261379704899161.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064436.1160047.577374015997116030.stgit@frogsfrogsfrogs>
References: <174553064436.1160047.577374015997116030.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If the user sets FUSE2FS_LOGFILE, redirect all debug messages and error
reports to that file.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    1 +
 1 file changed, 1 insertion(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 9fd35d14e10556..fa48956396e9d1 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3856,6 +3856,7 @@ int main(int argc, char *argv[])
 			goto out;
 		}
 		stderr = fp;
+		stdout = fp;
 	}
 
 	/* Will we allow users to allocate every last block? */


