Return-Path: <linux-ext4+bounces-6292-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD0FA24E44
	for <lists+linux-ext4@lfdr.de>; Sun,  2 Feb 2025 14:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6591882271
	for <lists+linux-ext4@lfdr.de>; Sun,  2 Feb 2025 13:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5D21D9359;
	Sun,  2 Feb 2025 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHUsXXA8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A0B1D8DFD
	for <linux-ext4@vger.kernel.org>; Sun,  2 Feb 2025 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738503073; cv=none; b=ofJrUokWVuOQkLjheS/btiqzWLqf6WUpCjkPc5NHlZYc918BNdCnBq0fM8gcFxY4Jk2cm1CcASnsg2Zv6O2RSP4y0o1dzxHWsl7tJU/SIvErZTdz4CKeczPOkoofnTsEMu6DCGg4eExqTzxYxl8fsAkofpz10q0uhSXNqJ4Beos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738503073; c=relaxed/simple;
	bh=NCViiLGt37hWVCtMkmMH2/R8r7bcq4JX5ae5x+7FS3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scyOE8E2BChiECZfcmUE0z5GdlQzamdXUAE4ZVKYhK4cDFkYd9c4+1bVfFuWvRGXbWTrMdRlmrCDLAytsWiB6bpVs02jbMYoa2cF3bkqtEUKPpaBQVfMSOlwtVKrEPoA2DhrRtLMLpGUocgstO3VnQH0uxK64DWF2CxNKUFuMcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHUsXXA8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738503069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MKySpnf15QN3pgTrERUuZmDdujpMTxeBmYql/qTM2kQ=;
	b=eHUsXXA8kbctD7ISN09Nvx4f3nhA5plB5UwEkH7hde9cfQwdnEs4By3oj8RFFOwR2VJd6c
	OSvT+wlAuQu2bcCChnPFozx4ntyN0BWhO3eeqCsFqRilnej+8ED9uh9QmyCFKDDGEXunO4
	/eyo6Ne8sFTN8MThYXyyPc6G1bWi7r8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-TEOP7K3mNGmVYQFyCs7OJw-1; Sun, 02 Feb 2025 08:31:07 -0500
X-MC-Unique: TEOP7K3mNGmVYQFyCs7OJw-1
X-Mimecast-MFC-AGG-ID: TEOP7K3mNGmVYQFyCs7OJw
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21638389f63so57188795ad.1
        for <linux-ext4@vger.kernel.org>; Sun, 02 Feb 2025 05:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738503066; x=1739107866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKySpnf15QN3pgTrERUuZmDdujpMTxeBmYql/qTM2kQ=;
        b=Vjh3dXSYepeCBPwyFL91Bg7gpjt2BZqqB6MoE93ieRT6dt3bISkPnN2939QKxaegeE
         2LNggnCrQss8wYfz5RRWCa1vPjnLdpPe8gQj8YQo6YHSIe2HawbJmKk/xKzNUrd5WaLs
         8TD4FgB8CKpVH5N7qIXoLiz7Y0FougbWNDO5EDBLzxX9vKomi0V34h5tV2zz5muqNMPd
         MEwocg16cRYZYifu2m9otdfel/zBHdUW+rw0CF/mUOLcQ7LOrlwAVfmZ2eAI9xjRxWAF
         z1oPptBOd67KRiBrL28W+wElUBDzy+8r/BSgJvrFn3UtBhaNObMzCrRPPhqfdfbvp+U+
         0Ayg==
X-Forwarded-Encrypted: i=1; AJvYcCV2i7fe5WrtHKqrU9TWAG1P/3uLLKhgMmBLxUda63jdFZFN3/9OSrZk9XXd8rYt9oGBaIT+rbwf5y6m@vger.kernel.org
X-Gm-Message-State: AOJu0YwoeprE8+bQXSQQO2MrMEuIA20PzrTHTpyVaZiucJ+HFmAxfZXo
	okYI33OmpIwf3Qr//NlMHtmy/uPBO1TO1tjleFe+agVXzQiKIkGFmmyq4vI7EB0SSf+5jyujJ/6
	m9vm22Wopv9SL+QRynCDd9Jzn1HNeERl++il1Qh4B8nBxpjkxd0Z/xe66wgo=
X-Gm-Gg: ASbGncvgYgHYoVjH8oJDhn2h3xZDk7WlsyRRSv/03icjPAypu++NMbIBbzfJ0S55Xu5
	QreFHhYTum/nV4W5kiUeIFFiBbWryLFOgK7wHTCp4mBqjt+UxP8ZAdGKJMpYO6YLUNqDUuoZew6
	wDAAI4aW/c1dp12Zek2TSb5GF9ar/PdpjHmwv2sG6WnlUcSYYFbc6HcWXCtY8cACZmx7l2kCLm5
	zqIKCQJ5xjUb4dc7MvidcWOEhsKnz2P6TkAuMTFlFKaO8kQY684S3DgdfD62BvmSudUDUsiG8c2
	j1x2e4FFLMG736IJ4/VElyf2IBUDyMulSPMWwIdWz3XReQ==
X-Received: by 2002:a17:902:d54c:b0:215:b8c6:338a with SMTP id d9443c01a7336-21eddbf334dmr184431685ad.4.1738503066126;
        Sun, 02 Feb 2025 05:31:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrluerR9Cas4r8yr5SJN9eyDs+Q9TMsBHnLh44hDBBubbIEpIixI6jnkPVPyxCQN9S2lBQyg==
X-Received: by 2002:a17:902:d54c:b0:215:b8c6:338a with SMTP id d9443c01a7336-21eddbf334dmr184430785ad.4.1738503065240;
        Sun, 02 Feb 2025 05:31:05 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de33036d9sm59130565ad.200.2025.02.02.05.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 05:31:04 -0800 (PST)
