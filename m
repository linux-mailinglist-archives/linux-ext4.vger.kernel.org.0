Return-Path: <linux-ext4+bounces-2263-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2498B9CDC
	for <lists+linux-ext4@lfdr.de>; Thu,  2 May 2024 16:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1876F289064
	for <lists+linux-ext4@lfdr.de>; Thu,  2 May 2024 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D9215359A;
	Thu,  2 May 2024 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PQYu2pjI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196731E526
	for <linux-ext4@vger.kernel.org>; Thu,  2 May 2024 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661514; cv=none; b=RkcHSIP2IMhOyYuuQysohdoLUZ045AwZD7J0IjCdc/CulP6wPPpVuFppqFzzFq7mMz6Jwn/2XcXUkCBw65yEczNdrKiPzOx1iZQgOgvC4CL585TvxhjOY2D+L+z5zF0a7RHdHpL1Kknmaeba4au5XvbR2/hKeQQfBCQPDS3AkbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661514; c=relaxed/simple;
	bh=WPgF3F69+qFKERSg7dMFGdM8ADSRBEOSxQ03oIZjEf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eONukfP9juSsHV3iK8iJZFqXAieqhY4m2bCTej9NdXGQlraAU2oSFEUhVPIvHnXNR6khmSsp+h1BVTc2pFoWRs8uMsXsRwTw4OKXVsnTzaKDUbR3cCQ5rWDRGw1Qab5pVckbjY9eLA/ZnmCdvUwApY7WBMvyOuans0v5+Spy0mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PQYu2pjI; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 442EpYE7032603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 10:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714661497; bh=JR52nggQZWfUmENivxZcKYRaIXuqgrtJvq+qw8Lw9Hk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=PQYu2pjIXuElk9PJbHlNvKspB/mzsOm4RvSeWI1H5DWyzAp5NlNiegbdjVV6kQma6
	 oW9c2glpBS+HB/hu4a2/BDpD5urcidcVeMwuFj+mKqJq9JtpaDIRYuc0yKh62+nPsj
	 AohDgOqoHYMx2gwYHKSA4URxlubb86RsAdCO34g4DJN/ocCigCJHcitpf2KB3zgK9/
	 0Zv5UiDDtVgrIm4yy/0fF6lXlpfdGmGPuavTJIzltCxu4P2XC6ZxzogvEnAbc2Wb0N
	 vnwOrevVfULcB/40BrbfyHp8SXQvj54QvROifLK8WkoBpu3bxVpWwsJZZSE2Wd8r5C
	 s7tGSC+G3zAjQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3DB9F15C02BB; Thu,  2 May 2024 10:51:34 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        stable@kernel.org
Subject: Re: [PATCH 1/2] ext4: Fixes len calculation in mpage_journal_page_buffers
Date: Thu,  2 May 2024 10:51:31 -0400
Message-ID: <171466148381.2958828.7901686717993253303.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cff4953b5c9306aba71e944ab176a5d396b9a1b7.1709182250.git.ritesh.list@gmail.com>
References: <cff4953b5c9306aba71e944ab176a5d396b9a1b7.1709182250.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 29 Feb 2024 11:40:13 +0530, Ritesh Harjani (IBM) wrote:
> Truncate operation can race with writeback, in which inode->i_size can get
> truncated and therefore size - folio_pos() can be negative. This fixes the
> len calculation. However this path doesn't get easily triggered even
> with data journaling.
> 
> 

Applied, thanks!

[1/2] ext4: Fixes len calculation in mpage_journal_page_buffers
      commit: c2a09f3d782de952f09a3962d03b939e7fa7ffa4
[2/2] ext4: Remove PAGE_MASK dependency on mpage_submit_folio
      commit: 53c17fe55a06cbb405b94d96759611d725d2c47a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

