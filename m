Return-Path: <linux-ext4+bounces-1359-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A785F9B6
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 14:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21D2288596
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1D513340A;
	Thu, 22 Feb 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksKmIfkf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD081332AC
	for <linux-ext4@vger.kernel.org>; Thu, 22 Feb 2024 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608391; cv=none; b=grFILoDS41yvZ11zxOatvgSv6LpBJL0uLhMJty1R7w5eegO2rHy3O8vDTBpt2qyqLROgcv147pNL/SMGPfW8aYNrs4CsYKQwKWp8OVg8m01pxGDXjAvwFMcoE4Te3nrSeRBpOiqB6HS1YyO+5OJhUbabylRW0+vLQ3Zxqc8EAi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608391; c=relaxed/simple;
	bh=izMOQ6q+ygXGACusehygwzpWEZre8yRkB2YiZPA1d08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfL+DgHjiyVyCruhFKzS/W5R8sBCjqbqgRUyeItXqZhP+BJPAhJOiTQDA7TDQELgqJRKz5ynzAfT32OpuDiblmpNRYmXY1v6H+FdPOPTsZsm6tNSIgW5siGf27GbLsYxehWq+buZA0eNeAzrbY1ZSQbMThMDknDrVgWUXnWMlYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksKmIfkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F80C433C7;
	Thu, 22 Feb 2024 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708608390;
	bh=izMOQ6q+ygXGACusehygwzpWEZre8yRkB2YiZPA1d08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ksKmIfkfqNUeUrOzHnMJNvw0qAhyOEOuVCY+/2bdr107ClW7kUKnNNKy3TNm+RSSm
	 jzx8zGa294IPip1XYzjFWsZjjEU55+5FbVVoy6WPJKqJXQpdVwDlD+3735pRHzSx/n
	 t4mTNu0tYM3oP0vrcSDWKMOW85QcOzDDOp4/UVQFUQiFTdUQ3brCfvxJPHIm2RuR+W
	 t3qZBMhucTDBMXYb79aSaTwuhyRyF+KZyR9Z4MBiGD3K+HdoI8MXyIKs/WTsd97ast
	 czXuJTUx1BUjbiecWtFLFl03Lp550GLinnD+bzzGO0OBOMlBV6W3FRYIJLVoWGcgQX
	 ab6dggA7Er5ag==
Date: Thu, 22 Feb 2024 14:26:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Luis Henriques <lhenriques@suse.de>
Cc: linux-ext4@vger.kernel.org
Subject: Re: fstest generic/696 failure on ext4 fs with quotas+idmap
Message-ID: <20240222-knast-reifen-953312ce17a9@brauner>
References: <87jzmxisqm.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzmxisqm.fsf@suse.de>

On Wed, Feb 21, 2024 at 06:20:49PM +0000, Luis Henriques wrote:
> Hi!
> 
> The fstest generic/696 (and 697) fail on ext4 when the filesystem is
> created with quota support (-O quota).  It's really easy to reproduce, and
> it fails when doing the idmapped tests (setgid_create_umask_idmapped() and
> setgid_create_umask_idmapped_in_userns()).
> 
> The failure happens when the test does an openat() with O_TMPFILE:
> 
>   ext4_tmpfile()
>     __ext4_new_inode()
>       dquot_initialize()
>         dqget()
> 
> and at this point the error occurs:
> 
> 	if (!qid_has_mapping(sb->s_user_ns, qid))
> 		return ERR_PTR(-EINVAL);
> 
> qid is '-1', which is invalid, but I'm failing to understand if it should
> really be invalid or if dqget() should handle this invalid qid some other
> way.  Earlier, __ext4_new_inode() called inode_init_owner(), which indeed
> sets inode->i_uid with '-1'.

I think that's a misanalysis? The dquot_initialize happens to be before
the inode creation for that tmpfile. Anyway, see below.

> 
> I've been trying to figure it out, but it's very tricky to follow all the
> details, so I decided to ask here and see if anyone has any idea.  Is this
> a known issue?  Maybe the issue is with the test itself, and not with
> ext4, quota or idmapped code.

So good new is that it's neither an ext4, quota, or idmapped bug. It's
just the test being broken because openat_tmpfile_supported() is called
after we created an idmapped mount on the idmapped mount which means
that the callers fs{g,u}id might not be mapped. That means
make_kquid_*id() will return INVALID_*ID which will later fail that
check whether the qid is mapped in dqget().

I sent a patch to xfstests with you can ext4 Cced. I've tested it here
and it's fixed. Feel free to test as well.

