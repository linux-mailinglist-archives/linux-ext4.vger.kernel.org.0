Return-Path: <linux-ext4+bounces-8759-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356ADAF041F
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 21:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1111144693C
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 19:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BF9283137;
	Tue,  1 Jul 2025 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YCq4GADN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65064212FB3;
	Tue,  1 Jul 2025 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399576; cv=none; b=mfLW9XNCxPYfbBQYKvQBCrbiat5VgAlYIZWlYmUVC8y1MlW6BWJ019J4+6aXi4fwUF64IzaEnIcAm46jtZtowKFha9/9TP4cbyXs0BHZonamqPRpv5tItEBpXGkkI3RnG06K2SthUCkQATVPFPg5Qk6JhoZ+AeiTP4KaMO5BrOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399576; c=relaxed/simple;
	bh=tlI5WAGL4cY5b5K3SdGSrgyCIbCBiIRYipbCPeodI/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t7Xie/AvOOivJWxPKozPBJRrvJupYJeeM15/zbtzIQm9E6jdlO1FSQLZxzNJKXG+goNnGFlwb42aemYB4Wsou1+p/jUtJ0oRYenPePV5wu7ZW+G/MtJfDcn39WO8Z6LKu8JOnxDL1jaCFM7bbUo9kuiuw0DtTqHnSYDuNnW7KRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YCq4GADN; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 60ED9406FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1751399574; bh=aIeBd2OXbU1kHcQ7pxghx4PCbNhBNaE25FKmGQqhIAY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YCq4GADN/OQZTw0UOndGJ3C8RIhnfiah+nC478siCIpaRCRVPjehMH5MaeksyHQbO
	 tIVkgdMOhFdoqchxoZho9N5BIHwVMbLjMGwfKyNMHhzqDJVghpVV/GqBiiPBK9vku7
	 a5YnFNbsAY1w+amrXi1LCTbbtiEyyu7nG2V5ohGoQmA+Nghz3NVrZtKKrMZVHzNuJS
	 KD9eeqz5M8Nq4ftOKZMoI4EJZOoqVhlR4uXt2X2k1gmzB2lJ+z7sph2MWdFMS0kcdY
	 EWz+/EPBUACcVJHVvgUfqdN9BfhSgEqQ48q5z19W6gEZVCwq57o6UCy7ATKZ51WSu+
	 E5Bkd3nE/WjSA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 60ED9406FC;
	Tue,  1 Jul 2025 19:52:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux ext4 <linux-ext4@vger.kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH 0/5] ext4 docs toctree reorganization
In-Reply-To: <20250701194535.GI9987@frogsfrogsfrogs>
References: <20250620105643.25141-2-bagasdotme@gmail.com>
 <87y0t7rajm.fsf@trenco.lwn.net> <20250701194535.GI9987@frogsfrogsfrogs>
Date: Tue, 01 Jul 2025 13:52:53 -0600
Message-ID: <87h5zvr8mi.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Tue, Jul 01, 2025 at 01:11:25PM -0600, Jonathan Corbet wrote:
>> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>> 
>> > Hi Jon, hi Ted,
>> >
>> > While discussing on my previous ext4 docs reorganization attempt
>> > by merging contents [1], Jon suggested that considering current docs
>> > file structure, a proper toctree would be ideal [2]. So, here's
>> > the patchset that does exactly that.
>> >
>> > Actual conversion to toctree structure is in [1/5], while the rest
>> > is cleanups to make the resulting toctree nicer.
>> >
>> > This patchset is based on docs-next tree.
>> 
>> So to me this seems like an improvement.  I'm happy to take it, though
>> would prefer an ack from ext4land if possible.
>
> I did, yesterday:
> https://lore.kernel.org/linux-ext4/87y0t7rajm.fsf@trenco.lwn.net/T/#mc3ea7f04fc1b0e4294bce6bd60f5f605017f6f7c
>
> Though I'm also happy not to be thought of as part of 'ext4land' ;)

Yup, I have your ack ... if that's good enough I'll proceed.  You can be
from wherever you want as far as I'm concerned :)

Thanks,

jon

