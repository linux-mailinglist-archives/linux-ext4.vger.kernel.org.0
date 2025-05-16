Return-Path: <linux-ext4+bounces-7940-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC56AB9C7B
	for <lists+linux-ext4@lfdr.de>; Fri, 16 May 2025 14:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A307917B41A
	for <lists+linux-ext4@lfdr.de>; Fri, 16 May 2025 12:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C6023F403;
	Fri, 16 May 2025 12:44:20 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FC623D2AC
	for <linux-ext4@vger.kernel.org>; Fri, 16 May 2025 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399460; cv=none; b=LAb1krAHd2FOTCLQYO1pPngS0f+XJcZ6zmP5oFKqLOuXfZ50B9wsoEjTI+0QLoauNklICVSJwC7cCTfvOyMPf5FBhYTGxxLHb+BCaqO0imXofypa926ZhW4gezt/+fhtGKd9IUlp/qg0MkPPEHq4N8J+7gd0yEbSxidSr0RLByc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399460; c=relaxed/simple;
	bh=2u25kwkrDYfiWB/3PyBVzLYBOEWZXpsDAyW72cjMLDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0nda71p4BpUyYaJDLS7ziVNurT0bQGo/oBjky8mWIsM4/A4i+KeTqoljOGaMI3QTHeXPkUDpCcYOi9yMeBQv2GEkyItto0QSpNCR4uMPRWwR8Qnftuu2KXQlXFrWN9kI+UIG9AVOZ5+Eo0yHUiggZNBvdw57yj/Y59m8kjQ04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-151.bstnma.fios.verizon.net [173.48.112.151])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54GCi5VK016245
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 08:44:05 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C4C982E00DC; Fri, 16 May 2025 08:19:38 -0400 (EDT)
Date: Fri, 16 May 2025 08:19:38 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: John Garry <john.g.garry@oracle.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, djwong@kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] ext4: Add atomic block write documentation
Message-ID: <20250516121938.GA7158@mit.edu>
References: <cover.1747337952.git.ritesh.list@gmail.com>
 <d3893b9f5ad70317abae72046e81e4c180af91bf.1747337952.git.ritesh.list@gmail.com>
 <3b69be2c-51b7-4090-b267-0d213d0cecae@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b69be2c-51b7-4090-b267-0d213d0cecae@oracle.com>

On Fri, May 16, 2025 at 09:55:09AM +0100, John Garry wrote:
> 
> Or move this file to a common location, and have separate sections for ext4
> and xfs? This would save having scattered files for instructions.

What is the current outook for the xfs changes landing in the next
merge window?  I haven't been tracking the latest rounds of reviews
for the xfs atomic writes patchset.

If the xfs atomic writes patchset aren't going to land this window,
then we can land them as ext4 specific documentation, and when the xfs
patches land, we can reorganize the documentation at that point.  Does
that make sense?

					- Ted

