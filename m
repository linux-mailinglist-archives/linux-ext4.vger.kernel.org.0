Return-Path: <linux-ext4+bounces-3175-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A5092DE6F
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 04:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46881F214FE
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 02:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD23114293;
	Thu, 11 Jul 2024 02:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ehtvRESQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54E6E572
	for <linux-ext4@vger.kernel.org>; Thu, 11 Jul 2024 02:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665355; cv=none; b=fq3/O5+gocDMM6WOUyAzN+N/63EOkGqVZk81wyRz9qEO8XMQamyLhE8UDZ5ux7FWsguQsMHqlMsYY4HMoHtkELOm37ZgtAFQSZUX29gZizkC43v+YM8G9TTfMW//tGJ3Hux3y0PulNx4bkbT9M3Iwx2yHYenC9igh0mu356tTS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665355; c=relaxed/simple;
	bh=DxW9uAtefmBNbd2Up8h4ZCpKcBcqevmd3QJ/VKmVlwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z86HHhjoIcxfzlsNtqgdNYGeRWbcwm7Sbq1b5rM/RrQ6va0Doz1AmfGXIpkAOdRgXLELIUyTg0TquY9jMs8ixVxrkhCo5iG20zGlzSFaBsRa9Z+Wdh7iB2gPmtb1TEoJS66Wv0+drAzp6T0J7iuX3hBmxTgnKGMDKJXx5HjFl+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ehtvRESQ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-79.bstnma.fios.verizon.net [173.48.116.79])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46B2Zf0A025367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 22:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1720665343; bh=EGHTmjZUqsI0uWTy5z5IGkFTtaNfrja+wucjDn/QOTI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ehtvRESQiysN70uBRxwBCk8DAt3Ip/EX/slcDmGaBg8Hhd9+s8AF3DxlN4qZwU7ur
	 9W0b+TFGo8CUuZHw4Mz4gBsB656/2gzelXdRKGAITQYiiwabvH0NIILF2iWVDXD3aH
	 /d2bwnzH6QRW9YKbphf1awCGdRJ90GmpSSleMiQQUe2GsTwfwxFQSMvQmW1oph4NtU
	 U4K1vM1Re2aBl9Bizj3D8tL5pXgrVLNXdwkVt8YP+RbqgJ9nvlj6Hn0YbVDEljRuBN
	 tPx3Bs4WRhC9e9hlyUW8m5zn4tIboDA1MRqf5h7oo6C8VR13wKR7Q5xbfHnYhmid6U
	 vTokZsURvSxFQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id CA2B615C18C4; Wed, 10 Jul 2024 22:35:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Alexander Coffin <alex.coffin@maticrobots.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] jbd2: Make jbd2_journal_get_max_txn_bufs() internal
Date: Wed, 10 Jul 2024 22:35:29 -0400
Message-ID: <172066485817.400039.10126884036863007062.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624170127.3253-1-jack@suse.cz>
References: <20240624165406.12784-1-jack@suse.cz> <20240624170127.3253-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 24 Jun 2024 19:01:17 +0200, Jan Kara wrote:
> There's no reason to have jbd2_journal_get_max_txn_bufs() public
> function. Currently all users are internal and can use
> journal->j_max_transaction_buffers instead. This saves some unnecessary
> recomputations of the limit as a bonus which becomes important as this
> function gets more complex in the following patch.
> 
> 
> [...]

Applied, thanks!

[1/4] jbd2: Make jbd2_journal_get_max_txn_bufs() internal
      commit: 4aa99c71e42ad60178c1154ec24e3df9c684fb67
[2/4] jbd2: Precompute number of transaction descriptor blocks
      commit: e3a00a23781c1f2fcda98a7aecaac515558e7a35
[3/4] jbd2: Avoid infinite transaction commit loop
      commit: 27ba5b67312a944576addc4df44ac3b709aabede
[4/4] jbd2: Drop pointless shrinker batch initialization
      commit: 1cf5b024a3ffa479ed14e520f81549fce037f322

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

