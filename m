Return-Path: <linux-ext4+bounces-9143-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6EAB0CDA0
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 01:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205681C22348
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 23:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304E122DA02;
	Mon, 21 Jul 2025 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djSFSTjh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C432C1C32;
	Mon, 21 Jul 2025 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139761; cv=none; b=dPQBxPI8hSX3QSZCu0vTXAOsqA6fxH6Uo7FL2ZW7d8K3798Kacsj65Q5iUv5Ff23FaPJHDbNmALFmTaUexZWeTiTWajXeLjR54hDIPFc/9hm9lt2PFFkUjYGWYmCxhrRfyYi9Sp9PnYYnLHLJ6WUxCH9SxtyCFYk86ZulqoFisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139761; c=relaxed/simple;
	bh=bg3AErbx3qcaOZTRaXuAqWefd1tvdSCGLoIohkga8gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQDTF0mlXpwqFo56HY5twafIOnGGuFVe33Dx4wMg3ZO4AxSe+0wGl6ChLO/F3RHr4c7UxGngCn+dBIlTAquoN2prQ0WNXpbpANosN+6oG8SpyhxjlexmHq2QaPbsBhLoCBF4y3UI9ilwm7IVtBPQhbP+86GpEv3LxKPc9BRc/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djSFSTjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23171C4CEED;
	Mon, 21 Jul 2025 23:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753139761;
	bh=bg3AErbx3qcaOZTRaXuAqWefd1tvdSCGLoIohkga8gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=djSFSTjh8tDbGf+Ye7KqrTVIZCJJKzIHHYgorI6EwsGZXSOTcykFOqMt2a1YIS7Io
	 51GanYR3nPkugd8tl/W1eqbLnn+iJDiGPZZWZD485UlZpSeXHGj3wsILs+IBtutB8J
	 hKaBlJu6P5v00x9/Po9GH2yzWlqXwUrcWNr7pXf/zZfx0fFp9h3uJfhu9z13nCEgB/
	 uKqvbcJnlZnHA4cz+D+AurdAIAv4ofbnm4K7CHvhR2/EPAHXs+38aPAVrniEzLPkXk
	 gDaHWprE2O/IclyCfqRjb8XsNaRvSlzNgCUKqVk9kSop21OuN/lYkl7+AJGZO7EBPa
	 zwt6tUV0d429A==
Date: Mon, 21 Jul 2025 16:15:59 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: kernel test robot <lkp@intel.com>,
	Ext4 Developers List <linux-ext4@vger.kernel.org>,
	oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org,
	ethan@ethancedwards.com
Subject: Re: [PATCH 3/3] ext4: refactor the inline directory conversion and
 new directory codepaths
Message-ID: <20250721231559.GA85006@quark>
References: <20250712181249.434530-3-tytso@mit.edu>
 <202507130429.rPIzofCD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507130429.rPIzofCD-lkp@intel.com>

Hi Ted,

On Sun, Jul 13, 2025 at 05:12:55AM +0800, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
>    fs/ext4/namei.c: In function 'ext4_init_new_dir':
> >> fs/ext4/namei.c:2968:34: warning: variable 'de' set but not used [-Wunused-but-set-variable]
>     2968 |         struct ext4_dir_entry_2 *de;
>          |                                  ^~

This warning is present in ext4/dev now.

- Eric

