Return-Path: <linux-ext4+bounces-7589-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53C2AA59ED
	for <lists+linux-ext4@lfdr.de>; Thu,  1 May 2025 05:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8572B9E0EBF
	for <lists+linux-ext4@lfdr.de>; Thu,  1 May 2025 03:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C7E226CE1;
	Thu,  1 May 2025 03:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKE3OCh4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8208E322A;
	Thu,  1 May 2025 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746069723; cv=none; b=ASvMazF9La3Wh+D0vUx1y9K0h/DRCYM7t15IEcsa5zXfQm3gHgrQmvv/swTg0dd6EnA6xYtcras+/FQEj7UhcG/LzC9dn5aRwezKp0N3k7kLSWXs2T6Q3JrOKS0OECCEArMoNgF1BTgskjEZ//WtnMINyhCwOuVOCEn8ocqPv88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746069723; c=relaxed/simple;
	bh=T7Ev572rtucr6hSw3luzwhBf+DzTGEiesdJYLuY5CyU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=KvWh7X09RvgJaPkyF9AwXLPgpx8yu6Uzh1B3L1ju2AovuEtBZd9e6N1tL/6cfhLIOjBDidv0mD+CNh37zQUiUlm/gD5Pse2EdE6zYYdTz00/cUEErv6BHObncLPCCdCVnXQqkkLW+lYP5SwSr+y6PqjFEOt5nBwEePflq4KAga8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKE3OCh4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2241053582dso7863485ad.1;
        Wed, 30 Apr 2025 20:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746069721; x=1746674521; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ocSRp7rMJn87fZBDOdIYWRxN9Od3igY/hkSgNTU7teE=;
        b=gKE3OCh4aeCwVHE51g2pSeQgv0gLsYtThgiQpQwpwVUkBmjirGQyJXrwIU8qow+R98
         TQT1jToEhFpiIMRGN93FfmZ8u+khGCMumk2qONNp7Di5WgVvI3aGSTbDQzgFSFyUJF8f
         ZskQEH7Wyg5hk2O4H74ecUdUf0NFrZGECrm9uoXj2eNw677Xo23OOeowR1Ib51Lfg4k/
         ggCPKhMbnfY+0bwFXVIagwnJr5p3lHspjqNntW6QElen84TtixapyR430xXXfCPucB3j
         uy64CECpxvvnD/sb2EHY9lOglfA0TXP0Hsg/3+lIk9BNY0QJrJTtSEMWPSsGeVMPpJM6
         6MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746069721; x=1746674521;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocSRp7rMJn87fZBDOdIYWRxN9Od3igY/hkSgNTU7teE=;
        b=RnyyXFRVMAHoYUCpnu6dZ+ORf8FkESseyDz0r8JwvV9wiCFW0SqesnAf36TI/0SL8w
         kUS2nG4mFKHmrgSrSBxxP1ufN69CYO7Wpy6wDfwKv6PpWvfT/ysszZdgnLE5KgzomvGN
         mNOYdlb13HXVL4TEpUKDwDeWIyiu/oE/NXr3ziXRDleNAJd8Xw4OZYCkrF5Zww9hxeSk
         uy3HhdKpP5XjfPXG1KUKgDZrSdhEQ5PV4Duo+xCUjkbOJRpONTf72ZSlwGQsRF6bmlbW
         nE9R4TgcY9RjZReKud22zixpeq+Ia8lghhq3JKoMQA8ki3EiW2tO/eeQjAj8/OKIxN5Q
         gKfA==
X-Forwarded-Encrypted: i=1; AJvYcCUSAUipHwvHzs0Pfk/vg0FJYIKVFJsFGm1DwiApMP04Z3G/T+Nezr4HuFBXnaXJkyC6/svLTzOAyghi@vger.kernel.org, AJvYcCWwTX9YeAlvo0rE9nmJlcIW4XZJKtC2noujsEjTbx6Xp4tBFW1U2vRGq8byw1tTf9cgjtR8RGF7@vger.kernel.org
X-Gm-Message-State: AOJu0YyqjIFm8FD7JFY2QWmWORe3Q7Z5FuzTqieoV3NCDm4XztE02UTU
	+uno3PHrVNrvvQlF/rtu7GwU54FGIVwwguyeSrRdicnF9rgwMXbC
