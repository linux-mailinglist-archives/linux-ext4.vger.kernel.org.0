Return-Path: <linux-ext4+bounces-8374-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30AEAD64EA
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 03:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839123ACD0E
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 01:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75A17080C;
	Thu, 12 Jun 2025 01:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYPnzI8C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BF020328;
	Thu, 12 Jun 2025 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749690583; cv=none; b=ZWwUq7LokJHxZYmWQSzRqCgJ8SNPmJXGnaDZ7vY17+G72s2WmSxZsxIwzRMasqWjpuoePBeKe8IWZ95gOityE1MMHpfm7eMSIe9Zh2Pzyb+ZyRqiYVTfLDvlcGYhaqzlle6snu4Q9PvHh9wpTKFoRi22NCwVTo4yKZmTXs/tjEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749690583; c=relaxed/simple;
	bh=zCSBb3C0bchjKqPuSRcT43zjzPpaIhdbrDvQN2MKDC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHxpLQ+UagKLzdT5lAHwDlb0LOQ/ifimDH7q/upIyQuzSSPl9YH2tpGmnexFGJkCFJuRmHHsu+5sRhBYBDIVM7EMN0lw9zbN5D1DH9368picdyajL+OYVb/PI5oFhk8PZMnwCpV8Za9aJ5lkEw8NuxcB+4uu9TmWDCDbx8SuZxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYPnzI8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AD2C4CEE3;
	Thu, 12 Jun 2025 01:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749690582;
	bh=zCSBb3C0bchjKqPuSRcT43zjzPpaIhdbrDvQN2MKDC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYPnzI8C8Z2aNuLmbYW8VmxYocQ1JDoIw+GHWDjVe22j1VrODdHA9V/VnOp+VaBip
	 ehzGs1Wn8xEBM/NTQ4ktw8EQ0k8toI4mBmb1F87gX3udpc8X5WTSH37cT/a+jFJ64z
	 QemCNbjw9pN4unzBdd9plF0/LgD8Yqr/jYwiucwt0/VRLEBXyq+q3Jb09WzS/VJfXh
	 AJaY/pWHxSew1X9XI+0JXGNjg2zle6KIGK5vfxdZ/gSp/2EtQWF2ossNmIZmV7HTiH
	 Y0+gV0Yd3DYxR1sPhoKPzR4a1wv/0KIJ717LHt077jBbxUbAlDvOvh5nKKKCx8pHqM
	 cuL6TXV7Q9OWw==
Date: Wed, 11 Jun 2025 18:09:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ext4 <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH] Documentation: ext4: atomic_writes: Remove
 cross-reference labels
Message-ID: <20250612010942.GJ6179@frogsfrogsfrogs>
References: <20250610091200.54075-2-bagasdotme@gmail.com>
 <20250611164800.GC6134@frogsfrogsfrogs>
 <87ikl21a5u.fsf@trenco.lwn.net>
 <aEoaJEhw5qHkd2_w@archie.me>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEoaJEhw5qHkd2_w@archie.me>

On Thu, Jun 12, 2025 at 07:07:00AM +0700, Bagas Sanjaya wrote:
> On Wed, Jun 11, 2025 at 11:05:17AM -0600, Jonathan Corbet wrote:
> > "Darrick J. Wong" <djwong@kernel.org> writes:
> > 
> > > On Tue, Jun 10, 2025 at 04:11:59PM +0700, Bagas Sanjaya wrote:
> > >> Sphinx reports htmldocs warnings on ext4 atomic block writes docs:
> > >> 
> > >> Documentation/filesystems/ext4/atomic_writes.rst:5: WARNING: duplicate label atomic_writes, other instance in Documentation/filesystems/ext4/atomic_writes.rst
> > >> Documentation/filesystems/ext4/atomic_writes.rst:207: WARNING: duplicate label atomic_write_bdev_support, other instance in Documentation/filesystems/ext4/atomic_writes.rst
> > >> 
> > >> These warnings reference duplicated cross-reference labels to themselves in
> > >> the same doc, which are because atomic_writes.rst is transcluded in
> > >> overview.rst via include:: directive, thus the culprit docs get processed
> > >> twice.
> > >
> > > <confused> How is that possible?  atomic_writes.rst is only "include::"d
> > > once in overview.rst.  Is the file implicitly included through some
> > > other means?
> > 
> > Sphinx wants to snarf up every .rst file it sees, regardless of whether
> > it is explicitly made part of the document tree.  So it will pick up
> > atomic_writes.rst separately from the include.

Does that mean that overview.rst doesn't need to include the other files
at all?

> > This could be "fixed" by removing the .rst extension from the included
> > file.  But, since there is no use of the atomic_writes label to begin
> > with, it's better to just take it out.  The other fix, removing a cross
> > reference, is not entirely ideal, but there is little text between the
> > label and the reference.
> 
> So removing the labels looks good to you, right?

I don't care that much either way, but if sphinx is going to include
every rst file implicitly then maybe we just get rid of the explicit
includes?

> Confused...

Me too.

--D

> 
> -- 
> An old man doll... just what I always wanted! - Clara



