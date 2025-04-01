Return-Path: <linux-ext4+bounces-7032-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86417A78417
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 23:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F80B188C242
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 21:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7011E207A28;
	Tue,  1 Apr 2025 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="wD9VTKdw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035B20F078
	for <linux-ext4@vger.kernel.org>; Tue,  1 Apr 2025 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743543461; cv=none; b=CauS2w3uCHYRp1VQpveKWyhWtBkyg/K2o8sS0Rr8tym6MFvz0RsSN+tcmvFh4GNCUFA7CODbrjEE0chkuT5peBgBg+mTQ8dEucyXQT9VJaVY7fpwa2zKXZ7S+YVFdmYx5rWXSVsL1BbVjZ/n7KyOciHCR0gCerhPi2wBW7tQK9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743543461; c=relaxed/simple;
	bh=Zfq+e90kIJYmWlLbfTBqcfsN5jfJzfqB3zrpKTonHg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nn8GojCX9hejxIXt+DmebPnVHkKlv1udXU4VIif6LVw1WhujaMdQt/YZzrj5rIDkEeUw5gFtf0OfeKfU7PNLf+j0POqi4oknmMY9Eyn6W1dSgYCxTg5GmTZgs6BXB7BGgMlqrzqzfyT4/m3H61C+OMJI70CnWTVEUDjuORBgdng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=wD9VTKdw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-227b828de00so106405135ad.1
        for <linux-ext4@vger.kernel.org>; Tue, 01 Apr 2025 14:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1743543457; x=1744148257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULn61q6MozZnynxCXcCepY0O1QeWkpcYUhiO0MIBGX0=;
        b=wD9VTKdw0Ess2HUvGuruaCBIiZrgjqSIxm8qfA0Ufb2SUJxTUft2tZQp4rcDsLl/YA
         k4nh+VklUgxRLszhSgLXOBBdtTe5xjmBDsTP7CPCNBh4pdd4rQ/3XGGlOc1Zzg+tI/Aa
         os43+2e9QZFi0+q2H46wjnkjDjTK4B5H04vSnmfJWAB4ebrnB6oPBJFk0UfQ0A0COY+x
         mGJHLcrfJrOFEXMoveE3bAj0fzz89J4EuQ7yZdDL6jgk1YXP7jzTljjRkN5Q40l8yTZd
         SIA6sbZC01SIYhVEYDjZNmpNBqtribAxWxOTEiihLu9m3mW0cT72Po6U3uHre+Nlcov/
         OB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743543457; x=1744148257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULn61q6MozZnynxCXcCepY0O1QeWkpcYUhiO0MIBGX0=;
        b=Znubq0dJnuqOzO0AGhWoJT95g1WLpAZDtzzJ76zn+f0A5vY6X5yE9H3qfC+aKlgKO4
         fpAOq9WkKh4vkKHOOUKSZTmtc0XUEdaHf4pmV55sBTCPpbT0v9f6dytNf65LZ99uJqHk
         GddH2XOM+e1FRFKHaxwFZkJCUCovrXahzszBd+8GoxCLSuUh6jMyOjUF4d//yYV3nvhm
         dqawQd4m9GM9WxYaw4Tu2S8VodbV5Q65o9k9SSoslk+ZNGkGB5HrnHTxCfaMIu7KgKR0
         Q2q060HjmUYv7xtI3HHH+CJzK+fqvZHihgfwKT6RBw7/egvwNLMzmW93I1lZ7Okjpp58
         dXwA==
X-Forwarded-Encrypted: i=1; AJvYcCUYtXy6+8pfrMjI15KuRROTQE6LRli1jj/+WjoKY3oJ/OPgjaj4sbcxz6bRb+Kdwv37994qq4I74sQ2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7mzUMzBWiUEcp5yI30nD9TnvN2F/+zEUOxE2t9fmkkzMEERiC
	vLcemkwafPC3tDT3DjcFpF+EaFbcHFkSrX+H7plNZc6Tu8pX8Rdh3ZYBiPKJdao=
X-Gm-Gg: ASbGncsvb4EAgAj1PmxJNdlNZ85fA8oh2xLTDDhttlwNKQtg7VfJOjpDdsuakzX76xX
	YOACkQGv73B3TW6uTdYGyVZ/QlsdLpWOJKpGDas3ZhkX6k+j8HyPnIbZWBmqYk9U4gXw+rXQeNY
	KUwEWOFmhcwd5xTgnBzgV12047UtMw6/yfJ9WeFgtCnYurM49ykZPrxe2eQREOo6E4QYknkTOta
	m30GectuiiQQIDmXrqdfZAy7mDd2CJM3aH1PeIaMpWtRCVZJf08CtsLUPLHreqVpXN/MGV3tjO7
	YK/CKuJbrTLgDA9+xg6fvUkWwYDVfKqtIpSd5ntiscS7TinJ2tGee9xAe+KhEDL/bS+qbV+S50N
	v09NXyD0uhRZUktpNrw==
X-Google-Smtp-Source: AGHT+IE3QYgeXg6/2MlJM1fZCmUe7aBtYQAosAh70NXGSZ1t+mEm/dDygBcG4sqjQ9ucj+eb0t4h2A==
X-Received: by 2002:a17:903:19ee:b0:223:4d7e:e52c with SMTP id d9443c01a7336-2296c60537fmr719425ad.5.1743543457550;
        Tue, 01 Apr 2025 14:37:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eec533csm94712635ad.36.2025.04.01.14.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 14:37:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tzjIb-00000003GtN-3ov3;
	Wed, 02 Apr 2025 08:37:33 +1100
Date: Wed, 2 Apr 2025 08:37:33 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v2 0/5] Minor cleanups in common/
Message-ID: <Z-xcne3f5Klvuxcq@dread.disaster.area>
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>

On Tue, Apr 01, 2025 at 06:43:55AM +0000, Nirjhar Roy (IBM) wrote:
> This patch series removes some unnecessary sourcing of common/rc
> and decouples the call to init_rc() from the sourcing of common/rc.
> This is proposed in [1] and [2]. It also removes direct usage of exit command
> with a _exit wrapper. The individual patches have the details.
> 
> [v1] --> v[2]
>  1. Added R.B from Darrick in patch 1 of [v1]
>  2. Kept the init_rc call that was deleted in the v1.
>  3. Introduced _exit wrapper around exit command. This will help us get correct
>     exit codes ("$?") on failures.
> 
> [1] https://lore.kernel.org/all/20250206155251.GA21787@frogsfrogsfrogs/
> 
> [2] https://lore.kernel.org/all/20250210142322.tptpphdntglsz4eq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> 
> [v1] https://lore.kernel.org/all/cover.1741248214.git.nirjhar.roy.lists@gmail.com/
> 
> Nirjhar Roy (IBM) (5):
>   generic/749: Remove redundant sourcing of common/rc
>   check: Remove redundant _test_mount in check
>   check,common{rc,preamble}: Decouple init_rc() call from sourcing
>     common/rc
>   common/config: Introduce _exit wrapper around exit command
>   common: exit --> _exit

Whole series looks fine to me. I've got similar patches in my
current check-parallel stack, as well as changing common/config to
match the "don't run setup code when sourcing the file" behaviour.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com

