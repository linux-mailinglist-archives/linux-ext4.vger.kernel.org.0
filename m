Return-Path: <linux-ext4+bounces-6538-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3B6A41488
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2025 05:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3126C188FCAA
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2025 04:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2461AAE28;
	Mon, 24 Feb 2025 04:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFTQkzqT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049182F3B;
	Mon, 24 Feb 2025 04:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740372657; cv=none; b=V4yju/df6j2f4+s98QGnFMcziBL05QodNhBXTGROlGwwHA6zbpg/7SklsG5DzHXZtyJDFhBFpO9YSyjtNClmIsmDfhYr6ARfBLo2DbrEUFO4voYqQkMpgHzqOfm0I/+gAR6hPQGHA73R8CG5REIg4K5Sv8lu7ntfr+5xG9+W7KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740372657; c=relaxed/simple;
	bh=BmOgzG0JI+d7aJv0Oa244avhqt4WXeAIWcDX/NTYfCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsxwomnCAmuSITu0dHWWC+Bc9AKpVTRlKXsk73UTY9VoVrBkUwXgRxZdgxtTtPS/oZ86ARG0oLpM/+4b97G66zJt0fkET66cq0bVlaZv9LiaD9mfmi2IaBXnE3fanE3KdJbd6MsSuqc+2CoxRvyvwDFsR9q2ccamFa/Xxl+JRo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFTQkzqT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc1f410186so8436681a91.0;
        Sun, 23 Feb 2025 20:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740372655; x=1740977455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cq5X6v/15Wba9AJ1b3Nzk+v3oL4H02L4uR5JtNkrOQU=;
        b=WFTQkzqTayEJ2gx3ILT3+/Wl0BI0c8fROB0wjkKgeb1BB9aE+l1bdM4XSwfmlvEzm/
         dw5XdmNkWkj1oXf/vDjXBQbFGuX/mLpRKtWInMeLz8jvKrSPxZ7+2MbAXxrr6M06apJQ
         k8FbzCImOJ1t1JPqmf3iRYOjy5a/MFJV9jsaEZnQEEflH9hs/wZIeEIM4VGTsZOTysrf
         tKQuAL8YJCfjMLvxiBei2zNO2Vp3xhZYHXVSXCxI8wP59tl2M4ZGrIXpkBkGKL97i8wD
         ZJaeO8/kLphALl//jHggik8JyHWWDbh2787ox/rGVA1Reb9pdJVEtOiHeqTQwCpqvxGr
         V5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740372655; x=1740977455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cq5X6v/15Wba9AJ1b3Nzk+v3oL4H02L4uR5JtNkrOQU=;
        b=uhIESvZ8Msgr7T9r8UpTuCSvxdPpBXtfdnh6F0nPMnol/u5njkv3LNwq4Gz3SQwBIc
         JxC32d0UGsSQhjkF7GapiyZm6QUDarKlpEEpXJbaxOgHLxbcAkkOdIXJEigVxhLCjFB9
         334l0Bs35kZJr853/UmpbpEEuy/Tu0ExSVWcZw+tkiekely+FAvqnrFOb8CvwJWi6eZj
         1VzmW+rQM0mdhYmdf53XXFibP4VyFQwuKvMggZmCAMU1+2LqS3yD2wtE/Jlcp86dsvZ0
         rBlO2ke9xUiORJEbdp407Lgk/oaMGlFWWtTjhhh2RnhD5PRWbD/9N/pXfroML5uHBcIt
         FKiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRXHIG6gKVYH07DHIaHTcEPjjsdYOO4aW8CmhlRYp3ggNy2NDZv+u+s+JrVc2fSymk3P2JvWEYRTvN@vger.kernel.org, AJvYcCWBXvcD0Bm7m+c5/g5F/oEX9yF4hH2fNK5oN2JpV729J1cspYffU4g/zpRUoRCTfa18zPkI1L+sL366@vger.kernel.org
X-Gm-Message-State: AOJu0YzeGSVZK6jSLreLSsqwXKsLXQA3EuawLbBrt1SHBtcWWdN/FTnE
	3rgG+lyDORGefqxtSefBOjJlCq4PSVE+UqYl/aMnHS5a4Lka/YJP
