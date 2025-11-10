Return-Path: <linux-ext4+bounces-11740-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1106C4893D
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 19:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB80C1893D69
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 18:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6101D32A3FD;
	Mon, 10 Nov 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5o+KiUp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E083218B2;
	Mon, 10 Nov 2025 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799225; cv=none; b=Z8WhCqCtvKQX3sJDWOGebL1wZeSeQ0GGEUmvAxPN28VkNfxDLhPPSIOixwTqZV06RErSTsXANqlMLJf+jpJ22SuUIG/sFBmg0tl89KWA/bvt5z1iBbEHzdrPzkHPlAb3o1kbVXzEfp4rNczkBNriyUC8UVWHeAAcgHc5Dff6Xsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799225; c=relaxed/simple;
	bh=jlio1RmFkVD2Ia7/wwIhXqCvBG4/fpLjxw0R4YoMQ/A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnkgCEgiema57POnI1vg9cUs4+fv2mrWxiWmDw/2SoLZBwAEQjijjaqo6ZtT72FejqoCdjarYmTldjZvY1Ubgbqu2jePXKDxHLYu8NZIgVs3WjKxil3YnLWAMN4+lAUpFxA5Ns+jrlnnKjjGbTYFsMHT4/rAs4epkvv6sJrCCCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5o+KiUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC702C4CEF5;
	Mon, 10 Nov 2025 18:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799224;
	bh=jlio1RmFkVD2Ia7/wwIhXqCvBG4/fpLjxw0R4YoMQ/A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=u5o+KiUpXjm3NYuKWO0kJJqJDZQnaT5l4YpwlAnM6bpc7APDb+Wka7ft9sx1kL6uE
	 l9sZFW1iP4gwIiCmK8d2eESKGBhoSfTbhR6IFPtlRUh3U65XxtrSZoDbj1fMh/I4l5
	 +zoKPbeNi+fsV9fhhekvuwlgyI7Je0cg9Ty2eXC8N1rq4JsTg/z6Zf0mdp+FzRu/UF
	 4pjLOpuSFkiuw5nAIPsE+q6FSbCZoUTYsr4SFzru++A0jV2zfL/MkKazIi7VSSrxQ0
	 KFOaAtjgdMzKDjjX+12VL5jewblGjTBh5ywLnNKwMus7pbzTM2OOuySdSELMZO8ylV
	 HjvUR0ipXpDJA==
Date: Mon, 10 Nov 2025 10:27:04 -0800
Subject: [PATCH 4/7] generic/019: skip test when there is no journal
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176279909079.605950.17890053232268440120.stgit@frogsfrogsfrogs>
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

This test checks a filesystem's ability to recover from a noncritical
disk failure (e.g. journal replay) without becoming inconsistent.  This
isn't true for any filesystem that doesn't have a journal, so we should
skip the test on those platforms.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/019 |    1 +
 1 file changed, 1 insertion(+)


diff --git a/tests/generic/019 b/tests/generic/019
index 00badf6dc320b2..3ea88e2e94e220 100755
--- a/tests/generic/019
+++ b/tests/generic/019
@@ -126,6 +126,7 @@ _workout()
 
 
 _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+_require_metadata_journaling $SCRATCH_DEV
 _scratch_mount
 _allow_fail_make_request
 _workout


