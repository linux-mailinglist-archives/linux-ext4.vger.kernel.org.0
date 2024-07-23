Return-Path: <linux-ext4+bounces-3396-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED4F93A9CE
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 01:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9FC2855F3
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 23:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EC01494D0;
	Tue, 23 Jul 2024 23:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="ip+MaP9P"
X-Original-To: linux-ext4@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC0143747;
	Tue, 23 Jul 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721777106; cv=none; b=f6juOuYXQLXcV6YqRyU6xEh9SUMOgPX/KXhuB8YTin8RYDc+98pHew3PDgiGNkU+bUM4HpaRZASBu4FDD7uDAk1QUR0Ab5HZbFBS+jC4DilNflQZf67IcqA65xjn/Jw90oOXjK0ur73igDs2tKXVQU9+J2oDVrBAd7cHy/sKncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721777106; c=relaxed/simple;
	bh=yc6kIr7ZrHuqjN4tIM5lkAFxFYTYQ3ntL2QfI194z3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mLXyF0Dr+Ssl18ak18u2gZLTsFBRE7LpIfaR6ht/If7+8+RvnH8XAGiE7zJSaY47jUnawbjFmyqcqiuYuL+I3vNvI/FVjw5Iww6KTDDIpsHh+mfWqqym1kqT1DckE3XTxfJE1B2n0kga1gB4RE+y7jw436EWEzZ7oT2IPNX0pec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=ip+MaP9P; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1137BC0005;
	Tue, 23 Jul 2024 23:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1721777096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FlxbZNSOyl5pTp7K6H99DbR/f/WeDANfLj0x7H2aP+o=;
	b=ip+MaP9PNnQTmta14XJsFntRzyHt1qoERb2H0WUM2+zk6JgpYXG+HDiCkxwls7TRHLjQna
	Yze/ayaFLNJs2EvQoyr+ckzewEN8xfcMHUJJ5H7838Hbc5NITB3w7CEfdFFezwsBln3t2u
	gFyHyGrKuzt5mmxcziSuN42sVWADvHskm7a71mhHLfTMQBVhN/pys+rOonoXPzkqy8a5+I
	IGm+GIR8dJPuKubl4vKnnlKi1LnWOTLpYjrKHVi3GWFY8sOBW5bSF0OErg3IJyg7/0awDP
	l0nMPw5B0DkKZjxA+rj5yd2LyRMbRtYDxToRjZ/RRcSnaORKyUMB+vbFTaPyEA==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: cel@kernel.org
Cc: amir73il@gmail.com,  gregkh@linuxfoundation.org,  jack@suse.cz,
  sashal@kernel.org,  stable@vger.kernel.org,  adilger.kernel@dilger.ca,
  linux-ext4@vger.kernel.org,  tytso@mit.edu,
  alexey.makhalov@broadcom.com,  vasavi.sirnapalli@broadcom.com,
  florian.fainelli@broadcom.com,  Chuck Lever <chuck.lever@oracle.com>,
  Gabriel Krisman Bertazi <gabriel@krisman.be>
Subject: Re: [PATCH v5.15.y] Revert "fanotify: Allow users to request
 FAN_FS_ERROR events"
In-Reply-To: <20240723214246.4010-1-cel@kernel.org> (cel@kernel.org's message
	of "Tue, 23 Jul 2024 17:42:46 -0400")
References: <875xswtbxb.fsf@mailhost.krisman.be>
	<20240723214246.4010-1-cel@kernel.org>
Date: Tue, 23 Jul 2024 19:24:47 -0400
Message-ID: <87jzhbsncw.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be

cel@kernel.org writes:

> From: Chuck Lever <chuck.lever@oracle.com>
>
> Gabriel says:
>> 9709bd548f11 just enabled a new feature -
>> which seems against stable rules.  Considering that "anything is
>> a CVE", we really need to be cautious about this kind of stuff in
>> stable kernels.
>>
>> Is it possible to drop 9709bd548f11 from stable instead?
>
> The revert wasn't clean, but adjusting it to fit was straightforward.
> This passes NFSD CI, and adds no new failures to the fanotify ltp
> tests.
>
> Reported-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 4 ----
>  include/linux/fanotify.h           | 6 +-----
>  2 files changed, 1 insertion(+), 9 deletions(-)
>
> Gabriel, is this what you were thinking?

Thanks Chuck.

This looks good to me as a way to disable it in stable and prevent
userspace from trying to use it. Up to fanotify maintainers to decide
whether to brign the rest of the series or merge this, but either way:

Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>


>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index d93418f21386..0d91db1c7249 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1701,10 +1701,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	    group->priority == FS_PRIO_0)
>  		goto fput_and_out;
>  
> -	if (mask & FAN_FS_ERROR &&
> -	    mark_type != FAN_MARK_FILESYSTEM)
> -		goto fput_and_out;
> -
>  	/*
>  	 * Evictable is only relevant for inode marks, because only inode object
>  	 * can be evicted on memory pressure.
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 558844c8d259..df60b46971c9 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -97,13 +97,9 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
>  #define FANOTIFY_INODE_EVENTS	(FANOTIFY_DIRENT_EVENTS | \
>  				 FAN_ATTRIB | FAN_MOVE_SELF | FAN_DELETE_SELF)
>  
> -/* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR */
> -#define FANOTIFY_ERROR_EVENTS	(FAN_FS_ERROR)
> -
>  /* Events that user can request to be notified on */
>  #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
> -				 FANOTIFY_INODE_EVENTS | \
> -				 FANOTIFY_ERROR_EVENTS)
> +				 FANOTIFY_INODE_EVENTS)
>  
>  /* Events that require a permission response from user */
>  #define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \

-- 
Gabriel Krisman Bertazi

