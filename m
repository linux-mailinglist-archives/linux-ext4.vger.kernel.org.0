Return-Path: <linux-ext4+bounces-10447-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49141BA5415
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 23:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A93456109A
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 21:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BCF29AB05;
	Fri, 26 Sep 2025 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GKwCNIwu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0476930CDA6
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923296; cv=none; b=a+gIGaIZ4X3D9Hd9UKC9kaZduCB/ALUG1ACR215t+X/qrDBd6TKOXSR1DHW1VDk7rTDxxXyrnsfxXOqsO5ugAVq+eLZklBvGrqytCZe0FOEJMN5Rchg24w6ruH5blUbGzjZVvIv+jIez3ILeDNTRwn4JNHsMQkhuADSiCYj81Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923296; c=relaxed/simple;
	bh=SNF5XSIkzfoubVeMWgItP0LHyGhdV8wvn8s8LRSroK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WqJJK8uZyOwU0EGSOo2x/y1V1mSEC5ApU0/TAiW0rcUTila7q71CEmK0nVDOY0LP3dY/5IABeO5I9w7C1c5ZYTS5uDnbKghauOx9ypag/bwrKLSs3CHrrYtxBpD2bdaHkAwypSvlJi85m5IZ8n1ykFcns4qQ9Ft52rw91o6+S0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GKwCNIwu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLltXG014749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758923278; bh=c8jfcZXXrcBFvXbHxZOIDX7eGGW1He3yQsm24i0st1E=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=GKwCNIwuGqJWLd0P6538wx/OhBfRsWlmTBuGg6QoejTtrPbcmI1GsMyiIQIWv0gQF
	 4NFmM+E7wXB0aGzj7ey+4GtNzoaSKYk8eS595RSlBsLxBgXNeLaX5YNdK+8CubY+E3
	 cuzE6kAqYtYc8rY8wTYo7tq0FcYsIbAiP4Geb/G1AnTNXZupgXlpJ7Hlt9Jky5x47U
	 NrUGN48S/kjlhlHx4MBYHsQ/SSvKEmau5NL7KQ7dkieW46Bnu2PSjdEI2YfgZ0jYVn
	 1mT10bOHIVXV66jDKsiwT5P4nkN9KzK0P1pi6lbGgiBxsb+VWtz4Hmw/+Ejxe320Fu
	 bgsm8K/x92L4Q==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E87832E00E2; Fri, 26 Sep 2025 17:47:53 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Ritesh Harjani <ritesh.list@gmail.com>,
        Zhang Yi <yi.zhang@huawei.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 0/2] Some more misc fsmap fixes
Date: Fri, 26 Sep 2025 17:47:43 -0400
Message-ID: <175892300643.128029.13242547873768049443.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757058211.git.ojaswin@linux.ibm.com>
References: <cover.1757058211.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 05 Sep 2025 13:44:45 +0530, Ojaswin Mujoo wrote:
> These 2 patches mostly fixup a couple edge case inconsistent behavior
> we were seeing in fsmap. Further, convert fsmap path to use block size
> units wherever possible to avoid issues due to block to cluster to block
> conversions like [1].
> 
> [1] https://lore.kernel.org/linux-ext4/e7472c8535c9c5ec10f425f495366864ea12c9da.1754377641.git.ojaswin@linux.ibm.com/
> 
> [...]

Applied, thanks!

[1/2] ext4: Correctly handle queries for metadata mappings
      commit: 46c22a8bb4cb03211da1100d7ee4a2005bf77c70

([2/2] fsmap: use blocksize units instead of cluster units was dropped
 because it introduced a regression.)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

