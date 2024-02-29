Return-Path: <linux-ext4+bounces-1421-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F7C86BE63
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 02:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4171C21E5E
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 01:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3232E40F;
	Thu, 29 Feb 2024 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsSP+umK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED282D05D
	for <linux-ext4@vger.kernel.org>; Thu, 29 Feb 2024 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170740; cv=none; b=A1XUyzXDzzNoPCi6DPa83bEojLXq27/wpFoWccDW8FMq1Q5h/OJsb/0tiCW7aAMf6J7RfbYNZ25IPwIeuZrA6BW6ADOfi/oUL7DzX6CjusFLHmPkWT8JGaOl5LhCikF1poQa0QVFt2CSefCaUxGZrBBamxSrrH2edUUETInWcKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170740; c=relaxed/simple;
	bh=UPsyAzFMRABJKfND0Izh3TINv5pbspyHYDz+sEhUpSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3CAxBAEOs3jG9rn+gcebnLoWl1AAMGtRqBxSrltJXk+Tkk1D9U8snfmhL2h8VJyZwg7b+1yH4ci9WKUV3iPZMSfzJW8HyS/TaYljmdVlQDbem2hILFDh3nqQOWMN/ox/AGKS08NIcs5sJaw4RcUg6Exzk1x37o8N+Z8osGnGxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AsSP+umK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709170737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EEeQkB95h/ydVzYCSEU8UvyiVcNyESf8j4dt1oMJMIE=;
	b=AsSP+umKcCAeVXFyNfoDH6hwxI4/QFzkzvcg0EzcQyRu6JJbwFjIirD+M6vQ35lN1+VIQB
	R2tgr2IxR0k1dvcbyUDFyCb7CO1OxhDNj5e9aTXLyJKauUVZtHaIslJmMJeYOK0ihfzoxb
	9K+53EWsdVvBVEKl/EGFJONKDsxpoEk=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-pwVl3GrGMBCPiBh3ovTDWw-1; Wed, 28 Feb 2024 20:38:53 -0500
X-MC-Unique: pwVl3GrGMBCPiBh3ovTDWw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c1a4222aa2so420671b6e.0
        for <linux-ext4@vger.kernel.org>; Wed, 28 Feb 2024 17:38:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709170733; x=1709775533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEeQkB95h/ydVzYCSEU8UvyiVcNyESf8j4dt1oMJMIE=;
        b=cBUjc5w4xujbJ7rp+eRnVqer8DeCLuhdsXaLObJIRW9GjLKrZzDziBo/dLpFUw0q+C
         hxuMM/IIivekmofxYKaawqyr1UrkzrfQ+dCN5v3xt3x7eHHU6Xk4CLsSgeEuL5rwMNQz
         xdpcprgrsoBsdnaFSX0JPavDsw4LMUjxjYKL2mmH7FnqkgLzT+zpK91x5h3ft3VP4Dvr
         JBWYBetfUteQG2JhFEPC2paxQFKd1QPF9L1RMUZs2Kl7/gMEhEHFU65DNwCkyuVR8Ruz
         p6bNe/yBegV0f7wN0kxETAgroecXj1LV/C1RRBUFooy2l9uizXZ9m3TusKGYMlsllx73
         timw==
X-Forwarded-Encrypted: i=1; AJvYcCU/2xN2wNKMsh74KQMbZxg0a8khvgMDR3uRGXgJgbQScUEZrbXkxp35K/gParmrSgUN3iXF4f9Q5MbMipUPFtsAWUWl73oYqSSJRA==
X-Gm-Message-State: AOJu0Yyxiiw1B4LYBoT5IMUVY9WurByv3XvRCdLQt+MCBANP0/5Z3shd
	HMZ7s3UP2vcReyOu3NHtr39aYOH5dHPtv2CsysCdAibZweecF57Eiyw1ZBWg1AGdINlJdCtf6Nj
	64gmXY55TEnVBSdUGsDVYafu4ZmxhwLbh+YDnlCNigFWYU1tmL/zQQCE5LcSlGNarDOCUHQ==
