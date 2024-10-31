Return-Path: <linux-ext4+bounces-4862-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 432E39B7CF0
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2024 15:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E5F1C21000
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2024 14:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDFC1A072A;
	Thu, 31 Oct 2024 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="CA1kQjJy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DBB49641
	for <linux-ext4@vger.kernel.org>; Thu, 31 Oct 2024 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385235; cv=none; b=R9hNQHTbRNcj+moj8mDi7IAt2rbJFwlrKeYKLX3aMwIV3WwMf9k4wjP2oB0BKjhTO2TgjMuYw7/zDD8ZizsqIxoz0wDYmNC+GWe4I+hs5wNqnMxhS2k8+uD8RB0H+yj2DjbmjVLf0HCBicnHBAgfc9UnYJAcOkQNpIiNd+gnPjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385235; c=relaxed/simple;
	bh=nSMaax40XyfiwxwEeqqE+KE7sXHDPcwsDszirrcERWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYfbq1Q0t2Zq+8BTTO6T8wRvm5Ks6zRTJpkxOa4laCMFZGHeGziM7kjwKxWwYdMM+MAgGtbpHryoAHr/aR2eQgj1Ad9FQgcUNgvXyxY7KwMwjTS+mbP6Ch2DQzsAM+8nRoScUboxI3VP41w953VYpi8195maldpTVJWqw4Oz4Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=CA1kQjJy; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-2.bstnma.fios.verizon.net [173.48.111.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49VEXiFK026371
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 10:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730385227; bh=rYNcBFVUCNMCg+1QFWoc6LBLc7Cq0qljFBcwRg7uBw8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=CA1kQjJyr6785TsuDnk1aBplGD5NL3hihNtMFldwqvbDNWoLm0HsqMgHZvKAXLwDz
	 PEC/S6KOryZh8I5CZKVWYraUTd6zKtcOX2vD4Tw0egU/WG1Ry2DM5UHam7FxhRalTF
	 4grTw8Pid5XarqFmRKK54CgDVl28UYE1HTQDWYdwbUOsrExKWEmcunYNdQI0qjSIN0
	 EQdCKfBWzfULcKbKegDAtOPrmnQ347n42INzghDGcxMH8fvuDZwz+/Ko+lzOSPTHV8
	 qxFAJ8+s4VhmVNXwcYUXP4r+SSqyVyGQFF0LL9C3ftLqML4iTWW/ZUw/PCz8Hl8JRA
	 BMb3YkypVlmTQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 7A56415C032A; Thu, 31 Oct 2024 10:33:44 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Jeongjun Park <aha310510@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, akpm@osdl.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] ext4: prevent data-race that occur when read/write ext4_group_desc structure members
Date: Thu, 31 Oct 2024 10:33:37 -0400
Message-ID: <173038521048.99135.17276287567851231611.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003125337.47283-1-aha310510@gmail.com>
References: <20241003125337.47283-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 03 Oct 2024 21:53:37 +0900, Jeongjun Park wrote:
> Currently, data-race like [1] occur in fs/ext4/ialloc.c
> 
> find_group_other() and find_group_orlov() read *_lo, *_hi with
> ext4_free_inodes_count without additional locking. This can cause data-race,
> but since the lock is held for most writes and free inodes value is generally
> not a problem even if it is incorrect, it is more appropriate to use
> READ_ONCE()/WRITE_ONCE() than to add locking.
> 
> [...]

Applied, thanks!

[1/1] ext4: prevent data-race that occur when read/write ext4_group_desc structure members
      commit: 902cc179c931a033cd7f4242353aa2733bf8524c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

