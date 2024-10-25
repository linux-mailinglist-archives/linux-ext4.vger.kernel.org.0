Return-Path: <linux-ext4+bounces-4751-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCE89AF884
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 05:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129AA1F226B7
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 03:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FEC18BC27;
	Fri, 25 Oct 2024 03:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="jdPCGrRg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037FD18C907
	for <linux-ext4@vger.kernel.org>; Fri, 25 Oct 2024 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828449; cv=none; b=CqNijYIUSjjPOL10aWpQevsnkVu8qLOIB6S331xrtIIRlIXmtqBP2riE1bfStIRv70rvT0xyFOV05EHPCek1FVcMq7GfgC1FiFwaS4WLpxdY9mzq57W2xV+S1J1YwUVTr5aAuv4CsMsKCjQtoFCA5XDseauYgzmwHHdgBCEdYlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828449; c=relaxed/simple;
	bh=nMxxoSAmXDNv1B3rAE0bi5dm9X3LLqP55Bk1CuktTVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXpGfOHy+1wW0trq13Zs3oY02I13g6/SrQd/LO+h0+SHAle5wDMiHvbefPm/N5QqBxva0tF9DQxM2/hlYYWiVS088E0qkeLs17qCaSE/alJtfBMuED/b4fZHvdq+tlxAv9fYvsoPU1M93QDOi8JgNGvmxsf2hlhFL6d/3ZHP10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=jdPCGrRg; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49P3rxOj027527
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 23:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729828441; bh=wOEKlbqBc4WsowJpnD35QZecdtIsJ7r8YQpDuqFTb1o=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=jdPCGrRggtWh3jD9fnoNpPi/+88eHbS+D5koBZriKeREfO2ZGvucFhcE/A8WFO28b
	 kriblGQptu3tVB2OBoZWOejhvIC3VtQkMb9RB0aT1H0swZWZ9806v/HPts9psYVFwp
	 +tdaKAo1edxvNzP2mfiTrPkkorX8BZduxUt1ru1gSEENyAhl25i8a5VM6MhRBV5jJG
	 AhdOth9/9g+FxjaGECmfFyI+tr3YdPDCC2xojtLYdNpPsHhpO6n8jCs3MVyY6LwQ3F
	 pLW5FwoAprh3CB3H5ByzTB+oJsMBygLxFoWPFmJsTG5QRbVeRrSHQc7+rHmm1Faglh
	 yFjVYfo9LpkkQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B070315C068B; Thu, 24 Oct 2024 23:53:57 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>,
        "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/2] e2fsck: make sure orphan files are cleaned-up
Date: Thu, 24 Oct 2024 23:53:52 -0400
Message-ID: <172982841322.4001088.14673558132634157301.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611142704.14307-1-luis.henriques@linux.dev>
References: <20240611142704.14307-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 11 Jun 2024 15:27:02 +0100, Luis Henriques (SUSE) wrote:
> I'm sending a fix to e2fsck that forces the filesystem checks to happen
> when the orphan file is present in the filesystem.  This patch resulted from
> a bug reported in openSUSE Tumbleweed[1] where e2fsck doesn't clean-up this
> file and later the filesystem  fails to be mounted read-only (because it
> still requires recovery).
> 
> I'm also sending a new test to validate this scenario.
> 
> [...]

Applied, thanks!

[1/2] e2fsck: don't skip checks if the orphan file is present in the filesystem
      commit: a8df015009e7cd71b411f21e7d6f0797a28cba5c
[2/2] tests: new test to check that the orphan file is cleaned up
      commit: 9448aedd93521deb038f64ba16eff574628f0632

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