X-Gm-Gg: ASbGncvykH0lfqqqBVc7SsCFqLvPXJTIeTkZv50kH/alllv/2OioEmX07AylYqC7m5K
	ul9QGvCjoqlasCGkWhtM+dqxcCrXp7YFKAiYXo45Qpvu/SUKSJgjoHoJKqeQzpRZVt/nn21FMVo
	CTpmDHwv7U8ptwyQatWhkQfb3QuRP4ljHzrsrGo5jXty1m7NECCSVxXlmIcDHgJcbVe5LKNZxDz
	cOF38x37rTA7PP1WzNOgQlI66u0ZnOGHzFTp5OV5YDnOxCcUGE0rz78R40WhzltKfOxU+RoW0iI
	huv3Qhxz0lxuNVLg0LNmzvrEhvIikD5Rz02z
X-Google-Smtp-Source: AGHT+IHyQCx/YO7KUUOXHjJV86KY038uKsEg/mHGAAw3dLoR/ht8tUPU69YggQrkSdqTTb52aJPp6w==
X-Received: by 2002:a17:90b:2b90:b0:2ee:8cbb:de28 with SMTP id 98e67ed59e1d1-2fce7ae96bemr22171227a91.8.1740372655134;
        Sun, 23 Feb 2025 20:50:55 -0800 (PST)
Received: from [192.168.0.120] ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceae32c24sm5430199a91.0.2025.02.23.20.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 20:50:54 -0800 (PST)
Message-ID: <8b927d46-f34f-4ae5-96df-835c40a6f574@gmail.com>
Date: Mon, 24 Feb 2025 10:20:49 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] xfs/539: Skip noattr2 remount option on v5
 filesystems
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org
References: <cover.1739363803.git.nirjhar.roy.lists@gmail.com>
 <8704e5bd46d9f8dc37cec2781104704fa7213aa3.1739363803.git.nirjhar.roy.lists@gmail.com>
 <Z60MMI3mbC9ou6rC@dread.disaster.area>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <Z60MMI3mbC9ou6rC@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/13/25 02:31, Dave Chinner wrote:
> On Wed, Feb 12, 2025 at 12:39:56PM +0000, Nirjhar Roy (IBM) wrote:
>> This test is to verify that repeated warnings are not printed
>> for default options (attr2, noikeep) and warnings are
>> printed for non default options (noattr2, ikeep). Remount
>> with noattr2 fails on a v5 filesystem, so skip the mount option.
> Why do we care if remount succeeds or fails? That's not what the
> test is exercising.
>
> i.e. We are testing to see if the appropriate deprecation warning
> for a deprecated mount option has been issued or not, and that
> should happen regardless of whether the mount option is valid or not
> for the given filesysetm format....
>
> Hence I don't see any reason for changing the test to exclude
> noattr2 testing on v5 filesystems...

Yes, this makes sense. The test indeed just checks for the dmesg 
warnings, and they appear even if the remount fails. I wrote the patch 
because xfs/539 has started failing in one of our fstests CI runs 
because RHEL 10 has started disabling xfs v4 support i.e, 
CONFIG_XFS_SUPPORT_V4=n. Do you think modifying this patch in such a way 
that the test ignores the remount failures with noattr2 and continues 
the test is an appropriate idea (since the test xfs/539 only intends to 
check the dmesg warnings)? So something like:,

--- a/tests/xfs/539
+++ b/tests/xfs/539
@@ -61,7 +61,11 @@ for VAR in {attr2,noikeep}; do
  done
  for VAR in {noattr2,ikeep}; do
      log_tag
-    _scratch_remount $VAR
+    _scratch_remount $VAR >> $seqres.full 2>&1
+    if [[ "$VAR" == "noattr2" && "$?" != "0" ]]; then
+        echo "remount will fail in v5 filesystem but the warning should 
be printed" \
+            >> $seqres.full
+    fi
      check_dmesg_for_since_tag "XFS: $VAR mount option is deprecated" || \
          echo "Could not find deprecation warning for $VAR"

I also suggested something similar in one of my previous replies[1] in 
this patch series. Can you please let me know your thoughts on this?

[1] 
https://lore.kernel.org/all/90be3350-67e5-4dec-bc65-442762f5f856@gmail.com/

--NR

>
> -Dave.

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


