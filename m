Return-Path: <linux-ext4+bounces-14290-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJUjJRw8pGlnawUAu9opvQ
	(envelope-from <linux-ext4+bounces-14290-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 14:16:12 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9CD1CFD97
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 14:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F272300F5DD
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2026 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6F41EA7CE;
	Sun,  1 Mar 2026 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Imd7PUpA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A603B1BD
	for <linux-ext4@vger.kernel.org>; Sun,  1 Mar 2026 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772370957; cv=none; b=tckK6th9aloafUJGeF/N0x1KTm5u6koWYx5ABKzXkJ7028FY/uEKkVn523GfJZcmoLTFyow/9XRhPn9Djsqm1a9gvFuabM/M1CuYOACA2qc9w5dYBx531FoPWL49xIzYLd1guhcAHZFymJFkZao4HeN3TrLTeV0lRtTdfwv+cUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772370957; c=relaxed/simple;
	bh=ZLZQE0GXeHZvnuR3V3ClHur20ND39tVVF7L8YuUrOM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa6CUeBmzo+X57cSrubM5Gt2d0ZGfMIEZFc+C51XUeMCNrozRYB6SJJ84lVfQJIkimyQ9edbE8yEYbd82GwYyPw5gz2LBIcGncPjZac3E+9Nj8ni1SwO/i086WJ0gd0QicWOsLWkXhYUOT9kbfh0oNJH9S3wOkf/6EAbe8v7Te8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Imd7PUpA; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b936331787bso559317966b.3
        for <linux-ext4@vger.kernel.org>; Sun, 01 Mar 2026 05:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772370954; x=1772975754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZuHbNxrjmmINf1/XZXGIBer5llHrVS+trrV0cr48Gc=;
        b=Imd7PUpAx5LizhFfyaFyReG0dwWtsm2/CbGzRc88/Mwjsd6QRJnR9b8RhV4Pu84VJI
         suv3MAJFGAlRbqgASpEP+PQnTWd14JM811thsOr7ZRSpFIYn+YwXsWiHKOQzdn95nYcZ
         FgcZxfTxAgv0bQhpRrUT6TGfIYP6cn2Vghr9MX6A76sMcFsKxQlQ39afmurWDp32jr1v
         TyRNr5U7UsTWoh4O4Ioc2+HV4D91aptkTUcKDYJdKHUFrPY52QxWKFxb9cK/fNmgieku
         8PwgXVkh+Ce4o1BlFv6Et1tDt5PAzE5e89anQ83fZCxpnTqD5HH8riYqo2GxpbDBXH9K
         IXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772370954; x=1772975754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZuHbNxrjmmINf1/XZXGIBer5llHrVS+trrV0cr48Gc=;
        b=HsnGZkj6l9GQS1s1LkywCJm0wjlMLZ5wXxtc8l/JsVaYO9IfbkOJfNw4bsRc3eZWqz
         kG5g3sZfVVnUO4sAVn2ZxQKe1LoTOstbXUgDX3fHh8EwMmpCQ3qPIsbn/p1imYtzFqJ2
         WMlLUbuhIBIw1kM416F6s+0XFO0yxeEWGm2xVS6rb6k4ulpkxsygP5AoCjkgh1sYBLaE
         1LpSeHc7bji3iB7gLD+tDydE4X2D3o+/cOhPLplRvjuWGWkohqTCHGJ58SlR7fGWe8DL
         MQ9Hi8bUiV2oBqmnVTySok9XiVcraEvTDCOTv8RFcF1+fFTcNCLB04SFuKnKOcY2dkwp
         k0tA==
X-Forwarded-Encrypted: i=1; AJvYcCVZJbw03PI60wsQ2Um4oZJhFSZ2NdHalZIZXN1RqedWoqg6evxT4hkR1dUycyq1GjEQiSZ3C3neIIgB@vger.kernel.org
X-Gm-Message-State: AOJu0YyC78EkZVcTVKzBdOGoUsgkn96oiKsmofSHXTwHE99lHm2H17+q
	mt5STQHmHozeTXR0Vr19dpw004snOz1hUdoerTzKtDTD31FvE8yZHTRu
X-Gm-Gg: ATEYQzyjZg6Cvh4R7QGCD3y0vrJNUn9jNAzS1DBH5Vq+S02vuO3UcQR+uXpS3m1+6xs
	wC1ntK+XOa4QYX+VhF5wihAXrRMTVvVnpYnQu1ehFkohwpxUewluVR8/JsUvBOrgRVzKxkv8TmD
	tLygSUfQ+YB0vUkYWINKB2JetOGVJImYG1/wczjTOCZD8u92u1gze5YOBZp9TB2r8QLw4E3DXYx
	mjG7VPWoSq1H/58Do0Okkg3VcQtJ0Vi1EOIxUErhkle4FdeDmp/66SS5zkTJ6gj4QdQ9TFK8vm2
	o43NM8Iip2273FwzB/n8Nh0b+kdXCdolEsDY9807b63AAONCAtN9uJwjI0QxCHzMdBQscDpX5K5
	k10PVdweexyrpl3kjI107L5OHFuLVIHUr5jFYZXcT8wB2hEVRF/wzP//4upyfvd65GnNyUUsOKx
	82IcRAl8skWzzW4oZNq4mPy/dXHgA/+p5sGlAlJdt5Ja3yt6gHLG0mvTsA9vjuTTLiYciMnSya5
	uNSWq8tloh8vj1zAvo6pEpXuQd3
X-Received: by 2002:a17:906:ad7:b0:b88:775c:bd6b with SMTP id a640c23a62f3a-b9376553e7amr432998666b.46.1772370953329;
        Sun, 01 Mar 2026 05:15:53 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-d118-5ff5-6236-8e43.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:d118:5ff5:6236:8e43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac51431sm360050666b.17.2026.03.01.05.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 05:15:52 -0800 (PST)
Date: Sun, 1 Mar 2026 14:15:52 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Anand Jain <asj@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 5/9] fstests: verify fanotify isolation on cloned
 filesystems
Message-ID: <aaQ8CB7C4FjDuedR@amir-ThinkPad-T480>
References: <cover.1772095513.git.asj@kernel.org>
 <b54dea5e72585db5f5c3d74ce399f9d839965821.1772095513.git.asj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b54dea5e72585db5f5c3d74ce399f9d839965821.1772095513.git.asj@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14290-lists,linux-ext4=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[popdir.pl:url,popattr.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,btrfs_crc32c_forged_name.py:url,scaleread.sh:url]
X-Rspamd-Queue-Id: EE9CD1CFD97
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:41:46PM +0800, Anand Jain wrote:
> Verify that fanotify events are correctly routed to the appropriate
> watcher when cloned filesystems are mounted.
> Helps verify kernel's event notification distinguishes between devices
> sharing the same FSID/UUID.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  .gitignore            |  1 +
>  src/Makefile          |  2 +-
>  src/fanotify.c        | 66 +++++++++++++++++++++++++++++++++
>  tests/generic/791     | 86 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/791.out |  7 ++++
>  5 files changed, 161 insertions(+), 1 deletion(-)
>  create mode 100644 src/fanotify.c
>  create mode 100644 tests/generic/791
>  create mode 100644 tests/generic/791.out
> 
> diff --git a/.gitignore b/.gitignore
> index 82c57f415301..7f91310ce58b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -212,6 +212,7 @@ tags
>  /src/dio-writeback-race
>  /src/unlink-fsync
>  /src/file_attr
> +/src/fanotify
>  
>  # Symlinked files
>  /tests/generic/035.out
> diff --git a/src/Makefile b/src/Makefile
> index d0a4106e6be8..ff71cde936a7 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -36,7 +36,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
>  	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
> -	rw_hint
> +	rw_hint fanotify

Check if you already have fsnotifywait installed on your system
most likely you do. It was added to inotify-tools quite some time ago.
Could save you from adding a custom prog.
Not 100% sure about fsnotifywait, but quite sure that
fsnotifywatch --verbose prints the FSID of events.

Thanks,
Amir.

