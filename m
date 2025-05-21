Return-Path: <linux-ext4+bounces-8071-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBD2ABF87A
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 16:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061291BC6F58
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0129223707;
	Wed, 21 May 2025 14:51:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF21B222581
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839090; cv=none; b=OasLMUsVVcfbgr50egEYUwispwPrt55YFjRHvmX+ZHo7dcOTVL2YQVkTj43STWleCT11PIW+mBiPOKhMkLeqP3JFHWKAXBNbsY9zBdtTikpdovd7o2CQcxUEArZ/ZSTnCP0uBG7L720TNdzA5B5beUa6H8caIyEtf+PdfsXnT18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839090; c=relaxed/simple;
	bh=g4CviFf44weDSCWQxRhUcpqIKTxmBYFEwStrvBz3NR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4887OYeH0lL+0KurZEGPtPX5fx9pMUsXLTonFqs+5veW4Rb/l4d/lLeqDk+IzddP+iuI/oSWzcCC2iN632QX9F1KFfP/apJDlAU8U5kUHQIn82e534mPLCulY3GdsKfheNSGBKsLwaglq6DK8UFi3te2lX/eXh0OXpB6FTrYf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54LEpDqx001382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:51:14 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id A7F912E00DD; Wed, 21 May 2025 10:51:13 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@whamcloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Li Dongyang <dongyangli@ddn.com>
Subject: Re: [PATCH 1/3] misc: deduplicate log2/log10 functions
Date: Wed, 21 May 2025 10:50:59 -0400
Message-ID: <174783906008.866336.9418124826859304764.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250125004220.44607-1-adilger@whamcloud.com>
References: <20250125004220.44607-1-adilger@whamcloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 24 Jan 2025 17:42:18 -0700, Andreas Dilger wrote:
> Remove duplicate log2() and log10() functions and replace them with
> functions ext2fs_log2_u{32,64}() and ext2fs_log10_u{32,64}().
> 
> The int_log10() functions in progress.c and mke2fs.c were not like
> the others, since they did not divide by the base before increment,
> effectively rounding up instead of down.  Compensate by adding one
> to the returned ext2fs_log10_u32() value at the callers.
> 
> [...]

Applied, thanks!

[1/3] misc: deduplicate log2/log10 functions
      commit: be4834c29e6f2c55ab6e6c9c94b95b46e24cfdb4
[2/3] journal: increase revoke block hash size
      commit: c2f2f0cdf5ad5f281582d810a0c48c612142a08b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