X-Received: by 2002:a05:6808:2219:b0:3c1:c202:ed53 with SMTP id bd25-20020a056808221900b003c1c202ed53mr959409oib.44.1709170732818;
        Wed, 28 Feb 2024 17:38:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDi4s0RXs79xYyW9nGTl/246WfdfXb9pjLope7l8Q9DyWiNClhKd8eWDSYmqjxmMO863CZ7A==
X-Received: by 2002:a05:6808:2219:b0:3c1:c202:ed53 with SMTP id bd25-20020a056808221900b003c1c202ed53mr959400oib.44.1709170732540;
        Wed, 28 Feb 2024 17:38:52 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c11-20020a63da0b000000b005bd980cca56sm132958pgh.29.2024.02.28.17.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 17:38:52 -0800 (PST)
Date: Thu, 29 Feb 2024 09:38:48 +0800
From: Zorro Lang <zlang@redhat.com>
To: Suraj Jitindar Singh <surajjs@amazon.com>
Cc: fstests@vger.kernel.org, sjitindarsingh@gmail.com,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4/060: Test marking last group as trimmed
Message-ID: <20240229013848.3kqkj6sytp7xs3oh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240228211612.2602355-1-surajjs@amazon.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228211612.2602355-1-surajjs@amazon.com>

On Wed, Feb 28, 2024 at 01:16:12PM -0800, Suraj Jitindar Singh wrote:
> Regression test for upstream commit added in v6.8-rc1:
> 7c784d624819a ext4: allow for the last group to be marked as trimmed
> 
> Which fixes bug introduced by upstream commit in v6.6-rc2:
> 45e4ab320c9b5 ext4: move setting of trimmed bit into ext4_try_to_trim_range()
> 
> Applicable to kernels 4.19..6.7:
> Kernel		Bug Introduced			Bug Fixed
> 		kver      - commit sha		kver      - commit sha
> 4.19		v4.19.296 - d61445f6a5c57	v4.19.307 - 5b6a7f323b533
> 5.4		v5.4.258  - 4db34feaf2977	v5.4.269  - a7edaf40fccae
> 5.10		v5.10.198 - c502b09d9befc	v5.10.210 - fa94912241835
> 5.15		v5.15.134 - a9d3bb58da959	v5.15.149 - cb904f5c71629
> 6.1		v6.1.56   - b4d5db1c77fac	v6.1.76   - 852b6b2a2f7b7
> 6.6		v6.6-rc2  - 45e4ab320c9b5	v6.6.15   - da9008da96404
> 6.7		v6.6-rc2  - 45e4ab320c9b5	v6.7.3    - 73986e8d2808c
> 
> Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
> ---
>  tests/ext4/060     | 62 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/060.out |  2 ++

Great, a new ext4 case :) CC ext4 list to get more review :)

>  2 files changed, 64 insertions(+)
>  create mode 100755 tests/ext4/060
>  create mode 100644 tests/ext4/060.out
> 
> diff --git a/tests/ext4/060 b/tests/ext4/060
> new file mode 100755
> index 00000000..cc5f3819
> --- /dev/null
> +++ b/tests/ext4/060
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 309
> +#
> +# Regression test for upstream commit added in v6.8-rc1:
> +# 7c784d624819a ext4: allow for the last group to be marked as trimmed
> +#
> +# Which fixes bug introduced by upstream commit in v6.6-rc2:
> +# 45e4ab320c9b5 ext4: move setting of trimmed bit into ext4_try_to_trim_range()
> +#
> +# Applicable to kernels 4.19..6.7:
> +# Kernel	Bug Introduced			Bug Fixed
> +#		kver      - commit sha		kver      - commit sha
> +# 4.19		v4.19.296 - d61445f6a5c57	v4.19.307 - 5b6a7f323b533
> +# 5.4		v5.4.258  - 4db34feaf2977	v5.4.269  - a7edaf40fccae
> +# 5.10		v5.10.198 - c502b09d9befc	v5.10.210 - fa94912241835
> +# 5.15		v5.15.134 - a9d3bb58da959	v5.15.149 - cb904f5c71629
> +# 6.1		v6.1.56   - b4d5db1c77fac	v6.1.76   - 852b6b2a2f7b7
> +# 6.6		v6.6-rc2  - 45e4ab320c9b5	v6.6.15   - da9008da96404
> +# 6.7		v6.6-rc2  - 45e4ab320c9b5	v6.7.3    - 73986e8d2808c
> +
> +. ./common/preamble
> +_begin_fstest auto
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +    _scratch_unmount

