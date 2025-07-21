Return-Path: <linux-ext4+bounces-9140-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8102CB0C930
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 19:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DCA543F3A
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 17:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0933629B782;
	Mon, 21 Jul 2025 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9HWsWDV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC670838
	for <linux-ext4@vger.kernel.org>; Mon, 21 Jul 2025 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753117308; cv=none; b=DT2ognSYSJJiE7jRGOvyD6Zs2neFFlrTPqVo13NB73kDVeMDqG3VFM3JVX1ZgZBvCk1QJSWLY84h75NHwIQk/TyTdL3I7PfEHbfOJQNy/r0fFV7hOFvvBBAwO3QoEoWu0YDpveDYojqzdjqmI9o0OEWrgk2BWx27OngMA3OR7Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753117308; c=relaxed/simple;
	bh=P3kHGOJo8Og3uW5ZKKeLJz5hZmiaEBCOsCgGej8Se+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSrgs/6NYdMS/s1CguvJqI+ymgooq77fhPvGGNElZMiYjbtg/jYB2hLkSigZLrmRDhba5sF6xtyL34Z+jkoDLi03nYNq0Bnj4U89GbY6TygUE2vRapYCJQUAR3yBEM5yr7+MUQZFq0CU6VsbhjWB4oYkeWlwK6bkVr4BGFPogm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9HWsWDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A80BC4CEED;
	Mon, 21 Jul 2025 17:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753117308;
	bh=P3kHGOJo8Og3uW5ZKKeLJz5hZmiaEBCOsCgGej8Se+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9HWsWDVEmyRm6sNxBbSxnQljMEpSjX6h7cq7cDc1fCYV5P68YQcw5jD0pegHfyjI
	 CQWI/6U5EEYt4f1QShpl/2CaoazxylNbLwL5YUDYRo8SkUmIASC77gDZycknclOsiL
	 gT2Qup/gMirj54YO0FlHC+r8P1MKHRSXZS90hYZ3tZZe4JHFpmYkfjvBu9Z5rBjygM
	 An5BXuBRdvX/InN8CsjhtLX2gBL9LLRdp9EPFh7HAWnfbgnIAzYPDL/7O6RGWKqm6K
	 EYGewhj3+4mQtf9a4LYr3lYSZXlHkglOWrBCtvEpZGi6op1otZ88E3BRNa6WikVgMO
	 JIyIBFOXJqHLw==
Date: Mon, 21 Jul 2025 10:01:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Sam James <sam@gentoo.org>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/5] fuse2fs: stop aliasing stderr with ff->err_fp
Message-ID: <20250721170147.GT2672070@frogsfrogsfrogs>
References: <174553064491.1160047.2269966041756188067.stgit@frogsfrogsfrogs>
 <87seirz2pu.fsf@gentoo.org>
 <20250720185135.GS2672070@frogsfrogsfrogs>
 <20250721054234.GN2672022@frogsfrogsfrogs>
 <20250721114117.GB231115@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721114117.GB231115@mit.edu>

On Mon, Jul 21, 2025 at 07:41:17AM -0400, Theodore Ts'o wrote:
> On Sun, Jul 20, 2025 at 10:42:34PM -0700, Darrick J. Wong wrote:
> > Oh wait no it turns out that libfuse obliterates std{in,out,err} in
> > fuse_daemonize() by opening /dev/null and using that exact trick.  So
> > the only reason why I was ever getting any FUSE2FS debug output
> > throughout *any* of the fuse+iomap development sprints was that glibc
> > lets you assign stdout/stderr directly.
> > 
> > freopen also won't work (at least on glibc) because its freopen
> > implementation uses the dup2 trick which will be undone by libfuse.
> > 
> > GREAT!  I only got to debug my program because OF A WEIRD GLIBC QUIRK!!
> 
> So either we need to find some way to inhibit fuse_daemonize() and
> then have fuse2fs handling doing the daemonization.  Or maybe we can
> arrange to have some kind callback to set up stdout/stderr after
> fuse_main() is called?  fuse_daemonize() is called from fuse_main(),
> right?

Right.  We could just set up the log file again in op_init, which will
fix the daemonize() problem; use dup2 to cover any libraries that output
directly to STDOUT/ERR_FILE; and use freopen on /dev/fd/XX which will
cover any other libraries that call printf or fprintf(stdout/err.

$ diffstat < patches-djwong-dev/019*
 fuse2fs.c |  141 +++++++++++++++++++++++++----
 1 file changed, 123 insertions(+), 18 deletions(-)

Yuuuuuck.

--D

> 						- Ted

