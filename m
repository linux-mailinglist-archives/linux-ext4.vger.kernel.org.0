Return-Path: <linux-ext4+bounces-12864-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F4DD259CD
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 17:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC76930F21A5
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2F22BFC70;
	Thu, 15 Jan 2026 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="HxowF311"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58F729E110
	for <linux-ext4@vger.kernel.org>; Thu, 15 Jan 2026 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492973; cv=none; b=iPOlCUTFjLX4xzrARswD1mtUN06kUWg0p8bYMQyE56g+rtxT3x/Yz53g+BlINFUyIiman5n9hJXoxuzsMOwe7ZE+Irl4tY0QJmHUC76iNC9zv7nYUbqD/UAQuqmT3YcEwAgfSMfdV9yLEC9NHSzCRSKyXBYCy5BMQPvDDl0wE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492973; c=relaxed/simple;
	bh=gJBPidgLPAYO1kC25Eas7RdB0ZEuKqjdUNydTsZQjKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pxrsr8R+rG6+puj6MgHDVA60M48MJxdAzlXtpc0QZ3B+sZLAK9XCtg0l24mz7O2dnmXhnvdeHp/wB7XqCygBQ1wPBDN/HXcyXKg7PhpWZ4oSBfI7pacXbM9cyKc3CbCuJAVCr0Ln0sKW01uelS5KMPRH8jYFF7tHJYLZ5vCfiHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=HxowF311; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-142.bstnma.fios.verizon.net [173.48.112.142])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60FG1xUg018688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 11:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1768492922; bh=ee1rYwzoiuEKDcT8iowfABcVqtAnFbb6ZHAx6FiYLL8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=HxowF311NE10srwymOS+M7keWhb2Y0iaJJpJSyWpJNSzE84zcyA2Dj04QxcjJer9M
	 52NgR/95XkYS7jrZADeOSYI0f/Dt6+k5OB9HY7nZ8rY1uFOV/YX08gKrWKBosNWip+
	 OYoUFTws4LvPqvpQ9zSW7srLyZLGviXEa1b3pgAp+lLHFuFlw4kY6322VpxFsmTrpV
	 UJ0t1mQYKnMAKKSfB6LQ8TXxGiYvLmj3EQsFTee00Hzs6i1RedJIyCPJ47wRQspaMC
	 /B4zLJEc9Z5Aiv2RuthI5b18WMK1lvGm6c6Yemtnsw5XWlUy3mCA1flbntIx2Bxy4s
	 0eqGq0AxEXtdg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 443052E00DA; Thu, 15 Jan 2026 10:37:48 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, eraykrdg1@gmail.com,
        albinbabuvarghese20@gmail.com, linux-ext4@vger.kernel.org,
        Yang Erkun <yangerkun@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, libaokun1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huaweicloud.com
Subject: Re: [PATCH] ext4: fix iloc.bh leak in ext4_xattr_inode_update_ref
Date: Thu, 15 Jan 2026 10:37:41 -0500
Message-ID: <176849145608.443151.6337295123633371431.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251213055706.3417529-1-yangerkun@huawei.com>
References: <20251213055706.3417529-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 13 Dec 2025 13:57:06 +0800, Yang Erkun wrote:
> The error branch for ext4_xattr_inode_update_ref forget to release the
> refcount for iloc.bh. Find this when review code.
> 
> 

Applied, thanks!

[1/1] ext4: fix iloc.bh leak in ext4_xattr_inode_update_ref
      (no commit info)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

