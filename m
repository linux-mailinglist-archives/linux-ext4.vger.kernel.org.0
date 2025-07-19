Return-Path: <linux-ext4+bounces-9114-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CF9B0B1FC
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Jul 2025 23:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D973C7ABDAF
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Jul 2025 21:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259441DA617;
	Sat, 19 Jul 2025 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="HeRomD72"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6118BF8
	for <linux-ext4@vger.kernel.org>; Sat, 19 Jul 2025 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752961579; cv=none; b=fOsVefwfZVl7WCHf1A4ysIevn2RZ/StWUuu2zA9ztFrkw8o8xdyEHWS7ghlNSYRQZ327NwNZ25OIC9X2LUYLWUYJD5P0cr9uZ/L2HiqdGs1CQmlrh0C5LSzE1+TQags0Mcil7DbZTDHJejvqrBLr/QhMFGox2d9OgUCC9pC5Bes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752961579; c=relaxed/simple;
	bh=g51E9qVkUHuH5cP4lzxW2eczfNGE0gr+PuJO9BddwSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKV28tuosAU1bE72OKd00+yTqt2zswa9w7qaUUhggoKYpFA54SjTK9UIDT7Lvw9QMEz4/eYxbqGhuC29VSwvGNXIAN6+qKrnMyAP3j8k5t0cWYM2Wcz4tWo6ra5ZakIqD79bncCVL4/KPHm7Ifw6ICw/Q4Tik2JSEeshND7rMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=HeRomD72; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-117-186.bstnma.fios.verizon.net [173.48.117.186])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56JLk1BF009670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Jul 2025 17:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752961564; bh=wZtbk6XggGNAIQo7Pj2dydBsNQKg5lH3amkmDSXHGQ4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=HeRomD72SCAwF3FPXAAgHoJDBM6zH1F4yqI3cMXKvrI92jh32PPzbzLf4JpCXeql9
	 1rrguHK91ufnXrU3BQX9BkE6MZkLAmjZidRezsQ5aCmZwMkdvzX7CHr+p+b8U0dBe/
	 SoUkCPWMKO/GeRWam9gqVfuIIHuv0KU1xlc6FDSq9eZHan6z7A+S68DRmyai8/it8P
	 QypdVlOqi51WWPXRup3+naOEqz9ahk7KWKSSh6cND83wrOHnPa0pqZhzvfw9Pjoo/V
	 ap/cNolcojWKxTeiCnRQCjZKEZDDIy7yHPt/wvmxu1niii0s36Xr0dTNF6jYyKxYfO
	 fFp22ThaPCe2Q==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 1E2FB2E00D5; Sat, 19 Jul 2025 17:46:01 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Baolin Liu <liubaolin12138@163.com>, Zhi Long <longzhi@sangfor.com.cn>
Subject: Re: [PATCH v4 RESEND] ext4: Make sure BH_New bit is cleared in ->write_end handler
Date: Sat, 19 Jul 2025 17:45:52 -0400
Message-ID: <175296153003.397842.9984626191637719714.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709084831.23876-2-jack@suse.cz>
References: <20250709084831.23876-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 09 Jul 2025 10:48:32 +0200, Jan Kara wrote:
> Currently we clear BH_New bit in case of error and also in the standard
> ext4_write_end() handler (in block_commit_write()). However
> ext4_journalled_write_end() misses this clearing and thus we are leaving
> stale BH_New bits behind. Generally ext4_block_write_begin() clears
> these bits before any harm can be done but in case blocksize < pagesize
> and we hit some error when processing a page with these stale bits,
> we'll try to zero buffers with these stale BH_New bits and jbd2 will
> complain (as buffers were not prepared for writing in this transaction).
> Fix the problem by clearing BH_New bits in ext4_journalled_write_end()
> and WARN if ext4_block_write_begin() sees stale BH_New bits.
> 
> [...]

Applied, thanks!

[1/1] ext4: Make sure BH_New bit is cleared in ->write_end handler
      commit: 91b8ca8b26729b729dda8a4eddb9aceaea706f37

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

