Return-Path: <linux-ext4+bounces-13706-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jILBCYgAlGmx+QEAu9opvQ
	(envelope-from <linux-ext4+bounces-13706-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Feb 2026 06:45:44 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB2C148DAD
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Feb 2026 06:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF3AC300751B
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Feb 2026 05:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432A9248F68;
	Tue, 17 Feb 2026 05:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqkdIcaJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73A6A937
	for <linux-ext4@vger.kernel.org>; Tue, 17 Feb 2026 05:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771307138; cv=none; b=AZzStApF0RmFH7SJiS9oLN+Cn92E8n4PNkH/3c/sra1YrfzDI1wPBB7nwKPGLYHk2CB0XB4OwDz2obByTOeKfiFde/0ZADyhJfrQcTIhe4p1y7wk2Phwy/vngl0omrvAtNNlISPT5dV9sgeipIa9D3Ne/n0aUC0J5UdRTkZgGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771307138; c=relaxed/simple;
	bh=jhGdwNsmQNh88TJ5n6chB7GnJrMG/97Da8n6+U/tl5Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=f9mqSSh21pMDrTy0NnGWPIOT1RFK44V4UP1lCO2GB2H33BxVuOfi9yv5PG1aSMX9k7gD++n/WwbzYd4A7RdXnykdHK3v6q8bSC+TYtKOkIHFDKbi8/2utKShGIlhOqPMKUAuC+QBGOzpp7E8Ly5WLwU4+H+5mvIYYqTUD29oOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqkdIcaJ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c6e1a67d4b8so2257609a12.0
        for <linux-ext4@vger.kernel.org>; Mon, 16 Feb 2026 21:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771307137; x=1771911937; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8mBKuQauHFi3JaxfrPkRH0QQ8Yp3uglFsYwwUmXybjw=;
        b=YqkdIcaJeklIO4zuYVt3IGb1iB498DOsdp5hN9ABHueGEPAehj/XqJ0VuDS9IG4ouO
         vgo3cSObOubhC1lfynwwDhjXpqXdp+YIomWAPAtQcHBvbos+TErjRReDtN9NTMrwnVN0
         QqaCGARsMrARhzynv+NeU6Cbc33pQt4DeXPWWntpZOGe7WVS3KWTwvLf54pZOYcSrLsi
         erfCOR/ex1lIJQiD9crbc0ycKJBTCAzdShe/uNKceEunP7HtOjN8d/K3Qzek3nThbuv+
         14wii2Jqy60QujtZoa53t4wNGpHzJ+Igbtgdee0fNbGcmXTd1720mdGjZvoKPldC0kjq
         lfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771307137; x=1771911937;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8mBKuQauHFi3JaxfrPkRH0QQ8Yp3uglFsYwwUmXybjw=;
        b=t/Y/Mu7xH/mp0xMmd5XjJjRL+iuEMwRkadAtvFbH/c0mMQtOjY5bZSd+FuHQA9tDtA
         v+dVqqZmYmFBGMJqFkb8HS1nBYHUsVF/Y0wBxmGVT34czFci/s8/Kf53awTnhIVOK9dO
         bPvUgCnramkDIHTfjaCkHiZ8tqtSWgr3bw9gLgTJGdzaisM3ccHXNpQAlxld0wDRepl/
         Otq//zv2A/Y9mjeft1h6DSg4aH8OnJZggdB6bf/PzxInEIMjeCkdw8n3kiZmk/dDRWXy
         gvikbEP+O6s0uLTom+mVdl2Dt9/1F8ZLRDt1QJiOhZdgybQlIO3hM1naa8alQM/GpG3K
         /s/g==
X-Forwarded-Encrypted: i=1; AJvYcCUDTkh+vdes49M6A6odzcGd5CjSXedx+6jTTWUeKmVi0geI4FQ5lBlgHDbfTXLOClxNUsUXzqd+YSZL@vger.kernel.org
X-Gm-Message-State: AOJu0YxyKvHEWXNPtsn2PxMpxj/oEaAkn/xzq0gJB1cHSSIxRgzgWgnH
	AQ2pManq72LD9ds07sa2NxUDscZ6ylHw6DFaeBpDKfMVILhoPtueFqUN
X-Gm-Gg: AZuq6aIRzijAl69cWXKckDy2nQtgzlt5nRIH+g35AAMN+coI8Y4T79AaL/atWLAzKS/
	sdZV+xSAqKN3OJKaj8vuEUJzHhE+Cr8SHgD/eM6ibp+ZtEtxvBECQFpRB1X6eVIT5f4ovnwrzlu
	FZvWBcQCNyyV1ZYpo10kZMskolWG4htxpEK3gpD1+86l8jPUfva+gD6mM+tXIdcoja8XH6PYdmx
	uwIaw8Nyb0AtKbUowqgHslkjG84wVYImjtkeIzT77lMhOP55XsY+2yEesu01OaXddfwpJf0KQ+E
	7wAHvmqdxoLYAyFEjct1ADP5sLsM/TDLgAcvvTDfDv9QmGVJJkdN5RezVVV5fKY7lNKXI15bBQ6
	uCByfRxC/qEm0q9ZrTRp3ocH3jnKQgmOK+rh1rlbMx/JxGkmHsVbDX8S8dQGyIJNVYl9opXv7hj
	QeQk4DLtJH93nCS2cl
X-Received: by 2002:a17:90b:1fcf:b0:356:41c2:897d with SMTP id 98e67ed59e1d1-356aaa7623amr12372868a91.8.1771307137159;
        Mon, 16 Feb 2026 21:45:37 -0800 (PST)
Received: from dw-tp ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356a8869539sm5647437a91.12.2026.02.16.21.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 21:45:36 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] ext4: Minor fix for ext4_split_extent_zeroout()
In-Reply-To: <20260206155821.2869356-1-ojaswin@linux.ibm.com>
Date: Tue, 17 Feb 2026 11:03:53 +0530
Message-ID: <87tsvg7x32.ritesh.list@gmail.com>
References: <20260206155821.2869356-1-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13706-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: AEB2C148DAD
X-Rspamd-Action: no action

Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:

> We missed storing the error which triggerd smatch warning:
>
> 	fs/ext4/extents.c:3369 ext4_split_extent_zeroout()
> 	warn: duplicate zero check 'err' (previous on line 3363)
>
> fs/ext4/extents.c
>     3361
>     3362         err = ext4_ext_get_access(handle, inode, path + depth);
>     3363         if (err)
>     3364                 return err;
>     3365
>     3366         ext4_ext_mark_initialized(ex);
>     3367
>     3368         ext4_ext_dirty(handle, inode, path + depth);
> --> 3369         if (err)
>     3370                 return err;
>     3371
>     3372         return 0;
>     3373 }
>
> Fix it by correctly storing the err value from ext4_ext_dirty().
>


Looks straight forward.


> Link: https://lore.kernel.org/all/aYXvVgPnKltX79KE@stanley.mountain/
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Fixes: a985e07c26455 ("ext4: refactor zeroout path and handle all cases")

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> ---
>  fs/ext4/extents.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 3630b27e4fd7..5579e0e68c0f 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3365,7 +3365,7 @@ static int ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
>  
>  	ext4_ext_mark_initialized(ex);
>  
> -	ext4_ext_dirty(handle, inode, path + depth);
> +	err = ext4_ext_dirty(handle, inode, path + depth);
>  	if (err)
>  		return err;
>  
> -- 
> 2.52.0

