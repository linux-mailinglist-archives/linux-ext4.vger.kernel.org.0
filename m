Return-Path: <linux-ext4+bounces-12389-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BAFCC8FD0
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 18:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80D6531659DD
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF63338927;
	Wed, 17 Dec 2025 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT1hgaD+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6781D33890D
	for <linux-ext4@vger.kernel.org>; Wed, 17 Dec 2025 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990925; cv=none; b=TdGRlJBFOLKRANK4cNh83aMU1XZ76kamC22Z2rslanfubOs5WEcVSru2Izy+pwzAZMFzTROuicZ7tUZMNCImdLm2wsFFLuLpxsy9J7mB541eAhHjQFM8SrnOqh8JG8Tb3RvLJH+ybTjWO4i5tjdXsMUFvoiVZcZ5rJGkW8T9Jh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990925; c=relaxed/simple;
	bh=rgDhIZfdsOfkurhbewxOfigJvc2eSqaTwXIruE5NLKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azsw0/79nqfaH7sYIRFKIfi+KsYroYB2nKvxjOclsIdXQmHFmeFLsdtT9mtuKgbRkpJREu6cKdKwjj0uQDKyoyzFFZVVJEElrnIRvw5B4Kuq7oPDbXKRwmAwpOVKHwI72r0VSHW1gdG+omdjyqeFWeUacIE03XHaTNzkJNcNIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nT1hgaD+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a12ebe4b74so34839715ad.0
        for <linux-ext4@vger.kernel.org>; Wed, 17 Dec 2025 09:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765990922; x=1766595722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GKCp6fL8IQ3vq9/UmgCTuTo5F9F6pquy8iJD7G2eufg=;
        b=nT1hgaD+SLPaL5AQW+dfq/Kod92fzOz936c5FLNfJvk8dvcxyGZoNrr+b7JP0Xo6CV
         bBbjkxkySSzlrP/hkKIfXn+EAPRj9bMBoAanGSbR5mMVw2YmHBBCvetIDUN/jdrYwNgW
         Enr92k7IlzTtAknmYGb0rCU3cvUYDQIFv3esxr7GuOsH2SxmmE4iUOphjRjjxC2RYgYs
         GXy/20C+/OlndCRhwE+E6C+ohU9rss1LuYNgIHtFTQGtO/7+tMQZp2o+Z3kIYjVJeTbm
         xmcWKr7NQiJVkP8HAKVR/3qzQhFOLSAp+WJblmccSiahqTxl7QlDdjao44qf9m4I2vOu
         4kNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765990923; x=1766595723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKCp6fL8IQ3vq9/UmgCTuTo5F9F6pquy8iJD7G2eufg=;
        b=dRBD7v7jyxsHtMEtrI9LOxoCAEZNiqry/YEDHLyDm5Dmzj5Vv7c5jqkTJXcFYpi0Ic
         CyDyqrMFTnMSqHRb9t+TNokaTzlu0ibtRJh/5FCOT1iP85OPgj8FzCRobmuVhpRNdasL
         aN6eJQrk9AKSmL+4fXVsRJB6FQ+2qIuHvzBn4/sPZQDbQVHFppeURqGoI4P3jyD189sk
         YNeHRSkH+P8ee9QwWujl95hDLpdrdlnsalCO4V9OHXujbTmnBwHZWqQgVj9glUXs6qnD
         MOUyA2y9McugK6ulJ4kAlYnFQqEjdAzb9MGXWkzu2YLD5B1DqOEyEguUz+tHz0pHzIkb
         rhMA==
X-Forwarded-Encrypted: i=1; AJvYcCWXT7FquuaZjj1tNp3zD53IgYtp0jMPn5z4ekpXnO9VXSG10XecJfsox981qjBfiq13oHM6BOeY1OKP@vger.kernel.org
X-Gm-Message-State: AOJu0YwXAAW2zIfJtbGx/6SQEGOZveLs44OoT5ZRgGJozQqYXz3LY0Bh
	7qSEw5A3yzZEWAkcZEFy+qEJSphS20fTk4MIDHMEKu69pIaGx+oZthin
X-Gm-Gg: AY/fxX7x9i51YiHGzWNDMNJJlQQ/lzKPCR8GwpWXO5yCOjR79H56BPNU4XCJwDGLBBv
	F1Z6t9XkBRtrJmJwgp080KgJ6eoY1kBE41WdPXGVbzoQC//ecb4W8zkqgKUlC8QRoPQwuJRzS7R
	CZ0yXGTHN4hFiBk7j3vDSgURg75dn6K06Pxz4iNIXqiX+H3iFC3L1BixsSZ49uEb89wFqIrKXGM
	x45jwpt+ZFoYnd8CeBYJkRa3vf0boinUENtrZ3NFIEBCs0xERjCLDwIKhZD3rSYaPFhWFS10/m9
	nWbjpM8aevjrUNbpAyZUhU3Efxk7yCF2FHsjkthRVaFWVca5y0fUNiEhS+AnGAI6C52/567Y1yi
	1TdLGqNFLp75GeLR9UnWP2aS/QCtFZNKGgZd615s4EhZcNsvdmuRmbPzwRomCiZZ07RAJkqJCkS
	+2l6jkOspEU9JH9FM=
X-Google-Smtp-Source: AGHT+IHQU6VgGvHLOaZBxPkML0Q3IsVDTQ69nAbkvfgwbuU/wkhHQjsH+QVx4aUpRGynw0ZJLPOnfQ==
X-Received: by 2002:a17:903:1b47:b0:295:3d5d:fe37 with SMTP id d9443c01a7336-29f23ca6bb5mr228820485ad.41.1765990922266;
        Wed, 17 Dec 2025 09:02:02 -0800 (PST)
