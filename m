Return-Path: <linux-ext4+bounces-1819-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5BB894A32
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 05:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 036CFB230FE
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 03:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9056217597;
	Tue,  2 Apr 2024 03:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="mlNKUkcH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43CE17BA7
	for <linux-ext4@vger.kernel.org>; Tue,  2 Apr 2024 03:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712030146; cv=none; b=Brm8WvQmGoexXJ+e2fCE2sdwFZh1H+0EhOPIURgSphlNnwAFLFBveS2hsnSlgSIxU9djUYAkL7Sf+dFdPcx9474Deqvg/cSnbBqyBLI6vzsCtW7NT0T8VrSiT3kwx+suVHqR1rG3+EvgUEBAxrddLXSOGaepj291VJMg4UwRCfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712030146; c=relaxed/simple;
	bh=Ovu1Zl+lRgprOnzlsNT9/gVbAYFDS0biN7y4UFFEcHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOWB2V1E0XWQFmbKI7iEBPHlcewwdJmYKt2+u3nJCjLOrL5M/sJWWUYFQfMQrrvdPoa09hHUNxM8Wf4RIMFOEvKhYbxR1MYZiJMa3IXBb9cWKpr+DR+m5kb7dUgM5jtEoNVewkfCbEHGhFX6U++iGgGFA962jq7eunxUFiDP3Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=mlNKUkcH; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-232.bstnma.fios.verizon.net [173.48.113.232])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4323tZ1X028188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 23:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1712030137; bh=W9AENbMZ6T30aoSARNRXwRAqIqETtvwIKmOEx7j/tuY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=mlNKUkcHa8imT+MUvtaDgSMiaAu2/xGV4g52aaStjZY8Nw1CwonKD26oTyR3hX48T
	 9mAJLdZmns97uBXH4lxd+NOW4QFScUDx/iDZIyzoKps4yGPd3fZAp+7VScuhbUHXqu
	 nIU+HxTCv6yR+ZR67bfgmASjrIKh6NH0ueofbRN6D8fd1NLKS2ggDEYAGeVlgwGD/f
	 +5/Q5gW0A50GnfO9htePeNKDo7xoCW1VEXIBF51zjgdaueZ4y09HAYUT/UJrjx6pgG
	 Erx/NRv//OAmc65/XeKDfkHLFdwDVUJ5/UzHus4jnb6uQXUdoVGKMzj04zS9s2sduz
	 pRfXKtNCcm85A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 1642A15C00DC; Mon,  1 Apr 2024 23:55:35 -0400 (EDT)
Date: Mon, 1 Apr 2024 23:55:35 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Li zeming <zeming@nfschina.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: extents: =?utf-8?Q?Remov?=
 =?utf-8?B?ZSB1bm5lY2Vzc2FyeSDigJhOVUxM4oCZ?= values from ablocks
Message-ID: <20240402035535.GD1189142@mit.edu>
References: <20240402024804.29411-1-zeming@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402024804.29411-1-zeming@nfschina.com>

On Tue, Apr 02, 2024 at 10:48:04AM +0800, Li zeming wrote:
> ablocks is assigned first, so it does not need to initialize the
> assignment.

That's technically true, but the compiler is perfectly capable of
optimizing it out.  So it's harmless, and removing it does make the
code a bit more fragile, since it needs to be set so that the cleanup
code doesn't accidentally dereference an uninitialized pointer.

Cheers,

					- Ted

