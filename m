Return-Path: <linux-ext4+bounces-8337-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99882AD239D
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Jun 2025 18:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0DC3A68BA
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Jun 2025 16:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF1E219A8C;
	Mon,  9 Jun 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUBtiSTh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160B220C480;
	Mon,  9 Jun 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486003; cv=none; b=SDJvWwAU4X+bpupGZeMKTm9Zsq6/SBohggYcYMIft7hMrohsqmX375DYJd7I2jWy/ciBQUgQQIDs8tkM9nWf+KYE1E/jxYcfJ8gJHyQjZEe1H4iyhH7C8nIYWe0VUnvzlPmcBi3UmAMAVZNhrGnMzLwOr9mYPJIAbLN9MNf1PVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486003; c=relaxed/simple;
	bh=yyN7VQYbmpy7gDSeA6TqzhBEdAeSw4nc9IpxlkG2wtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRGflYyQo0UyO8i/8jG7pF89uY834hQDWpY0c+NKa2iHMY4XDh4E49i4IzDxoFXtV+Fis1sdumBWFtp9l5j2k9l4TRj5MQPYPyEtChYjsZh4hA4LPcH5hQNRXlxsnxzQNvSY7Cs3K2EbB4kkkwoh3jFDncAWcvqHnVL3SYZurPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUBtiSTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E280C4CEEB;
	Mon,  9 Jun 2025 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749486002;
	bh=yyN7VQYbmpy7gDSeA6TqzhBEdAeSw4nc9IpxlkG2wtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUBtiSThGhubvZshwmkqLsYqzXpHR8gcgn2sQjcLyEPhOFtDa9E6AewSlmVOcaa/z
	 Y0eRBSeKh8SegpIQjJfkryaEWZeOFIOpIrP0u7GymNrMC4SGJlh8UnvrFldqGCYX9k
	 8dkp3SpZ1if7hoyczjFQs+j7EvMIFGYLl/ylRavHbEueThjXkBA4ZB5Ue74ac30l9D
	 2NeP/saUUXdjiRt4LJ/Xj6wz1AbPJDUuJsv3B5JPv3y7C5hut//pyLm/PHYAlylzUS
	 j6vj1cMpPvn8CHyic54Wl7Cl2srzHtbUi/BkH/aoByloTMwwJ/gerd0sefkodAriyd
	 p36NiAtIdDZpg==
Date: Mon, 9 Jun 2025 09:20:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: Zorro Lang <zlang@kernel.org>, hch <hch@lst.de>,
	"tytso@mit.edu" <tytso@mit.edu>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/2] ext4/002: make generic to support xfs
Message-ID: <20250609162002.GH6156@frogsfrogsfrogs>
References: <20250609110307.17455-1-hans.holmberg@wdc.com>
 <20250609110307.17455-3-hans.holmberg@wdc.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609110307.17455-3-hans.holmberg@wdc.com>

On Mon, Jun 09, 2025 at 11:03:54AM +0000, Hans Holmberg wrote:
> xfs supports separate log devices and as this test now passes, share
> it by turning it into a generic test.
> 
> This should not result in a new failure for other file systems as only
> ext2/ext3/ext4 and xfs supports mkfs with SCRATCH_LOGDEVs.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/{ext4/002 => generic/766}         | 11 ++++++++++-
>  tests/{ext4/002.out => generic/766.out} |  2 +-
>  2 files changed, 11 insertions(+), 2 deletions(-)
>  rename tests/{ext4/002 => generic/766} (91%)
>  rename tests/{ext4/002.out => generic/766.out} (98%)
> 
> diff --git a/tests/ext4/002 b/tests/generic/766
> similarity index 91%
> rename from tests/ext4/002
> rename to tests/generic/766
> index 6c1e1d926973..3b6911f0bdb9 100755
> --- a/tests/ext4/002
> +++ b/tests/generic/766
> @@ -3,10 +3,11 @@
>  # Copyright (c) 2009 Christoph Hellwig.
>  # Copyright (c) 2020 Lukas Czerner.
>  #
> -# FS QA Test No. 002
> +# FS QA Test No. 766
>  #
>  # Copied from tests generic/050 and adjusted to support testing
>  # read-only external journal device on ext4.
> +# Moved to generic from ext4/002 to support xfs as well
>  #
>  # Check out various mount/remount/unmount scenarious on a read-only
>  # logdev blockdev.
> @@ -31,6 +32,14 @@ _cleanup()
>  
>  _exclude_fs ext2
>  
> +[ $FSTYP == "ext4" ] && \
> +        _fixed_by_kernel_commit 273108fa5015 \
> +        "ext4: handle read only external journal device"
> +
> +[ $FSTYP == "xfs" ] && \
> +        _fixed_by_kernel_commit bfecc4091e07 \
> +        "xfs: allow ro mounts if rtdev or logdev are read-only"
> +
>  _require_scratch_nocheck
>  _require_scratch_shutdown
>  _require_logdev
> diff --git a/tests/ext4/002.out b/tests/generic/766.out
> similarity index 98%
> rename from tests/ext4/002.out
> rename to tests/generic/766.out
> index 579bc7e0cd78..975751751749 100644
> --- a/tests/ext4/002.out
> +++ b/tests/generic/766.out
> @@ -1,4 +1,4 @@
> -QA output created by 002
> +QA output created by 766
>  setting log device read-only
>  mounting with read-only log device:
>  mount: device write-protected, mounting read-only
> -- 
> 2.34.1
> 

