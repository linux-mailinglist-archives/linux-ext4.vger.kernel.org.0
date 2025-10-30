Return-Path: <linux-ext4+bounces-11362-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A3AC1FD89
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 12:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 833CB4E5A72
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 11:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29573334C15;
	Thu, 30 Oct 2025 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPIvBRaM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3812F1FD2
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824109; cv=none; b=gp6w4485GSs0wRMTSDpD3zNLaya4yJJbvq9XCh7awoaU1NFT5SYiGl4W9clnnEl/Y2vJnCf4q/cfLiuIHZg95hBmCQFX7RwGphxXMoc/w1nzQpgxZs556F/a1zU0lzQPqlwb6U9cSeEMIScyMCTHd51Ar4ykPPTkKwFjKoHoKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824109; c=relaxed/simple;
	bh=KlaYOnB2zIrOGxYethYD5P8DhWL9RjFbSyuNDnc9yxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3vyNCzNjaptaxkvq9zJDAVMypHBrMfi7bBi2g2eMwRtYllbweN5SCSN22DwNiCBzQ/w//n3FykvwiuL8cB3C3sE4J0OMlR6rElgAvoUkBu9idQjjvcimNXzLc43SSm74HGX/BZJc8xifNeUlZFEQZref6rshLNRDhTwZR0sOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPIvBRaM; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c523864caso1922907a12.1
        for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761824105; x=1762428905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1jQRJbq3W7ySqtjHUuXZDxThzL24ICiKDNUdWjz+YrM=;
        b=RPIvBRaME0TzsEGkqGarsH6SLFhE3ns4F76uwbg3lAuRG6dx3c5uZX2lji/hMPa7Hj
         8wepcqZ9WTr1W0X8UBzDjBmDB2QG1v47Z6bL5LRN5q6Yq7BDjop1Rx3JjEAi64v8pO/y
         uTsJx0LmEhqegYzK2+8DBQCPEFrS/wm/JGMaBMqRX8he2ozic6Gwwxv1XZcO0meZpyxy
         hnyV3FNtxCRClKuyYIi7VgtSAvfLLQMkaJ2RjO7fJJRDKyNA0fgp+eR9iryw7KmnKfxK
         9w4jTG8zGKTxe7Rd6GOCl6W6JBFc4TqgMuN8c96EAF81UDcPHkF+IasPKAb31pg7f25Q
         4n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761824105; x=1762428905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jQRJbq3W7ySqtjHUuXZDxThzL24ICiKDNUdWjz+YrM=;
        b=pnUl8V7iFEnbXFF+6P/lETbc45utVSyZ9TOjayvtm1NYV3kfkEeXm2NidBUMog8qlL
         rU4w1q27N/xVmdmspBsLZcC8AVulR4a13JTMUGxyAdkt6H9tsecsp6tRvezUfRyNikU2
         GyCj2R6kCjulYL9mOl/oTlH8JrF4j8Qe4IGZcd1kUB2QUcLfXKp0ztQsdkliGOQOgwiv
         OeBGxr295Ukn1f+1lJrOWi8JAY/8dqWAQqbrRBF7nbdTl6TAeonafqaToNjWniXkETOq
         wbgs+/UAE4xwZFuLQXdkO1GQOi/olQ70PEYZUGe8p0qQLwAXrl3Yt+3CNckrRnR/XT5r
         6fbw==
X-Forwarded-Encrypted: i=1; AJvYcCWAzsr4RFfMffMy8jHLZKclbOjqmXp/RPm/zxbV/ILt1nIrHnCV+YkZn21QRC2Nwt7s173VyEzAdYMa@vger.kernel.org
X-Gm-Message-State: AOJu0YxxMpSWBn2juoOycmcW9EOSUYYmQiShtQp3rI+5p4P54duIURgL
	NI9yHuF0UmEhQ6lqujUeEONA9JhSCEQ66IDDjSfVftygfSEiPoMcMmsd/FAASimbRaw=
