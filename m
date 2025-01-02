Return-Path: <linux-ext4+bounces-5865-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95B49FFB42
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jan 2025 16:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3FE162A10
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jan 2025 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5C61B3956;
	Thu,  2 Jan 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oSYSKiBu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+UBdp4yy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mKZF8lqD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Aw2tHFwA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A801B0F32
	for <linux-ext4@vger.kernel.org>; Thu,  2 Jan 2025 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735833506; cv=none; b=Y2I8CJAAlX3p123PHui7vFDjAhb2+UWhvHKH1peoiuAtUrm2ds57ipkOqsIyMIc9qtdFWaDsmFnjr3eXQ+yssikWniM6gdaMXwKE3a3bDEMMqvIyJwAokF9KXLYhGMdqytQgPO1jt+LEKXDSUeZd7pOewVQ5TlMzn/Z58Pisyqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735833506; c=relaxed/simple;
	bh=vukdyihwUS+3PFWLmUOg1J5pvlrkeOydq4ySJWXu9jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeNQEzigG5TWuVsD0gLoXrzcSzxHcw4lhb5s1wvWbJ0vnsvsJGgiUUkO3YejFUWfLms0X40d2+o5WXdxPHVO5ie3ZycjbSoqtzDpipPr1ZnWCjivld2rZ5sWCAwbJx7fn8rRa+pSLb22nwcRnnr/m235sDFK4FrwRsjZpwTfRDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oSYSKiBu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+UBdp4yy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mKZF8lqD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Aw2tHFwA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A8C9A1F38E;
	Thu,  2 Jan 2025 15:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735833503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6WkPDFtHoWl8GEh0TSvPW0qq4g4X2jytSiOihn+685A=;
	b=oSYSKiBuoE618iFy3R6LOV+RiP1hYmFaAEgJcAHLOe481ILE3bZCqJizaYmf94qy3Zx9n0
	aOwdsvBfzkiJaji8xKAfApO7di+tT8MhnoZwdZlvGP/Bnkk7J2H/OB6KZI9RDhkyo6SCQj
	KwqIPz7spnOxgEhL8SSeQZM+JM6+UmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735833503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6WkPDFtHoWl8GEh0TSvPW0qq4g4X2jytSiOihn+685A=;
	b=+UBdp4yylqUfrhWoje1+LbwYZZ6xGDVqPyo+M4cOGCkVQSo/lqYFuKD7jAUj6ls8GeE4HQ
	GR1qsD/W2Pzwx0Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mKZF8lqD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Aw2tHFwA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735833502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6WkPDFtHoWl8GEh0TSvPW0qq4g4X2jytSiOihn+685A=;
	b=mKZF8lqDIFlzVrN6ULMyR7ztp/LypKq1abu/+Dg7JC597Cdwq9M57aCm3ImMAXpbIgvIfv
	FNOUmBzkUwyVlF0ECCHlrzIKLy+HrLI9Mx+GyapHtedvfV/WBs+CCSqXCe498KhRPBhXfz
	D6sefY6Jh0dEc9ckgy/wdxBZiRMkOSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735833502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6WkPDFtHoWl8GEh0TSvPW0qq4g4X2jytSiOihn+685A=;
	b=Aw2tHFwAV/N2nkwEvMEJ89H7xHXLBL0mgaB9fPpd/3NrpNFn30v84nXpTGA0ic5pXxr56Z
	llN2JzgL1qQgmaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D0A7132EA;
	Thu,  2 Jan 2025 15:58:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GDQfIp63dmfxKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 02 Jan 2025 15:58:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 14720A0956; Thu,  2 Jan 2025 16:58:14 +0100 (CET)
Date: Thu, 2 Jan 2025 16:58:14 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, 
	Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	sunyongjian1@huawei.com, Yang Erkun <yangerkun@huawei.com>
Subject: Re: [BUG REPORT] ext4: =?utf-8?B?4oCcZXJyb3JzPXJlbW91bnQtcm/igJ0g?=
 =?utf-8?B?aGFzIGJlY29tZSDigJxlcnJvcnM9c2h1dGRvd27igJ0/?=
Message-ID: <z52ea53du2k66du24ju4yetqm72e6pvtcbwkrjf4oomw2feffq@355vymdndrxn>
References: <22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com>
X-Rspamd-Queue-Id: A8C9A1F38E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Mon 30-12-24 15:27:01, Baokun Li wrote:
> After commit d3476f3dad4a (“ext4: don't set SB_RDONLY after filesystem
> errors”) in v6.12-rc1, the “errors=remount-ro” mode no longer sets
> SB_RDONLY on errors, which results in us seeing the filesystem is still
> in rw state after errors. The issue fixed by this patch is reported as
> CVE-2024-50191.
> 
> https://lore.kernel.org/all/2024110851-CVE-2024-50191-f31c@gregkh/
> 
> This has actually changed the remount-ro semantics. We have some fault
> injection test cases where we unmount the filesystem after detecting
> a ro state and then check for consistency. Our customer has a similar
> scenario. In "errors=remount-ro" mode, some operations are performed
> after the file system becomes read-only.

I'm sorry to hear that your fault injection has been broken by my changes.

> We reported similar issues to the community in 2020,
> https://lore.kernel.org/all/20210104160457.GG4018@quack2.suse.cz/
> Jan Kara provides a simple and effective patch. This patch somehow
> didn't end up merged into upstream, but this patch has been merged into
> our internal version for a couple years now and it works fine, is it
> possible to revert the patch that no longer sets SB_RDONLY and use
> the patch in the link above?

Well, the problem with filesystem freezing was just the immediate trigger
for the changes. But the setting of SB_RDONLY bit by ext4 behind the VFS'
back (as VFS is generally in charge of manipulating that bit and you must
hold s_umount for that which we cannot get in ext4 when handling errors)
was always problematic and I'm almost sure syzbot would find more problems
with that than just fs freezing. As such I don't think we should really
return to doing that in ext4 but we need to find other ways how to make
your error injection to work...

> What's worse is that after commit
>   95257987a638 ("ext4: drop EXT4_MF_FS_ABORTED flag")
> was merged in v6.6-rc1, the EXT4_FLAGS_SHUTDOWN bit is set in
> ext4_handle_error(). This causes the file system to not be read-only
> when an error is triggered in "errors=remount-ro" mode, because
> EXT4_FLAGS_SHUTDOWN prevents both writing and reading.

Here I don't understand what is really the problem with EXT4_MF_FS_ABORTED
removal. What do you exactly mean by "causes the file system to not be
read-only"? We still return EROFS where we used to, we disallow writing as
we used to. Can you perhaps give an example what changed with this commit?

> I'm not sure
> if this is the intended behavior. But if the intention is to shut down
> the file system upon an error, I feel it would be better to add an
> "errors=shutdown" option.

The point was not really to create new "errors=" mode but rather implement
the "don't modify the filesystem after we spot error" behavior without
touching the SB_RDONLY flag.

So how does your framework detect that the filesystem has failed with
errors=remount-ro? By parsing /proc/mounts or otherwise querying current
filesystem mount options? Would it be acceptable for you to look at some
other mount option (e.g. "shutdown") to detect that state? We could easily
implement that.

I'm sorry again for causing you trouble.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

