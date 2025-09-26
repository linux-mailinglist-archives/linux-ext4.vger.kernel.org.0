Return-Path: <linux-ext4+bounces-10440-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736F3BA53F1
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 23:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 745D57B671C
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 21:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C7E299937;
	Fri, 26 Sep 2025 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="SeBgrSHq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2731028B400
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923282; cv=none; b=o1r3TpbxLetAvBCsSSFygLJYPeaknOQ8pyLqK0k9bxC48rgq7UhHSWb2+7KLee5HfDfJB62vjgjtECTOO2QrT1XbLIEScFYOqaQ+Z6aizjcYFoJDtJ1A2cjB6t2QfcYoL8BATMpHPWGwto8wnTxCDhSomMhxJKu91I6ueiWMtb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923282; c=relaxed/simple;
	bh=PqOvznEZfYxc3KTzkZdtu2bdO9mHs7aWBGQABXI7zF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7ReYH554VKJ6+RQmNXOxPDViNBu76LeQsEnFTcabX5z1sCI2YqsvMHv70gdhO2eaYU5ZtJ/1lNs0kKyWll8MhkInR97fc4sb36p/s458E+k5K3pFrxFKgMLXvjS1ksfOzXF4VQPsXdn+yIGcuo7UHuqLvBqx3AJB0HCNhw6VPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=SeBgrSHq; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLlsxh014702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758923275; bh=O5KK1Z5l6rrHosPFR88Fgf7yhrA7DJSjGP7pA1tvGk4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=SeBgrSHqEBskCGQeFj/gsWc/NP5X4ANrUjI5NiIJnsb1DTq33HDC0zyG9lykoPVIu
	 K6WKxj/nwVxfSV7UNTimnkjrBT2bhpbIcHgl4ML6a3z7IgTCzCxhyDvEIobwKM2WJv
	 z8W/XVCnMlMQX0E7gzf7yBslUuk/kF0gnT7bsMBtwXzORoEz6PAs5LUfRJLCCkDy4Q
	 uZtJsjNSuupn26xaUY+M6ci1oJvrdCo0hVxRci48SYzqWk0mdOkPuhf3pQCzQ8Gg8f
	 oNJdavGOvZiy3uuKSlzjg9vC174D3gGr++fGd9PNkMJYqS7eFo+3vEqWwTuI3k46L6
	 m/2GhCsgzCWbw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id DAF1F2E00DD; Fri, 26 Sep 2025 17:47:53 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        syzbot+0b92850d68d9b12934f5@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: verify orphan file size is not too big
Date: Fri, 26 Sep 2025 17:47:38 -0400
Message-ID: <175892300643.128029.358653394453986093.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909112206.10459-2-jack@suse.cz>
References: <20250909112206.10459-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 09 Sep 2025 13:22:07 +0200, Jan Kara wrote:
> In principle orphan file can be arbitrarily large. However orphan replay
> needs to traverse it all and we also pin all its buffers in memory. Thus
> filesystems with absurdly large orphan files can lead to big amounts of
> memory consumed. Limit orphan file size to a sane value and also use
> kvmalloc() for allocating array of block descriptor structures to avoid
> large order allocations for sane but large orphan files.
> 
> [...]

Applied, thanks!

[1/1] ext4: verify orphan file size is not too big
      commit: 0a6ce20c156442a4ce2a404747bb0fb05d54eeb3

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

