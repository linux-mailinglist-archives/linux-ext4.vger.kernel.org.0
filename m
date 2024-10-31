Return-Path: <linux-ext4+bounces-4863-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6249B7CF4
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2024 15:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2F01C21715
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2024 14:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF5F1A2554;
	Thu, 31 Oct 2024 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lEwUKk6j"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB381A0BD7
	for <linux-ext4@vger.kernel.org>; Thu, 31 Oct 2024 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385240; cv=none; b=DZO0SR5k/dMPQAVXGfnLcP9XXp/GwixgDc4jONRnS+MJJ4HIwe8GtPQ6Bf4xKv89B70/Qrgz3xcxH9TZ8lzlJUdAjHsitq3899b81z2PkCHjOfCvI1mySfm2xoiZhr3rCkU9Awph4sl/FASCzaIDgEeJIkB35JB7rGZYGdApxwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385240; c=relaxed/simple;
	bh=C8ggQh5DY68SvAzFdAXhqysQz7gLYo2gZ4AsHL1D9jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwr9xM0ey1BAzN35cpDKVaW8BzEQURjHIhS9mc8hcBLv9gxxFvli1crfcJ9iCWoscVHkSo5AoBbXCIHqroV8jooSl49zeOfAnZ+S5jYXjCGWEQo4B25vFWrbfRHgHG7YCcVc1J2pD8Uz1Lr2WSVgEZF5Kc+pKrQDkm0DcSP7/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lEwUKk6j; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-2.bstnma.fios.verizon.net [173.48.111.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49VEXinM026370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 10:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730385229; bh=GcKNEt7MiRVj21yu9kqvlPfY/5V3ZCbsyrssHSHS2Ow=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=lEwUKk6jxACg9YVaF/F8oWkRXEdvUb+UpggE1dFguhdywucaFc4xnTfX0Qc3aARaW
	 5aa07aCpq76EXtELMD38YqY9/1+R3xrP9cok+iemrqqEP5hTagXZZKZz3AQZvOB6q8
	 QhbKMn8fBft7PJtHqsrz5c+PZArIrd9yLpKtOes5EOMlxlMc3dzIkbLRx+S1OWS1wE
	 TbQCn6rFJwYn62t8qHQntNfGL9T9/4LWOzyxKCsQjXL+7khVZUjv7+5597Tkt/ZK/B
	 oCYM3TSRAzU5VtDOp+fbQmi7Qp+3q7aK2hrvxNcun9HTWcUcw0ZgRQyypnQZn+eVc5
	 osUJDh1oW6FjQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 822F715C0603; Thu, 31 Oct 2024 10:33:44 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Markus Elfring <Markus.Elfring@web.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext4: Call ext4_journal_stop(handle) only once in ext4_dio_write_iter()
Date: Thu, 31 Oct 2024 10:33:41 -0400
Message-ID: <173038521047.99135.12205944048774667317.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cf895072-43cf-412c-bced-8268498ad13e@web.de>
References: <cf895072-43cf-412c-bced-8268498ad13e@web.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 25 Sep 2024 21:54:18 +0200, Markus Elfring wrote:
> An ext4_journal_stop(handle) call was immediately used after a return value
> check for a ext4_orphan_add() call in this function implementation.
> Thus call such a function only once instead directly before the check.
> 
> This issue was transformed by using the Coccinelle software.
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: Call ext4_journal_stop(handle) only once in ext4_dio_write_iter()
      commit: d431a2cd28e8b7a91474d496e9226ef06a31c6eb

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

