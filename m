Return-Path: <linux-ext4+bounces-3375-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1A5939EF3
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 12:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194E41C21E0C
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 10:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA9414EC5E;
	Tue, 23 Jul 2024 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X/xbuG65";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sb4s2uVi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X/xbuG65";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sb4s2uVi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA613B2AF;
	Tue, 23 Jul 2024 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721731637; cv=none; b=Y3av4omkvhc+IINthx3kihUZPeiwHEs11emS4V0NltLjj41vm2j6fAtA6EutvI/o/gEc3sm4431LH0sXcAMv+x+MVGmTtNyiB06HK/i1Hroqeyh2hObZX6inlCslyhVaGRkiinodf/5xBOwokmIYtYQTuARCvAXKcg3+ZbJMnoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721731637; c=relaxed/simple;
	bh=Yj4tb/3k5GXBa3+fHTMsc6XHu9LqJ8DCAUldYTN11B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTvGMC3qOpLGcfOmv0jT7vUmYlyNwXpX8Wy8l81K2AT0GR6CmRfscKW6h5DAsBFoi1XUeuFPWZb3zf1DE5b3IbjKEUdZmGKtwlzT0YmVvimjcsvFBXCJ9g9Y9j+V+nWqFSuKEvZElO8uzLtVTVgVrJFdndsQT3jJtD8EvmnnNzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X/xbuG65; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sb4s2uVi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X/xbuG65; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sb4s2uVi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 994A621295;
	Tue, 23 Jul 2024 10:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721731633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MLuvFG9mhYANfvb3ikL7BM8asARlH3wBAQkedE8Wp0=;
	b=X/xbuG65Tz1uj1jkOawoiGIl2V18BYj0j4UHsdS1KstbdT3flWNVRIzQsUO/29GwMD9HRC
	bhPvB7nKFZZTjFajTZ2RNsCOXJSCVEOHCeSD+bNPhTKqQSHP4dFHW5TQvWm7WpEoIJfWld
	WlleAov71ma2sBibku6aPfITgFno7fQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721731633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MLuvFG9mhYANfvb3ikL7BM8asARlH3wBAQkedE8Wp0=;
	b=Sb4s2uVi3krIFKbarIl0DZKnEFpeIFPiOs/+JMxKB6dpo7GPqpz9Bcj6QWCOHAj7rIA32Z
	TwAcda4nFF1wBkAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="X/xbuG65";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Sb4s2uVi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721731633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MLuvFG9mhYANfvb3ikL7BM8asARlH3wBAQkedE8Wp0=;
	b=X/xbuG65Tz1uj1jkOawoiGIl2V18BYj0j4UHsdS1KstbdT3flWNVRIzQsUO/29GwMD9HRC
	bhPvB7nKFZZTjFajTZ2RNsCOXJSCVEOHCeSD+bNPhTKqQSHP4dFHW5TQvWm7WpEoIJfWld
	WlleAov71ma2sBibku6aPfITgFno7fQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721731633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MLuvFG9mhYANfvb3ikL7BM8asARlH3wBAQkedE8Wp0=;
	b=Sb4s2uVi3krIFKbarIl0DZKnEFpeIFPiOs/+JMxKB6dpo7GPqpz9Bcj6QWCOHAj7rIA32Z
	TwAcda4nFF1wBkAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52C0F13874;
	Tue, 23 Jul 2024 10:47:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 97mEEzGKn2aZEwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jul 2024 10:47:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D40D7A08BD; Tue, 23 Jul 2024 12:47:04 +0200 (CEST)
Date: Tue, 23 Jul 2024 12:47:04 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Ajay Kaher <ajay.kaher@broadcom.com>,
	gregkh@linuxfoundation.org, chuck.lever@oracle.com,
	krisman@collabora.com, patches@lists.linux.dev, sashal@kernel.org,
	stable@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, tytso@mit.edu,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH 5.10 387/770] fanotify: Allow users to request
 FAN_FS_ERROR events
Message-ID: <20240723104704.cqhqkkvslojg77x7@quack3>
References: <20240618123422.213844892@linuxfoundation.org>
 <1721718387-9038-1-git-send-email-ajay.kaher@broadcom.com>
 <20240723092916.gtpvnifv2rizbyii@quack3>
 <CAOQ4uxjGrPbq8=znBSV8i79Kj2Or4p5O5BZ0+RL1oXbxxNu3rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjGrPbq8=znBSV8i79Kj2Or4p5O5BZ0+RL1oXbxxNu3rw@mail.gmail.com>
X-Spam-Score: -3.81
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 994A621295
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Flag: NO

On Tue 23-07-24 13:13:41, Amir Goldstein wrote:
> On Tue, Jul 23, 2024 at 12:29 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 23-07-24 12:36:27, Ajay Kaher wrote:
> > > > [ Upstream commit 9709bd548f11a092d124698118013f66e1740f9b ]
> > > >
> > > > Wire up the FAN_FS_ERROR event in the fanotify_mark syscall, allowing
> > > > user space to request the monitoring of FAN_FS_ERROR events.
> > > >
> > > > These events are limited to filesystem marks, so check it is the
> > > > case in the syscall handler.
> > >
> > > Greg,
> > >
> > > Without 9709bd548f11 in v5.10.y skips LTP fanotify22 test case, as:
> > > fanotify22.c:312: TCONF: FAN_FS_ERROR not supported in kernel
> > >
> > > With 9709bd548f11 in v5.10.220, LTP fanotify22 is failing because of
> > > timeout as no notification. To fix need to merge following two upstream
> > > commit to v5.10:
> > >
> > > 124e7c61deb27d758df5ec0521c36cf08d417f7a:
> > > 0001-ext4_fix_error_code_saved_on_super_block_during_file_system.patch
> > > https://lore.kernel.org/stable/1721717240-8786-1-git-send-email-ajay.kaher@broadcom.com/T/#mf76930487697d8c1383ed5d21678fe504e8e2305
> > >
> > > 9a089b21f79b47eed240d4da7ea0d049de7c9b4d:
> > > 0001-ext4_Send_notifications_on_error.patch
> > > Link: https://lore.kernel.org/stable/1721717240-8786-1-git-send-email-ajay.kaher@broadcom.com/T/#md1be98e0ecafe4f92d7b61c048e15bcf286cbd53
> >
> > I know Chuck has been backporting the huge pile of fsnotify changes for
> > stable and he was running LTP so I'm a bit curious if he saw the fanotify22
> > failure as well. The reason for the test failure seems to be that the
> > combination of features now present in stable has never been upstream which
> > confuses the test. As such I'm not sure if backporting more features to
> > stable is warranted just to fix a broken LTP test... But given the huge
> > pile Chuck has backported already I'm not strongly opposed to backporting a
> > few more, there's just a question where does this stop :)
> 
> I'm not sure is it exactly "more features".  The fanotify patches and
> ext4 patches that use them where merges as a feature together.
> 
> IOW, FAN_FS_ERROR was merged with support for a single fs (ext4)
> it would be weird to backport the feature with support for zero fs.
> Also, 5.15.y already has the ext4 patches - not sure why 5.10.y didn't get them.

I forgot 5.15.y got all the patches. Ok, then pushing them to 5.10.y makes
sense as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