X-Gm-Gg: ASbGncu3CliB8LL8B5a3IqvKEbzUENdvF8L3avhbcjqiLsqqiAhOQLbAQn05UaNYZyI
	93E0Ej4EFBKPaunOldUl6QrmnNunArWijr29BmSBeg0oDd5KJvO2gD8Uq5iEceL1mJPTzUsT6CP
	gR+P12D3We1PJ8Geq1r4P5F0/UxiORnHjmhocluGcufO/etaJHQdksJIGOUCpB9bmzOoEygW/4z
	8Ah9iPnfvdzM3zT1JsYCqzDLN2EaJmX2bfEU1o+lZZynd1d1Gf1Ry3hK4ToRAcwsC9sHWObbA9l
	7ydWoK9CpHMpfM35j6blmRA3klx9cnHFjw==
X-Google-Smtp-Source: AGHT+IEsIuyl+WkNTydTxAH3J8rD7/t7QB8oofnJ1HdA4Udej1/zv6ZPSKwHuZaXWIIHl0bdeRT5MA==
X-Received: by 2002:a17:902:ccd1:b0:223:f639:69df with SMTP id d9443c01a7336-22df5835e57mr81861995ad.41.1746069720597;
        Wed, 30 Apr 2025 20:22:00 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e752asm130111705ad.158.2025.04.30.20.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 20:21:59 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, david@fromorbit.com, hch@infradead.org, nirjhar.roy.lists@gmail.com
Subject: Re: [PATCH v3 1/2] common: Move exit related functions to a common/exit
In-Reply-To: <7363438118ab8730208ba9f35e81449b2549f331.1746015588.git.nirjhar.roy.lists@gmail.com>
Date: Thu, 01 May 2025 08:47:46 +0530
Message-ID: <87cyctqasl.fsf@gmail.com>
References: <cover.1746015588.git.nirjhar.roy.lists@gmail.com> <7363438118ab8730208ba9f35e81449b2549f331.1746015588.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:

> Introduce a new file common/exit that will contain all the exit
> related functions. This will remove the dependencies these functions
> have on other non-related helper files and they can be indepedently
> sourced. This was suggested by Dave Chinner[1].
> While moving the exit related functions, remove _die() and die_now()
> and replace die_now with _fatal(). It is of no use to keep the
> unnecessary wrappers.
>
> [1] https://lore.kernel.org/linux-xfs/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  check           |  2 ++
>  common/config   | 17 -----------------
>  common/exit     | 39 +++++++++++++++++++++++++++++++++++++++
>  common/preamble |  3 +++
>  common/punch    | 39 +++++++++++++++++----------------------
>  common/rc       | 28 ----------------------------
>  6 files changed, 61 insertions(+), 67 deletions(-)
>  create mode 100644 common/exit
>
> diff --git a/check b/check
> index 9451c350..bd84f213 100755
> --- a/check
> +++ b/check
> @@ -46,6 +46,8 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
>  
>  # by default don't output timestamps
>  timestamp=${TIMESTAMP:=false}
> +. common/exit
> +. common/test_names

So this gets sourced at the beginning of check script here.

>  
>  rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
>  
<...>
> diff --git a/common/preamble b/common/preamble
> index ba029a34..51d03396 100644
> --- a/common/preamble
> +++ b/common/preamble
> @@ -33,6 +33,9 @@ _register_cleanup()
>  # explicitly as a member of the 'all' group.
>  _begin_fstest()
>  {
> +	. common/exit
> +	. common/test_names
> +

Why do we need to source these files here again? 
Isn't check script already sourcing both of this in the beginning
itself?

-ritesh

