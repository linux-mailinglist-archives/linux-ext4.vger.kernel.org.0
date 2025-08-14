Return-Path: <linux-ext4+bounces-9371-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7108AB26A1B
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Aug 2025 16:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE701886876
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Aug 2025 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261571F8AC8;
	Thu, 14 Aug 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="iS+++2h3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AB232142C
	for <linux-ext4@vger.kernel.org>; Thu, 14 Aug 2025 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182960; cv=none; b=tO1sg1beot5869bQY6fP4DE5X5uIvh4jHjIXfn9E+PWB2ROoPPv5r3009dyzqGcyJJR0qVHfvSyqogOcPODJE0nkaWq3wAzlN8g72laawCJVzC3g807q572DVTY9IgtEjA+J3jTJK0ATyjKKhmwP8mJ0tJTYXiF8GMqvp8SkiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182960; c=relaxed/simple;
	bh=O80FZ4SG2mJ0h4xlDkgpzGxbeG1JzFm5mKts486Wy3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RK3gUylTBpQdUTDGvDejhIEnfdnB/Vx6DePXLrsjZQVtQzuZJJjHhvbZwAv7/0bCE3+/Okyq5tfhcZ113PhLaNRHdEOMTNZBjE4/BVH0s5Dx+Fzjg7oI9dqBHWSF3VQ7d5IQrZKsANm4AxNLkYkt7+m4wKwocjcfBR19aN0SAv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=iS+++2h3; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-254.bstnma.fios.verizon.net [173.48.113.254])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57EEmp33028582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 10:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1755182933; bh=1Bder4oTcA8ybTNliyzTVUbU2jhU7gjKSX5BArY8q/Y=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=iS+++2h3ik2YFqWfFGMmAG4JKXpCIIfJlaenWBLW8AtImySomUOxW9y3lWgCIa3x2
	 jHl52rTJoaAIb6iVH2qmLovo7/b8uLoh7nQoPDnoY+u6wS1vgMK+KrYuj8p2yWIcBt
	 tN6sfH4J76sPcEo6A1dE6qhStVaLq6akIvsiWAQMW9mXaYTUXBdhlYfC4tu6/4PZ+O
	 B5azMILxfIzr0nGw/C+2Rfjc4CHkWoPAMNSs2la2iCf5CGIwdYlodyF3TJlv5DYWEN
	 Q1P/8fby4W58do/neafaYXKMvY8r9DSE7qwwIndxpi7fCRCNbnVVhFgJLScrzpfErL
	 vqkN1+/e5fW1g==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D4A2F2E00DD; Thu, 14 Aug 2025 10:48:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Ritesh Harjani <ritesh.list@gmail.com>,
        Zhang Yi <yi.zhang@huawei.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 1/2] ext4: Fix fsmap end of range reporting with bigalloc
Date: Thu, 14 Aug 2025 10:48:45 -0400
Message-ID: <175518289072.1126827.15970211175946568112.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <e7472c8535c9c5ec10f425f495366864ea12c9da.1754377641.git.ojaswin@linux.ibm.com>
References: <e7472c8535c9c5ec10f425f495366864ea12c9da.1754377641.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 05 Aug 2025 14:00:30 +0530, Ojaswin Mujoo wrote:
> With bigalloc enabled, the logic to report last extent has a bug since
> we try to use cluster units instead of block units. This can cause an issue
> where extra incorrect entries might be returned back to the user. This was
> flagged by generic/365 with 64k bs and -O bigalloc.
> 
> ** Details of issue **
> 
> [...]

Applied, thanks!

[1/2] ext4: Fix fsmap end of range reporting with bigalloc
      commit: bae76c035bf0852844151e68098c9b7cd63ef238
[2/2] ext4: Fix reserved gdt blocks handling in fsmap
      commit: 3ffbdd1f1165f1b2d6a94d1b1aabef57120deaf7

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

