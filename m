Return-Path: <linux-ext4+bounces-7728-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA4FAABDAE
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 10:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73CC63ADA8E
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 08:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BC7218AB3;
	Tue,  6 May 2025 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdw/ie7L"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A16525D91D;
	Tue,  6 May 2025 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521355; cv=none; b=d0GRGo94x+65xSEpf63p2PvvsCuByj52z1IoY9chbtPUHFFmw2sm3Spl1CsYppv+wxEsxjj+LbGEBNWjQd/yyTnL1KNir893pkQFPSK3GS2Bjy20+UUemGlR8L9afP+Q6ESFn6n8jo2ERF65OkkPMDgkVLhOzUqpgFYdPQyhYIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521355; c=relaxed/simple;
	bh=b1mLCyyrbPGOVJauOldC6hhxn2wmuENwHOAvSqBti4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVYUiBLdvyocFQbp9sHV3jpp0HXu0BgvIcXA4o+AcoUSkPZXPAU5rPA1kj/fXE3g4fxwkgftspShUsidkMdMT2eLxXtfCqrRTHAg0eoz17I4nZApWqRuBc4D9ZkkEjpEYQcsnDiGdDTerMWHQxObeQKOKM7tGgfTqosRp+I+BBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdw/ie7L; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-309f3bf23b8so7091543a91.3;
        Tue, 06 May 2025 01:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746521352; x=1747126152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cQbvbGJpE1sWLNjmB5MzSQvVORvzVUZro4iaud+JpLM=;
        b=jdw/ie7LaHPNHLrwnFvWEP2yNnB4DqUWw+G52UqlnC8+lKyIERtVYh9V9bKTbypTW4
         e2hR1bs6k76oDPqQB8p5eZ5CuNkO7++THm7lKdDqNu3AiI4P0jNEP9bDleTzE8P2Mb5l
         Zc3If2C3g8mGTJG/G97pn1CVdkE6fy0N06ww+yVaF2h9d+IiOC6/W6FWvJ+BKvhGJ4Sj
         8+xiKTbTEw2y+gDoxNaf5Q7YeWz380NzmrJelf0ZaiLUMAIaA6hoXvjwadVj9U/5fxa0
         WpPfYwbnBg+TNTYgBjagO1b0v/Nlqink057IEHAFTHcQVRLUI+jvgnPkT5OYRj6PNkXR
         AwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746521352; x=1747126152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQbvbGJpE1sWLNjmB5MzSQvVORvzVUZro4iaud+JpLM=;
        b=WyTuODLQVDwakJIvmNWuqTZ4sA7G/ZIfbpYRHUNZ70gNMsCoEQLYhPqehsLV0niKZG
         fJp+jp6GVDMm0BHf3HfPZQWI4rDE2rqMYvHnCNAxyofs3cl+c7ngHV2lAnVu0T4LNVtF
         3kvqdVem3dMoupA6mMIom+AfLbSd1f2RKL/1/Lyn/RJfusNKFdZL6H0emg1HuXi8jPmy
         1tUqP9+1Mi1ZpVehe7Zy3AFllTe8O8dDlslhODVTbCGmH38PD5ZARAgfLrytvFDhG9fI
         kDn0frmamh45jNVATJQUwcRIVuO4434/yUleeilAAjLspqqVQIoQj25OeQYjyPTHaY5u
         6pmA==
X-Forwarded-Encrypted: i=1; AJvYcCVRGlk33JVOvbbF+i5q5m8ttoQVWwDfK3LZscOWnFH2IdEQNmiWhuUZSBS6wZnkg60as8Y94MvvWE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz002GZ5QOyD6tcKSk7Y2E3tiRBq3nwdwytTbzu6VYeuXT2C5mw
	H/RCz4xkTfWHhgmzLoqLhDmuQZoTTx+0jidhrfFMPyI1yPXqOH5Tb5mTww==