Received: from [192.168.50.70] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2ccebafa0sm153975ad.25.2025.12.17.09.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 09:02:01 -0800 (PST)
Message-ID: <52111335-ca0e-4ede-a7b6-668ce2c81325@gmail.com>
Date: Thu, 18 Dec 2025 01:01:59 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] common: add a _check_dev_fs helper
To: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>, Filipe Manana <fdmanana@suse.com>,
 "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20251212082210.23401-1-hch@lst.de>
 <20251212082210.23401-4-hch@lst.de>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251212082210.23401-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

looks good

Reviewed-by: Anand Jain <asj@kernel.org>


Thanks


On 12/12/25 16:21, Christoph Hellwig wrote:
> Add a helper to run the file system checker for a given device, and stop
> overloading _check_scratch_fs with the optional device argument that
> creates complication around scratch RT and log devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>   common/dmthin     |  6 +++++-
>   common/rc         | 21 +++++++++++++++++----
>   tests/btrfs/176   |  4 ++--
>   tests/generic/648 |  2 +-
>   tests/xfs/601     |  2 +-
>   5 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/common/dmthin b/common/dmthin
> index a1e1fb8763c0..3bea828d0375 100644
> --- a/common/dmthin
> +++ b/common/dmthin
> @@ -33,7 +33,11 @@ _dmthin_cleanup()
>   _dmthin_check_fs()
>   {
>   	_unmount $SCRATCH_MNT > /dev/null 2>&1
> -	_check_scratch_fs $DMTHIN_VOL_DEV
> +	OLD_SCRATCH_DEV=$SCRATCH_DEV
> +	SCRATCH_DEV=$DMTHIN_VOL_DEV
> +	_check_scratch_fs
> +	SCRATCH_DEV=$OLD_SCRATCH_DEV
> +	unset OLD_SCRATCH_DEV
>   }
>   
>   # Set up a dm-thin device on $SCRATCH_DEV
> diff --git a/common/rc b/common/rc
> index c3cdc220a29b..8618f77a00b5 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3692,14 +3692,14 @@ _check_test_fs()
>       esac
>   }
>   
> -_check_scratch_fs()
> +# check the file system passed in as $1
> +_check_dev_fs()
>   {
> -    local device=$SCRATCH_DEV
> -    [ $# -eq 1 ] && device=$1
> +    local device=$1
>   
>       case $FSTYP in
>       xfs)
> -	_check_xfs_scratch_fs $device
> +	_check_xfs_filesystem $device "none" "none"
>   	;;
>       udf)
>   	_check_udf_filesystem $device $udf_fsize
> @@ -3751,6 +3751,19 @@ _check_scratch_fs()
>       esac
>   }
>   
> +# check the scratch file system
> +_check_scratch_fs()
> +{
> +	case $FSTYP in
> +	xfs)
> +		_check_xfs_scratch_fs $SCRATCH_DEV
> +		;;
> +	*)
> +		_check_dev_fs $SCRATCH_DEV
> +		;;
> +	esac
> +}
> +
>   _full_fstyp_details()
>   {
>        [ -z "$FSTYP" ] && FSTYP=xfs
> diff --git a/tests/btrfs/176 b/tests/btrfs/176
> index 86796c8814a0..f2619bdd8e44 100755
> --- a/tests/btrfs/176
> +++ b/tests/btrfs/176
> @@ -37,7 +37,7 @@ swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
>   # Deleting device 1 should work again after swapoff.
>   $BTRFS_UTIL_PROG device delete "$scratch_dev1" "$SCRATCH_MNT"
>   _scratch_unmount
> -_check_scratch_fs "$scratch_dev2"
> +_check_dev_fs "$scratch_dev2"
>   
>   echo "Replace device"
>   _scratch_mkfs >> $seqres.full 2>&1
> @@ -55,7 +55,7 @@ swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
>   $BTRFS_UTIL_PROG replace start -fB "$scratch_dev1" "$scratch_dev2" "$SCRATCH_MNT" \
>   	>> $seqres.full
>   _scratch_unmount
> -_check_scratch_fs "$scratch_dev2"
> +_check_dev_fs "$scratch_dev2"
>   
>   # success, all done
>   status=0
> diff --git a/tests/generic/648 b/tests/generic/648
> index 7473c9d33746..1bba78f062cf 100755
> --- a/tests/generic/648
> +++ b/tests/generic/648
> @@ -133,7 +133,7 @@ if [ -f "$loopimg" ]; then
>   		_metadump_dev $DMERROR_DEV $seqres.scratch.final.md
>   		echo "final scratch mount failed"
>   	fi
> -	SCRATCH_RTDEV= SCRATCH_LOGDEV= _check_scratch_fs $loopimg
> +	_check_dev_fs $loopimg
>   fi
>   
>   # success, all done; let the test harness check the scratch fs
> diff --git a/tests/xfs/601 b/tests/xfs/601
> index df382402b958..44911ea389a7 100755
> --- a/tests/xfs/601
> +++ b/tests/xfs/601
> @@ -39,7 +39,7 @@ copy_file=$testdir/copy.img
>   
>   echo copy
>   $XFS_COPY_PROG $SCRATCH_DEV $copy_file >> $seqres.full
> -_check_scratch_fs $copy_file
> +_check_dev_fs $copy_file
>   
>   echo recopy
>   $XFS_COPY_PROG $copy_file $SCRATCH_DEV >> $seqres.full


