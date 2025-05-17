Return-Path: <linux-ext4+bounces-7951-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40697ABA880
	for <lists+linux-ext4@lfdr.de>; Sat, 17 May 2025 08:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3185E1BA69C4
	for <lists+linux-ext4@lfdr.de>; Sat, 17 May 2025 06:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3487119E96A;
	Sat, 17 May 2025 06:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yrz8ZkBQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E751442C;
	Sat, 17 May 2025 06:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747461822; cv=none; b=q7EQ9I6iw38vFhzfCkaTMocrKfvf9HDYqvtTdxkw/QQ7PQol4bKYgrrCte2+0p4V9my8XzUg16aPC4tg0ahQm8E9OQvbuYzZ403n19PEx1bhDC37v6w+4YFBSqHF3M1RebrR11jh2ZJyQZp9JdcwaDJW1s9ctJjevLTmhQLDJ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747461822; c=relaxed/simple;
	bh=HhqKG2jlcF1+YXWAPPqbx062HR24A2Br8qxNQA2XFkI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ckfFQ02UMHYBUEmtmuffXuPlMirVWL1faymXggVEPyMJ5h51TJBsQAo3Zo22dM0sQ1SJ+bBvoMADxYHNmMWCMndmKCfoCOosPcxzvjrE4dDmfhROWvHBo9X5xs4Xb03d6ujwH+Mug+wCWUuNg3+a9DVDOTBL29KqvfxYpTmJMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yrz8ZkBQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73712952e1cso2823000b3a.1;
        Fri, 16 May 2025 23:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747461821; x=1748066621; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EB4fG5SiMy1qYs1t6MhkbWVdPLGff5wCkYdmjlBknLI=;
        b=Yrz8ZkBQhXCrp45wBh/XgdEmfq5jyihLRDwT67O3mtbCGvNlR8sGPdCi/jU9tambC3
         zXKkJc4pfGZZqdMO7VWcATjLNnp5G+TWLTxngt61sw4aeNeXoBfp9P9YOd4LnLUBfANw
         7jVPm/RXB5LfvE1L/f5xkQW5BKK/jPX6WpGZhDXNEIV9jU3wfFSLjFfv79goCS/mzKWI
         kD2zQ3VA152XIbOFEhiE9foUFBLzvVuioVfAJV5hkGkOYUo36K7VPO1645nPtemUlSfV
         FJBX7hNGfZ/3FxZJnkQ2KtxVS5yfXstT2mQ9VyE8SNq4xTmIbyagftlyubZ27vyKQ1lH
         F4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747461821; x=1748066621;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EB4fG5SiMy1qYs1t6MhkbWVdPLGff5wCkYdmjlBknLI=;
        b=jwNBg7tf92upEbn2k+utP3uCbBhRC6OVjhpHRmSHTpVovXVqWyos1sWm8jEIv1fxPo
         JQC7vX3HLTYWowTW5pN2rbjqRbI5Wo5emxfm3Ut5HsyjPpLf25HkrrKQ8W3BagBNyp7q
         rXAvXDZuMptReuAyToRuY4Xvfk9OZvG5EXGO+uraQnlfrBFGlXfP0iBULE4Rs2KmhGn4
         qDN40VMOIL4Ek14NdhSts7LpFloGMvVGmzZqyd939B/h0zbQ1gChiMCggpf/Q0M72zC3
         yC8UgHQe9iaAEfrHlNAZ9VFME5TLKHKAUidk4cVBmZj0jte4gCwwki5PSumR+g2bCPww
         vgSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM9Y/wPFEiszZ/PivQPEQ/A962yoNFWHYuncI+XFExwsFflu7dqt+gCn4PHlohEIYEXAZDpO5NIYPZ@vger.kernel.org, AJvYcCWpsS1ocJNSg88gVevmdgU3MsjqTPLJqOt81UBnmcX0Znk9y3vIIj9YXhyP/i/uPyDmljhcRyRn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4RrbfaGhFk6wVbwIM9mRpN8iPfopIzZT+B24RE6T5BqIIcYYO
	8Mxw9vItg5fycfkPnc7Lvd4mvnqmxihiQpWojKwj7lUqoDKgyLBzHGqF
X-Gm-Gg: ASbGnctjHXdVTEMrIIS8SEZIBWEggUuk2McEZkjqUx2+GUWtQQxtEzsDkhArfyBHeQG
	x7fKtgG/JNgIeBsPLZB6heRg8Qo5vjKi84ZGV2bQoI+0oiqLMKkEMbesqHRZPJq7UDmkv8t1dtR
	ArqchEnNYtwnJeCGXNFn/RZAGGtj8WeC0BI4p/ZGjXicMApJu6cELFxthqcPF68Y6ONMiHk5J+4
	n/bSyDS4I/evXhmu4eZeHrL4menU80wPC1+JiUWl5T0ZHielyOhzFcNcIHeJDHbzIKgxuySprsz
	5xY2lnfiYqV5skPS8otgPRZInGZFbCQCCKYDJvWCLAU=
X-Google-Smtp-Source: AGHT+IEKqqLD/cHqCdpenuJ2M5WKEFmsmY1QWaWWVNXhb+3Z59KhM/uOtWRFnunhWWfYceRwE+t+EQ==
X-Received: by 2002:a05:6a20:1591:b0:1f1:432:f4a3 with SMTP id adf61e73a8af0-2170ccb2dccmr7923277637.23.1747461820683;
        Fri, 16 May 2025 23:03:40 -0700 (PDT)
Received: from dw-tp ([171.76.82.96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf8db5csm2502662a12.34.2025.05.16.23.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 23:03:40 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, david@fromorbit.com, nirjhar.roy.lists@gmail.com
Subject: Re: [PATCH v2 2/2] new: Replace "status=0; exit 0" with _exit 0
In-Reply-To: <463f1f99c7b9ced218f62ea9fc048c2e645227c5.1747306604.git.nirjhar.roy.lists@gmail.com>
Date: Sat, 17 May 2025 11:28:38 +0530
Message-ID: <87cyc7wzg1.fsf@gmail.com>
References: <cover.1747306604.git.nirjhar.roy.lists@gmail.com> <463f1f99c7b9ced218f62ea9fc048c2e645227c5.1747306604.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:

> We should now start using _exit 0 for every new test
> that we add.
>

Right every test now sources common/exit in _begin_test() preamble.
So we may as well start using _exit for new tests.

Looks good to me. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> ---
>  new | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/new b/new
> index 636648e2..dff69265 100755
> --- a/new
> +++ b/new
> @@ -176,8 +176,7 @@ exit
>  #echo "If failure, check \$seqres.full (this) and \$seqres.full.ok (reference)"
>  
>  # success, all done
> -status=0
> -exit
> +_exit 0
>  End-of-File
>  
>  sleep 2		# latency to read messages to this point
> -- 
> 2.34.1

