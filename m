Return-Path: <linux-ext4+bounces-9760-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1CBB3C4E2
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Aug 2025 00:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AECA22639
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Aug 2025 22:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C3D28504B;
	Fri, 29 Aug 2025 22:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="EbBclWXT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0EB2A1AA;
	Fri, 29 Aug 2025 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756506776; cv=none; b=pfwAXYn6xEX7QN0EvwHaAiJbeKeweKVB1p/IryVi3i/aQhfAdNE7eNfKbwnm8EJ9CfHjk5CD6aF7+NDK1VQ+jwIkEiOqS96nBJTPbGwOZhlxkKvOszK+M2e2gLO7bnU98zEAbsm+eiKrxKKJDns4FuEY++VD3sf1wFP+GsgE/Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756506776; c=relaxed/simple;
	bh=rDcBuyWo+0HvxPLgD4oV6lnJ1hkzbJFrUIu+0BVXX58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ok2bXXikOKBCrUG2S8aSdIx1m+YPSTPJZTHphEr3jdDYE++CEd8LHZCeVQrn9CLvDGYQSGZVWm83oNVNHqIwVjneRtD7bYCwtGTp4qg3VT8+8Hg0M+B0KU49fbClta+3AnJFVtUITY9RB2sX3usZXaDhJNCFY24Jx6kpLdZQ3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=EbBclWXT; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 75BB640AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756506774; bh=Zn8/n6yhdXvEFJF944/ITKb9o1+OdebDXKbCUBHBqHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EbBclWXT4nWKSGmA0fHU7JjCcoekRWuBeD6KlvQUI5DzBJd+SCdZFvoGJ0fuLgLhm
	 Td9ff/NiImgExWQyg5zyq+Cb5NK7+rY0PmfB6MNad2ozWL/QJ+4eR5LCElT/v8G0VU
	 rpVGKC8GGd75AZN6PVM+4llJ7p5puuO4Q8VkVeyatiSwMuKbxhunJ8UTnh456X/yzX
	 qRFgQvgtzvxovF36XiUlZP/M3uoITbraDmCCC7mtczyqc2PD9fayV/SIUy1hSI4KGK
	 jZUQUC5i9D9sBSM3ZIrhQzvG4FclnnV35J7WWwzZMx6iRgHOIdeVCN7g5woUU2g0oc
	 hvLxRvJHjQAug==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 75BB640AF5;
	Fri, 29 Aug 2025 22:32:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mallikarjun Thammanavar <mallikarjunst09@gmail.com>, tytso@mit.edu
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mallikarjun
 Thammanavar <mallikarjunst09@gmail.com>
Subject: Re: [PATCH] docs: fix spelling and grammar in atomic_writes
In-Reply-To: <20250819124604.8995-1-mallikarjunst09@gmail.com>
References: <20250819124604.8995-1-mallikarjunst09@gmail.com>
Date: Fri, 29 Aug 2025 16:32:53 -0600
Message-ID: <87ms7h3giy.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mallikarjun Thammanavar <mallikarjunst09@gmail.com> writes:

> Fix minor spelling and grammatical issues in the ext4 atomic_writes
> documentation.
>
> Signed-off-by: Mallikarjun Thammanavar <mallikarjunst09@gmail.com>
> ---
>  Documentation/filesystems/ext4/atomic_writes.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon

