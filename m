Return-Path: <linux-ext4+bounces-6268-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D17A2175D
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jan 2025 06:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD291888E18
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jan 2025 05:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B1119006F;
	Wed, 29 Jan 2025 05:27:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D818C011;
	Wed, 29 Jan 2025 05:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738128457; cv=none; b=ohm7O4smmNeIyPNwqYN7LdpFRQm7b2wSbJnemnzczYnlgdXeLvgRIjbN3HCOh7B3HPrUup3tGBeqP+NZHZQgfv3qrbLIVlxu7K4vcAfaQ1kF42+VwMK4QrdRAXS1PvmRze6nuvcLVeJ4rcu176cXrDUNTLW0EupHwNRr2DR249U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738128457; c=relaxed/simple;
	bh=lldPHbNJVTV8m6M44Rog8lnsUuSYqe2yD6mYGYli+Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSCk9rZkXks7CTx6QPICVsQs1u4I56dWRPXUsrd7BCqYWfRtW4ApM+StaEWtOR/b2vy4jsmB17rLW45j39pz+U0ElTLJU43Nei7Ly/ThiP0FE7lvaI8V28TntgaJ7SksAv854Uo2KvIQVJSpnGo2MNkpt1KLsKi1u46Nzko1NxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54BF668D13; Wed, 29 Jan 2025 06:27:31 +0100 (CET)
Date: Wed, 29 Jan 2025 06:27:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
	Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/3] common: remove the $FSYP check in _cleanup_dump
Message-ID: <20250129052731.GB28665@lst.de>
References: <20250128071315.676272-1-hch@lst.de> <20250128071315.676272-3-hch@lst.de> <20250128191442.GP3557695@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128191442.GP3557695@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 28, 2025 at 11:14:42AM -0800, Darrick J. Wong wrote:
> I went looking in common/dump and I noticed the lack of an explicit
> setup routine.  Instead, variables and _require calls are done when
> sourcing the file.  Curiously there's no check for FSTYP==xfs, which I
> guess is reasonable for sourced stuff, but I think that should all get
> pulled up into _init_dump() or something.
> 
> The other thing I noticed is that sourcing common/dump deletes
> $seqres.full, which seems like a real bug.

Yeah, dump testing is at least as messy as xfsdump itself :)

Btw, did someone every spend some time analyzing why xfs/059 xfs/060
fail relatively frequently when using RT devices?  This is one of the
thing on my TODO list when I find a little more time..


