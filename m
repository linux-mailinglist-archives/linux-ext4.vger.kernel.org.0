Return-Path: <linux-ext4+bounces-11334-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E95C1976C
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 10:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B0C188E5EC
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 09:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C5E326D50;
	Wed, 29 Oct 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="sY4hn4BJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D7131352A;
	Wed, 29 Oct 2025 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731255; cv=none; b=lruw9tKzvMQXTAjkqflAPllHN+WCVniWsybA/Q82OwJn7s2CNN6mZkJZcCWhO50aEe/F/K8DgTayTt1qwFHqINZKb669V/bP4mOt3w3hvMWoV/ThJf0qWjIvMr22MZK4eZQGILWu2pN5/hs7FvMfQnD+EQwQ+eJRbvPWVdcAEVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731255; c=relaxed/simple;
	bh=EZLykF5+nD0j0H/qtlAr7yKbcKzbe0THiHcLF8iPYXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpcVOIXVB3DFNlmGq4sVGmpWOXJnlLWp1fyMuhTm/u2cY92+ALH1wTrA/i5nj7ORX70aU/6oaz7H0/XlK/iMtoT6PRYLM1i358El7fKnKrLT9LHeRrYBsQc3FBEIvXZnzEVL1vqLrBdf3737/+j8u7346WxnBlUHdq9XwUpHcp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=sY4hn4BJ; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 0B6364076720;
	Wed, 29 Oct 2025 09:47:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0B6364076720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1761731250;
	bh=TLz5zdyCTuCrBCHqkimDWCx7n89s+M72hIMxFHRBrJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sY4hn4BJBjCi/GvGhQ8+zJQXpd+frgeNHSRNSHuZvo3SgV5PXFVvJ14+Ny0pdPz/n
	 s0KkRVEjshdqzZqCvWPSiTZ5C4oyOJ6GNhwsQpemKmgDb7eAOVzYi47VhOmrsIAV9G
	 xGzb5LwZ5JwjDLaOlRpW1nlvohSrt5FMCtzjo/pU=
Date: Wed, 29 Oct 2025 12:47:29 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: kernel test robot <lkp@intel.com>, Theodore Ts'o <tytso@mit.edu>
Cc: oe-kbuild-all@lists.linux.dev, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/2] ext4: fix up copying of mount_opts in superblock
 tuning ioctls
Message-ID: <20251029123702-c9ce0615570d0ab7902183ad-pchelkin@ispras>
References: <20251028130949.599847-1-pchelkin@ispras.ru>
 <202510291703.2nhl90qz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202510291703.2nhl90qz-lkp@intel.com>

On Wed, 29. Oct 17:22, kernel test robot wrote:
> All errors (new ones prefixed by >>):
> 
>    In file included from <command-line>:
> >> ./usr/include/linux/ext4.h:141:30: error: expected ':', ',', ';', '}' or '__attribute__' before '__nonstring'
>      141 |         __u8  mount_opts[64] __nonstring;
>          |                              ^~~~~~~~~~~

That's my fault, apologies.  HDRTEST was not in my build testing for
these patches due to mistake.

There should be '__kernel_nonstring', not '__nonstring'.  The whole
annotation part is questionable though, maybe you think it's not needed at
all here?

Before sending out v2, I'll wait for the feedback on patch 2/2 - whether
the commit 8ecb790ea8c3 ("ext4: avoid potential buffer over-read in
parse_apply_sb_mount_options()") should be reverted or fixed with extra
memtostr() stuff like that patch proposes..?

Thanks!

