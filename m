Return-Path: <linux-ext4+bounces-11742-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 116A1C4894F
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 19:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A78774F0B20
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B73631326C;
	Mon, 10 Nov 2025 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntvHNRq6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D871284884;
	Mon, 10 Nov 2025 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799257; cv=none; b=nL3fqo7Bz4SM6ihZwylY9Fjs5xk+iL3TxKCPKLGjcU6gcwglatxQVSPBSWcmJZVjiSdu/hzjcfujPR97Voa3Tq7pYrGVzFnZ8NpANAEAP+D2lvFc13Fz0m63sbv9z0xu/j+KOx6CpT9FUPZVkNX8yXWackfznwX49mvEVf9fWEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799257; c=relaxed/simple;
	bh=0/vHn50+LLwRr7fGU6lIT1ji8gfUeaZxA57g1jmN7AI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPQBpreISO7I3zVmkIWR1PfU7WgTFfjsrLdm2o50hUzG7dzUhnJiAkTZOhUv6qEFRyKKQBd/IQ0/1BVbBnwWXhJb9EL7Xdh6RWoCxjmg/+JKPiivZbnVrSeCKJXkqi/vaDoT8zpSyaBs/76fAeZOKTS276FPIe/eHKk/i/nxE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntvHNRq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4DAC116B1;
	Mon, 10 Nov 2025 18:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799256;
	bh=0/vHn50+LLwRr7fGU6lIT1ji8gfUeaZxA57g1jmN7AI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ntvHNRq67omqStbR4qcmgpTQV2ivlrvGI0eR4+onh1xIwfGiac7oTUsQhPooezBwJ
	 LD3jO8AkI7dhjOBxpcHMsa0JSXXmO7FWqv4aeqVaEKH96XEtM5KRVci7xw01F58dRQ
	 heB9alTVfL/fm7XrpOkHV0LtpgkrxOtaYk06FdERh2C28lv6G/wbDugi8q+BWqTWNE
	 pdeuegbBKF43liLx1nLjWSkzUtn5KpynuV46RW9f1J/tyBpzwe1ab5isjtawB0xH4c
	 lKJzCpNOnHlSAVlY6FWomW7wW4gi6z4nAZ6xtvrfG8v3z+Z7OD+cCj5VGsm3x41BWH
	 oHfYnExSvNx1g==
Date: Mon, 10 Nov 2025 10:27:35 -0800
Subject: [PATCH 6/7] generic/774: reduce file size
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: fstests@vger.kernel.org, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <176279909116.605950.12144124358096086284.stgit@frogsfrogsfrogs>
In-Reply-To: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

We've gotten complaints about this test taking hours to run and
producing stall warning on test VMs with a large number of cpu cores.  I
think this is due to the maximum atomic write unit being very large on
XFS where we can fall back to a software-based out of place write
implementation.

On the victim machine, the atomic write max is 4MB and there are 24
CPUs.  As a result, aw_bsize to be 1MB, so the file size is
1MB * 24 * 2 * 100 == 4.8GB.  I set up a test machine with fast storage
and 24 CPUs, and the atomic writes poked along at 25MB/s and the total
runtime was 300s.  On spinning rust those stats will be much worse.

Let's try backing the file size off by 10x and see if that eases the
complaints.

Cc: <fstests@vger.kernel.org> # v2025.10.20
Fixes: 9117fb93b41c38 ("generic: Add atomic write test using fio verify on file mixed mappings")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/774 |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/tests/generic/774 b/tests/generic/774
index 7a4d70167f9959..28886ed5b09ff7 100755
--- a/tests/generic/774
+++ b/tests/generic/774
@@ -29,7 +29,7 @@ aw_bsize=$(_max "$awu_min_write" "$((awu_max_write/4))")
 fsbsize=$(_get_block_size $SCRATCH_MNT)
 
 threads=$(_min "$(($(nproc) * 2 * LOAD_FACTOR))" "100")
-filesize=$((aw_bsize * threads * 100))
+filesize=$((aw_bsize * threads * 10))
 depth=$threads
 aw_io_size=$((filesize / threads))
 aw_io_inc=$aw_io_size