>  
>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> diff --git a/src/fanotify.c b/src/fanotify.c
> new file mode 100644
> index 000000000000..e30c48dc0e52
> --- /dev/null
> +++ b/src/fanotify.c
> @@ -0,0 +1,66 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0
> + * Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
> + *
> + * Simple fanotify monitor to verify mount-point event isolation.
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <stdint.h>
> +#include <sys/fanotify.h>
> +
> +int main(int argc, char *argv[])
> +{
> +	int fd;
> +	char buf[4096] __attribute__((aligned(8)));
> +	setlinebuf(stdout);
> +
> +	if (argc < 2) {
> +		fprintf(stderr, "Usage: %s <path>\n", argv[0]);
> +		return 1;
> +	}
> +
> +	// Initialize with FID reporting
> +	fd = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
> +	if (fd < 0) {
> +		perror("fanotify_init");
> +		return 1;
> +	}
> +
> +	if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
> +			  FAN_CREATE, AT_FDCWD, argv[1]) < 0) {
> +		perror("fanotify_mark");
> +		return 1;
> +	}
> +
> +	printf("Listening for events on %s...\n", argv[1]);
> +	while (1) {
> +		struct fanotify_event_metadata *metadata = (struct fanotify_event_metadata *)buf;
> +		ssize_t len = read(fd, buf, sizeof(buf));
> +
> +		if (len <= 0) break;
> +
> +		while (FAN_EVENT_OK(metadata, len)) {
> +			// metadata_len is the offset to the first info record
> +			if (metadata->event_len > metadata->metadata_len) {
> +				struct fanotify_event_info_header *hdr =
> +(struct fanotify_event_info_header *)((char *)metadata + metadata->metadata_len);
> +
> +				if (hdr->info_type == FAN_EVENT_INFO_TYPE_FID) {
> +					struct fanotify_event_info_fid *fid = (struct fanotify_event_info_fid *)hdr;
> +					printf("FSID: %08x%08x\n",
> +						fid->fsid.val[0], fid->fsid.val[1]);
> +				}
> +			}
> +			metadata = FAN_EVENT_NEXT(metadata, len);
> +		}
> +	}
> +
> +	fflush(stdout);
> +	close(fd);
> +	return 0;
> +}
> diff --git a/tests/generic/791 b/tests/generic/791
> new file mode 100644
> index 000000000000..fe8109083732
> --- /dev/null
> +++ b/tests/generic/791
> @@ -0,0 +1,86 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
> +#
> +# FS QA Test 791
> +# Verify fanotify FID functionality on cloned filesystems by setting up
> +# watchers and making sure notifications are in the correct logs files.
> +
> +. ./common/preamble
> +
> +_begin_fstest auto quick mount clone
> +
> +_require_test
> +_require_scratch_dev_pool 2
> +
> +[ "$FSTYP" = "ext4" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"ext4: derive f_fsid from block device to avoid collisions"
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +	umount $mnt1 $mnt2 2>/dev/null
> +	_scratch_dev_pool_put
> +}
> +
> +_scratch_dev_pool_get 2
> +_scratch_mkfs_sized_clone >$seqres.full 2>&1
> +devs=($SCRATCH_DEV_POOL)
> +mnt2=$TEST_DIR/mnt2
> +mkdir -p $mnt2
> +
> +_scratch_mount $(_clone_mount_option)
> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
> +						_fail "Failed to mount dev2"
> +
> +fsid1=$(stat -f -c "%i" $SCRATCH_MNT)
> +fsid2=$(stat -f -c "%i" $mnt2)
> +
> +[[ "$fsid1" == "$fsid2" ]] && \
> +	_notrun "Require clone filesystem with unique f_fsid"
> +
> +log1=$tmp.fanotify1
> +log2=$tmp.fanotify2
> +
> +echo "Setup FID fanotify watchers on both SCRATCH_MNT and mnt2"
> +$here/src/fanotify $SCRATCH_MNT > $log1 2>&1 &
> +pid1=$!
> +$here/src/fanotify $mnt2 > $log2 2>&1 &
> +pid2=$!
> +sleep 2
> +
> +echo "Trigger file creation on SCRATCH_MNT"
> +touch $SCRATCH_MNT/file_on_scratch_mnt
> +sync
> +sleep 1
> +
> +echo "Trigger file creation on mnt2"
> +touch $mnt2/file_on_mnt2
> +sync
> +sleep 1
> +
> +echo "Verify fsid in the fanotify"
> +kill $pid1 $pid2
> +wait $pid1 $pid2 2>/dev/null
> +
> +echo fsid1=$fsid1 fsid2=$fsid2 >> $seqres.full
> +cat $log1 >> $seqres.full
> +cat $log2 >> $seqres.full
> +
> +if grep -q "${fsid1}" $log1 && ! grep -q "${fsid2}" $log1; then
> +	echo "SUCCESS: SCRATCH_MNT events found"
> +else
> +	[ ! -s $log1 ] && echo "  - SCRATCH_MNT received no events."
> +	grep -q "${fsid2}" $log1 && echo "  - SCRATCH_MNT received event from mnt2."
> +fi
> +
> +if grep -q "${fsid2}" $log2 && ! grep -q "${fsid1}" $log2; then
> +	echo "SUCCESS: mnt2 events found"
> +else
> +	[ ! -s $log2 ] && echo "  - mnt2 received no events."
> +	grep -q "${fsid1}" $log2 && echo "  - mnt2 received event from SCRATCH_MNT."
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/generic/791.out b/tests/generic/791.out
> new file mode 100644
> index 000000000000..9725c99bcb4b
> --- /dev/null
> +++ b/tests/generic/791.out
> @@ -0,0 +1,7 @@
> +QA output created by 791
> +Setup FID fanotify watchers on both SCRATCH_MNT and mnt2
> +Trigger file creation on SCRATCH_MNT
> +Trigger file creation on mnt2
> +Verify fsid in the fanotify
> +SUCCESS: SCRATCH_MNT events found
> +SUCCESS: mnt2 events found
> -- 
> 2.43.0
> 

