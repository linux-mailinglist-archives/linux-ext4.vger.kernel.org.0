Return-Path: <linux-ext4+bounces-341-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DE9808CE1
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Dec 2023 17:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767841C20ACC
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Dec 2023 16:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3703846B82;
	Thu,  7 Dec 2023 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gmeyRRi/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CA2A3
	for <linux-ext4@vger.kernel.org>; Thu,  7 Dec 2023 08:06:04 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-130-174.bstnma.fios.verizon.net [173.48.130.174])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3B7G5wYw030813
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Dec 2023 11:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1701965159; bh=8BdDr1D3xUuDvfKV4qPcVeU4Ul2r9TwrsoOPCjJK3AM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
	b=gmeyRRi/kLLUS3YirVKsvfDLfT3P1/v02NfZWE69A9I2LtQNy9rYsoLZ+INPH9iEY
	 XaoSbWqPHylOvrZVyXGP8f+nLjiXF+O2+0Krn24HUs4xbNU+S+3YEqFBri79zsC2TJ
	 de/VQEla2vwac+Vk/gtvTeAFrTiwbVVCWx+0tW+eBkCSsTo8s085aoBSDs2sAPjXes
	 BBr3XF5vLzEv5mRUo3qbqkpliHLbhOa16AZEr6ynlsgW1WRJzpcaJ2VO+jcQlrXgw1
	 5bvRMXJaT7j6JQkxRJjD5JLtEMoy5u43bMFpUBA+WqUromucekmoOzjieLbcWPBijM
	 tB5Muzeh8T8Gg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 59A7115C057B; Thu,  7 Dec 2023 11:05:58 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2fs: don't retry discard/zeroout repeatedly
Date: Thu,  7 Dec 2023 11:05:53 -0500
Message-Id: <170196512708.16594.7215006522173799558.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1683695929-26972-1-git-send-email-adilger@dilger.ca>
References: <1683695929-26972-1-git-send-email-adilger@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 09 May 2023 23:18:49 -0600, Andreas Dilger wrote:
> Call safe_getenv(UNIX_IO_NOZEROOUT) once when the device is
> opened and set CHANNEL_FLAG_NOZEROOUT if present instead of
> getting uid/euid/getenv every time unix_zeroout() is called.
> 
> For unix_discard() and unix_zeroout() don't continue to call
> them if the block device doesn't support these operations.
> 
> [...]

Applied, thanks!

[1/1] ext2fs: don't retry discard/zeroout repeatedly
      commit: cc20e3c4320ae34dd06ec4d6a71d07aa7d6599d7

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