X-Gm-Gg: ASbGncuwELnQ6zJsXdHtnzjpPENQY11BoGEwalDJhLrxT5sD3fQlnd0wieDgSYG4yhk
	moArUQ9JjbBr91iD8ChwtVcQxj+IA9otngsbQWcTNJQ8EuzflTr2ckxH2BgGOEo/KqgXAcyl4Qo
	5UNkzJjwTnOzgb8jXTSePqtL298DTtdh7cDOrgKJmtolh7wB+pV3IR2XS7E2XtOURyJO+bHx5we
	N5oieAqqTmdhA6kUplcry/w3XtRe5lpKcu6+2n453375YTI91frZ6dIqJRr3AzeVT8l84OFe2Ql
	X13IMCfm2mjjPL/Ahw5tsEM95xP35+IMyBumO8KckI7z4x5RJvQ2Ienq/9oHLe8CL3EgURE3AVz
	xKq9ZpjZpxJgyk42TeD9a4Xi4AT0gPwbp3m/Jl4PpzfLBMcHjAvOq+ZO4SfqIQc+6SA4Nah94ZB
	mfMwz6ok8HIJE5ErgfEM+N8TivG8xNmb2NBg/OXDIEyQvpS+ZtmUz3gygtxmo5Tj5/zSyIFaVIp
	x9yog==
X-Google-Smtp-Source: AGHT+IHwPDKpUkOtm37RUMhU0moYLn2XhmQqKXqCiHnNlwZMBqWVtEYi/CrdV0k+N7ak8l8WbmVrkA==
X-Received: by 2002:a05:6402:1ecd:b0:63e:19ec:c8e4 with SMTP id 4fb4d7f45d1cf-64044375786mr5486197a12.28.1761824104954;
        Thu, 30 Oct 2025 04:35:04 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-c54a-34bd-5130-fdd5.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:c54a:34bd:5130:fdd5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef95e8dsm14189735a12.20.2025.10.30.04.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:35:03 -0700 (PDT)
Date: Thu, 30 Oct 2025 12:35:03 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joannelkoong@gmail.com, bernd@bsbernd.com
Subject: Re: [PATCH 22/33] generic/631: don't run test if we can't mount
 overlayfs
Message-ID: <aQNNZ6lxeMntTifa@amir-ThinkPad-T480>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169820388.1433624.12333256574549591904.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZpygF3SuZCs2oZOn"
Content-Disposition: inline
In-Reply-To: <176169820388.1433624.12333256574549591904.stgit@frogsfrogsfrogs>


