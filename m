Return-Path: <linux-ext4+bounces-3865-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8505795B933
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 17:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C99A1F21684
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 15:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D051CC172;
	Thu, 22 Aug 2024 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="cL3aewO/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC0618EAB
	for <linux-ext4@vger.kernel.org>; Thu, 22 Aug 2024 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338844; cv=none; b=arlJ12fUVd0D9TxlWEEFXNksTztHaON31kT5NWJWKKjVus4iHHd647uQ7WKKrnNZa+e+laOMCyQOmYqNxfm6FZUpUsRXcjpZMXOlx9DhF2YFrgfd6TVbat5E7G8A4jInXrld+fb70uylkoQ1F6BY/xTbkD2wPEslRpkSZrMFSTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338844; c=relaxed/simple;
	bh=E8rEomQlcQTMFHur12Frg/n7vkc4mk3s3WvQz2oDh4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkZsfw3rgaUKqeqYIReWM7Kz50Ny4cvf6w+jEesQVpz5yGLXTq96YZBV2Eff5imU9ESjGwSTt1DOxSJcHgFg8Y4YTZxAPTpWg+xHjFPym3w2ePDPrthIpqH0K78r5yWIkCeSzMzz+PP2J4lmkUJERhAh3Ns0FAT+BBLISVqwr9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=cL3aewO/; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-67.bstnma.fios.verizon.net [173.48.112.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47MF0MnI022378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 11:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724338825; bh=s++mZG3MKUzC5PvILC4pUJYzIVMa6u/xJDXdzIQURaI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=cL3aewO/98SJs3aVqFbzy1uvViu+edbpRquG6emQMtdy6sl/6Iy2zJPHC+eJQDI6j
	 kRFkwN+1dyji0syFdP7cZO/v0fz8cATyUK3bfpqqZ8tO5uKfM2Ux9LNX5/m2+fyI2n
	 wOoZK891pJQd8PIPSZxeJprhaJ8DiT9jHccdv3VdH6g2MVoPDhvLm1NQPaD9hWIJTa
	 M0jR3+SVpMy2PlA5so386D3zZEasUJymQI6UdZHgkGS3eX04b9Z3B0TwfDgtyL+iUn
	 sfp6id94n4ZPXRTudfFJ66MJlGQx+UtAj3pKsSPAemAc1+hCyzRtSQ0eHuf+8E2joO
	 r7xk7dDs2OU0w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DD9D715C02C1; Thu, 22 Aug 2024 11:00:21 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com,
        Edward Adam Davis <eadavis@qq.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ext4: No need to continue when the number of entries is 1
Date: Thu, 22 Aug 2024 11:00:10 -0400
Message-ID: <172433877725.370733.2330809797744892142.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <tencent_BE7AEE6C7C2D216CB8949CE8E6EE7ECC2C0A@qq.com>
References: <00000000000075a135061c0480d0@google.com> <tencent_BE7AEE6C7C2D216CB8949CE8E6EE7ECC2C0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 01 Jul 2024 22:25:03 +0800, Edward Adam Davis wrote:
> When the number of entries mapped is 1, there is no need to split it.
> 
> 

Applied, thanks!

[1/1] ext4: No need to continue when the number of entries is 1
      commit: b2b81e122b5616890ba6657adeb8aa5ca1f05fe2

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

