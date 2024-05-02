Return-Path: <linux-ext4+bounces-2265-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B798BA132
	for <lists+linux-ext4@lfdr.de>; Thu,  2 May 2024 22:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B9E3B21B34
	for <lists+linux-ext4@lfdr.de>; Thu,  2 May 2024 20:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D3E17F37D;
	Thu,  2 May 2024 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="MWZ1FIWC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768F42AB6
	for <linux-ext4@vger.kernel.org>; Thu,  2 May 2024 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680023; cv=none; b=TuzQbj9LmgF0oZLE3PCqVswHMpZfm7t9poU2En+6X0lWlKh5vAJAsUmtiJIlicCunyyMfQAIpNSlp4mYcBSaXL3hKIBF5Ki16y3SWfyEcwUch5qLXLNB+20QmMIWBlLex0t3C6HTnuFu8Y/Y6bbL1RGsYwAo60sq+tUXEcEYFxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680023; c=relaxed/simple;
	bh=/2UMkj4TSE0Swg1tFoO0nTCt60O0QLQmo2br5v99vPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kw8HvmLW8+FPf7J0kPNgzKoPeseg0Za9+FBXE/3oT/SSDFVlbcI9MhUHZzR1FZIhSZP0b/IiPqE747jdf4XBcVaraLTEww48qtSBsVLVfg3FNKKYB62R4dyw4VYCuSLLA2cplNINk/JNODbhtxil+NThEgGbLC6UAPW5txHP7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=MWZ1FIWC; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 442K0D99006121
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 16:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714680015; bh=yTb51h5cBnmCMcQ2qs+2+BXv9WOQoRbasDnjd4e0svQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=MWZ1FIWCNK99K/AuOEehGE/ds6OLm2kVR7we5Z1iP7QYULzL1tF3dEIcQ0gzBXPev
	 hJ9BQSPC/mSZZsq7+esOZbdIN0z7xVSE+ttts+KPZIq/33Y+j0c3LnjuU0QM33CYOW
	 kQi3S8tlgtRUo3K2hm5w22rpzTtDl0Ra1MHKQBPhfi+nvpU7sbGUxh1AjcG8ZS2wtf
	 /n9phFEqmY4Rp9LLwTsbiFhqGBYcQtIUJfFkHM5OLCKlLDWRhOm5LovMCO2paE1GIK
	 MmJPpiAAOt+jgAMm92/eQSXZg+MhUYCuWZBOrh24E8c5Ye8IfI6FOrPjSE3zbLXMcl
	 666NWicnGaAQw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A9D0415C02BB; Thu,  2 May 2024 16:00:13 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Avoid excessive credit estimate in ext4_tmpfile()
Date: Thu,  2 May 2024 16:00:08 -0400
Message-ID: <171467920458.2990800.4376695200797934645.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240307115320.28949-1-jack@suse.cz>
References: <20240307115320.28949-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 07 Mar 2024 12:53:20 +0100, Jan Kara wrote:
> A user with minimum journal size (1024 blocks these days) complained
> about the following error triggered by generic/697 test in
> ext4_tmpfile():
> 
> run fstests generic/697 at 2024-02-28 05:34:46
> JBD2: vfstest wants too many credits credits:260 rsv_credits:0 max:256
> EXT4-fs error (device loop0) in __ext4_new_inode:1083: error 28
> 
> [...]

Applied, thanks!

[1/1] ext4: Avoid excessive credit estimate in ext4_tmpfile()
      commit: 35a1f12f0ca857fee1d7a04ef52cbd5f1f84de13

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

