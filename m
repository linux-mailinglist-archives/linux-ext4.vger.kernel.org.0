Return-Path: <linux-ext4+bounces-7071-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24998A7B6AA
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 05:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D513A3D2C
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 03:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7B156B81;
	Fri,  4 Apr 2025 03:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZJ0+Gpj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751704689;
	Fri,  4 Apr 2025 03:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743737600; cv=none; b=nTgNE8cyi+T4a6k9WeJ+Nsct7ujwj7VvmghPK5AKCdlBfoO9yRYp0zc6MTJ9hcuLZscsYEi1rQfVkl9+TwzCmjyNWzrU3OHadIdYjEvrK60vpEHSe/vrceFTBJEf0/NxaZTMnwtBJhsrsR9X6YHsirwNpQ9ZaHmNYGWgI+1LO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743737600; c=relaxed/simple;
	bh=jbGmYx23pGajaqIVhrf/yYbfbemA0dPKmyRwDNyymag=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=PHxEP23Gqt5XjX/w7sQvYB8gtsQcsv08PJilqYgBw50hSrjCq/DBG9z50/avnhwivaQ18Nb5bwuzQi9CBP2+fcs7uFEiPfld3JF08kUQWyUoxatNdGKKHS5ykhJZEGNLhDoi8CZ9zBLvcF8kCOfd2dQDCh0TfbdqR0v4qVzb5QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZJ0+Gpj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af980595952so1089478a12.2;
        Thu, 03 Apr 2025 20:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743737596; x=1744342396; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8JG+xIxfQUa6rSFyBv4OipnW7Cc4/fNxgI8QayiS1IY=;
        b=eZJ0+GpjjK7HHzNAllN2xTHOP/5kHXLTGDnSXwdPrxCuh5pXNbeMiRms9N+SjIZf59
         cGfzupJHDN+8e2GkHNyI9Oq3Ec3sF6UIOQoSTxgaNoy9DxcrArarT6ADKXJEMvOZdh8s
         htuJTphkIkTFzCCECowkiooqICAVUT0ZQWdJQqgq0xxBKwrG1x3eEw0BMA+VKG+lSnNJ
         0iIQ55+IAEnVtdyl5iTJge53ZOB/KE9J9K50ylKixU/fQyAVofs7Zhw0rzxgJioSrAcU
         E6DLSCvHqkNmUSDxepUBPZ/8Q7xR81tmtd51TtbhvTNi8UgFJiEM442kHVNXqW8gDzGi
         uP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743737596; x=1744342396;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JG+xIxfQUa6rSFyBv4OipnW7Cc4/fNxgI8QayiS1IY=;
        b=UYG6KdprC/inKmFHK/fXpl2vtqBOdB2Bv7TyDWOP1PhXDDpPeGgV/GM3/dtQXD/h1J
         Mr+n6PboVGtDcJj8E1NZf1ajZ5tvK55qVLUz1EHB3b7g70UrhSlgVOVa+scKm+5HMB+m
         ExlQXyXLjzcQGlShIDD+8PKepMQm5bo7hL1GTPKDhYLNsN6ZMCaOXI3KSy5jSZEfZfwA
         SSojBkbi09q7FXmNto3aKdJCRuvZ8vlFNMpK17DVFTp1ZebZLimO3BRehSB3fwmfTRev
         GRW8hAiDvpXVYVgEstagm5YwAWg25GuY3bwBn7e5fa0KBgBZ+PAZRwtpXQT+WRI4Wzwy
         9r1w==
X-Forwarded-Encrypted: i=1; AJvYcCUggiXbJSAVJGekQxIwn1MXqMDSAvQpceBR7axmv3ouFVu/QaWSFrK9/+CTeZVIz6XiO1+D5otY@vger.kernel.org, AJvYcCXapUgKSMp0Za3DVCpi1QUyJ1iIGY6PGOoKnSbCnGt7fVlTPIbxD+aqJhHnktLb76fnXHkMCtIxosm1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6q5FqPxd8AyiMlMPp8bR4gaALyIeBRuNaRYksIQLCqfaF7CEb
	mOZrpXUBwKw4NblJYJj4RKGx07Y+ygWqeHeEi7IbZNdpRon+HYVj97ymC/qd
X-Gm-Gg: ASbGncuLybBAGMzCItQ/4YqIPavrSei1o/SiBNVH4hcKixVmh3mkPvLcNI1O8TaHIq+
	n3i7QcCsqtZTBtWqUB/DB1OVZx2LRbXBNeCqKJntxfkPb9vCl8Ra2t+VCqH9Wo5dId47HaxsjF+
	An63YJYfmn/kQGpZ2RBuSSwV3CAtGIcC19a0R5MGMLmZqc+ROKjxMak8U72eFIojPeLdxKgiZdn
	hKhbelWhZykTw+seO1KRM9/0Yt7slHgZvUkIRin/+dqoO5hD4V6MZ438ceoOAoKbAZGwyMA/du+
	lYicWMyQpeaL2jOIGymm7N9vEdrE8VwrV62X
X-Google-Smtp-Source: AGHT+IEfkdBKQ+0fPYp0QQthjiAoGbX0znJcTPV4MIeAVedv8ovEnl7PQolUlB3ebMhgvnGA0w3yTQ==
X-Received: by 2002:a17:90b:518d:b0:2ff:58e1:2bb4 with SMTP id 98e67ed59e1d1-306a61ee10fmr1354488a91.22.1743737596474;
        Thu, 03 Apr 2025 20:33:16 -0700 (PDT)
Received: from dw-tp ([171.76.86.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb8e2afsm2547711a91.42.2025.04.03.20.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 20:33:15 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, david@fromorbit.com, nirjhar.roy.lists@gmail.com
Subject: Re: [PATCH v2 1/5] generic/749: Remove redundant sourcing of common/rc
In-Reply-To: <b44393e0f3d6fce937058525bf5726421f7ca576.1743487913.git.nirjhar.roy.lists@gmail.com>
Date: Fri, 04 Apr 2025 09:01:48 +0530
Message-ID: <87tt74vbyz.fsf@gmail.com>
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com> <b44393e0f3d6fce937058525bf5726421f7ca576.1743487913.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:

> common/rc is already sourced before the test starts running
> in _begin_fstest() preamble.

Indeed. The patch looks good to me. 
Feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/749 | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tests/generic/749 b/tests/generic/749
> index fc747738..451f283e 100755
> --- a/tests/generic/749
> +++ b/tests/generic/749
> @@ -15,7 +15,6 @@
>  # boundary and ensures we get a SIGBUS if we write to data beyond the system
>  # page size even if the block size is greater than the system page size.
>  . ./common/preamble
> -. ./common/rc
>  _begin_fstest auto quick prealloc
>  
>  # Import common functions.
> -- 
> 2.34.1