--ZpygF3SuZCs2oZOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2025 at 06:26:09PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This test fails on fuse2fs with the following:
> 
> +mount: /opt/merged0: wrong fs type, bad option, bad superblock on overlay, missing codepage or helper program, or other error.
> +       dmesg(1) may have more information after failed mount system call.
> 
> dmesg logs the following:
> 
> [  764.775172] overlayfs: upper fs does not support tmpfile.
> [  764.777707] overlayfs: upper fs does not support RENAME_WHITEOUT.
> 
> From this, it's pretty clear why the test fails -- overlayfs checks that
> the upper filesystem (fuse2fs) supports RENAME_WHITEOUT and O_TMPFILE.
> fuse2fs doesn't support either of these, so the mount fails and then the
> test goes wild.
> 
> Instead of doing that, let's do an initial test mount with the same
> options as the workers, and _notrun if that first mount doesn't succeed.
> 
> Fixes: 210089cfa00315 ("generic: test a deadlock in xfs_rename when whiteing out files")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/631 |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> 
> diff --git a/tests/generic/631 b/tests/generic/631
> index 72bf85e30bdd4b..64e2f911fdd10e 100755
> --- a/tests/generic/631
> +++ b/tests/generic/631
> @@ -64,6 +64,26 @@ stop_workers() {
>  	done
>  }
>  
> +require_overlayfs() {
> +	local tag="check"
> +	local mergedir="$SCRATCH_MNT/merged$tag"
> +	local l="lowerdir=$SCRATCH_MNT/lowerdir:$SCRATCH_MNT/lowerdir1"
> +	local u="upperdir=$SCRATCH_MNT/upperdir$tag"
> +	local w="workdir=$SCRATCH_MNT/workdir$tag"
> +	local i="index=off"
> +
> +	rm -rf $SCRATCH_MNT/merged$tag
> +	rm -rf $SCRATCH_MNT/upperdir$tag
> +	rm -rf $SCRATCH_MNT/workdir$tag
> +	mkdir $SCRATCH_MNT/merged$tag
> +	mkdir $SCRATCH_MNT/workdir$tag
> +	mkdir $SCRATCH_MNT/upperdir$tag
> +
> +	_mount -t overlay overlay -o "$l,$u,$w,$i" $mergedir || \
> +		_notrun "cannot mount overlayfs"
> +	umount $mergedir
> +}
> +
>  worker() {
>  	local tag="$1"
>  	local mergedir="$SCRATCH_MNT/merged$tag"
> @@ -91,6 +111,8 @@ worker() {
>  	rm -f $SCRATCH_MNT/workers/$tag
>  }
>  
> +require_overlayfs
> +
>  for i in $(seq 0 $((4 + LOAD_FACTOR)) ); do
>  	worker $i &
>  done
> 

I agree in general, but please consider this (untested) cleaner patch

Thanks,
Amir.


--ZpygF3SuZCs2oZOn
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-generic-631-don-t-run-test-if-we-can-t-mount-overlay.patch"

From 470e7e26dc962b58ee1aabd578e63fe7a0df8cdd Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Oct 2025 12:24:21 +0100
Subject: [PATCH] generic/631: don't run test if we can't mount overlayfs

---
 tests/generic/631 | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/tests/generic/631 b/tests/generic/631
index c38ab771..7dc335aa 100755
--- a/tests/generic/631
+++ b/tests/generic/631
@@ -46,7 +46,6 @@ _require_extra_fs overlay
 
 _scratch_mkfs >> $seqres.full
 _scratch_mount
-_supports_filetype $SCRATCH_MNT || _notrun "overlayfs test requires d_type"
 
 mkdir $SCRATCH_MNT/lowerdir
 mkdir $SCRATCH_MNT/lowerdir1
@@ -64,7 +63,7 @@ stop_workers() {
 	done
 }
 
-worker() {
+mount_overlay() {
 	local tag="$1"
 	local mergedir="$SCRATCH_MNT/merged$tag"
 	local l="lowerdir=$SCRATCH_MNT/lowerdir:$SCRATCH_MNT/lowerdir1"
@@ -72,25 +71,43 @@ worker() {
 	local w="workdir=$SCRATCH_MNT/workdir$tag"
 	local i="index=off"
 
+	rm -rf $SCRATCH_MNT/merged$tag
+	rm -rf $SCRATCH_MNT/upperdir$tag
+	rm -rf $SCRATCH_MNT/workdir$tag
+	mkdir $SCRATCH_MNT/merged$tag
+	mkdir $SCRATCH_MNT/workdir$tag
+	mkdir $SCRATCH_MNT/upperdir$tag
+
+	mount -t overlay overlay -o "$l,$u,$w,$i" "$mergedir"
+}
+
+unmount_overlay() {
+	local tag="$1"
+	local mergedir="$SCRATCH_MNT/merged$tag"
+
+	_unmount $mergedir
+}
+
+worker() {
+	local tag="$1"
+	local mergedir="$SCRATCH_MNT/merged$tag"
+
 	touch $SCRATCH_MNT/workers/$tag
 	while test -e $SCRATCH_MNT/running; do
-		rm -rf $SCRATCH_MNT/merged$tag
-		rm -rf $SCRATCH_MNT/upperdir$tag
-		rm -rf $SCRATCH_MNT/workdir$tag
-		mkdir $SCRATCH_MNT/merged$tag
-		mkdir $SCRATCH_MNT/workdir$tag
-		mkdir $SCRATCH_MNT/upperdir$tag
-
-		mount -t overlay overlay -o "$l,$u,$w,$i" $mergedir
+		mount_overlay $tag
 		mv $mergedir/etc/access.conf $mergedir/etc/access.conf.bak
 		touch $mergedir/etc/access.conf
 		mv $mergedir/etc/access.conf $mergedir/etc/access.conf.bak
 		touch $mergedir/etc/access.conf
-		_unmount $mergedir
+		unmount_overlay $tag
 	done
 	rm -f $SCRATCH_MNT/workers/$tag
 }
 
+mount_overlay check || \
+	_notrun "cannot mount overlayfs with underlying filesystem $FSTYP"
+unmount_overlay check
+
 for i in $(seq 0 $((4 + LOAD_FACTOR)) ); do
 	worker $i &
 done
-- 
2.51.1


--ZpygF3SuZCs2oZOn--

