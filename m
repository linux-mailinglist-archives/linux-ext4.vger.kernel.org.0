Return-Path: <linux-ext4+bounces-7590-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64808AA5A0B
	for <lists+linux-ext4@lfdr.de>; Thu,  1 May 2025 05:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3799F7ADAE3
	for <lists+linux-ext4@lfdr.de>; Thu,  1 May 2025 03:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6576A20C461;
	Thu,  1 May 2025 03:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3tnDNIl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB672194080;
	Thu,  1 May 2025 03:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746071402; cv=none; b=fRiamRx2ExOioUUHhaLIwaO2edPSBTDqpdkoViXRxvPMYgUznrR3Q0jUXx27Dln4hh91XYMAScHffQ33HbdDhcnNM/JsIVIF150aOGyOX5PdZVfFvEV9b4pyIDGZNQVn+zAqx1cZKUNN49cs+skjRTYtQWHRdqZesqBM0AVEKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746071402; c=relaxed/simple;
	bh=k7viiHkPEK4VIEk9V7gGTim/AadW8OZyPLUc4oy/g9w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=RBDeEM3xwAaWPUdoheBgrFkQBegSA5tUCbMEWJ2smshgX8ysPRpXNfsNep9Pz1pHXy6WdEJVpFx5OoghCV9V9x67r5P1eJ7iOzGEB6X9h4+945Dz2JI00pL6jCk9pI+azgvMgkM1OZl1tDUEipLbO3EpcD3RiHjIOQL97QH+wWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3tnDNIl; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso631832a91.1;
        Wed, 30 Apr 2025 20:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746071400; x=1746676200; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mFwyU/iq1Hx41pNqiSoEgwo1J6ylITQGtBMxO5TAzq4=;
        b=X3tnDNIldGjOEoM1n8Mpw5JSZqy6MgJ294CqnAMScEb085EljDxrGxFkcK5Va/9ma7
         FQVdYhnWJk+MThBx7K4YSGa3vU29vRcUvUxF0nYEw+wFnbtKlRgE6zkgnZpbe9tKfQ92
         4uXqv3RJI/npjedO+wHeZFbJ6Won8hEKcgoBNOWoe1qrDnwThPU+cVwhzfAwNq9QAn+A
         qwOvax4Iup/rBcNx7QaKqn+bVrYQsV/QJ9EVXPbRXPrY04A5OdV2WTWcdlCuzMooh8Gb
         9ZG91QUsUbzzlRMm+Ks428AeUasiapc9wQ/nzWBnGb2/OqA4JzjXXwrDzxDBj0yLVPF3
         eJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746071400; x=1746676200;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFwyU/iq1Hx41pNqiSoEgwo1J6ylITQGtBMxO5TAzq4=;
        b=WJqbxV3uopqGGabQARTdgoasOME5Q0QhbKz69FJDoDupdBssLRyfV/UIeBvX5PiCX9
         hcY0dvfsFx6UFA/Da7O6CHjcMCvYPI8jMhSYXMRj1c3/A2X81hi7iRR1lw5YhLCgDfs1
         512rehP9tDelpw+rB94Frq1ui4x7e2U3BMIVsTVAl24zwzuPAUIAKi6iY7mEA1kEUFO9
         7zee7DZpr9q7L3ReP1Z5O4/bpyVjRZu3ByMAsO52DLcapktkyTWrhYwOklu7dXa1RFJk
         wNs/o6rLyraFUZN6CZNJAnyQyo7xpeCCr/EbnsCHGPyEromZuhRspPiQw7IwaziAVXC+
         PPSA==
X-Forwarded-Encrypted: i=1; AJvYcCVHNYNmO9o5zOcgqnWddteJZD4D8tXlc3nmRuA07+0L9PxgWU7gswOFojv7Z2LMOJ82IU4WSjEObGuF@vger.kernel.org, AJvYcCVIR2fMBIsvPGFPZHXLUqPQTjf2owxTgm9Vqahu2OCcvH350bWLzdJDmlNAyyFM4f7ObIibXmph@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc430OBGNdZ5Yja87ldnJdSUosTOQ2wjxp3AIYqTtqHESDw4yb
	dYXw9YkbQnsjukiwKUi6ejnNtHxVlRdjbF3/f8bQkYival/04ulh
X-Gm-Gg: ASbGncthen2h/r8/jPJBlBpUUlH7bpR35up3nUFo59m9xTMPbYSV4n/nvwQNASl8Z31
	C9JOAptIbI4J2BcaCALMU3joN3aDTqSkwdM0rfuxKVGRVXM1lzyoV9uKFuBQSQmoUA+/tXgQaX8
	vulBaMlmfl7gd3iwcPUP+NEsY6fk+OxwDg6dpAkPVjfZtjpltYaMSrGhTuirTiYDa3AloNNMfIK
	F+q2BB+qHvL26M3fRsGiNZNy9FGrScgkwzJ6s+o6tscYIVrfZKoLEVcXo3Me1BruIKd45L8Vpl7
	kGafY0BHwhlgpjcMF6FNhaD/wQs20e/HQVbOq2KOQ2yW
X-Google-Smtp-Source: AGHT+IHRUNQww33YA6tiY5J4BDQ4w5fPKPDywLJntG7QPBmku/bA3YnPed8z6tNUeuJY8hOip2hA6w==
X-Received: by 2002:a17:90b:520f:b0:2f4:4003:f3d4 with SMTP id 98e67ed59e1d1-30a41eeb91amr1991558a91.30.1746071399869;
        Wed, 30 Apr 2025 20:49:59 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a34a11adcsm2519774a91.26.2025.04.30.20.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 20:49:59 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, david@fromorbit.com, hch@infradead.org, nirjhar.roy.lists@gmail.com
Subject: Re: [PATCH v3 2/2] check: Replace exit with _fatal and _exit in check
In-Reply-To: <34273527dab73c9e03415a7c3d6d118980929396.1746015588.git.nirjhar.roy.lists@gmail.com>
Date: Thu, 01 May 2025 09:01:22 +0530
Message-ID: <87bjsdqa5x.fsf@gmail.com>
References: <cover.1746015588.git.nirjhar.roy.lists@gmail.com> <34273527dab73c9e03415a7c3d6d118980929396.1746015588.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:

> Some of the "status=<val>;exit" and "exit <val>" were not
> replaced with _exit <val> and _fatal. Doing it now.
>

Indeed a nice cleanup. The changes in this patch looks good to me. 

Please feel free to add: 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


So I guess these couple of series was to cleanup exit routines from
common bash scripts. Do we plan to update the tests/ as well where
we call...
    status=X
    exit

...or updating tests/ is not needed since we didn't find any wrong usage of
"exit X" routines there?


Either ways - I think we might need to update the README at some point
in time which carries this snip. You might need to add that there are
helper routines like  _exit() and _fatal() perhaps for use in common
scripts.

<snip>
    To force a non-zero exit status use:
	status=1
	exit

    Note that:
	exit 1
    won't have the desired effect because of the way the exit trap
    works.


-ritesh

