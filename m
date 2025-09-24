Return-Path: <linux-ext4+bounces-10405-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D9BB9C646
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 00:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61DE919C604C
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Sep 2025 22:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5BF27FB3A;
	Wed, 24 Sep 2025 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il2GGEWM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF851B423C
	for <linux-ext4@vger.kernel.org>; Wed, 24 Sep 2025 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754431; cv=none; b=o/xTIB+6ppdqHP6A+08mF85RjclpSdJcOgc/ngTUR9f2iRiy2pKMPN1Qb4ta+vc+nENhaqDlbbLMAIgafXCBnkH+w2me6EEMPEJcW9PSI1C1FId7Hs8q1Av1HjNGlAUjJ31KJ1kOyK751q5acA8AEXKIpnWVW/8uuE2NfCKcSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754431; c=relaxed/simple;
	bh=qHDaN4fxq+33TeuPxLHXVx+PAknon7egB4iDvCqkcNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBCTE4CajuWhNsf0BidQ/3x2Wzy4telMARdJYQBv/DJdvsdRhYPBPUGG91FVP1cH2dZaYFh6VF4bkayGmSMZHiS5rFGu+IJx2HOx6vdMFhVRvR2fVUpAw9C9f9oGldDEBTmRqefBYztmg7K2+kKEW7U4VQCEO/soo6bcpox/2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il2GGEWM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4d2686300f6so3816901cf.2
        for <linux-ext4@vger.kernel.org>; Wed, 24 Sep 2025 15:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758754429; x=1759359229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OMv6M4S9k49MdsUE0Vs8ZejZ+912P5gb20KbIpJokts=;
        b=il2GGEWMHExJSWERcxGMQFs3J5CUXvievwD8Cz0y4QDOZyok72+0aSux/LrgEKzYEA
         ePi/HUCVeD3PIRd8z+GB057rGt6BOpBFSwra7H4hQVVoF3iFDubLtUJuFrJ82hZPnSLX
         4ttXiC1TzuLnk/l9jMmpUotIbVMiXrvq+qedGU7YVum2H9IZ8Z3JwQy74qKMbw9AGOd1
         nlv0qNyyWTpvLcyfDwMC3vZsSblz66vTYrK54igubNX5FBw6WOp9bNJIsty7vsy/cmkq
         c6cZ1eDy/WdJpJmE8r/TsqALlotOsZllcxqD5rYeZ1ctzyt7NZLUrwvxhvsbwh5m7LwC
         65VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758754429; x=1759359229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMv6M4S9k49MdsUE0Vs8ZejZ+912P5gb20KbIpJokts=;
        b=du96oqKkh6h4iTiiFOHXecM7PiFw8yqTvtZxx+cg7B+OHX7XSBEPI1iqhlvobhZ7IF
         zxzjjrA3oC5ud0mo5ID/gx1itLs64EYYg9Ua5+TibMBKMw2pYe1s6RQ3ZFFg8BK3Z3SK
         nePixlDrtp6tXAsBIRG32qCjZTLBBYTB20yrgM5QYZ+XoXXaDdGJfuMhn6xJg3arxTCu
         0HNWeWGEjKlI++upsVBjh+A5yg6zBhHkwG2QyXQoofwJcc9LrKsgHsmGidlRrBFLAVNG
         BbOkE3YBQblHK8wzklbH7iqoYziN0RxyeQZd+fAdr4TAul8TeFSUSHXrarzdcomiHAE6
         BLcw==
X-Forwarded-Encrypted: i=1; AJvYcCX1Bm8TutWHWtd7yXhJiqFa3oCq/ijrE0V2OQGHcx4y8A29otk2LcFk1hut9STr9yCOAHAcDcZcAQ5D@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfbkc9Ac0DSqlta6Z9b0GbDDNpdJOPc+y4HxIkHM3GxsoiEdbJ
	g1KagOogC+s2G6QwYrzngmZWAfLRqSpX5JfEirWhVIAkZWLfChKXGM4a
X-Gm-Gg: ASbGncvByVUa/PnIGfRx4RE9Xg0c5KTVOvxjEE1+siCHJDCi76zlpQSIyP7XBmOWDM0
	iGWt5Z+N6IDl6GC87x0GcwluWV6LKogP7JiRbLw4rCVEN1Qs0lOu++UfU7vIvn3Q8Y8lvr9CL89
	9XTJjvB8ke+lrGxMdfPp361BeNW+R7qYSwd1blq5wWWVeRxHjlRQ+3qDR/vUy3+UWTbFtmFvdug
	Hbp6bMFldeagIRIvR3khCs+2N6s1eYvHTeCnfZN9UuKwL2ZjHLJ0O+wG/7zoJzG9THPil9321hq
	P9H11K67JwZ9GQXDUaMWLt8/YHbG0KuYrsktXjZXvHQdGWvIbTskdjW9W/EXS/TYl0sILVQE9Tj
	v11EimEYz1l6XRMd/Cg==
X-Google-Smtp-Source: AGHT+IEBC+joViliP/PQ25auOrWeoPG1kaQmBfu5QNRWbNYA+rQQb3vtViLCUnZuYqfGk3yWHCfqXg==
X-Received: by 2002:a05:622a:610b:b0:4d4:7311:3cd2 with SMTP id d75a77b69052e-4da4cd4cc5cmr19410541cf.74.1758754428694;
        Wed, 24 Sep 2025 15:53:48 -0700 (PDT)
Received: from arch-box ([2607:fea8:54de:2200::dd5f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0b94599esm772621cf.16.2025.09.24.15.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 15:53:48 -0700 (PDT)
Date: Wed, 24 Sep 2025 18:53:46 -0400
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ahmet Eray Karadag <eraykrdg1@gmail.com>, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Fix: ext4: guard against EA inode refcount underflow
 in xattr update
Message-ID: <aNR2erc6QYubynYK@arch-box>
References: <20250918175545.48297-1-eraykrdg1@gmail.com>
 <20250920021342.45575-1-eraykrdg1@gmail.com>
 <20250923233934.GJ8084@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923233934.GJ8084@frogsfrogsfrogs>

Hi Darrick, Ted,

Thanks a lot for taking the time to review this patch and for the helpful
suggestions. 

> /me wonders if you could use check_add_overflow for this, but otherwise
> everthing looks fine to me...
We looked at check_add_overflow() and check_sub_overflow(), but our
understanding is that they are mainly useful if ref_change can vary beyond the
current ±1. Since the call site appear to only pass increments or decrements
of one, would you prefer we still use the helpers for defensive hardening, or
is it acceptable to rely on explicit 0 / U64_MAX boundary checks in this case?

> ...though while you're modifying the precondition checking here, I think
> these i_nlink preconditions should also be hoisted to the top and cause
> an EFSCORRUPTED return on bad inputs.
Thanks for pointing this out. We will include this in V3.

Cheers,
	Albin

