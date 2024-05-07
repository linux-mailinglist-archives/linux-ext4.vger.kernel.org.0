Return-Path: <linux-ext4+bounces-2350-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93BE8BF141
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2024 01:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8307E286E57
	for <lists+linux-ext4@lfdr.de>; Tue,  7 May 2024 23:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB9982497;
	Tue,  7 May 2024 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ew1Iw2JF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D44012BF29
	for <linux-ext4@vger.kernel.org>; Tue,  7 May 2024 23:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123064; cv=none; b=ZXBRIYCDuIcSqQRRbP4M57HbV4uWPS13zoRP1LE09KmbxxBlf9qSKM9o5MZeERVivnytXdis4HncZDKhw9Pfu4m8z/TCbJroaXgw891zgixM/k1qkLlnUKFQVJHIykX+mCxBAE62n/QgQ9q7C3EUj6tt7VU8PsRn07PIoQtqb4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123064; c=relaxed/simple;
	bh=2M+KmZprJCApjJb20RXD0Lpgyd9aK69CB+zmwx+ItRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCb1RpnfLOLQ6D4mZwoh26B3jfajKX0Wz6hgzTL9C4LALSwpj68bElHq2T3YbLmWz9yvgnOPbOTfmxOo4x+67FleFPMu3YKF/TGmB3un9RJaPmpFiYrGz5aRdsa1YNRAv9oHReqGGfEjPRi2Pr3wvE2N2o6h6Xm8abM7yPhfMkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ew1Iw2JF; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 447N40OQ026156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 19:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715123045; bh=lzTTUd9PzF3vgkpDA0XZwUuNlJRtK6e/3MWs0LiCM48=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ew1Iw2JFeLEdQwrfvi0xcZfYttH5v4zB2JNSje15Xr1quqv8W/K61uknB6ucFWBPi
	 2UyVlxfOCt0lFatngMXEdZYritpHCGkxBpLFC2MqvtX3PUIX1K2cvkqzC8kxUnH0gc
	 O72eLjcdud/MJ/9sBe+PWXQoc09R4O5wtWC/ITgd2vwkV33pCEygYcSIPBGQTjqLaU
	 g3KuctgPT6jFnm/km3HJGcPSGcggISlq9xq+qV0BLZpOGiB8CYJQvLtgnCBbQa0lSZ
	 C+ZM8IFGTqoC2rvHYIpKbfBbO+mGWgepqYQJeYP5kFyxnVCdMK+Hb/UxcpTgmgyNBg
	 HaYEauT4Amn5g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 0FDA715C02B8; Tue, 07 May 2024 19:04:00 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kemeng Shi <shikemeng@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com
Subject: Re: [PATCH v3 0/5] Minor improvements and cleanups to ext4 mballoc
Date: Tue,  7 May 2024 19:03:52 -0400
Message-ID: <171512302194.3602678.5608981738614745810.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424061904.987525-1-shikemeng@huaweicloud.com>
References: <20240424061904.987525-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 24 Apr 2024 14:18:59 +0800, Kemeng Shi wrote:
> v2->v3:
> -Coleect RVB from Jan
> -Remove more unneeded "cr =" in comment
> 
> v1->v2:
> -Collect RVB from Jan and Ojaswin
> -Rewrite changelog of "ext4: call ext4_mb_mark_free_simple to free
> continuous bits in found chunk"
> -Remove "cr =" in comment of criteria name as criteria name has CR_
> prfefix now.
> -Only open codeing repeated checks in next_linear_group
> 
> [...]

Applied, thanks!

[1/5] ext4: keep "prefetch_grp" and "nr" consistent
      commit: 9c97c34a998a01bc0cf970b1685456bc2ea16b64
[2/5] ext4: add test_mb_mark_used_cost to estimate cost of mb_mark_used
      commit: d0b88624f81f272626c767f4b715f4b690fcbed2
[3/5] ext4: call ext4_mb_mark_free_simple to free continuous bits in found chunk
      commit: d1a3924e43a35860ed7edaeec7f901a1ade2ac37
[4/5] ext4: use correct criteria name instead stale integer number in comment
      commit: 2caffb6a277bb0f2a482a2eb824d012d5f45f4d0
[5/5] ext4: open coding repeated check in next_linear_group
      commit: da5704eef7037a5bc84a56519729d93d10a0e0a0

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

