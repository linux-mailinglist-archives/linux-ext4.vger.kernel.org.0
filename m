Return-Path: <linux-ext4+bounces-6430-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8F0A33C26
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 11:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C903A9130
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 10:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB02212F94;
	Thu, 13 Feb 2025 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoBIZMLK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34214211A2A;
	Thu, 13 Feb 2025 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441334; cv=none; b=LNHH+Aa2vEFdBnVS3RmtHNagkO8iB6IcDhTt7+c/T1RLRR/aMImtTsK7Es2+iFPzCLfdSbeurbfVaCCdFHGpnkw8s84owE1ALx9v1//E0S2bCL0E2vj9X/nCzVSY6f0ohQgL7l/c6+sFVLYwEQrRK+rutu3SuFrlg2EsDb0Y/DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441334; c=relaxed/simple;
	bh=FlYi4cTX8y3mHwfG9ibyUsaIUqVSgvIUu6d7s8WKwDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0F2FfKxHvrzYWIayvYDJp/NvukgEsOWdHrMk71crVFWcEsxH8d56ynfqQEpj/T8NzbJ6mOt7O6gAucjCJRukGJ8HZwXNw08qyxkPkLdu9MdGSeWqs3B+DBpDYBmcq2mz2JhcnR477Ux6FfZ0K+/8rx7rwd/aJBvUvtUFUsSGvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoBIZMLK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f6a47d617so10646805ad.2;
        Thu, 13 Feb 2025 02:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739441332; x=1740046132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z18pwIlmCF3OO2DMRI8974kIEsJ8jHY2B5wtphEuTrk=;
        b=FoBIZMLKTv0vcIt9ELHVN943ogbJW3v9g6ItoJ9JxIjV5qOiXLsJbqf4kehgG7Ri3e
         bTQ1FA1BcvFA+GuG8Asz1BV3tUCuzpjOy357CbawG1XqdMeF9kSYVveIK0lX+PAgPpKa
         GGVTLI9CLzbDUJQSuiMrSCh4/LK/TC0HlnoVjlzoORnc6wwz1rNy5/gbuVw9No1dryrL
         J/EV6XwPDCGFAUdAmM6b7a6XlHJxmhjQMvL3uB01jkOzLY6xYzDE87RqhVr5vSjj33qn
         zxQwzx4s9WAthPOIuUk8hC3+iem0REChNOAjYQLIqnf3DdsG5ZDdPV4MjZrlwiQqL2ch
         C3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739441332; x=1740046132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z18pwIlmCF3OO2DMRI8974kIEsJ8jHY2B5wtphEuTrk=;
        b=tEmKzipy35foXWC6b8eoISVgWe33cghGUsyJxmm26hqt3GNYhjw2pYfD063I5TeH4r
         8ZVCpbW4/W1tGII271kMhXjNoK97e5+wmPiGSNG4cox1MFplvL9BDbl5dBs2aSoX2ZV5
         ESZaiwUAEfMrCQc0FYMrn1X/EJyWmlFXm6+uLS97lmKvRHT6dtuvfGi/e/U+83RhpfqP
         e6Le3vuxH+tHkaR3u2BBffieb4CAuKaDVJfHUeiRYwHebnz+YcvYob6MAlpIHb0kYXjv
         CMDAosoIkZrxxhVCkTShoKkxRtPUSK16ThA44HN92133VacYfgI3OW0HSAZKso7fbbJC
         SZfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN06M0mCzyYKg3+jmkV9q02aESyaPRQmkMVi94CGoHY2uv7xTCWnRrALyDgXMm5vQOiE7etYsDanCT@vger.kernel.org, AJvYcCWi9GKmC/Xcj3MBub++inLxv3uUN/wkrihuu/qo+VajmMsgk98qj+BKr3XdEZtK/vMWIvapDfVK2TXm@vger.kernel.org
X-Gm-Message-State: AOJu0YxXLuMyneA1IOc0XcbuhV5IyzvbdjuTvfD0VBq6Niy0cnpyEomk
	gT0ZGlOnoD0QLCQg060pdEOE7M0tmhYAR4LjIpPN90nWHZYu/dTU
X-Gm-Gg: ASbGnct+LeKPUayeeUY/lvc2XwWJbTIAOi0uw2esr/yRbTDFbaY+otJvTffpqtDCSjQ
	BT8/iULybpWO6r9Kg0+bVAi93Ytc/UkcIn9QxyvQSUwpvgUlT0j1ykJU2yvAL8gqJbDPeYkI91Q
	7Nd9eoJm4uCAghhp//V2hREOxZQQKjVzUedkQX3dbmMlGT2kNW2RsnTXe+OpRmmw1GIT5g2snkJ
	NJ3yuu0V6W3HVfx6d9e8d05DiMwNkTnORdR29+bOkSx5kaBcVkrBMO+TaCpLemA7LAylTkMpExw
	47Sy57T/ndz587tpu6gyUS5kSw==
X-Google-Smtp-Source: AGHT+IH1T/K5U9t0Jm8Tn3af9vTPC9krL6ylsOaK8g23Mk8qip8SwQvfQp1TqU44miM7WnECcHq2fQ==
X-Received: by 2002:a17:902:ce02:b0:21f:93be:8b12 with SMTP id d9443c01a7336-220bbb1cf46mr103766405ad.30.1739441332240;
        Thu, 13 Feb 2025 02:08:52 -0800 (PST)
Received: from [192.168.0.120] ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d7a464f1sm7764585ad.206.2025.02.13.02.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 02:08:51 -0800 (PST)
Message-ID: <7167ad8b-d96e-4864-ac51-48b847a17102@gmail.com>
Date: Thu, 13 Feb 2025 15:38:47 +0530
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
Content-Transfer-Encoding: 7bit


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

Okay, thank you for the clarification. Also, based on your response on 
patch 3/3, remount with noattr2(or any other invalid remount options), 
should be silently ignored, so this patch won't be necessary. However, 
we have observed failure of the test xfs/539 because remount with 
noattr2 was failing with CONFIG_XFS_SUPPORT_V4=n on v5 xfs and this 
failure looks like a kernel bug. More on this on my reply[1] to your 
comments on patch 3/3.

[1] 
https://lore.kernel.org/all/b43e4cd9-d8aa-4cc0-a5ff-35f2e0553682@gmail.com/

>
> Hence I don't see any reason for changing the test to exclude
> noattr2 testing on v5 filesystems...
>
> -Dave.

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


