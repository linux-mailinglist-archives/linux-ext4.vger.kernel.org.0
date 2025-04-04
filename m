Return-Path: <linux-ext4+bounces-7072-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A8FA7B6B4
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 05:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81536175B7B
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 03:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC80B14A0A8;
	Fri,  4 Apr 2025 03:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CA0Wc7y1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D7B2E62D1;
	Fri,  4 Apr 2025 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743738922; cv=none; b=e3Eg8R8FWRkMUEJF3+QkJefMEhJq21XjlyuMGGKRWinPp4y0Yq4+QoCStKTMlaNYekJvWfGgsTwOS8N8LyP2gO6o45LXz/QYAuhID3STj6k8rkO0UpLUDH5LKwW0tGLrZ8sdjTqhMjhuyzNG9b3qrVHBpxXhToqA/XjKs/OTrDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743738922; c=relaxed/simple;
	bh=5whN2m5UVTXxBC3+0XYMT0wWajMA82fX5udBfje9Jsc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=khpwysGN1PQqmjF/+/lhfjIYIwBJxPA++3AareULFdXX4weQwKkqK3jGK9MVXasd1OqZ1BoIWt+J7ERraPSFkjZ+gzA4FFdKEULAIsm2CbPx/IF8BfzWfwZkXAvImp4RfmPwyTXPkPgjeZcZ70EpQ4JRP50cPT4z5mxjCOk9EFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CA0Wc7y1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7399838db7fso1505443b3a.0;
        Thu, 03 Apr 2025 20:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743738918; x=1744343718; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LBEuQIQWNKUaU8kPbuT6eGC7RlkhcQj1DVO3JXMN2Xg=;
        b=CA0Wc7y1LJ9bSr9t5hLjrZF3s1Uzn6yxmG8j6Nnb9X++SAVopiu1+oM0EnCFOvW429
         FOSFc1sQ5JDerbY9thxfzm/rzEXyW0n9cpetktbDpjsMcNOQ9mKwDsYsvjVrp9u1G1IZ
         7hUs1U24ALW+/t/1jzJG1f88W8d1gcqJX3jd/MDssKayQqO0pfjq9tjKvX71MkPuYoWq
         dwpPMti6JutxFrVQHrRldUwRqZc9nvM/g/5Opp0YNF0EAIuO2hySFSYH1OPgeeDj3KlE
         jGb1MEbWvVhB/9SfIx8QJt1LiOlIEikAiwkgH9DITfOhQT2w+tiOmoVWO3OPixwnXC+P
         f+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743738918; x=1744343718;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBEuQIQWNKUaU8kPbuT6eGC7RlkhcQj1DVO3JXMN2Xg=;
        b=N+X9PB+1oC0Lt4C5KXFu6qWVJnCZkNodSq8TrE7uMcP/Y2HvREI/fZzjV6+5h/nF+6
         mGqWdP7OMppAxYwILI+GHktSaA8q5MkLC/44llvon5g5yWDiS1ds88b3PVjUMkDsZiJK
         sNHLpV92eLkOynPGGQy+RqS9+MwHsW8fZEOsdSbmzDLAeRRFPgtXki01UoEUdfKAYxQF
         N6o80XLuSy1nWag11P5KpgGuJKS5lPV7fMHIrRxGzXZKAZ6OyhHYqrCBNZk8LrtuVv3W
         UGEE6i76AJip+8grvvT+SrqWeN0ptNGbAL5/jpSdf+1KXAoO+LAnLkTecapTCnLgE7N3
         HTCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2TNTZoFX8izLjsENGMaLp1SXez0CZ0PERJNVXbbw6RjXvWBA/YNqUqPAQ4xLkYGsBgO+0QPQB9efP@vger.kernel.org, AJvYcCXhVU+3se+ple2jbesSFskeWRq+LdZWmOZvAuVjHE2Z4/YNNVb1WOoa9X46hEbp67dVXT0gkQn0@vger.kernel.org
X-Gm-Message-State: AOJu0Yylgt/Qldv9k2zBQdAmCyiPp4p3mDksyY/PLnAbWuWjyPofG0rb
	CLF5FY+QPy70vLG85r3V6a3nrGSydu6J0El4Lbn5naf7BttPaAfm
X-Gm-Gg: ASbGncseiF8G6I13YJ0FONHjy7QRvG/cky1mLTqQLhRD1z/lUPEKeGCTz2fssVwFif3
	PKTVLnZxdiFm4Xir4CZYMgPAHXR4TqEcE/HoQZ+XAPAJ2qB1D8hA3FBjJ5sW+FUY7WfmWt8OZXN
	e72O6kSRcqSLcCH0y7zd4YPoRuau0tD6jWrKlNFSCnzhnc9moywaXRDHyVybNJOmF4Wqk1PDF5B
	H92NoDf6qmZpbDFPmfYW40ijFiuanaeV5ht4mhvcSxo263FAd58kepn8/vcIbRNr7VugdKliOA1
	4OVCytvCCfwagX3AvtRTunFfRf6ElM/lio8d
X-Google-Smtp-Source: AGHT+IFYbv6ogfDp9u8Hd0HyP9o2vc9y/4GxH6j3OCgqwhb9Z83yxkLv5aCNC4w98WwGPcvY2cQqzg==
X-Received: by 2002:a05:6a00:2e0f:b0:732:706c:c4ff with SMTP id d2e1a72fcca58-739d6457e97mr9172971b3a.7.1743738917580;
        Thu, 03 Apr 2025 20:55:17 -0700 (PDT)
Received: from dw-tp ([171.76.86.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0b41f1sm2390818b3a.147.2025.04.03.20.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 20:55:16 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, david@fromorbit.com, nirjhar.roy.lists@gmail.com
Subject: Re: [PATCH v2 2/5] check: Remove redundant _test_mount in check
In-Reply-To: <6a8a7c590e9631c0bc6499e9d2986a6d638c582a.1743487913.git.nirjhar.roy.lists@gmail.com>
Date: Fri, 04 Apr 2025 09:06:15 +0530
Message-ID: <87semovbrk.fsf@gmail.com>
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com> <6a8a7c590e9631c0bc6499e9d2986a6d638c582a.1743487913.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:

> init_rc already does a _test_mount. Hence removing the additional
> _test_mount call when OLD_TEST_FS_MOUNT_OPTS != TEST_FS_MOUNT_OPTS.
>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  check | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/check b/check
> index 32890470..16bf1586 100755
> --- a/check
> +++ b/check
> @@ -792,12 +792,6 @@ function run_section()
>  		_prepare_test_list
>  	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>  		_test_unmount 2> /dev/null

Would have been nicer if there was a small comment here like:

  	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
        # Unmount TEST_DEV to apply the updated mount options.
        # It will be mounted again by init_rc(), called shortly after.
        _test_unmount 2> /dev/null
    fi

    init_rc

But either ways, no strong preference for adding comments here.

Feel free to add - 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> -		if ! _test_mount
> -		then
> -			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
> -			status=1
> -			exit
> -		fi
>  	fi
>  
>  	init_rc
> -- 
> 2.34.1

