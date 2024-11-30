Return-Path: <linux-ext4+bounces-5442-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE3B9DF303
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Nov 2024 21:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2576C162CDE
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Nov 2024 20:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C5B1A9B45;
	Sat, 30 Nov 2024 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ+0AMi/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2B517BD3
	for <linux-ext4@vger.kernel.org>; Sat, 30 Nov 2024 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732998968; cv=none; b=nesNGyTTcIwH7hkoBhJZAY7uZkxKee4AxB44NHPcZrNAvrf+bGH+TUgngSjkMHE4ZEfmBSXSLZQqW8GBUiy8tLKuqkh/ZIPpB8KZwU4yD+xfODnOW7zj7VcPZSKHO9N4UPbjzjhVN3ZSrjpYJwY5gDv/u6P8dIWLBkE/O1LVaV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732998968; c=relaxed/simple;
	bh=rIq9kk8+kLipb5jpn/zX9Q3YH/PEgvlgOdkmPs3WZXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeW7g+G6tCzWaqQ1Qh1HeNyyJiTQPqTs4AHGMtHuiiQHa2NuJX5YWK4eVezbq4a42kk1uowGkcRjrEY/1p7GUFQf2r5XctXvLwjbdpmAODruS7DOAUNpZ05xbw9ER4sDAWENVZqwm7WmiP8pPgKDOMKzA22Od89T5XxMFRAfE1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ+0AMi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD87C4CECC;
	Sat, 30 Nov 2024 20:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732998967;
	bh=rIq9kk8+kLipb5jpn/zX9Q3YH/PEgvlgOdkmPs3WZXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQ+0AMi/vPvl9fjvY2znUGgPzMoN/FO70VbD0obSEfEfukYM9gZ6Nrt0iUwo07zrE
	 j9fVhGbYzQTGufFUn05cQqTJ8VMEEBpKaxEfYxNi++1LToOKHOlS/iKFCRDWWpo7C7
	 vkJCCBDfcuWuUP2/5VYI6YDns1Zp4nQult7UroK+Bs0KAlT41SXO/5fgiP1r7CP9+X
	 aW5i0iUioeREk41akiGwkWRuTc4bx3GWDTppo0H2SKWhbij1uexGChtpdF3wbvE47b
	 11n4aweo2IBO4qTTDSeGI6SGpauXt+x9O1yz3mTgUt9nqdoyT7ncd9krTRYOKY2B3q
	 X/HThHRxETsqw==
Date: Sat, 30 Nov 2024 12:36:07 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: Release candidate for e2fsprogs 1.47.2 is available
Message-ID: <20241130203607.GC9417@frogsfrogsfrogs>
References: <20241130013429.GA812025@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130013429.GA812025@mit.edu>

On Fri, Nov 29, 2024 at 08:34:29PM -0500, Theodore Ts'o wrote:
> Hi all,
> 
> There is a release candidate for e2fsprogs 1.47.2 available at:
> 
> https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/testing/v1.47.2-rc1/e2fsprogs-1.47.2-rc1.tar.gz
> 
> It is also uploaded to Debian unstable, for folks who want to try that out.
> 
> A known issue is that f_clear_orphan_file is failing on s390x,
> powerpc, and ppc64 which is why Debian packages haven't been built on
> those architectures:
> 
>     https://buildd.debian.org/status/package.php?p=e2fsprogs

IOWs, the big endian architectures.

Hmmm, why does ext2fs_do_orphan_file_block_csum claim to return a __u32
yet the actual return statement returns an __le32:

	return ext2fs_cpu_to_le32(crc);

Particularly because ext2fs_orphan_file_block_csum_verify then compares
the returned __le32 value to a __u32 that was converted from the ondisk
structure:

	return ext2fs_le32_to_cpu(tail->ob_checksum) == crc;

AFAICT ext2fs_do_orphan_file_block_csum should not do that conversion,
and mkorphan_proc should be doing:

	tail->ob_checksum = cpu_to_le32(
			ext2fs_do_orphan_file_block_csum(...));

But I'm not that familiar with this code.

--D

> Please give it a try, and let me know if you run into any other
> problems.
> 
> Many thanks!!
> 
> 					- Ted
> 

