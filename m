Return-Path: <linux-ext4+bounces-2123-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0388A7A50
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 04:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA691F22288
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 02:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8DB63AE;
	Wed, 17 Apr 2024 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="RGBBqRZY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE8B1878
	for <linux-ext4@vger.kernel.org>; Wed, 17 Apr 2024 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713319438; cv=none; b=dklErhm67TmaJWW6Ro1g03wKS+oJU5uU/2r7Cng1G/mO8aT+jaUnrFAVaVuqrjHMB2P/sheSw/04jvxCES3Dcxyjz7XqLFhbv8QSIEP9o+jG6YjeHd7Gb+gtC4jfQjnQ57Tf2DqAeHyEWDbNDc5PzAGvuQUonSW0lr+p5kTikyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713319438; c=relaxed/simple;
	bh=CJcB2yYFPCUtdGUA7sI3ibDMEdbxkOF7WMxpr25AaVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owxHnoVC+SaCt0GlBn57izEOhyctRHO3SE+hl8j8Ks7QupgAjvkN8ODDSAPjJUB/YMueWonIjwQNJxGkLlcUJgMT5w/Xewy95+wgT/FKbDNtSMgKG0sWIus86cdc/jUBYvbdt2aZHZedRzNPACPM52DvWc0nce9hOqUEVocaipQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=RGBBqRZY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43H23gp9013704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 22:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713319424; bh=ulhNAbbg1avzlTDJgRonGtmchAbTH5TZW0mliFQJhZI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=RGBBqRZYOjE9ms5XRE4eJ4Y4eMGUQ+LqWumU1KWWoIQKS5AbhBtCRk8vWnbi+w4Ez
	 SLtKJ7ZL3AEcFk+mH+IkcMAi4h17PlsnrVnepU5YsevZQemrb1ImtfZ3GokE6DAG6c
	 XLtlSuxdvWYifAxt/1ynQ4xT/tXtmV4tVCZEew9k3lYNoHIJ1uIzWoBsCr/ckWKgfn
	 vJoPNthLsjxFOZAPnMu3DqcduH6viKSv1gUq7Ev8brzAx7bPfJKTSHCb51PFajFwBj
	 Ls2IVjnr8Jwd5N67R7IfKcotzNE3v1zq7fd7dRmS57EW31FzYkf4d9MRQR6cqmmgy0
	 hDM+hsgOs5xZQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C12F315C0CD2; Tue, 16 Apr 2024 22:03:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Li Dongyang <dongyangli@ddn.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger@dilger.ca
Subject: Re: [PATCH] mke2fs: batch zeroing inode table
Date: Tue, 16 Apr 2024 22:03:33 -0400
Message-ID: <171328638215.2734906.8018789914145416497.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20230904045806.827621-1-dongyangli@ddn.com>
References: <20230904045806.827621-1-dongyangli@ddn.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 04 Sep 2023 14:58:06 +1000, Li Dongyang wrote:
> For flex_bg enabled fs, we could merge the
> inode table blocks into a contiguous range,
> this improves mke2fs time on large devices
> when lazy_itable_init is disabled.
> 
> On a 977TB device, unpatched mke2fs was running
> for 449m10s before getting terminated manually.
> strace shows huge number of fallocate, given the
> offset from fallocate it has done 41% of the inode
> tables, the estimated time needed would be 1082m.
> 
> [...]

Applied, thanks!

[1/1] mke2fs: batch zeroing inode table
      commit: a192f4f344456c2390ce946b4a71db0b85ce5665

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

