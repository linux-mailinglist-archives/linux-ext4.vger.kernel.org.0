Return-Path: <linux-ext4+bounces-11007-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08441BF6BC9
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Oct 2025 15:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 750F74F832B
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Oct 2025 13:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2980333710C;
	Tue, 21 Oct 2025 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="C2UOt8wR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132827F759
	for <linux-ext4@vger.kernel.org>; Tue, 21 Oct 2025 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052954; cv=none; b=G09aHl6tYviCdIFrznUaKz50GPRhFMoiBBv/aYxxBhCEHT7ByRmqbvYk7O/vEDEQR+aYr0PwPZnzGRnF7aMGABlujKmw+gYB7n1yGErYsiBYTWS6TMVqxsVT9aeSFlvu29ZCI2B+xPJwbbAIjSTm/TP+Zo7Oq0JT+P+hc1+qoas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052954; c=relaxed/simple;
	bh=VfO1CbBOw7MopsrM7SEkx/WxGgqiiLkWkznH5P2LIjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpkhWQp9+HdFMOUt5XxTWnWIDOHTDfVg6bkkGQH+As2nTBcaUf4XAwyE9XptHniMi/eaY+OG7ZibECAAmVNqIxUrCgrAaIKznkBSkyl6cFYo52VJ9a/h0P8Z9va6cMpVUeWJf7eJ9t9VcF62yQQf7yYuA3/ytjhroKT54HIJoTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=C2UOt8wR; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([12.0.67.227])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59LDMCRY028899
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 09:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1761052934; bh=L1f9bubL92K6XuO72S4dObuGNiMMEyeRJppfl5CKIkI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=C2UOt8wRtAsJesRV9UXlRzlFDFY32ABfxELIMolZfJ5N9cxJvdAMFGPfHs9KtXiQH
	 wIdNGB16Q3y/eW3Fc+dCSnE8iSOzllpLMx5Yw8HyKgt/6Oy+sM+hJaZ+czB/T8FBvD
	 0nM+hUpDxcEo9kkLywAubEb3mQLhOW18VgfD6qKuEKCxYY3E+FawcAUhngAnnLJ+6m
	 W+G9jBlQqVLr1hH1e1+RB66zxL3KL0bRG5MXIvuRncteWqB87hXRGeT11wks3Dc6WR
	 QFjUXSfPu66PByAUnxyUa+jKwOEZyv69EaioB0kcjnd6UfKpXgxWabQ8eMaRAJfai3
	 hjB19+8dtbncg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id CF1DD4795940; Tue, 21 Oct 2025 06:22:11 -0700 (PDT)
Date: Tue, 21 Oct 2025 06:22:11 -0700
From: "Theodore Tso" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCHSET] fuse2fs: round 6 bug fixes
Message-ID: <20251021132211.GA6859@macsyma-3.local>
References: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>

On Thu, Oct 16, 2025 at 08:39:57AM -0700, Darrick J. Wong wrote:
> Hi all,
> 
> This series fixes more bugs in libext2fs and fuse2fs.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> Comments and questions are, as always, welcome.
> 
> e2fsprogs git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-fixes

Thanks, I've merged fuse2fs-fixes_2025-10-17 from your tree.

							- Ted

