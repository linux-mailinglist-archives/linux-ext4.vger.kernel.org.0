Return-Path: <linux-ext4+bounces-11743-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E03C48952
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 19:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 157FD4F0B02
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82A932D42A;
	Mon, 10 Nov 2025 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7gNZst1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F3332AAB2;
	Mon, 10 Nov 2025 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799272; cv=none; b=LkEE4kjP9IZXojUFmmyF5LYv/6B6gnK7KZ7w9WSIh6/zSLQCMaxjW9jfXAWf6djDTS531HNyYnGv2kHsUJywQDGoYMEsApIAxJd4XxZn3jFCMGjJklwO4rttPbwT+uNthOSUnOSyZGdZJFSy42ZekuZCcUmBVqEccXvBVLO3ZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799272; c=relaxed/simple;
	bh=EM4Euget4QIJpL8ZTsgm8lBzPY58PlzahH6RR+bcQkI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9CfEXUdZmZD5xsMaUzhWK1IxgkaMDw65vHKlFXM3EuBlYHDNKGArAmjWxCtH6CYCRpPOylY16NlInQJrctJP/RYgiYvkBRZ/r+RxC0Q3qldWQVKoWXmyen8Sa4dFo5u1q0IEmttk4eDMmVxLb6XqW7+bKKXtX0h8z7CnHdSsBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7gNZst1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313A3C4CEF5;
	Mon, 10 Nov 2025 18:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799272;
	bh=EM4Euget4QIJpL8ZTsgm8lBzPY58PlzahH6RR+bcQkI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=N7gNZst19MlPNoWhTn4RsiSZWoY2RgnlX+i3XpI6yr3dEv2Q6hq9Z+/HfqYlhN23S
	 R/2hVL+uK8mWngVUTl+mq656plUVxBAUzQcAFRdRxd2DuYuJkXYfxOmGbgFIo+uUuz
	 rx3TzcMzKEQDDKmVZpPiK5o9CsMT/sT0KEwPF6DUCSpUSB2ScoRDV2mJ/ycbBxP6Wx
	 pOtqFrS2RZKXtnbMm0KH0xvS59E08TtpyGUhLxAudiavvtcR4XMZJ/g8y1U0HeDDSF
	 0h+w9L3y0AUz/vf/JgN6EMBrmFuhBnaGu+3QYvqMOqeyZh9KPXbLOD6Fu6TzhauanK
	 d7cU70PXyKwWg==
Date: Mon, 10 Nov 2025 10:27:51 -0800
Subject: [PATCH 7/7] generic/774: turn off lfsr
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: fstests@vger.kernel.org, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <176279909135.605950.17114455316765178991.stgit@frogsfrogsfrogs>
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

This test fails mostly-predictably across my testing fleet with:

 --- /run/fstests/bin/tests/generic/774.out	2025-10-20 10:03:43.432910446 -0700
 +++ /var/tmp/fstests/generic/774.out.bad	2025-11-10 01:14:58.941775866 -0800
 @@ -1,2 +1,11 @@
 QA output created by 774
 +fio: failed initializing LFSR
 +verify: bad magic header 0, wanted acca at file /opt/test-file offset 0, length 33554432 (requested block: offset=0, length=33554432)
 +verify: bad magic header 0, wanted acca at file /opt/test-file offset 33554432, length 33554432 (requested block: offset=33554432, length=33554432)
 +verify: bad magic header 0, wanted acca at file /opt/test-file offset 67108864, length 33554432 (requested block: offset=67108864, length=33554432)
 +verify: bad magic header 0, wanted acca at file /opt/test-file offset 100663296, length 33554432 (requested block: offset=100663296, length=33554432)
 +verify: bad magic header 0, wanted acca at file /opt/test-file offset 134217728, length 33554432 (requested block: offset=134217728, length=33554432)
 +verify: bad magic header 0, wanted acca at file /opt/test-file offset 167772160, length 33554432 (requested block: offset=167772160, length=33554432)
 +verify: bad magic header 0, wanted acca at file /opt/test-file offset 201326592, length 33554432 (requested block: offset=201326592, length=33554432)
 +verify: bad magic header 0, wanted acca at file /opt/test-file offset 234881024, length 33554432 (requested block: offset=234881024, length=33554432)
 Silence is golden

I'm not sure why the linear feedback shift register algorithm is
specifically needed for this test.

Cc: <fstests@vger.kernel.org> # v2025.10.20
Fixes: 9117fb93b41c38 ("generic: Add atomic write test using fio verify on file mixed mappings")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/774 |    4 ----
 1 file changed, 4 deletions(-)


diff --git a/tests/generic/774 b/tests/generic/774
index 28886ed5b09ff7..86ab01fbd35874 100755
--- a/tests/generic/774
+++ b/tests/generic/774
@@ -56,14 +56,12 @@ group_reporting=1
 ioengine=libaio
 rw=randwrite
 io_size=$((filesize/3))
-random_generator=lfsr
 
 # Create unwritten extents
 [prep_unwritten_blocks]
 ioengine=falloc
 rw=randwrite
 io_size=$((filesize/3))
-random_generator=lfsr
 EOF
 
 cat >$fio_aw_config <<EOF
@@ -73,7 +71,6 @@ ioengine=libaio
 rw=randwrite
 direct=1
 atomic=1
-random_generator=lfsr
 group_reporting=1
 
 filename=$testfile
@@ -93,7 +90,6 @@ cat >$fio_verify_config <<EOF
 [verify_job]
 ioengine=libaio
 rw=read
-random_generator=lfsr
 group_reporting=1
 
 filename=$testfile


