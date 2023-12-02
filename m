Return-Path: <linux-ext4+bounces-273-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DE8801DEB
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Dec 2023 18:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDD62810D0
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Dec 2023 17:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DB01C686;
	Sat,  2 Dec 2023 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwPZy3lV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F318AF6
	for <linux-ext4@vger.kernel.org>; Sat,  2 Dec 2023 17:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F4EC433C7;
	Sat,  2 Dec 2023 17:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701537045;
	bh=/go9u9e/fOcrfL8ufc7YY7zZbCRqib75ln0/i5X3s58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HwPZy3lV5b6jloY95xYng9NGHCO3oeL9djls+AjCllYCJpbP0/IqiLU9y0n/lFB0Z
	 mKe0ZIQtGzCOa8dCTbu7OAA7FChvkPx7ODhKSJKoCmt3xc4rgvjpUaBk/GhseyP43T
	 8zd8cIlBVbXVZZSZQSdg9kE7rcrLISOCV7qBNT4DVHgFwbhDjIW0APW/6G3xN/+1sj
	 etXc8hnSl2rC5EImLULKBDkS4Qu4oIGUKrGBUaxSdw8SFryehFt5ezsQVJJW5F00wr
	 BFAb3GeKYOsRxTrOu++gHVn8oSEs7dTIiKv90VeNRO8Zl0pu+kw7pn783zdss6T+U+
	 YTgN97T4/tfjA==
Date: Sat, 2 Dec 2023 09:10:44 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] lib/ext2fs: Validity checks for
 ext2fs_inode_scan_goto_blockgroup()
Message-ID: <20231202171044.GB36164@frogsfrogsfrogs>
References: <20231201000126.335263-1-briannorris@chromium.org>
 <20231201162410.GA36164@frogsfrogsfrogs>
 <CA+ASDXPYufpx0uaC7iyo_cgaa_2XdR+OLBvMDKk=rpwJe1hWXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+ASDXPYufpx0uaC7iyo_cgaa_2XdR+OLBvMDKk=rpwJe1hWXQ@mail.gmail.com>

On Fri, Dec 01, 2023 at 09:30:38AM -0800, Brian Norris wrote:
> On Fri, Dec 1, 2023 at 8:24 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > On Thu, Nov 30, 2023 at 04:01:18PM -0800, Brian Norris wrote:
> > > This resolves issues seen in ureadahead, when it uses an old packfile
> > > (with mismatching group indices) with a new filesystem.
> >
> > Say what now?  The boot time pre-caching thing Ubuntu used to have?
> > https://manpages.ubuntu.com/manpages/trusty/man8/ureadahead.8.html
> 
> Sure. ChromeOS still uses it. Steven Rostedt even bothered to do a
> talk about it recently:
> https://eoss2023.sched.com/event/1LcMw/the-resurrection-of-ureadahead-and-speeding-up-the-boot-process-and-preloading-applications-steven-rostedt-google

Wow.  I had no idea that ureadahead reads the inode blocks of a mounted
ext* filesystem into the page cache.  Welp, it's a good thing those are
part of the static layout.

Anyway, this fix looks correct to me, so I don't see any reason to hold
this up...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> Brian
> 

