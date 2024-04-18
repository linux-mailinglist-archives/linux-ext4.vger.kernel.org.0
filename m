Return-Path: <linux-ext4+bounces-2145-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E878A9DA4
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Apr 2024 16:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15803281E83
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Apr 2024 14:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB2E168B06;
	Thu, 18 Apr 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="UJDq98an"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70632137761
	for <linux-ext4@vger.kernel.org>; Thu, 18 Apr 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451986; cv=none; b=Zya65RPSS2iAJzwQOvujs4H0K+mhln1k57Xw4kHjzyhL/jGNrQe653IqiQRSIteCtx+3/KRlnpTlJ18wUoQkjfdFraLx7f/22oWN9lqvjl6dWY6+CjmPvurZwiR1dgtnH0SpcXdn4YcboeOEEKJIXKAUe0UOjMO7ZAeKR6qEos0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451986; c=relaxed/simple;
	bh=j00t2PKPe2h/mNzbq04BT+FBsngK8s6ORQxbDnKGtII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsrMbpKaG7mpV8jgrbPNTr/o4K5SEyXgG4Pkxr6zTVU6wfXykxQYPa9kNgPUnQEO1FDU3V4aOiZJ9asddn4UgJ/AlBQj91niMyryX/oQGY3Ur3ugXVKFlG+RVZPzx3B48IeIt9Ck9ZeCqP9wVGYY5UlX1lS0HLcprjcJm1caUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=UJDq98an; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43IEqtWP018578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 10:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713451979; bh=Wp1G16tgzb4yCi01boeAthMNP8cwFm/rLSUwXRy4xZo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=UJDq98anvCdF4z6/lAHCq0oPbIvzBnwJ+quOV4baLYNu4ENaPpj0Fbf8oC4G0G5uH
	 aqZIyllHCikSrbYFOy+sCD7zAPub1lwUcxlPcztntjG2J7V5hFyq3bk2bPs1DTTBJE
	 MWT7uYEoLO6hspf417mQL83Un+RbYNc1w1MWM7kv9QVaUgAaQi6DIerY9ub8+dIuoE
	 Gg3wuSzkdSmblILgVneBCi+AXiAzBGB0TTI1ctNZGZgdffPE0Wp2RAnXev9BJh/Udz
	 opq0njfFySBEg8k3G7gzS5GS4x4ehK025V6to2qf0wqndDXM0kih5yfULYKkduAiGV
	 lI8CsF0desY5Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 195E515C0CBA; Thu, 18 Apr 2024 10:52:55 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Pascal Hambourg <pascal@plouf.fr.eu.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] e2fsprogs: misc/mke2fs.8.in: Update default inode size description
Date: Thu, 18 Apr 2024 10:52:36 -0400
Message-ID: <171345195124.3374690.3098788458634501991.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <E1rx4t4-00073d-1e@zenith>
References: <E1rx4t4-00073d-1e@zenith>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 17 Apr 2024 13:48:22 +0200, Pascal Hambourg wrote:
> Since a23b50cd ("mke2fs: warn about missing y2038 support when
> formatting fresh ext4 fs"), the default inode size is 256 bytes
> for all filesystems, including small and floppy, except for the
> Hurd since it currently only supports 128-byte inodes.
> 
> 

Applied, thanks!

[1/1] e2fsprogs: misc/mke2fs.8.in: Update default inode size description
      commit: 0d346c3a0851a52d332c6b4bb1ab021858ad3cc5

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

