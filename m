Return-Path: <linux-ext4+bounces-9116-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CECFB0B1FB
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Jul 2025 23:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D81AA527B
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Jul 2025 21:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B8E22FE0D;
	Sat, 19 Jul 2025 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="KF1HJf2+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175033208
	for <linux-ext4@vger.kernel.org>; Sat, 19 Jul 2025 21:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752961582; cv=none; b=G4qkzUiLXWdujJsm3kcXYqn/V2Z3fZ6ccWZocgpmi8TVZPqGjg2/NcZFhqRmgfFRBc0wPH0zxtzRiuWjXMNp/sV8yeZXWPoHCCEPLgC3Zzd5rkSwTZcVLm3LUSDRp7H4tFDRnL/6tifSScjGRP5aOsEgLIQm5rAOe4FSyr682L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752961582; c=relaxed/simple;
	bh=rsFk0m1wzUGgmql+jRt6b72ND2V98KGu27RWREmEN90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/AT95aKwY6aer+OFliBzYXk7fd2GrkXbGHrQzDbjNZKydROHkDvDEzZBmHVEcXa4Cbh4G9yt+oJ2PoTdfKfsI5isqOQmoG/P4FqJDTrT9K1i371F/3t4h5fW65HdCnwLnndqWfSoisGNgq5iaV3z5q5OSRgDNLvzygOUB7oqgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=KF1HJf2+; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-117-186.bstnma.fios.verizon.net [173.48.117.186])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56JLk1Zn009674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Jul 2025 17:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752961562; bh=ateKGK5G6ibW3xgUev1QWjEYe8jtwF5cKiUGmAAwRMI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=KF1HJf2+NhPnATngEsw3cVYaE6XWZuu0ONgu6BtlwAVLXx4unpjgZu2me6lpEcKP9
	 TrHlTBJQyXFjOfzpEaMtX27NfwnyNNSDD4CLguhrkAlvlK7x6DvVt8HtD66cfTklGY
	 yyMFUuJJILrZlCtu2IhAcDvzue5YYxDsdHAK0f7LHokRwNshoxTpKm4sxTthguf4xj
	 VLixoc082JyvPq8ZOx9/w0Z9lT8sMNqPse5IhyTxXLAGvS0dLf88x+YihABZXyoybd
	 SmNrq4F+8E1/sEaN6OgR+RhTZZayBl5Kq/MidsduBclX4XYvMPWAnyNqvrq12Eg1B5
	 VR6+iYaMw/URQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 2735B2E00DA; Sat, 19 Jul 2025 17:46:01 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-hardening@vger.kernel.org, ethan@ethancedwards.com
Subject: Re: [PATCH 1/3] ext4: replace strcmp with direct comparison for '.' and '..'
Date: Sat, 19 Jul 2025 17:45:56 -0400
Message-ID: <175296153002.397842.308299159591338786.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250712181249.434530-1-tytso@mit.edu>
References: <20250712181249.434530-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 12 Jul 2025 14:12:47 -0400, Theodore Ts'o wrote:
> In a discussion over a proposed patch, "ext4: replace strcpy() with
> '.' assignment"[1], I had asserted that directory entries in ext4 were
> not NUL terminated, and hence it was safe to replace strcpy() with a
> direct assignment.  As it turns out, this was incorrect.  It's true
> for all all directory entries *except* for '.' and '..' where the
> kernel was using strcmp() and where e2fsck actually checks and offers
> to fix things if '.'  and '..' are not NUL terminated.
> 
> [...]

Applied, thanks!

[1/3] ext4: replace strcmp with direct comparison for '.' and '..'
      commit: 3658b8b3398eb2a49ee8d1ac88e5cdc41764f1c9
[2/3] ext4: use memcpy() instead of strcpy()
      commit: a35454ecf8a320c49954fdcdae0e8d3323067632
[3/3] ext4: refactor the inline directory conversion and new directory codepaths
      commit: 90f097b1403f232a202c501bfd49b1b196e840ea

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

