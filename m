Return-Path: <linux-ext4+bounces-12369-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D0BCBF9B7
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 20:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 120CB3028581
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 19:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C594E2737E7;
	Mon, 15 Dec 2025 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihoQWjQU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2872B1CDFD5;
	Mon, 15 Dec 2025 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765827680; cv=none; b=osK66fUEiGxYTKLOY9E+rdClOP69To8id3y1NiCf9k1pzBn/c85h7iTUC+/0URMyPM9/fw06CDduhEOiVUZe/wxNtfMCzENrzOdQz2SFxtrCW3lSoJGVjUziBtH3FX0G0i0TKMRmg4QII9NmeMQNEKNYh0R5HloSmxLoCOMNQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765827680; c=relaxed/simple;
	bh=GhJJF3osCt9kBmMGEStzqIm16/inVHzkWj3g/fixxC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdcbnOh2Afhpd3/fSHYN7EZKNDkmdE6zXLeWrkDHgVZj1RcTyf1URTkoknjVS2WUw9pcSXmtimPoS5eY2+28sM566QPJjB4mbaTbkinrXjmcotC70o4WXqg85es38UBb8sZGA1S7ZobPOLvcyL1k3N+f1B3KqsumgKgEpCP8l+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihoQWjQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA5EC4CEF5;
	Mon, 15 Dec 2025 19:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765827679;
	bh=GhJJF3osCt9kBmMGEStzqIm16/inVHzkWj3g/fixxC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihoQWjQU8kCNVXD62+sTTet+SXxHQUeHh+BfMZ9tlK6/pwdbqr8FeCOfORusAiKy9
	 19S6wptgW+ld+l9t2Rdahjj3cljmKbCK3o6o3rOVdzJ79h3eakqWTpvoxtTCLbrzAy
	 6uWsLUPm3PLX2XwQEJT9UhhzBm7wkKHscOuV4R8KWlmdOt8eoUGa3G4xrQTP8hMR1z
	 E9GSALAl6NU5GoVyYs6Op9OyrYXJ063KRy2e5UA7qIPVN3LBivHHNU/aFC2jl+Afh7
	 ddKm5VnDh1YUWGuYbo9p5BOL+ksLmgcwLSVpXfBayqOmFWayktxONXs0liRSkIbap5
	 o2TmL+uF6w0uw==
Date: Mon, 15 Dec 2025 11:41:18 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 01/13] dmflakey: override SCRATCH_DEV in _init_flakey
Message-ID: <20251215194118.GN7725@frogsfrogsfrogs>
References: <20251212082210.23401-1-hch@lst.de>
 <20251212082210.23401-2-hch@lst.de>
 <20251212201142.GF7716@frogsfrogsfrogs>
 <20251215052913.GB30524@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215052913.GB30524@lst.de>

On Mon, Dec 15, 2025 at 06:29:13AM +0100, Christoph Hellwig wrote:
> On Fri, Dec 12, 2025 at 12:11:42PM -0800, Darrick J. Wong wrote:
> > Ok, so _init_flakey still sets FLAKEY_TABLE_ERROR...
> > 
> > >  	_dmsetup_create $FLAKEY_NAME --table "$FLAKEY_TABLE" || \
> > >  		_fatal "failed to create flakey device"
> > >  
> 
> > >  # no error will be injected
> > >  _init_flakey
> > 
> > ...but won't _init_flakey clobber the value of FLAKEY_TABLE_ERROR set
> > by make_xfs_scratch_flakey_table?
> 
> I think so.  But nothing really changed here except for a variable
> name, so the whatever clobber was there before is the same and apparently
> worked?

I suppose it could work (I haven't tried), but
make_xfs_scratch_flakey_table redefines FLAKEY_TABLE_ERROR so that
internal log writes continue to work but everything else doesn't,
because it's testing that write failures during AIL push operations
don't set us up to hang the system.  It's not testing iclog write
failures themselves.

--D

