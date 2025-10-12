Return-Path: <linux-ext4+bounces-10788-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E926BBD0A69
	for <lists+linux-ext4@lfdr.de>; Sun, 12 Oct 2025 21:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955483BEF5C
	for <lists+linux-ext4@lfdr.de>; Sun, 12 Oct 2025 19:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAAE2EC55C;
	Sun, 12 Oct 2025 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="V4KThtQX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B461FC0ED
	for <linux-ext4@vger.kernel.org>; Sun, 12 Oct 2025 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760296087; cv=none; b=lrAY9wqK/rU48Li147K/68/AIn39yu948IH6ENTpOABxQ3Igk6slzoKgju/W+lyZ4rVZlPbusEI3xUrHSnvVGtYDnZ0la6ZDPMwMPQxNLZyy0DepRtnb1O61eLPt2dLZ5BzeBtccmVty6TPo7334XqDLBNvZTDqtN9sPaNe3uvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760296087; c=relaxed/simple;
	bh=45E1b0cOd8vVwMpH1NaiaACbdU3WHCZKthIdb9vaxZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HP6Nix2r6zPvqIQ3k6uJwL62K0cubbrExalODkcFCbkPOuUjuveGz7zyq7oCkfA7nwWeBceK7hJ8LDrZJG4LTvb8/hh5aMJuv6XuWb521sY8FgJqM1lImoyqeAqqL7PG/eobqeMn6bedjPh5AiE7EDQDf+lRzd5tbJ2hAIS6ucU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=V4KThtQX; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-184.bstnma.fios.verizon.net [173.48.113.184])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59CJ7Vc4016344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Oct 2025 15:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1760296054; bh=Njp2cf3h0BFIMRzHckuQXhpEa7uPfeq2Zq1D7V9BgnU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=V4KThtQXO0ZQ0NWvG+WbwFgzpWOzovsbr3o+8Ki4wtSAQJsLatEz1ULX+DUyblNYP
	 0Fx3GUMU85AT7hQuxkZmPTUkwC/y+Bf6j9QUfPatAi7ifrlcvi5oOZt0Tx0gQeWAsK
	 hLobENL0KzGw49nqDehBrrmQtIUD9jijS8gfSkZJ2/r8TRmfobobDkP5XEGo42HlFq
	 +V0oJ82Q5ZnAwmq/PNNiwgc0ccW5pb46sxZM8kvvFp+mSjrJ+hqqcngwh5GEa9lpkX
	 IYS1ZUSRctfhoU3yOFOrhaxGRZ9j4fj6zzsRSIBfYkcZmoNJYCRdHGVONMBgWMjZmL
	 lM6UnIEWOl1/g==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 190112E00D9; Sun, 12 Oct 2025 15:07:31 -0400 (EDT)
Date: Sun, 12 Oct 2025 15:07:31 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: lkp@intel.com, adilger.kernel@dilger.ca, david.hunter.linux@gmail.com,
        khalid@kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v2] fs: ext4: fix uninitialized symbols
Message-ID: <20251012190731.GF354523@mit.edu>
References: <202510110207.yBvUMr5Z-lkp@intel.com>
 <20251011063830.47485-1-vnranganath.20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011063830.47485-1-vnranganath.20@gmail.com>

On Sat, Oct 11, 2025 at 12:08:29PM +0530, Ranganath V N wrote:
> Fix the issue detected by the smatch tool.
> 
> fs/ext4/inode.c:3583 ext4_map_blocks_atomic_write_slow() error: uninitialized symbol 'next_pblk'.

This one is valid, and I agree with your proposed changed.  (Although
the worst that will happen is that in case of an ENOSPC error comined
with a corrpted file system the warning message may print an
uninitialized value.  So not a big eal, but we might as well fix it.)

> fs/ext4/namei.c:1776 ext4_lookup() error: uninitialized symbol 'de'.

This is a false positive for smatch.  There isn't actualy a prolem
here, because all of these funtions are calling ext4_find_entry() or
ext4_lookup_entry(), and the callers will not try to dereference the
pointer passed into *res_dir ('de') if the function has either
returned NULL or an ERR_PTR(), and that's in fact correct.

I don't especially mind the fix (but I do wish smatch could be
smarter).  Out of curiosity, if we move the *res_dir = NULL from
__ext4_find_entry() and move it so it's unconditionally set in
ext4_find_entry() and ext4_lookup_entry(), is that sufficient to make
smatch stop complaining?

					- Ted

