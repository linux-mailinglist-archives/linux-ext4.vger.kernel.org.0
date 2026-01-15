Return-Path: <linux-ext4+bounces-12863-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 533D4D25921
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 17:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 779BD300F680
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C8E2BE647;
	Thu, 15 Jan 2026 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XOv8O1Mj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BB22C030E
	for <linux-ext4@vger.kernel.org>; Thu, 15 Jan 2026 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492954; cv=none; b=T+mF91kZp8asKDMDzltFk9iUHLTmEaHRjSxjGzv1WmKbw6jQiRn2E/+i5hdt+aPqiXmp02sCCA90Z+L2mFQOdqOGYj7Q81cxnsK293w2o25Q/Ph6fuIaVlpQbZ6VZ37UEhWb7NJMBAH0wA7YbkzhLY6Ya7fnBmDwLeuK3kzi07A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492954; c=relaxed/simple;
	bh=QStpUTvRJMGvgcvgbH5DH55ZDeFM9bQtmbjQLWUE6YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLy1qvfzH+3ON4LFjG5Q63K+NIsbFp5x4J5asM936qgjY8bSdvY5tmC+9te97pDPqGdwbaAB03hXwH+Gn86IIdyvE9cCMDqup84dnSf79YllvsEun/9adXJEwKhm0MSM7B/D2QFOS7LT4lRxHTSePGCgr3mOahEn062iq/KSHIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XOv8O1Mj; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-142.bstnma.fios.verizon.net [173.48.112.142])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60FG1xwY018686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 11:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1768492922; bh=ZR/Lyx0nL/4ujZwCs2VMraL332UqgcNJ6FzcWValb2U=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=XOv8O1Mj0Y/m/gmtBO59rVtkx97VJuqHVTS3isBT1rzitCX7E6JJgQSdATjNMPJbT
	 0Oqs0ykG2c/PmnXjzxls3ZzbTj/pwr2fcwpLsQvxIBBpJs5G0QnbY5/aHDguq0Bm/8
	 zd88irEyNxNcb1uCIMffe5bn4VJGW8LrLPpdcSGfvtmdP5rSsyGfgoDQ+RScZnmXba
	 3bBNNL1UVVcp+0BcMKZ38q3xf+42mdmp7dRAlGHTGR/J0zkVLCzTyjBRZar3RG0aaZ
	 FTk3tBMXBhT9BUei/rYiketOdcJWnKDohS4MDcKQdf5KVkvJ48twhS/CFEMxdOfYQj
	 bODGoYywoWT7Q==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 3FC4D2E00D4; Thu, 15 Jan 2026 10:37:48 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Julian Sun <sunjunchao@bytedance.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, yi.zhang@huawei.com, jack@suse.cz
Subject: Re: [PATCH] ext4: add missing down_write_data_sem in mext_move_extent().
Date: Thu, 15 Jan 2026 10:37:40 -0500
Message-ID: <176849145607.443151.3423344603031355519.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208123713.1971068-1-sunjunchao@bytedance.com>
References: <20251208123713.1971068-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 08 Dec 2025 20:37:13 +0800, Julian Sun wrote:
> Commit 962e8a01eab9 ("ext4: introduce mext_move_extent()") attempts to
> call ext4_swap_extents() on the failure path to recover the swapped
> extents, but fails to acquire locks for the two inode->i_data_sem,
> triggering the BUG_ON statement in ext4_swap_extents().
> 
> This issue can be fixed by calling ext4_double_down_write_data_sem()
> before ext4_swap_extents().
> 
> [...]

Applied, thanks!

[1/1] ext4: add missing down_write_data_sem in mext_move_extent().
      (no commit info)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

