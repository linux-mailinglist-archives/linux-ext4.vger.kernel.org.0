Return-Path: <linux-ext4+bounces-8757-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4984EAF036D
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 21:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343593B6B27
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 19:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF2280A47;
	Tue,  1 Jul 2025 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="jTir4Ovy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BDA26A0E0;
	Tue,  1 Jul 2025 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397088; cv=none; b=oyFcnSgB7WV+AR5ipZkQi1WDWO33EsqXAeDnYm0TgteP25BxStmzs6MCLnO4j3SPaKlBrdUKiVWe9tcJOAvtnQn4u4VX4lgSJ8Zxd8Qf0n7BDnhAT9Vw2TNUjsLW+mEB9PFimSUri5J4CVYKBXthDixqwXEnlKng8nHfYuTfqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397088; c=relaxed/simple;
	bh=z4f+eQJG65IF7q83wr7qPgXhTWfnXVrZOVU35IJNU9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q9FTDsgmXCEmdfr1Kk6HEh1EQD4XPaVABvHI83P++7HqcWswtKXOHEk9MV3uZD6Gyi3Zm2dZ4Xn7d0ZmV9YrVCV7D8VDLYitHjB0WXHrYvOzzwXuBpS/omB/zb22agTSjvayoMQfdevSUyLvIReRsMeC2Bw3q2eycoOp4KdGIEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=jTir4Ovy; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 04AFF406FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1751397086; bh=2BeC9ePAMZTy0IbNm56dxbKdnRGE6FcrpsbWIQptkVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jTir4OvyjsfDadhSD6P98fYu6lq7wOw56wodpA0Zjv1GwAFMmh1hPAOeRNCW6JbfI
	 UPgzwMJ6uNRWYFy1KxImyw/Xz4S28LH6cB7YRY+YkAvX/bZ62BoseuEeqOdE0zBogg
	 9UnZEnuro/h4/qe5eDM9N9hcRdoiUrE5rC1eyx7TFCdlela6bWWJ+N+TzqJFkImuxc
	 E2+sYXlhsnGZinv3xaiE7diwDuWJ7TAwf/hmAkOqHEcz5IIZV0oO0uy3Mb3bkMGLgq
	 6wmkqKASqKUBFc2NNHW1wu+DoiBTf5rI/yPDuE5EJnRVxtdaOVL2CmpUYWkM0we5kL
	 gbQNgV8BdjjLw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 04AFF406FC;
	Tue,  1 Jul 2025 19:11:25 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux ext4 <linux-ext4@vger.kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, Bagas
 Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 0/5] ext4 docs toctree reorganization
In-Reply-To: <20250620105643.25141-2-bagasdotme@gmail.com>
References: <20250620105643.25141-2-bagasdotme@gmail.com>
Date: Tue, 01 Jul 2025 13:11:25 -0600
Message-ID: <87y0t7rajm.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Hi Jon, hi Ted,
>
> While discussing on my previous ext4 docs reorganization attempt
> by merging contents [1], Jon suggested that considering current docs
> file structure, a proper toctree would be ideal [2]. So, here's
> the patchset that does exactly that.
>
> Actual conversion to toctree structure is in [1/5], while the rest
> is cleanups to make the resulting toctree nicer.
>
> This patchset is based on docs-next tree.

So to me this seems like an improvement.  I'm happy to take it, though
would prefer an ack from ext4land if possible.

Thanks,

jon

