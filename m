Return-Path: <linux-ext4+bounces-4746-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C611D9AF880
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 05:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B9B4B21D78
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 03:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E0E18C018;
	Fri, 25 Oct 2024 03:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="mH+QbYGp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5139718A6D8
	for <linux-ext4@vger.kernel.org>; Fri, 25 Oct 2024 03:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828445; cv=none; b=u11MsRZvNh+fJJmS1Uk0KsoVwYNS/U8VN1PJfI0j+/lhykRqBQ16/m6pGhTl8tws7tV87Sb3CA3YcuA+nmucvZ+H+LV1gLXanZjG0syzCed38qMDFGAjJwK3+0YSd+K13YBC4L16BlrNfldubRp3NpFLNK4aBIH++kWLriuOgqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828445; c=relaxed/simple;
	bh=wPhrSqwxYuVooOpd49Lpx9liVtVDwSP09haWFx5PjU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFJ3FtIdgzyY5gQd5Kn/R0cP/d64ExZj3CQnfupnbV+IpY5tswCz1yEf9+4PBOvr1lqOKVCqQr5rzBPzgZ74ZIqTj7f87A/xdSjjJFFBN0Wj8NuCkEjJNu5UhY37McnPUVPhZKoPNbaEkE3ADrce2UBr2v+Y4IpwuBxggOKYv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=mH+QbYGp; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49P3rvqH027475
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 23:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729828439; bh=QfpknP1BPsSKalT8jyInt/Xehx9AxQ1QknwCrqHsfyE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=mH+QbYGphPcXxpU2zmiSO58Lsreh5w3/xZcq6NkRCSTrOAJrFWjd/x68nHZfPtXzY
	 JyvHX4c5wna8h6BkIGvXvcaW74ulLHWVivaKjhegugvSDah3MNQ6ihIGHfDIOQlXRv
	 64YEGyRabmi6TqDaHSN6KHLhT5Sw17NjHlvGnjaUOjQ10k7LEirhWYo/EkkTzRQ6Y0
	 JzF60fVnZOy0BrJ8DzcQu+dRlKXjkEmvNqoW4Ul32K+PDNgZIp4YunS/pDIyjWRjMt
	 cXcAAyt1TFK6Fu7D/VJsgneoZ0kRwcor9txDxVaJ+7p1SGf07DG4T3iyqDhpIT+Y5j
	 PlEpm4wXS49wg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A686D15C05C4; Thu, 24 Oct 2024 23:53:57 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] tune2fs.c (main): do not set dirty when default is not changed
Date: Thu, 24 Oct 2024 23:53:47 -0400
Message-ID: <172982841322.4001088.11138876356077698025.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718175204.1590917-1-gwendal@chromium.org>
References: <20240718175204.1590917-1-gwendal@chromium.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 18 Jul 2024 10:52:04 -0700, Gwendal Grignou wrote:
> If the default group is not modified, don't set the superblock
> dirty bit.
> 
> Similar to commit 2eb3b20e80, it speeds up `tunefs -g` command when
> the group argument is identical.
> 

Applied, thanks!

[1/1] tune2fs.c (main): do not set dirty when default is not changed
      commit: 2c1e5543169254863e0edc40bd35712e21073479

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

