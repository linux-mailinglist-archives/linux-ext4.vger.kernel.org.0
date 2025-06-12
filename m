Return-Path: <linux-ext4+bounces-8392-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F2BAD701E
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 14:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490741BC61D4
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 12:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2907222574;
	Thu, 12 Jun 2025 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="eADZ33bx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B1D183CA6;
	Thu, 12 Jun 2025 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730827; cv=none; b=lP0AgCQYxJtnWsZgQB5tJDAGzwtowLZMNhyIGtqSV5aqbVUxoCGGPB8w/2M31PVYrMQaVQal4lt0PM2VxWql/KmtDAx/gR2AoalsEnzhxiuuHF61zc+9y4FTGbBoTwCaQZYLxRv+uiMhiAGOVNP3gvCvsXC1IBYi6FMsrnyHOGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730827; c=relaxed/simple;
	bh=QC0sTLDqFvqcLqc30uNT68TZUAuimB/qFhe2XEuKifg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V18xlciXArdtIol0wfoBunzhbnRWmFXU9LTZjkJwjDBbCEUX4ccOge6WXV2gqYQqGJIoZBXb0EsxCRcarPk+kO8QaKRASMlzaQ5epwwvhOcPLWWMTJJ5Wb6FEmrdMjQrjBE7GWztKyCtRVS88zuJQvrWNxSdr8J3WvzAEftTtrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=eADZ33bx; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1DFC141AA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1749730825; bh=DGy3ShBYGBdoD3hfRuZt/ol3arHzO+6RWfreOOJAaMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eADZ33bx3KjPWc6XQhY3ZNvVMMiWIDcxQR2/sJLEPIotHyHPp5MCnBn4+ocT5/9So
	 5KdnRoB+2lRr95pveN1yB8GFKj8gDvDdUKIsdDLA8j7lr/JMeBZj4J989l13aPoYp2
	 bkajAC6HxbOoGJ+V5ngIs8P9UT+kuSW9qFRD7fjxRrfD4aJxIqunL9lADnfVLPmc/8
	 2aqbFZegv38O7UsxyIW3xUGIK1Y8JaH9AoX1Vcpr6gSxTwLuUU3Uh7ML8PDIz29ocA
	 T8mbbYC/nAukXr9imes/0sZX9mYMButXJo5nprq0pHK8YPREyY7q9+4mwX4OSjWMlz
	 5C/Jy593yCgeg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1DFC141AA1;
	Thu, 12 Jun 2025 12:20:25 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux ext4
 <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas
 Dilger <adilger.kernel@dilger.ca>, "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>
Subject: Re: [PATCH] Documentation: ext4: atomic_writes: Remove
 cross-reference labels
In-Reply-To: <aEoaJEhw5qHkd2_w@archie.me>
References: <20250610091200.54075-2-bagasdotme@gmail.com>
 <20250611164800.GC6134@frogsfrogsfrogs> <87ikl21a5u.fsf@trenco.lwn.net>
 <aEoaJEhw5qHkd2_w@archie.me>
Date: Thu, 12 Jun 2025 06:20:24 -0600
Message-ID: <87o6utm9rr.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> So removing the labels looks good to you, right?
>
> Confused...

Removing unused labels is always good.  Removing *used* labels is
obviously a bit more questionable; in this case, as I said, it's
probably OK.

jon

