Return-Path: <linux-ext4+bounces-4524-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF739932EE
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Oct 2024 18:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C716A1C22819
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Oct 2024 16:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E753B1D9346;
	Mon,  7 Oct 2024 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fa0n2R0Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zF7KI0Kb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fa0n2R0Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zF7KI0Kb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26001D4152
	for <linux-ext4@vger.kernel.org>; Mon,  7 Oct 2024 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317913; cv=none; b=jWwwfR3KAkKoH413HRpqwxZyotcHcRcnQuGEhEo/LdCpDQmDopx6viRgYOruo3vxoF4OZbQBvlZcn9TLU8a6gA3cyIHsx64FrjtlCi66mXgdXIkypU6pHmDcC860WGhzcW9D/0xr6hXtZ+nux4L9jZHLhjnRP07el8p+NemrR18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317913; c=relaxed/simple;
	bh=UItaE0j2oHbZcS1dsd1eoqu1YCuLT0cVar47OPYdKhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cY9X2NKQ3TWKzR54TkC22uqan5Kvz19NGsSfm94NPoLA72GMOWWVCfvTVIPuEMZ8AFpEBkrWlekFuKXyKdTfPjLzLz2FmOaH9XvlV8/rphtNn+AyfNWNQPSDW/QXtdnmIs6YJFPQ8RFhtHkvLZEP6n4URe2dRNCPa0sfoixbT34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fa0n2R0Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zF7KI0Kb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fa0n2R0Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zF7KI0Kb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA94421B87;
	Mon,  7 Oct 2024 16:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728317909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCCnIA4pPdJb47KXlYuCQ73YmB9PSYtnaO/E5dCrBHE=;
	b=Fa0n2R0ZbiUp4lak5S2L2aH1koFGzJq/sZltdxznrecWRttxUbm+mQAelTwPQnrArozHKD
	lTAZQMZyXog9a7Q9QjDs+8NZqXZ28BrOIjfOn6MJ1P+pV8hJFXlrHQ/ure5qN3YFMhop5k
	o1nuskyb5E8HsMru/RRTKvu7hefouE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728317909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCCnIA4pPdJb47KXlYuCQ73YmB9PSYtnaO/E5dCrBHE=;
	b=zF7KI0KbzK7mY48eefbh+s3RCGGPJN8FEV24Y6YAL/YHc5sc6GJROzCtjGu62MdD05SRsw
	+OD1/m245F1JRuDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Fa0n2R0Z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zF7KI0Kb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728317909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCCnIA4pPdJb47KXlYuCQ73YmB9PSYtnaO/E5dCrBHE=;
	b=Fa0n2R0ZbiUp4lak5S2L2aH1koFGzJq/sZltdxznrecWRttxUbm+mQAelTwPQnrArozHKD
	lTAZQMZyXog9a7Q9QjDs+8NZqXZ28BrOIjfOn6MJ1P+pV8hJFXlrHQ/ure5qN3YFMhop5k
	o1nuskyb5E8HsMru/RRTKvu7hefouE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728317909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCCnIA4pPdJb47KXlYuCQ73YmB9PSYtnaO/E5dCrBHE=;
	b=zF7KI0KbzK7mY48eefbh+s3RCGGPJN8FEV24Y6YAL/YHc5sc6GJROzCtjGu62MdD05SRsw
	+OD1/m245F1JRuDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99A7B13786;
	Mon,  7 Oct 2024 16:18:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i4d4JdUJBGfXIAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Oct 2024 16:18:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1309DA07D0; Mon,  7 Oct 2024 18:18:25 +0200 (CEST)
Date: Mon, 7 Oct 2024 18:18:25 +0200
From: Jan Kara <jack@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
	linux-ext4@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] ext4: Avoid remount errors with 'abort' mount option
Message-ID: <20241007161825.yh2d4464ef7ysbye@quack3>
References: <20241004221556.19222-1-jack@suse.cz>
 <CAASaF6wKeEkAWW6SQOur+R7EHwC7YVx_C+DTcQojhOfhUCLvaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAASaF6wKeEkAWW6SQOur+R7EHwC7YVx_C+DTcQojhOfhUCLvaw@mail.gmail.com>
X-Rspamd-Queue-Id: AA94421B87
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,mit.edu,vger.kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Mon 07-10-24 11:13:38, Jan Stancek wrote:
> On Sat, Oct 5, 2024 at 12:16 AM Jan Kara <jack@suse.cz> wrote:
> >
> > When we remount filesystem with 'abort' mount option while changing
> > other mount options as well (as is LTP test doing), we can return error
> > from the system call after commit d3476f3dad4a ("ext4: don't set
> > SB_RDONLY after filesystem errors") because the application of mount
> > option changes detects shutdown filesystem and refuses to do anything.
> > The behavior of application of other mount options in presence of
> > 'abort' mount option is currently rather arbitary as some mount option
> > changes are handled before 'abort' and some after it.
> >
> > Move aborting of the filesystem to the end of remount handling so all
> > requested changes are properly applied before the filesystem is shutdown
> > to have a reasonably consistent behavior.
> >
> > Fixes: d3476f3dad4a ("ext4: don't set SB_RDONLY after filesystem errors")
> > Reported-by: Jan Stancek <jstancek@redhat.com>
> > Link: https://lore.kernel.org/all/Zvp6L+oFnfASaoHl@t14s
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> In case the mount option isn't getting deprecated right away:
> Tested-by: Jan Stancek <jstancek@redhat.com>

Well, even if we decided to deprecate it, it would mean that now we'd just
start warning about deprecation and it would get removed in an year or so.
So fixing this still makes sense. Thanks for testing!

								Honza
> > ---
> >  fs/ext4/super.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 16a4ce704460..4645f1629673 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -6518,9 +6518,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
> >                 goto restore_opts;
> >         }
> >
> > -       if (test_opt2(sb, ABORT))
> > -               ext4_abort(sb, ESHUTDOWN, "Abort forced by user");
> > -
> >         sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
> >                 (test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
> >
> > @@ -6689,6 +6686,14 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
> >         if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
> >                 ext4_stop_mmpd(sbi);
> >
> > +       /*
> > +        * Handle aborting the filesystem as the last thing during remount to
> > +        * avoid obsure errors during remount when some option changes fail to
> > +        * apply due to shutdown filesystem.
> > +        */
> > +       if (test_opt2(sb, ABORT))
> > +               ext4_abort(sb, ESHUTDOWN, "Abort forced by user");
> > +
> >         return 0;
> >
> >  restore_opts:
> > --
> > 2.35.3
> >
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

