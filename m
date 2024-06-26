Return-Path: <linux-ext4+bounces-2950-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF8F917711
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jun 2024 06:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97F9283CE2
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jun 2024 04:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D5112FF76;
	Wed, 26 Jun 2024 04:02:09 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18EB8248D;
	Wed, 26 Jun 2024 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719374528; cv=none; b=PliPmS+yqnLn570sjkYsJPv1XrbkYJ6fluyhUilKDZPxHHWAA14i9Z9S+x2Wc7Dh6I0j7Qj6x2stsecG8HqVGcKVQb41pEFudS4jl2JgG2SM1qP7TAlnZL3IqZDVVTAe1DyCEsBSrydGCGNYgDFDc6BX624AgHrD5Omcvn5ENmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719374528; c=relaxed/simple;
	bh=7ivA//q39b1BZ5rXPDEYkxFaVEYDfFxbHl3pE1w90M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGFEDrpUuE8G0QXV9w5kDOw9eSX4V9A+yTAzU/kX4AzLiCGSmiXWavUoDqKRNYxtlgTRuF6fNr7006pXfUWOMqIGMWRecXUJqlbNfPsb0OO8JlPMV8ONM1Ky5DGM/xyUY4yv+T+Fo/znQgPWmbtw8MDPyt5rSoWIWCyFopQ9StA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 25E0868BEB; Wed, 26 Jun 2024 06:01:54 +0200 (CEST)
Date: Wed, 26 Jun 2024 06:01:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 5/8] generic/740: enable by default
Message-ID: <20240626040153.GA20683@lst.de>
References: <20240623121103.974270-1-hch@lst.de> <20240623121103.974270-6-hch@lst.de> <20240624161605.GF103020@frogsfrogsfrogs> <20240625035008.GC7185@mit.edu> <20240625060038.GA1497@lst.de> <20240625200555.GA394275@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625200555.GA394275@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 25, 2024 at 04:05:55PM -0400, Theodore Ts'o wrote:
> Oh, good point.  Yeah, mke2fs uses libblkid in addition to libmagic.
> So yes, it should work for basic detection of file systems for the
> purposes of generic/740.  So the only issue would be the fact that
> mkfs.extN only does the detection if it is running with a tty.  The
> reasoning behind this was that there might have been existing shell
> scripts that might try to reformat a block device over an existing
> file system.  (For example, like file system test / performance
> scripts like, say, for example xfstests's "check" script.  :-)
> 
> What I've considered doing adding an extended option, "mke2fs -E
> existing_fs_test={on,off,auto}" where auto is today's behavior, and
> "on" would always do the pre-existing file system test and fail if it
> there is a pre-existing file system, and "off" would skip it entirely.
> 
> This would allow generic/740 to work without having to depend on
> "script" being installed.  Of course, this would only work if a
> sufficiently new version of mkfs.extN being used by fstests.

Yes, so it's probably not worth it at least for this purpose.

My preference would be to go ahead with the series as-is for now.
I'll see if I can come up with the script magic eventually.


