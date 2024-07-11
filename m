Return-Path: <linux-ext4+bounces-3183-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B3492DE7E
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 04:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B842284060
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 02:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C6B7D405;
	Thu, 11 Jul 2024 02:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="qHW5XwEn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2224D10A
	for <linux-ext4@vger.kernel.org>; Thu, 11 Jul 2024 02:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665362; cv=none; b=tj5mv1eMIdCsevzKSz5G9crDgiP2cgj6iiPvMQRvV4CQOMW/frEqE7b3L99dq3IysHx45ysAe37fu4FVFom7YAM0PxbM8FfLJe//EAoRNixYxGxm9AjDPc+6/9xCUcDw5qkDitWJF6aEurOyMwPkRsXRkya67i6fTEvzbFRi2fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665362; c=relaxed/simple;
	bh=SaIR3HxhvRimkX5MYUsLr3EYmkjGfftWGnQhZOcCjAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKckFu6ICPGNr6dIe41qgtL/jSrsr22li8ICVO1n+eZlUDB0rh1f/somtUbIYYTowFUeSnfvlyyFvMSoejhk9DIurFy6YKXxIuDpak73QCsGJVQpHrNIxizpIAVIGHLULGoo0ITCMdyJXwQbPDpeEO+1jm0WD55uKt1dju8PiFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=qHW5XwEn; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-79.bstnma.fios.verizon.net [173.48.116.79])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46B2Zhjd025439
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 22:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1720665345; bh=0pnRCgQT7tYy2yHjIe8NDPbecJ1A1kWfXar9/YTvwBo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=qHW5XwEn9+93CMgMBeyG/KOEv/sVfVZ2xGR5GijqlTqOA4QjvZOcvZ0ducxd47/pv
	 MIYjuZtqEo67rOPr6y2Q31jAEL8QlBpiDAqfo2Y2mUCc8WaaI2Lhu1Qqs6yH03zYBt
	 mV3UlJg9NCbr8uhAXNaa8h68m0cpFE5NdoOoZ2lzBx8swe3HYPPt7xWo4pxL7qe3Ua
	 oFyIureJZxfngcKpz3Wwaa+8RZvmEoNP9OFAokRymf3pNoq6b83z6G0e+JsDR8tkzT
	 ZY5WDJAKqWxCWHNdvth7/cwB47wp83BJ8DR4OanOcY16p4TR0R0+Dy7Yexg+m6n9l1
	 hwViHIsfSBaaA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id CFFD115C18E6; Wed, 10 Jul 2024 22:35:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>,
        "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: use ext4_update_inode_fsync_trans() helper in inode creation
Date: Wed, 10 Jul 2024 22:35:32 -0400
Message-ID: <172066485812.400039.10346897666209783675.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240527161447.21434-1-luis.henriques@linux.dev>
References: <20240527161447.21434-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 27 May 2024 17:14:47 +0100, Luis Henriques (SUSE) wrote:
> Call helper function ext4_update_inode_fsync_trans() instead of open
> coding it in __ext4_new_inode().  This helper checks both that the handle
> is valid *and* that it hasn't been aborted due to some fatal error in the
> journalling layer, using is_handle_aborted().
> 
> 

Applied, thanks!

[1/1] ext4: use ext4_update_inode_fsync_trans() helper in inode creation
      commit: 2d4d6bda0f7ba0f188a22698855a1397c8999df3

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

