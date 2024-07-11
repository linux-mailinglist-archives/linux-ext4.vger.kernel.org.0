Return-Path: <linux-ext4+bounces-3185-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4571F92DE83
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 04:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDEF1F23B1C
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 02:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AC5C133;
	Thu, 11 Jul 2024 02:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Vsm9fNMP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A08D512
	for <linux-ext4@vger.kernel.org>; Thu, 11 Jul 2024 02:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665375; cv=none; b=fOyOQFwNkM3/n3m9ShQzyr4hfA9LKxHgKILjKpZCgx9733QAg7ID9rz37JI+GB4LiwXaLJFybACO7yuIuHyAtJw1wBH8qfw3nB/NMYrKLRg72qdrPxGjCw5od/zxwq6yvlFECKpcVfGtVDhhktlxhEVPPOW9S2NT7KYN0d94PhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665375; c=relaxed/simple;
	bh=NueEFf0t1sZJSd4qbpBhEWAqNGJbxPxlheiWcMAyz2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0tw7WsXjuD0KXqBuNG9fXtVBAS/YV+zou5BD8f7U5YB8HK1Mwblz6gKp+3N2jNWIE3l5l80OYpg150hWcn6aR3vahipE+yEG/rkziSDz8Zw0w2yBQQJeVcylvus1oGrBRY0beLuNpZQkT102MUz9N2srv8jqNHue0yoXhsXDOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Vsm9fNMP; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-79.bstnma.fios.verizon.net [173.48.116.79])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46B2ZhOD025455
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 22:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1720665346; bh=OSnidkPPLHOxiFT3TGKDV+j+9027LhrdPp6LYruURVg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Vsm9fNMPRKpK6GTGbpkyS2xZsoVw0kr6gpPrXZ1aC/bxrK3pwY9mpz8ySt65BM51W
	 ZeDSh4Y9aOozC0TAkCPAYhH/EK2CCpg663Tv2aYqNx+f6ySjb4RFPT3+AZSEDSBc1x
	 MV0MSgyNVNYTmRmBCsmQ0FD6vOuJfHZonYC7ybwUlieJCrIAtxxo3UCeSBLQvgZ3Ht
	 DfyH5pW15rUF8NZCXaivDjEYTmbJTNasPGuRK5wNb6EdSyGy7mzuaguPpTxlPW0qxS
	 h6ex8FI3kJqHx89DafLAJGJGFJ7FNHmjn0fO/pg8zIkADQC3yTWth9BKw5sgNL/DWQ
	 +dIh3fkvuCeiA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D9FF915C1930; Wed, 10 Jul 2024 22:35:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Ye Bin <yebin@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v4] jbd2: avoid mount failed when commit block is partial submitted
Date: Wed, 10 Jul 2024 22:35:37 -0400
Message-ID: <172066485817.400039.10621926219835783958.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620072405.3533701-1-yebin@huaweicloud.com>
References: <20240620072405.3533701-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 20 Jun 2024 15:24:05 +0800, Ye Bin wrote:
> We encountered a problem that the file system could not be mounted in
> the power-off scenario. The analysis of the file system mirror shows that
> only part of the data is written to the last commit block.
> The valid data of the commit block is concentrated in the first sector.
> However, the data of the entire block is involved in the checksum calculation.
> For different hardware, the minimum atomic unit may be different.
> If the checksum of a committed block is incorrect, clear the data except the
> 'commit_header' and then calculate the checksum. If the checkusm is correct,
> it is considered that the block is partially committed, Then continue to replay
> journal.
> 
> [...]

Applied, thanks!

[1/1] jbd2: avoid mount failed when commit block is partial submitted
      commit: 0bab8db4152c4a2185a1367db09cc402bdc62d5e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