X-Gm-Gg: ASbGncubDst7lD/FIss36bHs1A9O7zy5TgtPQaf3/jK6fv08hV4sHG6nNjeWTPfGo6j
	gBgBArSVup+73fvdFFKFZ5DXmWlpRTrSb0urFIdXRW07ur+7dSkCK7pdXcRHq61upf+DBMa5tFh
	HvLNvejjie7zkIBXDRC/rNtirRx6tsx3Uobui7J67iSqL+SqCTcSiuY9BetSPuNKKYcLYepKgXQ
	39XIPmF7VgHNByFzZDY66s18qcVDWlc0nVfzfD9IMFwuLdlwihLMe/+8K6mNvTGiM88YD+TQttU
	LfdWAobrzeRpPHy2emLC1hCjEJNYNMNZ0lHZngTQNxXZDaqmX2M=
X-Google-Smtp-Source: AGHT+IGxd8/1ykuO1cAq7Ln1eVp8NwUyq8awp1NxRwaVeKD6E/gCBWkJ5rLDWHmSj/tFqfxvrxbhtA==
X-Received: by 2002:a17:90b:1dc7:b0:2ff:52e1:c49f with SMTP id 98e67ed59e1d1-30a7c0c8b80mr3126740a91.26.1746521352299;
        Tue, 06 May 2025 01:49:12 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fd12sm68600295ad.127.2025.05.06.01.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 01:49:11 -0700 (PDT)
Message-ID: <aefede43-9ac6-43bb-a22a-47dc0f4c8cd9@gmail.com>
Date: Tue, 6 May 2025 14:19:07 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] common: Move exit related functions to common/exit
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
 zlang@kernel.org, david@fromorbit.com, hch@infradead.org
References: <cover.1746015588.git.nirjhar.roy.lists@gmail.com>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <cover.1746015588.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/30/25 18:15, Nirjhar Roy (IBM) wrote:
> This patch series moves all the exit related functions to a separate file -
> common/exit. This will remove the dependency to source non-related files to use
> these exit related functions. Thanks to Dave for suggesting this[1]. The second
> patch replaces exit with _exit in check file - I missed replacing them in [2].
>
> [v2] -> v3
>   Addressed Dave's feedbacks.
>   In patch [1/2]
>    - Removed _die() and die_now() from common/exit
>    - Replaced die_now() with _fatal in common/punch
>    - Removed sourcing of common/exit and common/test_names from common/config
>      and moved them to the beginning of check.
>    - Added sourcing of common/test_names in _begin_fstest() since common/config
>      is no more sourcing common/test_names.
>    - Added a blank line in _begin_fstest() after sourcing common/{exit,test_names}
>   In patch [2/2]
>    - Replaced "_exit 1" with _fatal and "echo <error message>; _exit 1" with
>     _fatal <error message>.
>    - Reverted to "exit \$status" in the trap handler registration in check - just
>      to make it more obvious to the reader that we are capturing $status as the
>      final exit value.

Hi Dave and Zorro,

Any further feedback in this version?

--NR

>
> [v1] https://lore.kernel.org/all/cover.1745390030.git.nirjhar.roy.lists@gmail.com/
> [v2] https://lore.kernel.org/all/cover.1745908976.git.nirjhar.roy.lists@gmail.com/
> [1] https://lore.kernel.org/all/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
> [2] https://lore.kernel.org/all/48dacdf636be19ae8bff66cc3852d27e28030613.1744181682.git.nirjhar.roy.lists@gmail.com/
>
>
> Nirjhar Roy (IBM) (2):
>    common: Move exit related functions to a common/exit
>    check: Replace exit with _fatal and _exit in check
>
>   check           | 54 ++++++++++++++++++-------------------------------
>   common/config   | 17 ----------------
>   common/exit     | 39 +++++++++++++++++++++++++++++++++++
>   common/preamble |  3 +++
>   common/punch    | 39 ++++++++++++++++-------------------
>   common/rc       | 28 -------------------------
>   6 files changed, 79 insertions(+), 101 deletions(-)
>   create mode 100644 common/exit
>
> --
> 2.34.1
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


