Return-Path: <linux-ext4+bounces-3371-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B926C939DD1
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 11:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40479283B7A
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 09:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F9014EC65;
	Tue, 23 Jul 2024 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ef/zH1Ya";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b9MLnql7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ef/zH1Ya";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b9MLnql7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774DD14D2BD;
	Tue, 23 Jul 2024 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726964; cv=none; b=jqkleEwjtLYMnssUFmVkIYiXkviE54gCYGKVxRv5DaUKO5IIucYKOMpvA7ZkqZMaALuwAqYJwmzGIn2vCjkSm4JRf5YozagTalYyjB4GH1SBmKM/42u+qkN90Mthz31fDntz15rjb2BTODYPWQAFMJStLSOXyJvHZmBjQQGbOsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726964; c=relaxed/simple;
	bh=iREJ5hETH4iOLpnSo4JBd93xj0uCQ+zee5hAXGztr6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbYkGGA6CzG+dx/McWovgKiiVF++clx7yWHEoUoIqmt4g6e1LHz8qHrFxm3eJcmnh0d+faOIpZ4w09MDO3tqkI5d4NT02v+bhL8gF5miEAEbVLA2e8WAFXWJk1/PUONvS2kEW+yYduxY/vxnUj5WpMh1EPp8IWGszPwDx14uIgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ef/zH1Ya; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b9MLnql7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ef/zH1Ya; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b9MLnql7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1E03218EC;
	Tue, 23 Jul 2024 09:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721726960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ArijaW9b6KicSHPt37A2ErQiZIilMSnhCUiCGMlxGSQ=;
	b=ef/zH1YaWpIoSn2o1YI1id3po0hJj/vp3iVSYF+i3GimazkTLe6Oc3EaOz2RgXWt3htysO
	e+QKeIu+38RKmPM0Yj1G3utdSZTxoCgR5h5tuZOcbGGId8FMbkf1Bdhd5Ju2Em5c0ctWgV
	USoB0LxjGOn0yOSIueLUmuJwMiAYcL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721726960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ArijaW9b6KicSHPt37A2ErQiZIilMSnhCUiCGMlxGSQ=;
	b=b9MLnql7CY2jDPtfIIixkzsRtUHw0yY5IyNgOcmf+NEawg25wRm1fRLx7W715owFNndHwM
	43l89uZi9dOsZeDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721726960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ArijaW9b6KicSHPt37A2ErQiZIilMSnhCUiCGMlxGSQ=;
	b=ef/zH1YaWpIoSn2o1YI1id3po0hJj/vp3iVSYF+i3GimazkTLe6Oc3EaOz2RgXWt3htysO
	e+QKeIu+38RKmPM0Yj1G3utdSZTxoCgR5h5tuZOcbGGId8FMbkf1Bdhd5Ju2Em5c0ctWgV
	USoB0LxjGOn0yOSIueLUmuJwMiAYcL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721726960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ArijaW9b6KicSHPt37A2ErQiZIilMSnhCUiCGMlxGSQ=;
	b=b9MLnql7CY2jDPtfIIixkzsRtUHw0yY5IyNgOcmf+NEawg25wRm1fRLx7W715owFNndHwM
	43l89uZi9dOsZeDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B366113874;
	Tue, 23 Jul 2024 09:29:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W8PDK/B3n2auegAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jul 2024 09:29:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 697F9A08BD; Tue, 23 Jul 2024 11:29:16 +0200 (CEST)
Date: Tue, 23 Jul 2024 11:29:16 +0200
From: Jan Kara <jack@suse.cz>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: gregkh@linuxfoundation.org, amir73il@gmail.com, chuck.lever@oracle.com,
	jack@suse.cz, krisman@collabora.com, patches@lists.linux.dev,
	sashal@kernel.org, stable@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, tytso@mit.edu,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH 5.10 387/770] fanotify: Allow users to request
 FAN_FS_ERROR events
Message-ID: <20240723092916.gtpvnifv2rizbyii@quack3>
References: <20240618123422.213844892@linuxfoundation.org>
 <1721718387-9038-1-git-send-email-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721718387-9038-1-git-send-email-ajay.kaher@broadcom.com>
X-Spam-Score: -0.60
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.60 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,oracle.com,suse.cz,collabora.com,lists.linux.dev,kernel.org,vger.kernel.org,dilger.ca,mit.edu,broadcom.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 

On Tue 23-07-24 12:36:27, Ajay Kaher wrote:
> > [ Upstream commit 9709bd548f11a092d124698118013f66e1740f9b ]
> > 
> > Wire up the FAN_FS_ERROR event in the fanotify_mark syscall, allowing
> > user space to request the monitoring of FAN_FS_ERROR events.
> > 
> > These events are limited to filesystem marks, so check it is the
> > case in the syscall handler.
> 
> Greg,
> 
> Without 9709bd548f11 in v5.10.y skips LTP fanotify22 test case, as: 
> fanotify22.c:312: TCONF: FAN_FS_ERROR not supported in kernel
> 
> With 9709bd548f11 in v5.10.220, LTP fanotify22 is failing because of
> timeout as no notification. To fix need to merge following two upstream
> commit to v5.10:
> 
> 124e7c61deb27d758df5ec0521c36cf08d417f7a:
> 0001-ext4_fix_error_code_saved_on_super_block_during_file_system.patch
> https://lore.kernel.org/stable/1721717240-8786-1-git-send-email-ajay.kaher@broadcom.com/T/#mf76930487697d8c1383ed5d21678fe504e8e2305
> 
> 9a089b21f79b47eed240d4da7ea0d049de7c9b4d:
> 0001-ext4_Send_notifications_on_error.patch
> Link: https://lore.kernel.org/stable/1721717240-8786-1-git-send-email-ajay.kaher@broadcom.com/T/#md1be98e0ecafe4f92d7b61c048e15bcf286cbd53 

I know Chuck has been backporting the huge pile of fsnotify changes for
stable and he was running LTP so I'm a bit curious if he saw the fanotify22
failure as well. The reason for the test failure seems to be that the
combination of features now present in stable has never been upstream which
confuses the test. As such I'm not sure if backporting more features to
stable is warranted just to fix a broken LTP test... But given the huge
pile Chuck has backported already I'm not strongly opposed to backporting a
few more, there's just a question where does this stop :)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

