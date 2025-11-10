Return-Path: <linux-ext4+bounces-11705-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26494C44EA4
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 05:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E50AF4E6797
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 04:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724A21E9B3A;
	Mon, 10 Nov 2025 04:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bfRiMdsw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635DE28D8DA
	for <linux-ext4@vger.kernel.org>; Mon, 10 Nov 2025 04:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762749225; cv=none; b=APsUbCx1DzxLQ87kdJG42x5LbMWTOx4yGuPxsoM513Mjx5OC2m7Cfvq7VzwMXzDJW+7yOZiuaG1JrJvcHlAniCwNBPz5KsIcrPRAaAQ3yksNlgXKxAW0fGBVcCexvr12+xfbPhds934ggTth5O/YF2xE9ggaA+m+MyjkwQQ9NVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762749225; c=relaxed/simple;
	bh=nTJTaXpzzBsfdj+1/crO1yYXdzbYP2qdrQO0b4BNBpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY7745EniybtjYq5webfG7isVicHagIsPcXITZSgNVlfl3wRpA6w/3I/Y5Ds35rVji0fgQwTiG6VK5rZ6hP4jSiLuJ3Y8Lhq497w6abzdTNLEkxEcoyxnsxqfr8tB7oxReuHZz24A09Hmv8bNUnd2fIvztF0pNLFX8hKhLg6lr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bfRiMdsw; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-154.bstnma.fios.verizon.net [173.48.122.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AA4WQhx031348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 9 Nov 2025 23:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762749150; bh=Ji62mRQ7gxde16ghmlwgDkA5BKifVd2MaUowQoZKmt8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bfRiMdsw8RflfCtLJ3pcuAnaMzkTW2Df9ohNF6OL2vQRmzzegIq+7wsMhyjVA4nwD
	 dbfm+C31wNDMboTLUQq3mquJn5plT0keEqfcmRSCrsT1qs9C9O+9g36wID0Q1pPI2L
	 uPmyaNuuk5JWXMxc3DVJJTqtFUVhFsjg6zM0Zn/qOyBACWAYaZMguVlDAzAJ3QgLn3
	 VEh/gSb00KWj6F8EfdQUxuxJeQR/bjsfT05JWn30S7y171bVSmmI6MMigFLqbEBKIk
	 ji9LxqzdSdOo3u6Z9zm56FM1by/K1s2XW605dyBrk5YnWOKOWnVZNYFmys5FyLFbal
	 7AS2mDV6Vnnwg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BE1392E00D9; Sun, 09 Nov 2025 23:32:26 -0500 (EST)
Date: Sun, 9 Nov 2025 23:32:26 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, kernel@pankajraghav.com,
        mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        libaokun1@huawei.com
Subject: Re: [PATCH v2 00/24] ext4: enable block size larger than page size
Message-ID: <20251110043226.GD2988753@mit.edu>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107144249.435029-1-libaokun@huaweicloud.com>

I've started looking at this patch series and playing with it, and one
thing which is worth noting is that CONFIG_TRANSPARENT_HUGEPAGE needs
to be enabled, or else sb_set_blocksize() will fail for block size >
page size.  This isn't specific to ext4, and maybe I'm missing
something, but apparently this isn't documented.  I had to go digging
through the source code to figure out what was needed.

I wonder if we should have some kind of warning in sb_set_blocksize()
where if there is an attempt to set a blocksize > page size and
transparent hugepages is not configured, we issue a printk_once()
giving a hint to the user that the reason that the mount failed was
because transparent hugepages wasn't enabled at compile time.

It **really** isn't obvious that large block size support and
transparent hugepages are linked.

					- Ted


