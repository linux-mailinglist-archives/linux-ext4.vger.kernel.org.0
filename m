Return-Path: <linux-ext4+bounces-8648-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CAFAE9496
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jun 2025 05:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E281C28818
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jun 2025 03:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B135A202C45;
	Thu, 26 Jun 2025 03:35:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C81FC0F0
	for <linux-ext4@vger.kernel.org>; Thu, 26 Jun 2025 03:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750908926; cv=none; b=AZsPXNaONas3PF+ebri0BN0z+475nqQUwpEyUUdJFU4YHLow05kjQkD3Wz+birCwuuke+AcLWeG0P/ftCuyDxov2XypoiS40e4CtPnRV2ZdWsImIt1NktBGso9ssweB7ENxbo8tBefyyZr+8V8y5q6ft8Bh3ncL6+nshhplv4hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750908926; c=relaxed/simple;
	bh=6TtcDFAZk92GXRgWoBYIbrGc4eYL97NDKlxpU6NiTrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VuqHRuaxtxErUhTzYnGSpJLSNPLxndTFMoLGrXR4SLf50NDQbHWHFT13xUzTcTmYGrONx2zCL4dvad0Xv8RVXq+AgcpzA7Q5LMT8b5BzcJa/Z4qUKZRI7kx6vt8s5qfioHFkplFvhj8X5d7dDQCd1/Eid0yYPnJBU0x8ruBZA54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-219.bstnma.fios.verizon.net [173.48.82.219])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55Q3ZGjq023001
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 23:35:17 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id A74732E00D5; Wed, 25 Jun 2025 23:35:16 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Tim Woodall <debianbugs@woodall.me.uk>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] fuse2fs: clean up the lockfile handling
Date: Wed, 25 Jun 2025 23:35:10 -0400
Message-ID: <175090890592.198062.9803658186310097955.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250616150614.GG6134@frogsfrogsfrogs>
References: <20250616150614.GG6134@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 16 Jun 2025 08:06:14 -0700, Darrick J. Wong wrote:
> Fix various problems with the new lockfile code in fuse2fs: the printfs
> should use the actual logging function err_printf, the messages should
> be looked up in gettext, we should actually exit main properly on
> error instead of calling exit(), and the error message printing for the
> final lockfile unlink is broken.
> 
> 
> [...]

Applied, thanks!

[1/1] fuse2fs: clean up the lockfile handling
      commit: e50fbaa4d156a6ff62dc85c4737fa97c4cb858aa

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