This cleanup is useless, the SCRATCH_DEV will be unmounted and checked by default,
so you can remove this specific _cleanup if you don't need other cleanup steps.

> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs ext4

fstrim isn't an ext4 specific operation. Can this case be a generic case?
And you can have:

[[ "$FSTYP" =~ ext[0-9]+ ]] && _fixed_by_kernel_commit 7c784d624819a \
	ext4: allow for the last group to be marked as trimmed

> +
> +_require_scratch
> +_require_fstrim
> +
> +# Make an ext4 fs where the last group has fewer blocks than blocks per group
> +blksz=$(_get_page_size)
> +blocks_per_group=8192
> +
> +$MKFS_EXT4_PROG -F -b $blksz -g $blocks_per_group $SCRATCH_DEV $(( blocks_per_group - 1 )) >>$seqres.full 2>&1

Can it be replaced by _scratch_mkfs_sized? e.g.

MKFS_OPTIONS="-b $blksz -g $blocks_per_group" _scratch_mkfs_sized $(( blocks_per_group - 1 )) >> $seqres.full 2>&1

If you don't mind the effection of $MKFS_OPTIONS outside, you can keep it:
MKFS_OPTIONS="-b $blksz -g $blocks_per_group $MKFS_OPTIONS" ....

And of course better to check if the mkfs fails or not:

... _scratch_mkfs_sized .... || _fail "......"

It also helps to make this case be generic.

> +_scratch_mount
> +
> +$FSTRIM_PROG -v $SCRATCH_MNT >>$seqres.full 2>&1

Due to _require_fstrim only checks [ -z "$FSTRIM_PROG" ], the fstrim might still not
be supported by the SCRATCH_DEV, so we can check at here:

$FSTRIM_PROG -v $SCRATCH_MNT >>$seqres.full 2>&1 || _notrun "FSTRIM not supported"

> +# If we have the fix commit then the above trim command should have marked the
> +# group as trimmed and subsequent trim operations shouldn't discard anything.
> +# If we don't have the fix commit then the group won't have been marked as
> +# trimmed and the below trim operation will discard more than 0.
> +bytes=$($FSTRIM_PROG -v $SCRATCH_MNT | tee -a $seqres.full | _filter_fstrim)
> +if [ $bytes -gt 0 ]; then
> +	status=1
> +	echo "Final group in filesystem not marked as trimmed after trimming entire fs."
> +else
> +	status=0
> +	echo "Final group in filesystem correctly marked as trimmed after trimming entire fs."
> +fi

How about simplify this part as:

  $FSTRIM_PROG -v $SCRATCH_MNT | _filter_scratch

It will get "SCRATCH_MNT: 0 B (0 bytes) trimmed" as golden image (in .out file).
So if it's "0", then the test will fail by the golden image broken.

> +
> +exit
> diff --git a/tests/ext4/060.out b/tests/ext4/060.out
> new file mode 100644
> index 00000000..f3457134
> --- /dev/null
> +++ b/tests/ext4/060.out
> @@ -0,0 +1,2 @@
> +QA output created by 060
> +Final group in filesystem correctly marked as trimmed after trimming entire fs.
> -- 
> 2.34.1
> 
> 


