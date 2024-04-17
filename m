Return-Path: <linux-ext4+bounces-2125-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 859508A7A52
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 04:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C048F1C2128F
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 02:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8316FBF;
	Wed, 17 Apr 2024 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="jPg9nWss"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB839566A
	for <linux-ext4@vger.kernel.org>; Wed, 17 Apr 2024 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713319440; cv=none; b=JoX3BnnvWXufpPEJtOvM2CdcaKP7oaxBZ+g6LrBIygEwVNpnQeBfa9xAlv1rBJI+PULeMB40AD7iFr7iRR3hIUWjiwI1VXiabvKP4k4pU905/wIyJ35H9W57eBhV125vS523/VOonuLGlSCtLNKeXn6zKzDxQZRlbE/4oknKZw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713319440; c=relaxed/simple;
	bh=eOhJnMkkTy8w2sz73cq+umOcc4SPErm2rLs6wEBTQ8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6pZbrH2WTv4AaAbyodgW1KaZT7sDD7TZvyyJdzDSpwWI7pbsdGnhmIKfdrjTmToSfb2dJHlVoq/EEESJXgom1T4gFaxELKV4maNGFrLnRSAClJ4UtqIccn4ubO0lg2cUBg86G4qnvJlcYmyzXq10n2f7ccY7fR00pyPVpACZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=jPg9nWss; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43H23gJq013700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 22:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713319424; bh=LRvlgKL6nSNeKIvWHm0BR9qCixk6BWMeu6V0QnbEHvM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=jPg9nWssQvVMt8teVyMI6fdJdaIrq3wy6JxbVwJpLjd7sInVNQU9vMZJwkBK2fOCk
	 AoCCU8YIRvc5zdB1DMO2Q1cvoMRqYUVO58K9xelBgYfJShAdrg2TOcWVhyVMtQZ9Bx
	 OIBUFIiPaj+c5QR26C9bqq7yuyU4DaXdYjhLh1xYPe/MnopKF/JhGQsRTYrILv/YKk
	 LRXi3HR8HucCNZWnKgJBDD2bmWfSe5bz1bOMyAh5JPmcupt+RsGYg/huQ16RZUK/AU
	 6MlVQB5GVdKmBzrY7SdCMAfz6OF7o6eLX7L3GkPD7oPmrQ+KCZtotPooXFZ7UYOTXh
	 00Z/RgIRRtDMw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id BE2EF15C0CCB; Tue, 16 Apr 2024 22:03:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Li Dongyang <dongyangli@ddn.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger@dilger.ca
Subject: Re: [PATCH] e2fsck: check all sparse_super backups
Date: Tue, 16 Apr 2024 22:03:32 -0400
Message-ID: <171328638215.2734906.2062108155717360367.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20230904045742.827584-1-dongyangli@ddn.com>
References: <20230904045742.827584-1-dongyangli@ddn.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 04 Sep 2023 14:57:42 +1000, Li Dongyang wrote:
> Teach e2fsck to look for backup super blocks in the "sparse_super"
> groups, by checking group #1 first and then powers of 3^n, 5^n,
> and 7^n, up to the limit of available block groups.
> 
> Export ext2fs_list_backups() function to efficiently iterate groups
> for backup sb/GDT instead of checking every group.  Ensure that the
> group counters do not try to overflow the 2^32-1 group limit, and
> try to limit scanning to the size of the block device (if available).
> 
> [...]

Applied, thanks!

[1/1] e2fsck: check all sparse_super backups
      commit: f7ef5f3e356d9ee3e20a4c591456da1cf8184814

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

