Return-Path: <linux-ext4+bounces-7469-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5712DA9BA07
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32FBA7ABDC3
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC4A21D3E3;
	Thu, 24 Apr 2025 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3V8kEBj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DE5198851
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530879; cv=none; b=G/+XZCk88rfXOK54m+H+H4V10LwTdZIPxrh2UGK4fHVxmLs7qaPQ0PeOaooUPTa1iAmk20lqC1U0A/z/YcAHViY2ldUKHZq4rUQFfhy7K+YlACZeIyjOJBDotZGxTFrUNPI5qVq9g4E8yR7mhW6Qa9c5oRxnT9AH8SIcNSDQxdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530879; c=relaxed/simple;
	bh=7OMDSKRAX383h6SIuAw74KK4e78c1PHpR2HJA7capr0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1UxafFnGWgHD+Gp7Np5tPwg2Uz+ZLh++H6QVINi2S21G2DEhT9rC5g7ZPVxJ/lTXyhUf87OngUqgjx5aU36dzD1BEIPrC/Ua4hFp+258vbMBqrx9bqcdpwM8LtCX/qFnpkQb3iEmPHX+QSRlxFPUtwL9NX9SUyPo6EfGqJtyeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3V8kEBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E390BC4CEE3;
	Thu, 24 Apr 2025 21:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530879;
	bh=7OMDSKRAX383h6SIuAw74KK4e78c1PHpR2HJA7capr0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=m3V8kEBjfLf8iNEmVpAn3Hg99aNWb6LInXlJM/VTWPqmcc2YmZbnFExBrXZZQ8OqV
	 GeOHHXUdlM4liUhYbGwPEe+qLAyFNhTcN97DT5Cu/6cVWYCcrf09/RlLNXFMM9UNiF
	 tqpwysituvAR8LbDgchADDocbdnyhtdqFceZcSnjqIryAodYlcZcTzj35YM1tQWJRu
	 7PV36kb9a0wDTDk8hq6lfezEEygsJIhx6IcMIz2C5aHBAV0YqC6sZPVd5uEWFHmsJn
	 jI+wClDFLvYkFeYNYqh/gzxCPD7mHTyK3Bfcya+OfHXV8dCmPfn63hIhEIiz7Ug/7w
	 mwdFRJNvh9hCA==
Date: Thu, 24 Apr 2025 14:41:18 -0700
Subject: [PATCH 02/16] fuse2fs: return -EOPNOTSUPP when we don't recognize a
 fallocate mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553064961.1160461.9412670014664878384.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
References: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If we don't recognize a set bit in the mode parameter to fallocate,
return EOPNOTSUPP to communicate that we don't support that mode instead
of EINVAL.  This avoids unnecessary failures in generic/521 such as:

generic/521       - output mismatch (see /var/tmp/fstests/generic/521.out.bad)
    --- tests/generic/521.out   2025-01-30 10:00:16.898276477 -0800
    +++ /var/tmp/fstests/generic/521.out.bad    2025-04-03 14:46:20.019822396 -0700
    @@ -1,2 +1,9 @@
     QA output created by 521
    +zero range: 0x407ca to 0x52885
    +do_zero_range: fallocate: Invalid argument

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5a92e54031a8b7..e5f3cec083c0f5 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3630,7 +3630,7 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 
 	/* Catch unknown flags */
 	if (mode & ~(FL_PUNCH_HOLE_FLAG | FL_KEEP_SIZE_FLAG))
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	pthread_mutex_lock(&ff->bfl);
 	if (!fs_writeable(fs)) {