Date: Sun, 2 Feb 2025 21:31:01 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Brian Foster <bfoster@redhat.com>,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] replace _supported_fs with _exclude_fs
Message-ID: <20250202133101.bpst6rzhjn7g4zvw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250128071315.676272-1-hch@lst.de>
 <20250128071315.676272-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128071315.676272-4-hch@lst.de>

On Tue, Jan 28, 2025 at 08:13:00AM +0100, Christoph Hellwig wrote:
> Tests don't require a list of supported file systems, as that is deducted
> from the test directory name.  Instead we exclude specific file systems
> from a few common tests, and specify which of ext2 and ext3 should
> actually also be tested after oddly multiplexing them into the ext4
> directory full of tests only working for ext4.
> 
> Replace _supported_fs with a new _exclude_fs that takes only a single
> file systems as the argument, making it easier to explain why the file
> system is not supported for the common test.  For ext4 this increases
> the existing mess even further, but the maintainers have a plan to
> move it to feature checks instead that are hopefully easier to
> understand.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

generic/730 is missed:

  /var/lib/xfstests/tests/generic/370: line 31: _supported_fs: command not found

Anyway, I'll help to change g/370 when I merge this patch.

Thanks,
Zorro

>  common/rc         | 30 ++++++++----------------------
>  tests/ext4/001    |  4 +++-
>  tests/ext4/002    |  2 +-
>  tests/ext4/003    |  3 ++-
>  tests/ext4/004    |  3 ++-
>  tests/ext4/005    |  4 +++-
>  tests/ext4/006    |  3 ++-
>  tests/ext4/007    |  3 ++-
>  tests/ext4/008    |  3 ++-
>  tests/ext4/009    |  3 ++-
>  tests/ext4/010    |  3 ++-
>  tests/ext4/011    |  3 ++-
>  tests/ext4/012    |  3 ++-
>  tests/ext4/013    |  3 ++-
>  tests/ext4/014    |  3 ++-
>  tests/ext4/015    |  3 ++-
>  tests/ext4/016    |  3 ++-
>  tests/ext4/017    |  3 ++-
>  tests/ext4/018    |  3 ++-
>  tests/ext4/019    |  3 ++-
>  tests/ext4/020    |  4 +++-
>  tests/ext4/021    |  4 +++-
>  tests/ext4/022    |  4 +++-
>  tests/ext4/023    |  4 +++-
>  tests/ext4/024    |  4 +++-
>  tests/ext4/025    |  4 +++-
>  tests/ext4/026    |  4 +++-
>  tests/ext4/027    |  4 +++-
>  tests/ext4/028    |  4 +++-
>  tests/ext4/029    |  4 +++-
>  tests/ext4/030    |  4 +++-
>  tests/ext4/031    |  4 +++-
>  tests/ext4/032    |  3 ++-
>  tests/ext4/033    |  4 +++-
>  tests/ext4/034    |  3 ++-
>  tests/ext4/035    |  3 ++-
>  tests/ext4/036    |  3 ++-
>  tests/ext4/037    |  2 +-
>  tests/ext4/038    |  3 +--
>  tests/ext4/039    |  3 ++-
>  tests/ext4/040    |  1 -
>  tests/ext4/041    |  1 -
>  tests/ext4/042    |  3 ---
>  tests/ext4/043    |  2 +-
>  tests/ext4/044    |  4 +++-
>  tests/ext4/045    |  3 ++-
>  tests/ext4/046    |  3 ++-
>  tests/ext4/047    |  4 +++-
>  tests/ext4/048    |  3 ++-
>  tests/ext4/049    |  3 ++-
>  tests/ext4/050    |  3 ++-
>  tests/ext4/051    |  3 ++-
>  tests/ext4/052    |  3 ++-
>  tests/ext4/053    |  1 -
>  tests/ext4/054    |  4 +++-
>  tests/ext4/055    |  4 +++-
>  tests/ext4/056    |  4 +++-
>  tests/ext4/057    |  4 +++-
>  tests/ext4/058    |  4 +++-
>  tests/ext4/059    |  4 +++-
>  tests/ext4/060    |  4 +++-
>  tests/ext4/271    |  4 +++-
>  tests/ext4/301    |  4 +++-
>  tests/ext4/302    |  4 +++-
>  tests/ext4/303    |  4 +++-
>  tests/ext4/304    |  4 +++-
>  tests/ext4/305    |  3 ++-
>  tests/ext4/306    |  3 ++-
>  tests/ext4/307    |  4 +++-
>  tests/generic/187 |  8 +++++---
>  tests/generic/294 |  2 +-
>  tests/generic/357 |  2 +-
>  tests/generic/362 |  3 ++-
>  tests/generic/465 |  2 +-
>  tests/generic/500 |  2 +-
>  tests/generic/631 |  4 +++-
>  tests/generic/679 |  2 +-
>  tests/generic/699 |  3 ++-
>  tests/generic/732 |  4 +++-
>  tests/generic/740 |  7 ++++++-
>  80 files changed, 188 insertions(+), 106 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index c5421c9454fa..a38eaf52ab8e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1769,30 +1769,16 @@ _fail()
>      exit 1
>  }
>  
> -# tests whether $FSTYP is one of the supported filesystems for a test
>  #
> -_check_supported_fs()
> -{
> -	local res=1
> -	local f
> -
> -	for f; do
> -		# ^FS means black listed fs
> -		if [ "$f" = "^$FSTYP" ]; then
> -			return 1
> -		elif [ "$f" = "generic" ] || [[ "$f" == "^"* ]]; then
> -			# ^FS implies "generic ^FS"
> -			res=0
> -		elif [ "$f" = "$FSTYP" ]; then
> -			return 0
> -		fi
> -	done
> -	return $res
> -}
> -
> -_supported_fs()
> +# Tests whether $FSTYP should be exclude from this test.
> +#
> +# In general this should be avoided in favor of feature tests, and when this
> +# helper has to be used, it should include a comment on why a specific file
> +# system is excluded.
> +#
> +_exclude_fs()
>  {
> -	_check_supported_fs $* || \
> +	[ "$1" = "$FSTYP" ] && \
>  		_notrun "not suitable for this filesystem type: $FSTYP"
>  }
>  
> diff --git a/tests/ext4/001 b/tests/ext4/001
> index 4575cf6973bb..1990746aa587 100755
> --- a/tests/ext4/001
> +++ b/tests/ext4/001
> @@ -14,7 +14,9 @@ _begin_fstest auto prealloc quick zero fiemap
>  . ./common/filter
>  . ./common/punch
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_xfs_io_command "falloc"
>  _require_xfs_io_command "fzero"
>  _require_test
> diff --git a/tests/ext4/002 b/tests/ext4/002
> index 9c6eb5a04136..6c1e1d926973 100755
> --- a/tests/ext4/002
> +++ b/tests/ext4/002
> @@ -29,7 +29,7 @@ _cleanup()
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext4 ext3
> +_exclude_fs ext2
>  
>  _require_scratch_nocheck
>  _require_scratch_shutdown
> diff --git a/tests/ext4/003 b/tests/ext4/003
> index e2b588d88849..e752a769603f 100755
> --- a/tests/ext4/003
> +++ b/tests/ext4/003
> @@ -20,7 +20,8 @@ _cleanup()
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  _require_scratch_ext4_feature "bigalloc"
> diff --git a/tests/ext4/004 b/tests/ext4/004
> index ab2f838e9fac..4e6c4a75f601 100755
> --- a/tests/ext4/004
> +++ b/tests/ext4/004
> @@ -43,7 +43,8 @@ workout()
>  	rm -rf restoresymtable
>  }
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_test
>  _require_scratch
> diff --git a/tests/ext4/005 b/tests/ext4/005
> index a271fbbf641a..b581ac1cacb9 100755
> --- a/tests/ext4/005
> +++ b/tests/ext4/005
> @@ -17,7 +17,9 @@ _begin_fstest auto quick metadata ioctl rw
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch
>  _require_command "$CHATTR_PROG" chattr
>  
> diff --git a/tests/ext4/006 b/tests/ext4/006
> index d78620731148..2ece22a4bd1e 100755
> --- a/tests/ext4/006
> +++ b/tests/ext4/006
> @@ -28,7 +28,8 @@ if [ ! -x "$(type -P e2fuzz)" ]; then
>  	_notrun "Couldn't find e2fuzz"
>  fi
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  _require_attrs
> diff --git a/tests/ext4/007 b/tests/ext4/007
> index deedbd9e8fb3..39c9427c5257 100755
> --- a/tests/ext4/007
> +++ b/tests/ext4/007
> @@ -21,7 +21,8 @@ _cleanup()
>  . ./common/filter
>  . ./common/attr
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
> diff --git a/tests/ext4/008 b/tests/ext4/008
> index b4b20ac10d6d..1ca6d90e0c3d 100755
> --- a/tests/ext4/008
> +++ b/tests/ext4/008
> @@ -21,7 +21,8 @@ _cleanup()
>  . ./common/filter
>  . ./common/attr
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
> diff --git a/tests/ext4/009 b/tests/ext4/009
> index 06a42fd77ffa..71e59f90e4b8 100755
> --- a/tests/ext4/009
> +++ b/tests/ext4/009
> @@ -21,7 +21,8 @@ _cleanup()
>  . ./common/filter
>  . ./common/attr
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_xfs_io_command "falloc"
>  _require_scratch
> diff --git a/tests/ext4/010 b/tests/ext4/010
> index 1139c79e80d5..dec08a62cdf0 100755
> --- a/tests/ext4/010
> +++ b/tests/ext4/010
> @@ -21,7 +21,8 @@ _cleanup()
>  . ./common/filter
>  . ./common/attr
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  _require_dumpe2fs
> diff --git a/tests/ext4/011 b/tests/ext4/011
> index cae4fb6b8476..e135ae4cefac 100755
> --- a/tests/ext4/011
> +++ b/tests/ext4/011
> @@ -21,7 +21,8 @@ _cleanup()
>  . ./common/filter
>  . ./common/attr
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
> diff --git a/tests/ext4/012 b/tests/ext4/012
> index f7f2b0fb4557..9a420bd3c696 100755
> --- a/tests/ext4/012
> +++ b/tests/ext4/012
> @@ -21,7 +21,8 @@ _cleanup()
>  . ./common/filter
>  . ./common/attr
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
> diff --git a/tests/ext4/013 b/tests/ext4/013
> index 7d2a9154a669..343a8e65cfce 100755
> --- a/tests/ext4/013
> +++ b/tests/ext4/013
> @@ -21,7 +21,8 @@ _cleanup()
>  . ./common/filter
>  . ./common/attr
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
> diff --git a/tests/ext4/014 b/tests/ext4/014
> index ffed795ad4e9..870f7ef911a2 100755
> --- a/tests/ext4/014
> +++ b/tests/ext4/014
> @@ -21,7 +21,8 @@ _cleanup()
>  . ./common/filter
>  . ./common/attr
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
> diff --git a/tests/ext4/015 b/tests/ext4/015
> index 81feda5c9423..08e669584c6b 100755
> --- a/tests/ext4/015
> +++ b/tests/ext4/015
> @@ -21,7 +21,8 @@ _cleanup()
>  . ./common/filter
>  . ./common/attr
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_xfs_io_command "falloc"
>  _require_xfs_io_command "fpunch"
> diff --git a/tests/ext4/016 b/tests/ext4/016
> index b7db4cfda649..925f39d15ad2 100755
> --- a/tests/ext4/016
> +++ b/tests/ext4/016
> @@ -21,7 +21,8 @@ _cleanup()
>  . ./common/filter
>  . ./common/attr
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
> diff --git a/tests/ext4/017 b/tests/ext4/017
> index fc867442c3da..f081900a9a1e 100755
> --- a/tests/ext4/017
> +++ b/tests/ext4/017
> @@ -21,7 +21,8 @@ _cleanup()
>  . ./common/filter
>  . ./common/attr
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
> diff --git a/tests/ext4/018 b/tests/ext4/018
> index f7377f059fb8..5999837a9db1 100755
> --- a/tests/ext4/018
> +++ b/tests/ext4/018
> @@ -21,7 +21,8 @@ _cleanup()
>  . ./common/filter
>  . ./common/attr
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
> diff --git a/tests/ext4/019 b/tests/ext4/019
> index 987972a80a37..dc8243961ee0 100755
> --- a/tests/ext4/019
> +++ b/tests/ext4/019
> @@ -21,7 +21,8 @@ _cleanup()
>  . ./common/filter
>  . ./common/attr
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
> diff --git a/tests/ext4/020 b/tests/ext4/020
> index a2fb60fa8cc6..c2a188e4cdae 100755
> --- a/tests/ext4/020
> +++ b/tests/ext4/020
> @@ -17,7 +17,9 @@ _begin_fstest auto quick ioctl rw defrag
>  . ./common/filter
>  . ./common/defrag
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch
>  _require_defrag
>  
> diff --git a/tests/ext4/021 b/tests/ext4/021
> index d69dc584dc58..337470e0ca6b 100755
> --- a/tests/ext4/021
> +++ b/tests/ext4/021
> @@ -12,7 +12,9 @@ _begin_fstest auto quick
>  
>  # Import common functions.
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch
>  _require_dumpe2fs
>  
> diff --git a/tests/ext4/022 b/tests/ext4/022
> index 6b74ff892a35..eb04cc9d9000 100755
> --- a/tests/ext4/022
> +++ b/tests/ext4/022
> @@ -18,7 +18,9 @@ do_setfattr()
>  . ./common/filter
>  . ./common/attr
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch
>  _require_dumpe2fs
>  _require_command "$DEBUGFS_PROG" debugfs
> diff --git a/tests/ext4/023 b/tests/ext4/023
> index b5217da33f15..335a4bfff96d 100755
> --- a/tests/ext4/023
> +++ b/tests/ext4/023
> @@ -18,7 +18,9 @@ _register_cleanup "_cleanup" BUS
>  . ./common/populate
>  . ./common/fuzzy
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch
>  
>  echo "Format and populate"
> diff --git a/tests/ext4/024 b/tests/ext4/024
> index e58cb9918f25..f3c028adda68 100755
> --- a/tests/ext4/024
> +++ b/tests/ext4/024
> @@ -13,7 +13,9 @@ _begin_fstest auto quick encrypt dangerous
>  # get standard environment and checks
>  . ./common/encrypt
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch_encryption
>  _require_command "$KEYCTL_PROG" keyctl
>  
> diff --git a/tests/ext4/025 b/tests/ext4/025
> index ce3a3d21969b..640285a25a53 100755
> --- a/tests/ext4/025
> +++ b/tests/ext4/025
> @@ -13,7 +13,9 @@ _begin_fstest auto quick fuzzers dangerous
>  # get standard environment and checks
>  . ./common/filter
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch_nocheck
>  _require_command "$DEBUGFS_PROG" debugfs
>  _require_scratch_ext4_feature "bigalloc,meta_bg,^resize_inode"
> diff --git a/tests/ext4/026 b/tests/ext4/026
> index 5bb2add23036..f29ff5a97688 100755
> --- a/tests/ext4/026
> +++ b/tests/ext4/026
> @@ -16,7 +16,9 @@ _begin_fstest auto quick attr
>  . ./common/filter
>  . ./common/attr
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch
>  _require_attrs
>  _require_scratch_ext4_feature "ea_inode"
> diff --git a/tests/ext4/027 b/tests/ext4/027
> index 93de00f29481..8f89062afd0a 100755
> --- a/tests/ext4/027
> +++ b/tests/ext4/027
> @@ -19,7 +19,9 @@ _cleanup()
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch
>  _require_xfs_io_command "fsmap"
>  
> diff --git a/tests/ext4/028 b/tests/ext4/028
> index 30f3c4480c7c..1b8855098f82 100755
> --- a/tests/ext4/028
> +++ b/tests/ext4/028
> @@ -20,7 +20,9 @@ _cleanup()
>  . ./common/filter
>  . ./common/populate
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch
>  _require_populate_commands
>  _require_xfs_io_command "fsmap"
> diff --git a/tests/ext4/029 b/tests/ext4/029
> index 8a6969d2aaef..1915aaa67a74 100755
> --- a/tests/ext4/029
> +++ b/tests/ext4/029
> @@ -19,7 +19,9 @@ _cleanup()
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_logdev
>  _require_scratch
>  _require_xfs_io_command "fsmap"
> diff --git a/tests/ext4/030 b/tests/ext4/030
> index 80f34ccf3e49..5eec9d353a8e 100755
> --- a/tests/ext4/030
> +++ b/tests/ext4/030
> @@ -15,7 +15,9 @@ _begin_fstest auto quick dax
>  . ./common/filter
>  
>  # Modify as appropriate.
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch_dax_mountopt "dax"
>  _require_test_program "t_ext4_dax_journal_corruption"
>  _require_command "$CHATTR_PROG" chattr
> diff --git a/tests/ext4/031 b/tests/ext4/031
> index b583f825162f..330804d39688 100755
> --- a/tests/ext4/031
> +++ b/tests/ext4/031
> @@ -19,7 +19,9 @@ SAVE_MOUNT_OPTIONS="$MOUNT_OPTIONS"
>  MOUNT_OPTIONS=""
>  
>  # Modify as appropriate.
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch_dax_mountopt "dax"
>  _require_test_program "t_ext4_dax_inline_corruption"
>  _require_scratch_ext4_feature "inline_data"
> diff --git a/tests/ext4/032 b/tests/ext4/032
> index 238ab178363c..690fcf066c11 100755
> --- a/tests/ext4/032
> +++ b/tests/ext4/032
> @@ -83,7 +83,8 @@ _cleanup()
>  
>  # get standard environment and checks
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_loop
>  _require_scratch
> diff --git a/tests/ext4/033 b/tests/ext4/033
> index 53f7106e2c6b..3827ab5c52ad 100755
> --- a/tests/ext4/033
> +++ b/tests/ext4/033
> @@ -24,7 +24,9 @@ _cleanup()
>  . ./common/filter
>  . ./common/dmhugedisk
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch_nocheck
>  _require_dmhugedisk
>  _require_dumpe2fs
> diff --git a/tests/ext4/034 b/tests/ext4/034
> index cdd2e553f534..c4ae807519d6 100755
> --- a/tests/ext4/034
> +++ b/tests/ext4/034
> @@ -19,7 +19,8 @@ _begin_fstest auto quick quota fiemap prealloc
>  
>  
>  # Modify as appropriate.
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  _require_scratch
>  _require_quota
>  _require_nobody
> diff --git a/tests/ext4/035 b/tests/ext4/035
> index cf221c5adb7d..fe2a74680f01 100755
> --- a/tests/ext4/035
> +++ b/tests/ext4/035
> @@ -19,7 +19,8 @@ _begin_fstest auto quick resize
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  _require_scratch
>  _exclude_scratch_mount_option dax
>  _require_command "$RESIZE2FS_PROG" resize2fs
> diff --git a/tests/ext4/036 b/tests/ext4/036
> index 045fe82ff956..4a1471fd4cb5 100755
> --- a/tests/ext4/036
> +++ b/tests/ext4/036
> @@ -15,7 +15,8 @@ _begin_fstest auto quick
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext3 ext4
> +_exclude_fs ext2
> +
>  _require_scratch
>  
>  echo "Silence is golden"
> diff --git a/tests/ext4/037 b/tests/ext4/037
> index ac309d67aac5..dea02a79927a 100755
> --- a/tests/ext4/037
> +++ b/tests/ext4/037
> @@ -15,7 +15,7 @@ _begin_fstest auto quick
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext3 ext4
> +_exclude_fs ext2
>  
>  # nofsck as we modify sb via debugfs
>  _require_scratch_nocheck
> diff --git a/tests/ext4/038 b/tests/ext4/038
> index b594bd9cb2e2..07b090b11f13 100755
> --- a/tests/ext4/038
> +++ b/tests/ext4/038
> @@ -10,9 +10,8 @@
>  . ./common/preamble
>  _begin_fstest auto quick
>  
> -# Import common functions.
> +_exclude_fs ext2
>  
> -_supported_fs ext3 ext4
>  _require_scratch
>  _require_command "$DEBUGFS_PROG" debugfs
>  
> diff --git a/tests/ext4/039 b/tests/ext4/039
> index 2830740eb3cf..2e99c8ff9ffd 100755
> --- a/tests/ext4/039
> +++ b/tests/ext4/039
> @@ -56,7 +56,8 @@ chattr_opt: $chattr_opt" >>$seqres.full
>  	done
>  }
>  
> -_supported_fs ext3 ext4
> +_exclude_fs ext2
> +
>  _require_scratch
>  _exclude_scratch_mount_option dax
>  
> diff --git a/tests/ext4/040 b/tests/ext4/040
> index 5760058ad7d4..f22c655b4909 100755
> --- a/tests/ext4/040
> +++ b/tests/ext4/040
> @@ -21,7 +21,6 @@ PIDS=""
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext2 ext3 ext4
>  _require_scratch_nocheck
>  _disable_dmesg_check
>  _require_command "$DEBUGFS_PROG"
> diff --git a/tests/ext4/041 b/tests/ext4/041
> index 76513db3f887..3df1b9db803d 100755
> --- a/tests/ext4/041
> +++ b/tests/ext4/041
> @@ -21,7 +21,6 @@ PIDS=""
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext2 ext3 ext4
>  _require_scratch_nocheck
>  _disable_dmesg_check
>  _require_command "$DEBUGFS_PROG"
> diff --git a/tests/ext4/042 b/tests/ext4/042
> index 0d97f6de4c2a..61fe948f2b61 100755
> --- a/tests/ext4/042
> +++ b/tests/ext4/042
> @@ -12,9 +12,6 @@ _begin_fstest auto quick
>  # Import common functions.
>  . ./common/filter
>  
> -
> -# Modify as appropriate.
> -_supported_fs ext2 ext3 ext4
>  _require_scratch
>  
>  _scratch_mkfs >> $seqres.full 2>&1
> diff --git a/tests/ext4/043 b/tests/ext4/043
> index 0bbbb42ac41d..8d124ba36f72 100755
> --- a/tests/ext4/043
> +++ b/tests/ext4/043
> @@ -12,7 +12,7 @@ _begin_fstest auto quick
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext3 ext4
> +_exclude_fs ext2
>  
>  _require_scratch
>  _require_test_program "t_get_file_time"
> diff --git a/tests/ext4/044 b/tests/ext4/044
> index 53006514dc72..cd52f0d741e0 100755
> --- a/tests/ext4/044
> +++ b/tests/ext4/044
> @@ -12,7 +12,9 @@ _begin_fstest auto quick
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch
>  _require_test_program "t_get_file_time"
>  _require_metadata_journaling
> diff --git a/tests/ext4/045 b/tests/ext4/045
> index 587bedece4e1..15b2541ee342 100755
> --- a/tests/ext4/045
> +++ b/tests/ext4/045
> @@ -16,7 +16,8 @@ LONG_DIR=2
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  _require_scratch_ext4_feature large_dir
> diff --git a/tests/ext4/046 b/tests/ext4/046
> index 5c2100ce9253..60d33550e3db 100755
> --- a/tests/ext4/046
> +++ b/tests/ext4/046
> @@ -16,7 +16,8 @@ _begin_fstest auto prealloc quick
>  . ./common/filter
>  
>  _require_check_dmesg
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  _require_scratch
>  _require_xfs_io_command "falloc"
>  _require_scratch_size $((6 * 1024 * 1024)) #kB
> diff --git a/tests/ext4/047 b/tests/ext4/047
> index f67b615ab082..b7df1ede4805 100755
> --- a/tests/ext4/047
> +++ b/tests/ext4/047
> @@ -13,7 +13,9 @@ _begin_fstest auto quick dax
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch_dax_mountopt "dax=always"
>  _require_dax_iflag
>  _require_scratch_ext4_feature "inline_data"
> diff --git a/tests/ext4/048 b/tests/ext4/048
> index 99a2c7b8fe4d..2031c8c8933d 100755
> --- a/tests/ext4/048
> +++ b/tests/ext4/048
> @@ -13,7 +13,8 @@ _begin_fstest auto quick dir
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  _require_command "$DEBUGFS_PROG" debugfs
> diff --git a/tests/ext4/049 b/tests/ext4/049
> index 5b24e632a73b..075408e0b867 100755
> --- a/tests/ext4/049
> +++ b/tests/ext4/049
> @@ -13,7 +13,8 @@ _begin_fstest auto quick
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  _require_scratch
>  
>  sdev=$(_short_dev ${SCRATCH_DEV})
> diff --git a/tests/ext4/050 b/tests/ext4/050
> index 6ba0038e71f2..99e824898e0f 100755
> --- a/tests/ext4/050
> +++ b/tests/ext4/050
> @@ -13,7 +13,8 @@ _begin_fstest auto ioctl quick
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  _require_command "$DEBUGFS_PROG" debugfs
> diff --git a/tests/ext4/051 b/tests/ext4/051
> index a1e35fa323d3..728ad19bfcec 100755
> --- a/tests/ext4/051
> +++ b/tests/ext4/051
> @@ -12,7 +12,8 @@
>  . ./common/preamble
>  _begin_fstest auto rw quick
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  _require_scratch
>  _require_scratch_shutdown
>  _require_command "$TUNE2FS_PROG" tune2fs
> diff --git a/tests/ext4/052 b/tests/ext4/052
> index edcdc02515f7..0df8a651383e 100755
> --- a/tests/ext4/052
> +++ b/tests/ext4/052
> @@ -29,7 +29,8 @@ _cleanup()
>  
>  
>  # Modify as appropriate.
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  _require_test
>  _require_loop
>  _require_test_program "dirstress"
> diff --git a/tests/ext4/053 b/tests/ext4/053
> index 4f20d217d5fd..5922ed571d8a 100755
> --- a/tests/ext4/053
> +++ b/tests/ext4/053
> @@ -39,7 +39,6 @@ echo "Silence is golden."
>  SIZE=$((1024 * 1024))	# 1GB in KB
>  LOGSIZE=$((10 *1024))	# 10MB in KB
>  
> -_supported_fs ext2 ext3 ext4
>  _require_scratch_size $SIZE
>  _require_quota
>  _require_loop
> diff --git a/tests/ext4/054 b/tests/ext4/054
> index 0dbe83640072..458eed6a7072 100755
> --- a/tests/ext4/054
> +++ b/tests/ext4/054
> @@ -17,7 +17,9 @@ _begin_fstest auto quick dangerous_fuzzers prealloc punch
>  # Import common functions
>  . ./common/filter
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch_nocheck
>  _require_xfs_io_command "falloc"
>  _require_xfs_io_command "pwrite"
> diff --git a/tests/ext4/055 b/tests/ext4/055
> index e1815c23727a..3117bf15f9f0 100755
> --- a/tests/ext4/055
> +++ b/tests/ext4/055
> @@ -16,8 +16,10 @@
>  . ./common/preamble
>  _begin_fstest auto quota
>  
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch_nocheck
> -_supported_fs ext4
>  _require_user fsgqa
>  _require_user fsgqa2
>  _require_command "$DEBUGFS_PROG" debugfs
> diff --git a/tests/ext4/056 b/tests/ext4/056
> index 8a290b11d697..fb5bbe93e972 100755
> --- a/tests/ext4/056
> +++ b/tests/ext4/056
> @@ -26,7 +26,9 @@ ONLINE_RESIZE_BLOCK_LIMIT=$((256*1024*1024))
>  
>  STOP_ITER=255   # Arbitrary return code
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch_size $(($RESIZED_FS_SIZE/1024))
>  _require_test_program "ext4_resize"
>  
> diff --git a/tests/ext4/057 b/tests/ext4/057
> index 73cdf941a181..2be46223538f 100755
> --- a/tests/ext4/057
> +++ b/tests/ext4/057
> @@ -11,7 +11,9 @@ _begin_fstest auto ioctl
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch
>  _require_test_program uuid_ioctl
>  _require_command $UUIDGEN_PROG uuidgen
> diff --git a/tests/ext4/058 b/tests/ext4/058
> index f853649644db..9a2c3aa59ba8 100755
> --- a/tests/ext4/058
> +++ b/tests/ext4/058
> @@ -13,7 +13,9 @@
>  . ./common/preamble
>  _begin_fstest auto quick
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _fixed_by_kernel_commit a08f789d2ab5 \
>  	"ext4: fix bug_on ext4_mb_use_inode_pa"
>  _require_scratch
> diff --git a/tests/ext4/059 b/tests/ext4/059
> index 50e788f0a169..7ea7ff92744d 100755
> --- a/tests/ext4/059
> +++ b/tests/ext4/059
> @@ -11,7 +11,9 @@
>  . ./common/preamble
>  _begin_fstest auto resize quick
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _fixed_by_kernel_commit b55c3cd102a6 \
>  	"ext4: add reserved GDT blocks check"
>  
> diff --git a/tests/ext4/060 b/tests/ext4/060
> index 38d1c8f7b672..b8cc542fd242 100755
> --- a/tests/ext4/060
> +++ b/tests/ext4/060
> @@ -14,7 +14,9 @@
>  . ./common/preamble
>  _begin_fstest auto resize quick
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _fixed_by_kernel_commit a6b3bfe176e8 \
>  	"ext4: fix corruption during on-line resize"
>  
> diff --git a/tests/ext4/271 b/tests/ext4/271
> index 6d60f40d3d25..5535384742ee 100755
> --- a/tests/ext4/271
> +++ b/tests/ext4/271
> @@ -12,7 +12,9 @@ _begin_fstest auto rw quick
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch
>  # this test needs no journal to be loaded, skip on journal related mount
>  # options, otherwise mount would fail with "-o noload" mount option
> diff --git a/tests/ext4/301 b/tests/ext4/301
> index dd0c7d483761..abf47d4b7ece 100755
> --- a/tests/ext4/301
> +++ b/tests/ext4/301
> @@ -15,7 +15,9 @@ fio_config=$tmp.fio
>  . ./common/filter
>  . ./common/defrag
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch
>  _require_defrag
>  _require_odirect
> diff --git a/tests/ext4/302 b/tests/ext4/302
> index d73cf9bf84da..87820184e30f 100755
> --- a/tests/ext4/302
> +++ b/tests/ext4/302
> @@ -16,7 +16,9 @@ fio_config=$tmp.fio
>  . ./common/filter
>  . ./common/defrag
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch
>  _require_defrag
>  _require_odirect
> diff --git a/tests/ext4/303 b/tests/ext4/303
> index d9be45674e40..2381f0477082 100755
> --- a/tests/ext4/303
> +++ b/tests/ext4/303
> @@ -16,7 +16,9 @@ fio_config=$tmp.fio
>  . ./common/filter
>  . ./common/defrag
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch
>  _require_defrag
>  _require_odirect
> diff --git a/tests/ext4/304 b/tests/ext4/304
> index 208b8a2ac119..53b522ee85bd 100755
> --- a/tests/ext4/304
> +++ b/tests/ext4/304
> @@ -17,7 +17,9 @@ fio_config=$tmp.fio
>  . ./common/filter
>  . ./common/defrag
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch
>  _require_defrag
>  _require_odirect
> diff --git a/tests/ext4/305 b/tests/ext4/305
> index acada44bc75a..35dae5571b55 100755
> --- a/tests/ext4/305
> +++ b/tests/ext4/305
> @@ -22,7 +22,8 @@ _cleanup()
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  
> diff --git a/tests/ext4/306 b/tests/ext4/306
> index b5147caf547e..b0e08f65ea24 100755
> --- a/tests/ext4/306
> +++ b/tests/ext4/306
> @@ -22,7 +22,8 @@ _cleanup()
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
>  
>  _require_scratch
>  _require_command "$RESIZE2FS_PROG" resize2fs
> diff --git a/tests/ext4/307 b/tests/ext4/307
> index 8361f04312b2..1f0e42ca2638 100755
> --- a/tests/ext4/307
> +++ b/tests/ext4/307
> @@ -34,7 +34,9 @@ _workout()
>  	run_check md5sum -c $out.md5sum
>  }
>  
> -_supported_fs ext4
> +_exclude_fs ext2
> +_exclude_fs ext3
> +
>  _require_scratch
>  _require_defrag
>  _require_xfs_io_command "falloc"
> diff --git a/tests/generic/187 b/tests/generic/187
> index 2a06aff35e58..536ce9fa9ab8 100755
> --- a/tests/generic/187
> +++ b/tests/generic/187
> @@ -28,10 +28,12 @@ _cleanup()
>  . ./common/filter
>  . ./common/reflink
>  
> +# btrfs can't fragment free space.
> +_exclude_fs btrfs
> +
> +# This test is unreliable on NFS, as it depends on the exported filesystem.
> +_exclude_fs nfs
>  
> -# btrfs can't fragment free space. This test is unreliable on NFS, as it
> -# depends on the exported filesystem.
> -_supported_fs ^btrfs ^nfs
>  _require_scratch_reflink
>  _require_cp_reflink
>  _require_xfs_io_command "falloc"
> diff --git a/tests/generic/294 b/tests/generic/294
> index 54b89a26294f..b07459116371 100755
> --- a/tests/generic/294
> +++ b/tests/generic/294
> @@ -16,7 +16,7 @@ _begin_fstest auto quick
>  
>  # NFS will optimize away the on-the-wire lookup before attempting to
>  # create a new file (since that means an extra round trip).
> -_supported_fs ^nfs
> +_exclude_fs nfs
>  
>  _require_scratch
>  _require_symlinks
> diff --git a/tests/generic/357 b/tests/generic/357
> index 8db31f8b0432..51c6d5efd2d7 100755
> --- a/tests/generic/357
> +++ b/tests/generic/357
> @@ -26,7 +26,7 @@ _cleanup()
>  
>  # For NFS, a reflink is just a CLONE operation, and after that
>  # point it's dealt with by the server.
> -_supported_fs ^nfs
> +_exclude_fs nfs
>  
>  _require_scratch_swapfile
>  _require_scratch_reflink
> diff --git a/tests/generic/362 b/tests/generic/362
> index 2396ec7d3a57..3a1993e81d4b 100755
> --- a/tests/generic/362
> +++ b/tests/generic/362
> @@ -11,7 +11,8 @@
>  _begin_fstest auto quick
>  
>  # NFS forbade open with O_APPEND|O_DIRECT
> -_supported_fs ^nfs
> +_exclude_fs nfs
> +
>  _require_test
>  _require_odirect
>  _require_test_program dio-append-buf-fault
> diff --git a/tests/generic/465 b/tests/generic/465
> index f8c4ea9671a2..5b49040e3ad0 100755
> --- a/tests/generic/465
> +++ b/tests/generic/465
> @@ -20,7 +20,7 @@ _cleanup()
>  # Import common functions.
>  . ./common/filter
>  
> -_supported_fs ^nfs
> +_exclude_fs nfs
>  
>  _require_aiodio aio-dio-append-write-read-race
>  _require_test_program "feature"
> diff --git a/tests/generic/500 b/tests/generic/500
> index ba6e902ec96b..c5492a09246c 100755
> --- a/tests/generic/500
> +++ b/tests/generic/500
> @@ -41,7 +41,7 @@ _require_dm_target thin-pool
>  # and since we've filled the thinp device it'll return EIO, which will make
>  # btrfs flip read only, making it fail this test when it just won't work right
>  # for us in the first place.
> -_supported_fs ^btrfs
> +_exclude_fs btrfs
>  
>  # Require underlying device support discard
>  _scratch_mkfs >>$seqres.full 2>&1
> diff --git a/tests/generic/631 b/tests/generic/631
> index 642d47863987..8e2cf9c63b77 100755
> --- a/tests/generic/631
> +++ b/tests/generic/631
> @@ -37,8 +37,10 @@ _cleanup()
>  
>  _require_scratch
>  _require_attrs trusted
> -_supported_fs ^overlay
> +
> +_exclude_fs overlay
>  _require_extra_fs overlay
> +
>  _fixed_by_kernel_commit 6da1b4b1ab36 \
>  	"xfs: fix an ABBA deadlock in xfs_rename"
>  
> diff --git a/tests/generic/679 b/tests/generic/679
> index 4c74101c5834..741ddf21502f 100755
> --- a/tests/generic/679
> +++ b/tests/generic/679
> @@ -23,7 +23,7 @@ _require_xfs_io_command "fiemap"
>  #
>  #   https://lore.kernel.org/linux-btrfs/20220315164011.GF8241@magnolia/
>  #
> -_supported_fs ^xfs
> +_exclude_fs xfs
>  
>  rm -f $seqres.full
>  
> diff --git a/tests/generic/699 b/tests/generic/699
> index 3079a861df74..620a40aa3921 100755
> --- a/tests/generic/699
> +++ b/tests/generic/699
> @@ -21,8 +21,9 @@ _cleanup()
>  	rm -r -f $tmp.*
>  }
>  
> -_supported_fs ^overlay
> +_exclude_fs overlay
>  _require_extra_fs overlay
> +
>  _require_scratch
>  _require_chown
>  _require_idmapped_mounts
> diff --git a/tests/generic/732 b/tests/generic/732
> index e907a009fe16..83caa0bc915c 100755
> --- a/tests/generic/732
> +++ b/tests/generic/732
> @@ -24,7 +24,9 @@ _cleanup()
>  # This case give a assumption that the same mount options for
>  # different mount point will share the same superblock, which won't
>  # sucess for the follow fs.
> -_supported_fs ^nfs ^overlay ^tmpfs
> +_exclude_fs nfs
> +_exclude_fs overlay
> +_exclude_fs tmpfs
>  
>  _require_test
>  _require_scratch
> diff --git a/tests/generic/740 b/tests/generic/740
> index 903e891db0fd..10817521cc93 100755
> --- a/tests/generic/740
> +++ b/tests/generic/740
> @@ -14,7 +14,12 @@ _begin_fstest mkfs auto quick
>  
>  # a bunch of file systems don't support foreign fs detection
>  # ext* do support it, but disable the feature when called non-interactively
> -_supported_fs ^ext2 ^ext3 ^ext4 ^jfs ^ocfs2 ^udf
> +_exclude_fs ext2
> +_exclude_fs ext3
> +_exclude_fs ext4
> +_exclude_fs jfs
> +_exclude_fs ocfs2
> +_exclude_fs udf
>  
>  _require_block_device "${SCRATCH_DEV}"
>  # not all the FS support zoned block device
> -- 
> 2.45.2
> 
> 


