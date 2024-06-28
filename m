Return-Path: <linux-ext4+bounces-3026-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E7D91C4A3
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 19:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC561F22F11
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 17:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABFF1CCCBD;
	Fri, 28 Jun 2024 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GswiZf5X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44C157A67
	for <linux-ext4@vger.kernel.org>; Fri, 28 Jun 2024 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595089; cv=none; b=lCVTKbeBrW1Ju8lmg+7nFeheIqu8uA0RKqcNhmWVO5sJ5nvANY+i315f2PCX0s6Oxnxeg9rPaWbd7DRYGWQi9bW5upOqlDRr7SwMI2c9ZNzZf+VidHjm7klBj9x3rDnVTIxN/bXSEa8hBHAPlqrGS3HoBfqGdlglJtl+x1+tuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595089; c=relaxed/simple;
	bh=vvjuPBBxRjWuO9qbMksuSjap90JxeVrDrY54pzBkrzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCNwVzEzmnR9JeHDfwhivaDMBplhLo6yERL7OMVFovilrh2LCe+4GAy5c6KdYNHPC7HiOxOXAEeCszno6vAzMpT4FGwPlHJ53s3gJ4YQzxNXj+IXBjHyTXQ3toVZmtWnVzmp7oC98D8pAfm7SUAWIMSiuCSDSzFaIppYCAYpxRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GswiZf5X; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-120-63.bstnma.fios.verizon.net [173.48.120.63])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45SHHt3l024130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 13:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1719595076; bh=oUns7pp1fHbC3YmPhBTMwnxjZNbAd0kuLwtU37VEgyU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=GswiZf5XGR/5xpmZZEXy2Rw/J/B3T27KOkU03oZamc9olvqrppvotjNkITdCgrWLz
	 FWuDkkoDhutRHvSz9CwTfr8QdQsTfQ8+EUtaNu861LGVhMiCt5503x0yoJJyN6nYYD
	 pAD84ksfvxf5V/BbmrFr25D9GqEmqmfSTFXUWIk9zec+wDs1o4AFWpovcbHjiWTkgc
	 X2QfWCJK5VMup/zgGZ2Jzfbw/pR41qILObdWbSlDjWyoTav2qUmSWCnqEQAWnPHjS7
	 +Bn1SlEX62qBCd0OM+P1MDZPvriXAkbSCChbr1FRjYqdeyzNHKQUv0Lh98YPcmeJT6
	 a2xRBQtgDyCBQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D8AEB15C02D9; Fri, 28 Jun 2024 13:17:54 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.com>, Thorsten Blum <thorsten.blum@toblux.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: Use str_plural() to fix Coccinelle warning
Date: Fri, 28 Jun 2024 13:17:49 -0400
Message-ID: <171959506215.737463.15134273406614968934.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240402105157.254389-2-thorsten.blum@toblux.com>
References: <20240402105157.254389-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 02 Apr 2024 12:51:58 +0200, Thorsten Blum wrote:
> Fixes the following Coccinelle/coccicheck warning reported by
> string_choices.cocci:
> 
> 	opportunity for str_plural(dropped)
> 
> 

Applied, thanks!

[1/1] jbd2: Use str_plural() to fix Coccinelle warning
      commit: be210737fe6cef2d0d578e23342261688c9317e1

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

