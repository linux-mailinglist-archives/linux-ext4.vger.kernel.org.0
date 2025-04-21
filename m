Return-Path: <linux-ext4+bounces-7365-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE2DA953C5
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Apr 2025 17:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FC157A5890
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Apr 2025 15:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5D11DEFDD;
	Mon, 21 Apr 2025 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeFLx0gP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986077D3F4;
	Mon, 21 Apr 2025 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745250874; cv=none; b=nd79phxuvDtwdYpvRJOLZixZ8AvJT9Utzu10tzwQeIYOzNZP8AVcylYAwKe5zhlzzhJjMffo7HgPcJ/sWxD1/RH6i2nj2G978sLNJlPTd63++8PzObOmXqPl5dW5PNelR3mAApp6Wkvc9kSZ/f9a1m8dTfops56tLj0/E0WfhRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745250874; c=relaxed/simple;
	bh=H8IYcNld+2Uzf+iL0mwPExwljYsFP8aS3lNcy5lYoHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfbAWXkSaHO68lOat3BXAiVaF/OricHZ3Ejav+CRM5ybWj0WTbwkSuddEDfD5oqPWREE0JSsOEuYEZz5qIs08J3HNQg+IfepmJS4k88PdovEHLraQROJdvJ7cybQzPX/SbY0JA+pZV5dpDPSZ8E2Ar48+RKNZUcIegr5p+ZRC7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeFLx0gP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFC8C4CEE4;
	Mon, 21 Apr 2025 15:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745250874;
	bh=H8IYcNld+2Uzf+iL0mwPExwljYsFP8aS3lNcy5lYoHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GeFLx0gP+/pnVS0nF2zWexjZm5H1kfOaaRS/PT/apgZFgH7I1k+dqXIdVztTAkZND
	 TGSoEG0Ggxe+vfwWZSt6BkqfvkMT0Ug8TLjNcn5PIXB4OJZJZ2OVGHWivaqhOKzDtE
	 iSjYG9DHmzRQ6LWdjtFwA/4JAuAlccWY5MnXyOgiWcvbFkFrLj2+bG0YqiSY8BOB/Y
	 s2Ndhe5N0XTAKdc3rZKlMcq6KfU5rHsQdWjrzmiR4DStEBWRqnUGMDnVK0zqpkRpZy
	 Vi3X8Jlmb2qgBXB1TxL4/KKHPuMWPk3DB7YcxkNLMlHgRwwdJJJrsYa5mndJ795XbR
	 XasEx81twAjXg==
Date: Mon, 21 Apr 2025 08:54:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Luis Chamberlain <mcgrof@kernel.org>, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, kdevops@lists.linux.dev,
	dave@stgolabs.net, jack@suse.cz
Subject: Re: ext4 v6.15-rc2 baseline
Message-ID: <20250421155433.GC25700@frogsfrogsfrogs>
References: <Z__vQcCF9xovbwtT@bombadil.infradead.org>
 <20250416233415.GA3779528@mit.edu>
 <20250417163820.GA25655@frogsfrogsfrogs>
 <20250417183711.GB6008@mit.edu>
 <aAFq_bef9liguosY@bombadil.infradead.org>
 <20250419182249.GC210438@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419182249.GC210438@mit.edu>

On Sat, Apr 19, 2025 at 01:22:49PM -0500, Theodore Ts'o wrote:
> On Thu, Apr 17, 2025 at 01:56:29PM -0700, Luis Chamberlain wrote:
> > 
> > Perhaps something like (not tested):
> > 
> > From a9386348701e387942e3eaaef8ee9daac8ace16a Mon Sep 17 00:00:00 2001
> > From: Luis Chamberlain <mcgrof@kernel.org>
> > Date: Thu, 17 Apr 2025 13:54:25 -0700
> > Subject: [PATCH] ext4: add ordered requirement for generic/04[456]
> > 
> > generic/04[456] tests how truncate and delayed allocation works.
> > ext4 uses the data=ordered to avoid exposing stale data, and
> > so it uses a different mechanism than xfs. So these tests will fail
> > on it.
> 
> No, you misunderstand the problem.  The generic/04[456] tests are
> checking for a specific implementation detail in how xfs works to
> prevent stale data from being exposing data after a crash.  Ext4 has a
> different method for achieving the same goal, using data=ordered,
> which is the default.  So checking for data=ordered isn't necessary,
> because it is the default.  But how it achieves thinigs means that
> these tests, which tests for a specific implementation, doesn't work.
> 
> Fundamentally, these tests check what happens when you are writing to
> a file and the file system is shutdown (simulating a power failure).
> Exaclty how this handled is not guaranteed by POSIX, so testing for a
> specific behaviour is in my opinion, not really that great of an idea.
> In any case, the fact that we don't do exactly what these tests are
> expecting is not a problem as far as I'm concerned, and so we skip
> them.

I might be wading in deeper than I know, but it seems to me that
after a crash recovery it's not great to see 64k files with no blocks
allocated to them at all.  That probably falls into "fs crash behavior
isn't guaranteed by POSIX", but if that's the case then these three
tests (generic/044-046) should _exclude_fs ext3 ext4 and explain why.

(I don't care about the others whining about _exclude_fs-- if you make
the design decision that the current ext4 behavior is good enough, then
the test cannot ever be satisfied so let's capture that in the test
itself, not in everyone's scattered exclusion lists.)

--D

> Cheers,
> 
> 						- Ted

