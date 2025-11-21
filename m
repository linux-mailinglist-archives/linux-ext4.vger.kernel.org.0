Return-Path: <linux-ext4+bounces-11994-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB20C78ABE
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 12:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 559AF4ED665
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 11:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045C53491D0;
	Fri, 21 Nov 2025 11:03:10 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A60346A1D;
	Fri, 21 Nov 2025 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763722989; cv=none; b=WYVsljvQ6KSXvfl58/2Veh/mMOhC8KXQgffLkUrrVYYYG03wSJMOMShhI8XpGh5A4UHG7q39hiwrteA1h5UsRy50gwo1KA3+JXuQ51RpcwAjPd0B5iODT8/2vjWu9PhvI5AXB74y8otJ2xtIufHsY3CvInUdjarg006TyYPKecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763722989; c=relaxed/simple;
	bh=r3J7GIT+Vs/dQQa4Ti08Qz3kmBIGeDS87m3mvuezloI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CwRx2IKYS/VPJjxrKjsXccrA5CIS93vC1DnAYBUSXEmtCbm25qdg+bON11EIDaWlNaxHPuP+bolUVhk0db6zcIQpVeiHEgtvs6zm1yRl3LE8PlhDoUzy7HxWt43ZczZrf7exhzc41ev4TD2CP3SGpvuhIvZdMBloLQws5HaVRvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4dCXF414Vrz1sCH0;
	Fri, 21 Nov 2025 11:55:36 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4dCXF40FVLz1qqlW;
	Fri, 21 Nov 2025 11:55:36 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id XIy6PGFbtizJ; Fri, 21 Nov 2025 11:55:26 +0100 (CET)
X-Auth-Info: GEU8wFDN2nAHmNcwsT1h9rm+gql8c4zviPTjunEh5ybiFjikdEurOdW0QxWxCayO
Received: from igel.home (aftr-82-135-83-234.dynamic.mnet-online.de [82.135.83.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Fri, 21 Nov 2025 11:55:26 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 8BAEF2C1F17; Fri, 21 Nov 2025 11:55:26 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: "Theodore Tso" <tytso@mit.edu>
Cc: David Laight <david.laight.linux@gmail.com>,  Guan-Chun Wu
 <409411716@gms.tku.edu.tw>,  Andreas Dilger <adilger.kernel@dilger.ca>,
  linux-ext4@vger.kernel.org,  linux-kernel@vger.kernel.org,
  visitorckw@gmail.com
Subject: Re: [PATCH] ext4: improve str2hashbuf by processing 4-byte chunks
In-Reply-To: <20251120155816.GB13687@macsyma-3.local> (Theodore Tso's message
	of "Thu, 20 Nov 2025 10:58:16 -0500")
References: <20251116130105.1988020-1-409411716@gms.tku.edu.tw>
	<20251116193513.0f90712a@pumpkin>
	<20251120155816.GB13687@macsyma-3.local>
Date: Fri, 21 Nov 2025 11:55:26 +0100
Message-ID: <87a50flko1.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Nov 20 2025, Theodore Tso wrote:

> Secondly, it's not that a promotion happens before "any" arithmetic.
> If we add two 8-bit values together, promotion doesn't happen.

That is not true.  Integer promotion is applied individually to each
operand independent of context.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

