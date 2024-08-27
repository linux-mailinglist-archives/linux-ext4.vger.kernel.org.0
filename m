Return-Path: <linux-ext4+bounces-3904-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C558960AEE
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 14:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0BA1C22A89
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 12:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66691BFE12;
	Tue, 27 Aug 2024 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ABxAHJxd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6701BF7FF
	for <linux-ext4@vger.kernel.org>; Tue, 27 Aug 2024 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762874; cv=none; b=hR1oUiFcQooOT4EYW9NosD+5rIcVTi+CV5zhd6tzke5VEKuqrFhWS8+Tt+Aqo6a0vvDNpuQb4hVI7cl4sqxK6nTDumKA9vRPiq6QY5E0VqnymJUK/jLz7tz/uziaLV628M6PcEWbJvdDQ35uMeOIIQ8AZXYg0y79lzZnTbcTBis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762874; c=relaxed/simple;
	bh=psCOuogJY6vyhqZpgbTol4K+yi7sFZ1xPdXlQn5ZddQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hux5dkt2nQkLGt0Dn3SAHIHPDrdzcr9/KFMA7KbruEZ6H/66iqnIk9mlq3tXmrZnC3rAVdOTQBXw0Q3S0U4yeEvGUTxIK4xvyYgB94IdGIXmAmF8huqRpPYPkkdW/HsMzCp2tEBsc14dL2vZ14TeS9wq5xz2TaICvqbI3T6WEm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ABxAHJxd; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47RClfTq021527
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 08:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724762863; bh=cSqYsJazqQVSj1BtvlBuCCy16X7dHrEI2THz+qj+LS8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ABxAHJxdGn2NgKIiNRCi13SIQMoUjIPKgsNqJ2Idcvjcl6O8qww3dII9uwhNo7MSx
	 R0OkZ4VJY8bzfDCASeVtRpj6+r3PyU24vs6idAzQ+RrI4BmxKDaGr1ehQgGJG4IWCK
	 0BynWCMfR1Qt2s+vgyN9/gKZfMAr54p8zLKN3BIkYSvE90kyS4vW9NlWT+BZuav+4F
	 39X8YbcOC/9ko1IM5+dxcGkplRQFFIiyAIdowUsPVxwuvsG1o8pA5Qva5VMqVjX+kV
	 VML6ZM/jcQuoqTSx9ABx81YWvRs5tZLwmmLeGoji8sY7RrDuaDt5e6W74zi0s+l/tG
	 3MACdqFt1PrIg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C16B515C1A13; Tue, 27 Aug 2024 08:47:38 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: corbet@lwn.net, Stefan Tauner <stefan.tauner@gmx.at>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] Documentation: ext4.rst: Remove obsolete descriptions of noacl/nouser_xattr options
Date: Tue, 27 Aug 2024 08:47:31 -0400
Message-ID: <172476284021.635532.18338846085891684831.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240728003433.2566649-1-stefan.tauner@gmx.at>
References: <20240728003433.2566649-1-stefan.tauner@gmx.at>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 28 Jul 2024 02:34:33 +0200, Stefan Tauner wrote:
> These have been deprecated for a decade[1] and removed two years ago[2].
> 1: f70486055ee351158bd6999f3965ad378b52c694
> 2: 2d544ec923dbe5fbed64a7f43dccf527218380bc
> 
> 

Applied, thanks!

[1/1] Documentation: ext4.rst: Remove obsolete descriptions of noacl/nouser_xattr options
      commit: 736c24e62e7e1f5d00fb5b750bb7c13c56410d07

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

