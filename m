Return-Path: <linux-ext4+bounces-2278-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F888BA5E5
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 06:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160A71C22128
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 04:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEA6208D0;
	Fri,  3 May 2024 04:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YZPQPLbp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F40E2033A
	for <linux-ext4@vger.kernel.org>; Fri,  3 May 2024 04:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714709294; cv=none; b=pvaGfadkcA5ydQpBhRtbN7DHcTUvPoziPB0BcBDLUPW31rMNk9l1yr4uXpAPVhzYePZORFVVr7yrJYWTogkTBL5d+qwyZqmEAqItV8m5DTfumtRMHOdCnPSo0bTyoS5b9e7xdHj+QpaMQZ8rJt1Vm65Zr44UqJ/Qvl1+rkx/+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714709294; c=relaxed/simple;
	bh=SWsxKJEgzvpXcQlXwJrcVy/rjJDeDt64dglUtgj9IUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=naqNORO3vfh2vbZZJ15IzNLsxCM0MMgmUNa8t6cg9/0SZW5ddidABPlpCvxXkqpkrwCZ3JMdbz7/RFv3fV+3rtTJRNDVHg4qJ0TQDocVab0pAGvYMiFLwXhYiRMm6pOdK/dWwh80R/AR6o2iyX7vosHzrl0Q6xmCSBKjdDlxe1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YZPQPLbp; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44347jF6022592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 00:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714709268; bh=6W4nY6I7f9qgNvQB4sn4R6qrO7L3wg8HX6T3Kp+J8gs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=YZPQPLbpf74mDXdM+rn2mIT+rSu5A01rigdaQ6qqozJUoEwxKq/T994h/k3EI9HdH
	 CkD+g98QiL1JVK+YRmFxyO6g6W7kcYoj9S1hiiWAaLTbQ4XeESp4RUTEirQHjPBj7Z
	 7SYxF9tRtrGn+rmciZL3lnarQ3wbay+Mbca9iV3CFmkYlYA6VdIVo3PzX7fWa3oi08
	 MeD3Ed4I97ie44F/acz1ffFeHrqEdWj1GewdkkA95hZgC+Sh36gnFrANgKthpQEeDT
	 j53m3rLbl1m/orgKMCu5/eejtkGngzk1f/C5je8NMRSMw4ajxQHyD/8XHRIoLCHS9n
	 LRKT/0rsKZGxA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A07B215C02BB; Fri,  3 May 2024 00:07:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, linux@roeck-us.net,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: implement filesystem specific alloc_inode in unit test
Date: Fri,  3 May 2024 00:07:43 -0400
Message-ID: <171470925416.3028448.14729984123074119208.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322165518.8147-1-shikemeng@huaweicloud.com>
References: <20240322165518.8147-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 23 Mar 2024 00:55:18 +0800, Kemeng Shi wrote:
> We expect inode with ext4_info_info type as following:
> mbt_kunit_init
>   mbt_mb_init
>     ext4_mb_init
>       ext4_mb_init_backend
>         sbi->s_buddy_cache = new_inode(sb);
>         EXT4_I(sbi->s_buddy_cache)->i_disksize = 0;
> 
> [...]

Applied, thanks!

[1/1] ext4: implement filesystem specific alloc_inode in unit test
      commit: a11adf7be9d8baefe798eab49c356ab8e3924f0e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

