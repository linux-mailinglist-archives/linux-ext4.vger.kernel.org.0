Return-Path: <linux-ext4+bounces-7137-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A686DA80EA9
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 16:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585148A1D8B
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 14:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3921A9B52;
	Tue,  8 Apr 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+Wsd4uF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C4D1DBB0C;
	Tue,  8 Apr 2025 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122827; cv=none; b=PvcaKZ6lYNA2Mv4UTI1yUBXH0nAH8PhFgaFn3ubxOgjZ24/nnKP62LHaptnGu2xZ0EyWxmDp6Qacph2MtivzeXkTE+GK6WpJ7GVe2B8j86U9G7g4hOU/QnpnV8MAgFVs+xRgluk1f9uKfTvUxNZGdnnmWtNfp8UbUj8Phh6p3Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122827; c=relaxed/simple;
	bh=aEfx6RkU/Tu2k8S2tBQr8QBzC2LFzW6gVbGKB908vOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duuQsJi67HDhotY8GYWC7+65mF3oXq9Ry9kRtJnMyxD9bSplA9AKWI4aGhZ8RKHE0H2qQvIGRtyuyRprpUE66XC6VlAz+a/vvD02vrG7SmWX49ozQAZO9ePlTytXWA/LQTYx/mGpQ/4KR1uM1fWFYRZXnm5p2aGwbqRjc8LGfDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+Wsd4uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5F8C4CEE5;
	Tue,  8 Apr 2025 14:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744122826;
	bh=aEfx6RkU/Tu2k8S2tBQr8QBzC2LFzW6gVbGKB908vOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+Wsd4uFxkefVyM0Rcp0TuN+gwpTIMtSSLaIkCzk3iWbn0P8QFMm7P1NPsk+p+QNr
	 RwUEbiSOVsUTPgY/llpADBQ4LKVgPwpmXVVbe2e7jgl7BtL7MJX8wE3DFUawDZ5HBu
	 8RQUGaGkPeKbw1+QPjGRIuDzGjWVOjUCSuTjYA7RSriBP1jIc9BRvF4EhSb8ZHemCF
	 6KcjqcO39DD+3bdMSbkosN9MnLa7y6sV4TxGx90TJWqRkYTJtpZNBfH3Mhr+xzHGlg
	 p+/KV8rF6vmQUsLgBLeIfJzuT07evGopX/iLESfrlA9xA2AXJwWWz5fuvYWsM1iSXe
	 MKoEgI7CJzU2w==
Date: Tue, 8 Apr 2025 07:33:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v2 5/5] common: exit --> _exit
Message-ID: <20250408143346.GD6274@frogsfrogsfrogs>
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
 <f6c7e5647d5839ff3a5c7d34418ec56aba22bbc1.1743487913.git.nirjhar.roy.lists@gmail.com>
 <87mscwv7o0.fsf@gmail.com>
 <20250407161914.mfnqef2vqghgy3c2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <877c3vzu5p.fsf@gmail.com>
 <3c1d608d-4ea0-4e24-9abc-95eb226101c2@gmail.com>
 <20250408142747.tojq7dhv3ad2mzaq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408142747.tojq7dhv3ad2mzaq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Tue, Apr 08, 2025 at 10:27:48PM +0800, Zorro Lang wrote:
> On Tue, Apr 08, 2025 at 12:43:32AM +0530, Nirjhar Roy (IBM) wrote:
> > 
> > On 4/8/25 00:16, Ritesh Harjani (IBM) wrote:
> > > Zorro Lang <zlang@redhat.com> writes:
> > > 
> > > > On Fri, Apr 04, 2025 at 10:34:47AM +0530, Ritesh Harjani wrote:
> > > > > "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
> > > > > 
> > > > > > Replace exit <return-val> with _exit <return-val> which
> > > > > > is introduced in the previous patch.
> > > > > > 
> > > > > > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > > <...>
> > > > > > ---
> > > > > > @@ -225,7 +225,7 @@ _filter_bmap()
> > > > > >   die_now()
> > > > > >   {
> > > > > >   	status=1
> > > > > > -	exit
> > > > > > +	_exit
> > > > > Why not remove status=1 too and just do _exit 1 here too?
> > > > > Like how we have done at other places?
> > > > Yeah, nice catch! As the defination of _exit:
> > > > 
> > > >    _exit()
> > > >    {
> > > >         status="$1"
> > > >         exit "$status"
> > > >    }
> > > > 
> > > > The
> > > >    "
> > > >    status=1
> > > >    exit
> > > >    "
> > > > should be equal to:
> > > >    "
> > > >    _exit 1
> > > >    "
> > > > 
> > > > And "_exit" looks not make sense, due to it gives null to status.
> > > > 
> > > > Same problem likes below:
> > > > 
> > > > 
> > > > @@ -3776,7 +3773,7 @@ _get_os_name()
> > > >                  echo 'linux'
> > > >          else
> > > >                  echo Unknown operating system: `uname`
> > > > -               exit
> > > > +               _exit
> > > > 
> > > > 
> > > > The "_exit" without argument looks not make sense.
> > > > 
> > > That's right. _exit called with no argument could make status as null.
> > Yes, that is correct.
> > > To prevent such misuse in future, should we add a warning/echo message
> > 
> > Yeah, the other thing that we can do is 'status=${1:-0}'. In that case, for
>                                            ^^^^^^^^^^^^^^
> That's good to me, I'm just wondering if the default value should be "1", to
> tell us "hey, there's an unknown exit status" :)

I think status=1 usually means failure...

/usr/include/stdlib.h:92:#define        EXIT_FAILURE    1       /* Failing exit status.  */
/usr/include/stdlib.h:93:#define        EXIT_SUCCESS    0       /* Successful exit status.  */

--D

> Thanks,
> Zorro
> 
> > cases where the return value is a success, we simply use "_exit". Which one
> > do you think adds more value and flexibility to the usage?
> > 
> > --NR
> > 
> > > if the no. of arguments passed to _exit() is not 1?
> > > 
> > > -ritesh
> > 
> > -- 
> > Nirjhar Roy
> > Linux Kernel Developer
> > IBM, Bangalore
> > 
> 
> 

