Return-Path: <linux-ext4+bounces-2267-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69648BA31B
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 00:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C20A1F21ED8
	for <lists+linux-ext4@lfdr.de>; Thu,  2 May 2024 22:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2295057CAD;
	Thu,  2 May 2024 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="OE/3/ODb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6D57CA1
	for <linux-ext4@vger.kernel.org>; Thu,  2 May 2024 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714688795; cv=none; b=Ouzb+rTV5dbiLStTtBF0E94SSfNBYeq2kMc08OQEyQtyyFuC0u0aCAxhUqMs/FORaNxjfI4jXdOWluhqRaD6Xc6lqqPmzdbcOzoH0RH67BLGd234JdkY6xTY2KSqpQt1QW0TE04ndxtrtusRRpN9aZ/y+/Af0FoRTTCagane+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714688795; c=relaxed/simple;
	bh=OFyhe+pZ002CGKfqUyrrvABdHY64yqc4yo/dkPbQBfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6GzoaYQaCgvenW1Pix27sI2F5W7dQaYUF1NbrL2ZOck/LRBAStb2oVEsZqJp7cAFk4vfVi44QkL+t1W47W+Z60nZWob6z9Mz/0h1DLi4fp2Jqq2NyaI7INjbS6nt3JEzdzV5wtBk9o8v+bcJv0a5xrz/jZ0XiZo76iyaMdvG+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=OE/3/ODb; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 442MQITb023809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 18:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714688782; bh=IcvOCz/6+um4o0OaSx3gbOetx5YYhVfo6D+c4SaOQr0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=OE/3/ODbINXLodxg7NhkZenTN6kcRtlqVKLvQNgdADvVb2lLMZg7Bj9MzT8+YpHVG
	 6Jo4V9wOjqH3Glzv9c476R0qd12p2mlh1lpNaq/MJg17GQOC4+Y4Q8FDBDi2T+JYoN
	 E4thypwFzAM3vmdhmejW+uEejodyauR+21v+LBsaAt1gcFxl9sNIK+82f6UYwFlDgH
	 0ajaBnxlty1U+P3qKQe3AyAfeZbFE1X6d+GMdar548WeReUWRCnknwARJk0Q8OTrJr
	 Eu0zxvnTVcRlXGXmfQQwvwrIC0Pu9ETmPucYrSspvathy6yMhJCeKuocDIDgxgRsC3
	 BqHjXKm0jOTTQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B4C6015C02BB; Thu,  2 May 2024 18:26:18 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, brauner@kernel.org, mforney@mforney.org,
        Max Kellermann <max.kellermann@ionos.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "ext4: apply umask if ACL support is disabled"
Date: Thu,  2 May 2024 18:26:16 -0400
Message-ID: <171468877064.2998637.14217086529278734176.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315142956.2420360-1-max.kellermann@ionos.com>
References: <20240315142956.2420360-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 15 Mar 2024 15:29:56 +0100, Max Kellermann wrote:
> This reverts commit 484fd6c1de13b336806a967908a927cc0356e312.  The
> commit caused a regression because now the umask was applied to
> symlinks and the fix is unnecessary because the umask/O_TMPFILE bug
> has been fixed somewhere else already.
> 
> 

Applied, thanks!

[1/1] Revert "ext4: apply umask if ACL support is disabled"
      commit: c77194965dd0dcc26f9c1671d2e74e4eb1248af5

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

