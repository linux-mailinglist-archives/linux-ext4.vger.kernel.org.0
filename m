Return-Path: <linux-ext4+bounces-10442-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A8FBA53F4
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 23:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 804A47B6806
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 21:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEFF298987;
	Fri, 26 Sep 2025 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="okvM/xzL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E166296BAB
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923284; cv=none; b=QXHc00CeiED7IR9Ek5xS8GF+W8yeQmTV0yqyzjT7DV+e9Nc/wbacFU5JDizTxBw6gF6ocBC8tafgeBN2N3z6E2pXLXSFLMhGUcM1WcHuG1RZKydBgd94XAP41S+0aqA90h1tVaUumfsdxG22eIoS8dLiEtSplH7W2XWUlrC+Zp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923284; c=relaxed/simple;
	bh=MkWU/6f+fSnUl/CL1Qlh8jEvh7y4pv+/R48UasHyjpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4nVXchb4pRhLlbMyUwmcCCohuyJ6aa6AsDMADYloxC93jECxdoDD3tA3mZs2B3k0VntHr4ogYbK3qwHKflydAmC6st5K+Ukwl27yCizFkZNnBq5p9jWYoxVn4yYF6XXdBeA6hXMTR5ZC01ouByx05FogRtrAHhIXEfV9mWq5y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=okvM/xzL; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLluwG014774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758923277; bh=6L9BUYeyyOIIfKv4k8/ENXrK8PLqjkbHu0SkOFX77yg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=okvM/xzLXmFFsMUvMGjj98Y7fnsN/Mnx6uWFujjfV4SwghOkgknkktnfypy3ZqJIY
	 UQDUNMYCKw3+OoT7AKtwAC5rJxaj9D4G5o1H86+3AwSFKx0nQ4ERGUj8K7Y7UT5j2Y
	 t7+A//2df+PnwA88JczYm+uBvNx2bXnQuGFTwGz6xXuZBCkkRf72Fc+8r0b9/MZ8Qp
	 W7F+aEwCfAnYOxkHOg3pQnQCr7BL8PUspJsNtbYJyLErM/b2Q6SIIL9xjjXiJQMYul
	 QT9gtcorUcN8b3VuciQofD89cduVQycIgoR7m1wDGGfyjnOblpL0H1+k8Z1kEia0S9
	 WzOyimw3PXUbw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id F31892E00E6; Fri, 26 Sep 2025 17:47:53 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ext4: Add support for mounted updates to the superblock via an ioctl
Date: Fri, 26 Sep 2025 17:47:47 -0400
Message-ID: <175892300645.128029.14007371112529693095.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916-tune2fs-v2-0-d594dc7486f0@mit.edu>
References: <20250916-tune2fs-v2-0-d594dc7486f0@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 16 Sep 2025 23:22:46 -0400, Theodore Ts'o wrote:
> This patch series enables a future version of tune2fs to be able to
> modify certain parts of the ext4 superblock without to write to the
> block device.
> 
> The first patch fixes a potential buffer overrun caused by a
> maliciously moified superblock.  The second patch adds support for
> 32-bit uid and gid's which can have access to the reserved blocks pool.
> The last patch adds the ioctl's which will be used by tune2fs.
> 
> [...]

Applied, thanks!

[1/3] ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()
      commit: 8ecb790ea8c3fc69e77bace57f14cf0d7c177bd8
[2/3] ext4: add support for 32-bit default reserved uid and gid values
      commit: 12c84dd4d308551568d85203fd6ed2685e861fda
[3/3] ext4: implemet new ioctls to set and get superblock parameters
      commit: 04a91570ac67760301e5458d65eaf1342ecca314

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

