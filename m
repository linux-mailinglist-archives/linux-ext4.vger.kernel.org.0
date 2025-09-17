Return-Path: <linux-ext4+bounces-10232-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4E5B80CEF
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 17:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A53C67BA042
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9802F83B3;
	Wed, 17 Sep 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yejESO9h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FaF0So9j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yejESO9h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FaF0So9j"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF71341348
	for <linux-ext4@vger.kernel.org>; Wed, 17 Sep 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124728; cv=none; b=BuVTC/qxXYbY5Ww7gKF45mEeKKawxMLCH0QSs7JYkWUGjtzRtHbTqUjgCqJa4+wETqlGq94plFzJogtccq73+Ca5DjAuvYd1bmro2hlYhkRrI60BVVcmrmfL85eXe6PgJnzcMiSG94xKWmQKX54jVt8HJMpThTikuuewWvkdK6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124728; c=relaxed/simple;
	bh=hXotjRyyuTCECr1G/Kwj3aQ5gjzIbBnpLtrMa+laGLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLdwdkAoM3gnhWXb9XPM9WpQFb6vVYXd9e6WYMkh+Kh/YQI+RgWC9ZglqLr5+5NlWBDz+WnLKwttKHTwdd1HdDglw82XnNomCYnbbeqdu5DWBbv15qvpqqRb/xxgzTvsZhgxNJaY8dOS5ezVSsGSCHiUdQ8iQlu6pCjDyerylF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yejESO9h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FaF0So9j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yejESO9h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FaF0So9j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D9A9B20B27;
	Wed, 17 Sep 2025 15:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758124724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0zHdnAZCem9ktLgqq9emXhSsqZhBkYJHzyWxXEfvRk=;
	b=yejESO9hiUQ/aeRCZ/Xa5g7Bd+ojmKMum6A9uSQH9YmRDq71sqZ960iXq3QFADVpKxhBAk
	8fZyye8qgIR77gsyWYSpen5NHVG8mnxBOLq0aQn2OtgpleGUxvzKkYl869EubTmVn5wJ2V
	CZNNdNZ6tZYhQT+/sVEsGintXOX2ZoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758124724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0zHdnAZCem9ktLgqq9emXhSsqZhBkYJHzyWxXEfvRk=;
	b=FaF0So9jsXlfxBPcIZW1bU+tpJ1TPicOhWHXYg6AglxIIk6vZUWIv9EKaWLGuw+6oXvvYp
	dpiOZm7Grfo0xyCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yejESO9h;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FaF0So9j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758124724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0zHdnAZCem9ktLgqq9emXhSsqZhBkYJHzyWxXEfvRk=;
	b=yejESO9hiUQ/aeRCZ/Xa5g7Bd+ojmKMum6A9uSQH9YmRDq71sqZ960iXq3QFADVpKxhBAk
	8fZyye8qgIR77gsyWYSpen5NHVG8mnxBOLq0aQn2OtgpleGUxvzKkYl869EubTmVn5wJ2V
	CZNNdNZ6tZYhQT+/sVEsGintXOX2ZoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758124724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0zHdnAZCem9ktLgqq9emXhSsqZhBkYJHzyWxXEfvRk=;
	b=FaF0So9jsXlfxBPcIZW1bU+tpJ1TPicOhWHXYg6AglxIIk6vZUWIv9EKaWLGuw+6oXvvYp
	dpiOZm7Grfo0xyCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE97B137C3;
	Wed, 17 Sep 2025 15:58:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6WWCLrTaymh7KAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Sep 2025 15:58:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E828FA083B; Wed, 17 Sep 2025 17:58:43 +0200 (CEST)
Date: Wed, 17 Sep 2025 17:58:43 +0200
From: Jan Kara <jack@suse.cz>
To: "Richter, Rafael" <rafael.richter.extern@gin.de>
Cc: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: ext4: slow unmount with large clean page cache; =?utf-8?Q?is_?=
 =?utf-8?Q?fsfreeze=E2=86=92umount?= recommended?
Message-ID: <db7ikfrvqkz6ovmpsaahkwozdizeq34ev6nhnxaldwlhbklx7x@vxl5e6hu2c6e>
References: <5008ea1dfc7a49babd670e94ce5dbda7@gin.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5008ea1dfc7a49babd670e94ce5dbda7@gin.de>
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D9A9B20B27
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Hi!

On Fri 12-09-25 14:20:13, Richter, Rafael wrote:
> we consistently see slow unmounts (~6–8s) on ext4 after heavy buffered writes
> (e.g., dd ~30 GiB) that grow the page cache. Same test on XFS unmounts <1s on
> the same hardware, but we must stay on ext4.
> 
> Env:
>   - Kernel: 6.6.36 (Yocto-based)
>   - Device: SSD via mdraid (/dev/md0p1)
>   - Mount: ext4 on /mnt/disk (defaults)
> 
> Repro:
>   dd if=/dev/zero of=/mnt/disk/big.bin bs=1M count=30720 status=progress
>   sync -f /mnt/disk
>   time umount /mnt/disk      # ext4: ~6–8s

Yes. This is because with this kernel version XFS uses large folios (upto
2MB in size) while ext4 uses only 4k folios for the page cache. And
evicting that many folios in ext4 takes time. Large folio support has been
added to ext4 recently (6.16?) so with that you should see similar umount
times again.

> Observations:
>   - Dirty/Writeback are ~0 before unmount.
>   - `fsfreeze -f /mnt/disk` immediately before `umount` makes unmount very fast.
>   - `mount -o remount,ro` before `umount` does NOT improve unmount time.

Well, this is definitely not recommended. fsfreeze -f will acquire
superblock reference which means that the filesystem actually stays mounted
in the background after umount until you unfreeze it (for which you need to
mount it again ;)). That's a bit of a catch with fsfreeze.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

