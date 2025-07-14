Return-Path: <linux-ext4+bounces-8996-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A732B046D8
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 19:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B82189C611
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 17:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A369258CEC;
	Mon, 14 Jul 2025 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="AtFIuCGf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417579FE
	for <linux-ext4@vger.kernel.org>; Mon, 14 Jul 2025 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515242; cv=none; b=eYPLPCQq94E47+KT/KGz6QzCFWxyMGk7dk/jQRqVgAd4e+DxBQv+G6f592GnlxBrX2gX77TXMBShPkS7oSh5R6MB4PDQL1K/udB5gpIdfrCQfyh+P47kK2+Crswv4PYhs/otOQ9ZfLUs69MDgL8QhpLcENS0e5BzhMrxRhCbX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515242; c=relaxed/simple;
	bh=AI1vTvHLWqYIaeqm1PAiftr4WMaTl3SszV3ypdKVuc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G71851uqpxItRm1hWEL+pRDkLCwrGXcCa2+ZlFJjEW/y462d61e1KbB1JswQgadTg8CPXvseCXp8kNevIbF/NfxLpVRYUNhj2asiTlSkoBt0rMc2w2pTU4gnrabQVbnXem+RCB2xt0PlVZIMC/3kF5tDIOCnUiqSV15lhYZGKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=AtFIuCGf; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-88.bstnma.fios.verizon.net [108.26.156.88])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56EHkx4S021821
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 13:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752515222; bh=yZzKDXarn/y49OEK99mtIshfkv/3B3+cqduOcnSWbIs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=AtFIuCGfqnzo2Eqb+JexMpQckvZj5lBgZM+H1jmPynXkygv+4LZyOjLIxrxjut6eZ
	 n8igEmRCZzfkAFvsbp7urbmGrJ1vp61uLiHInxaeL63B880nX7/hZ71mDlG4h9PwdM
	 WGr/sE/VX470nw00mGDZCvoixa4IsmQOC97x7byV9UYqWEZVv7Tjzhbw5fzyFxUWZm
	 lVZXHVaVieu17Q0LWoDnICzhReVil0Kc+A9N8+9mAh1pSljzBVm1veJFSo8NHzeYxY
	 iNkd6tcGt26S9D9T6IfaWKK5wXpi4XEFWhJ+2BEpWjVLUa9VqDhwbGysNCk9kOdn+X
	 4G717RTLCGjAQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E32D92E00D5; Mon, 14 Jul 2025 13:46:58 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Baolin Liu <liubaolin12138@163.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1] ext4: remove unused EXT_STATS macro from ext4_extents.h
Date: Mon, 14 Jul 2025 13:46:40 -0400
Message-ID: <175251519238.80092.14886450019680623922.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250527053805.1550912-1-liubaolin12138@163.com>
References: <20250527053805.1550912-1-liubaolin12138@163.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 27 May 2025 13:38:05 +0800, Baolin Liu wrote:
> The EXT_STATS macro in fs/ext4/ext4_extents.h has been defined
> but never used in the codebase since its introduction. This patch
> removes it.
> 
> Analysis:
> 1. No references found in fs/ext4/ or other kernel code.
> 2. No impact on compilation or functionality.
> 3. Git history shows it was never utilized.
> 
> [...]

Applied, thanks!

[1/1] ext4: remove unused EXT_STATS macro from ext4_extents.h
      commit: a073e8577f1816cfd2cff25d0a4ffbeb064b48ae

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

