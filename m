Return-Path: <linux-ext4+bounces-4748-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95F99AF882
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 05:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718D028308D
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 03:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9265218C341;
	Fri, 25 Oct 2024 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="I5pbcaXw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7070018BC1D
	for <linux-ext4@vger.kernel.org>; Fri, 25 Oct 2024 03:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828447; cv=none; b=oagq1/BVWQU5Wk65UoQBhQ96bypzZQX6QB8ZGBQpiq4mV+CpKZUcM5IPJwPCygeAJWFu2eIWuUYmp2TzCCdJniP5BKg4g/XdfIpdu5zmnBiZZrNy5g99sxaN1YfbANo5OubUQUFO4LgCbpba/YTBmVOxAADGB7g6LCSIo8zv8dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828447; c=relaxed/simple;
	bh=iY6H7GOjp3rNG8ouPifK52xEbW/KwpuvEC2DXLKK91Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oo4B8COxgvsawIuCJgkL4dr1SgQH1+eK78O9mlQOxXTtYwWj563Xml8p8bMOuSeCZ5nXPnvbms+PNZp5mFZkiE3Kl4pp+H2yy5/biVR8Rf/VDu9xjVoy+PBmxc33ck3eL9MJlOMddVynRw1iaIA1TnVpl+7FRdPdXncddMN1RZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=I5pbcaXw; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49P3rvtY027476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 23:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729828439; bh=I8+xnqFbJSf0oRq5UMI8oEW/iEA1Ia4k6JXlOXC6uw8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=I5pbcaXwr6yGow8wv6q5lLko9msy6P1wGiQ2k1KLYlPoViWMAwH1EFNjf8NWPqsa7
	 zntmLty52T9/OKirqpvh3wG5lLUlb8oDRCsFPp25FvVuq23UhKw21rMPZ4FXIsWYsU
	 UiYQ9PO0FBinGALNLh6dNvrwgWXYiqLubFUnp62USWGlzOh6ugUzeztApAw3NB3TXc
	 Kp9r+UNDev8cYzdXtN41wRw4TuYCA1qTJRIpIZcjcg3eFnUaqfK6VGFfg4r7z6aSnu
	 rzcrBU7aSdYpA2Mn2URQbLCt6KFR7DqLSXzKXE4TCqSMBMtmuiJkFE4kJUHB3alrrI
	 IlvMGMgzyRDyg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A418B15C032A; Thu, 24 Oct 2024 23:53:57 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4 <linux-ext4@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] fuse2fs: explicitly set _FILE_OFFSET_BITS again
Date: Thu, 24 Oct 2024 23:53:46 -0400
Message-ID: <172982841321.4001088.9223384705402700203.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240529181214.GA52969@frogsfrogsfrogs>
References: <20240529181214.GA52969@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 29 May 2024 11:12:14 -0700, Darrick J. Wong wrote:
> In commit 3ab99d9b602, the build system was changed not to set
> _FILE_OFFSET_BITS explicitly due to some weird error on mips64el.
> Unfortunately, this breaks the aarch64 Debian build because libfuse
> 2.9.9 requires this value to be set explicitly.  Restore this dumb
> preprocessor symbol dependency with even more hackery as documented in
> the commit.
> 
> [...]

Applied, thanks!

[1/1] fuse2fs: explicitly set _FILE_OFFSET_BITS again
      commit: fb702218ab47b045cbbaf3268984fbdc5f75632e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

