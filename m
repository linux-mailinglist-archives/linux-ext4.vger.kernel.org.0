Return-Path: <linux-ext4+bounces-2129-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF498A7B64
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 06:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA282B224B0
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 04:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CB21170F;
	Wed, 17 Apr 2024 04:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="OLZY0Ayz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19CC45949
	for <linux-ext4@vger.kernel.org>; Wed, 17 Apr 2024 04:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713328446; cv=none; b=oCh6ZA5zsnLp5RI+iEYmOqQSU45zmJpWXTnMeU96O6s1X2WQfU5MIgLMKyS7iSOLaWD+X1vMrZmDLM1SnUdMwH4JjUkdoT/fPTy8dyc5fPp2bsPj+nAELG5jcuAt7Ls7QNMqA6ithPBMeeHSVR9cwxHfxU2Y75UafcZYnnnRqEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713328446; c=relaxed/simple;
	bh=v0gFiG5RUmt4kU4KvdwFVYFfLjeENJtIP+NqCwE9dcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbPhafu6QIceM4V6T5/dUlIOSPbk8ouFIy4jehYt6sBzA2fojiCamVTZQm3ZJ8tyKg5RcPaVhOoNghoVwRApntmpGebEGlu+xArRLX5WM92pCTGRz1N7d5j1zw1U5IWrm8ym28OPa8o958udZkOtzjoQkJMl4hrhry5GtO011xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=OLZY0Ayz; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43H4XisP030664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 00:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713328426; bh=I7vRHLzCDwI1WrwcVnPEDZ0fdAZDRg86pJdk1RZ2794=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=OLZY0AyztbDc91NBzvzB/wXLEvEqyzErBzi4fTGOcPUQWQMc0FiuFexyonN8vSk96
	 BjECCaARxVxaa+NMl0bUDJEfzLVrbhhPOW0rLhAE/FhsRTmo9upNVntWq75vlH2ihV
	 JjtXDdfpcaKG347L/65dmLyEOpIzErZSikCtYV+E435GuxxpETuXjlW8Fa5++uWMC7
	 0NynuJ/VzrDnLDj1C9Z7wbZeCCKgf5VcyYSygzpsPYvCj4tSElVtLJhN5IVOKYheKl
	 wYhj0gFHAGi9HcH3emlBW0LjLOpAIUnCRYCeoO+aTkzt5JB3nHcgVdvLQZ7ccaLV25
	 1BvCD8pVtbrng==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 78E4015C0CBA; Wed, 17 Apr 2024 00:33:44 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Anssi Hannula <anssi.hannula@iki.fi>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH e2fsprogs] resize2fs: avoid constantly flushing while moving blocks
Date: Wed, 17 Apr 2024 00:33:40 -0400
Message-ID: <171332777784.2749069.4830925403023907737.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231107094920.4056281-1-anssi.hannula@iki.fi>
References: <20231107094920.4056281-1-anssi.hannula@iki.fi>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 07 Nov 2023 11:46:53 +0200, Anssi Hannula wrote:
> resize2fs block_mover() flushes data after each extent and, curiously,
> only if progress indicator is enabled, every inode_blocks_per_group
> blocks.
> 
> This significantly affects performance, e.g. on a tested large
> filesystem on top of MD-RAID6+LVM+dm-crypt these flush calls reduce the
> operation rate from approx. 500MB/s to 5MB/s, causing extremely long
> shrinking times for large size deltas (70TB in my case).
> 
> [...]

Applied, thanks!

[1/1] resize2fs: avoid constantly flushing while moving blocks
      commit: e0e6b13d0ea7330234a6fe51ec3ba13ef884735e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

