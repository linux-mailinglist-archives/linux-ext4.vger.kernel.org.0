Return-Path: <linux-ext4+bounces-4747-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE279AF881
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 05:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF21B21C4B
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 03:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7616118C033;
	Fri, 25 Oct 2024 03:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Vg8wb1Sw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483F618BB9A
	for <linux-ext4@vger.kernel.org>; Fri, 25 Oct 2024 03:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828446; cv=none; b=ZG1BwxdIe1fPhKwvDlK5OZ9FaG+8K47yLfBgDbMCEJ4Y7qhofpQm6LK4vJV682+xtEeXKZn1b1HOatREGroB0KnXaGcjy4Im4pTkuelFDMXkIM181saOT0tvgAxoUrgoXNqqt+unJ741v3eK79hj/tAnXPWZ82Ztyate2ojpL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828446; c=relaxed/simple;
	bh=jws9toHPBfqEkTSlnCrI+UG68xLef+Mjv6XneyjrdZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8qDQst/VTtSm4PqHJy3cqiEpqYFvn6+qC6R0KWez3KCTPzyVmglaiI0NGNWObBW5KGZ3twIl5XFeRclosNdLWfKOX3dZJaJhTIi3X9uoLrvGqbbU4Thp1moTSCilkeFQEjsXoAUV9uGJ3cz4diFyNdZz2u8Pr+u2R++LaZhmng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Vg8wb1Sw; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49P3rvhL027474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 23:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729828439; bh=SQPIrt+9+cBGnSNlwWjz1jE8uVXaqnjhFgI+wiSIsUk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Vg8wb1SwA+0UH6OYAS7OJoGCMdp25hwfrg4qqjIQ6FiOj/FPIOrWctpu6oDBliUSy
	 XYIo6dTtyhbFv4F0GeAm5uI6kllIA8b2h+KPBpnklgiEQRX+YG6ifRfWPld/CnFJU/
	 1FAoI5zR2jFuXRG6/kJAShIALRQiffePxEylTIagoR8N56zEskSdvobhpDDEBEjLIS
	 exnh6t6DA397E2brKD7c5KIWJLbeRXXXo0cFmu3w/h9iCBNcZucdMCl8VSCNmYo9xL
	 R65961FasF11A+EVDBzYqlZf/f/kiRlvagg7YTvgNbfNdFNFgUBP+nnELKRH2TBxgG
	 ao3vOakBTcD6w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id AA60F15C05FE; Thu, 24 Oct 2024 23:53:57 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Alyssa Ross <hi@alyssa.is>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] configure: add SIZEOF_TIME_T to public_config.h
Date: Thu, 24 Oct 2024 23:53:49 -0400
Message-ID: <172982841321.4001088.16541388509451729205.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240527074121.2767083-1-hi@alyssa.is>
References: <20240527074121.2767083-1-hi@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 27 May 2024 09:41:21 +0200, Alyssa Ross wrote:
> This has recently started being used by ext2fs.h.  Other users of the
> ext2fs.h header would always get the 32-bit versions of the
> __encode_extra_time, __decode_extra_sec, and __sb_set_tstamp; and the
> 64-bit version of __sb_get_tstamp, due to the SIZEOF_TIME_T macro
> being undefined and treated as zero.
> 
> 
> [...]

Applied, thanks!

[1/1] configure: add SIZEOF_TIME_T to public_config.h
      commit: 6cbb0684c2618a27e49b04e3a99dcbbe90be524c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

