Return-Path: <linux-ext4+bounces-1613-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCA787B6F4
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 04:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18771B2298A
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 03:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E7C8F6C;
	Thu, 14 Mar 2024 03:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gXfYII/W"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4968F58
	for <linux-ext4@vger.kernel.org>; Thu, 14 Mar 2024 03:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710388507; cv=none; b=sqceWbwsWIWfjHUXSVentuMaaJByX/uYNExmzAZkRe5yaorEvHggMGDlMIZ7Uz/MPNBi1yMUBpTWCHGdZP5Kz4CTa9poYEhEiiXlc8gqWMsZ3DKuhIQGi+8NXBXMUctulc4+rUZ1LqK3peQ70zf23h9UeY3G7XxwFN2KnkT9zZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710388507; c=relaxed/simple;
	bh=p09XKBtdqS+za3+1COV64+Xpd7STAuhwdhO+BsZUVC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzLyYnPKltU/1sbmbB+yt3Sf9Jd2CkHzHFfcRLCmWpRWIEgBV9PCB0mcEGvfDdv76xdM+Ti8ijAlcA1ljpEvQHzHJxsr722DGzfudqYT+FRv1kRPg+UV1r4y107qI/9rDzCRrt5aOdLtd0RMri5KkAIOV6f0Wxfeok2hihCrcR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gXfYII/W; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-252.bstnma.fios.verizon.net [173.48.116.252])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 42E3snHk003033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 23:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1710388491; bh=0wlQm3vPPezMzf0GNStZXh57M0cYu8DjSgY1T0rQNac=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=gXfYII/WytgFCQYY2ZgltdhC1+gWbi84RgEeP31Hky9yaQJ4O4HcwulxM8yyugJkn
	 4pPLi2B6FXge39Uzw4c/w/T83+pI5EAymEJfrIi+OWCXwOZs0GyTr/7tZCL+sOF/zs
	 z0ED31YmMqWjjIP+E6fRYe/vAPmnuCvic2JfhZV4YRRfwgyM5zKI8dvXDX7fvTBonV
	 IEbgrDVGytFJprZRKDWKCRy8PoK7Wph+MMj6+dpyNJw1TBZx/xRQMESTtBtxzkehj+
	 KMfZ5bBQwaRM33VrMVt5Ux6eS0KYBiGT0drCOiouVNNxyb4Zi20H8Kuw1ORgPitRem
	 2YW0u5QxWZZEg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id F1FBB15C0288; Wed, 13 Mar 2024 23:54:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com
Subject: Re: [PATCH] ext4: Enable meta_bg only when new desc blocks are needed
Date: Wed, 13 Mar 2024 23:54:45 -0400
Message-ID: <171038847841.855927.1707863077916756800.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227131329.2608466-1-srivathsa.d.dara@oracle.com>
References: <20240227131329.2608466-1-srivathsa.d.dara@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 27 Feb 2024 13:13:29 +0000, Srivathsa Dara wrote:
> This patch addresses an issue observed when resize_inode is disabled
> and an online extension of a filesysyem is performed. When a filesystem
> is expanded to a size that does not require a addition of a new
> descriptor block, the meta_bg feature is being enabled even though no
> part of the filesystem uses this layout.
> 
> This patch ensures that the meta_bg feature is only enabled if
> any of the added block groups utilize meta_bg layout.
> 
> [...]

Applied, thanks!

[1/1] ext4: Enable meta_bg only when new desc blocks are needed
      commit: 07be778c70149321f785611a9c50125b904b0508

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

