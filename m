Return-Path: <linux-ext4+bounces-1360-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2301785FA64
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 14:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A90C1C21C98
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 13:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063991350D8;
	Thu, 22 Feb 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x4Rls0UN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pOvhH5UX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x4Rls0UN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pOvhH5UX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0D21339A4
	for <linux-ext4@vger.kernel.org>; Thu, 22 Feb 2024 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610006; cv=none; b=GtxtIUQmaRnYlyXv0gQZNpnzMAECU/a2XptIYE4uSjh+JbocUfPp+v4S0tiQLV5bAM4iQTSW3sWJVN40lkXZkNzDBvVt6q5EMIARumxwi4H1+v72mMoCA9OEKkvP/2ezW1k1XmJcBYHO8T7Bli4g1m7X/uvXth2T23/Yn57z2SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610006; c=relaxed/simple;
	bh=IkIOkmQxc8shmHLsfRjVOwtd922N1PXTP/BfLYa24kE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WCL1SXKu5MK0r04AqeBbZ0akZvY/NoOTTIswNhLXKguNQ3+8O3GT5OYeOSXgoYcNp0STiCHh2AN6zRdzxoYNLUu493yL/0+YTSnJYc4hE1gXdt3bbuLfkYMU6AE1fFsf7U+MrJ2rGwvmruXIczQAsKjNnKIg7meWWkCjqWdaIqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x4Rls0UN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pOvhH5UX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x4Rls0UN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pOvhH5UX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46079222AE;
	Thu, 22 Feb 2024 13:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708610002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbqWkMNxY5Tx9OpvF030nuidakoQOAL/iSFwACm4dPM=;
	b=x4Rls0UNXfRG23CzE+A9UniY3R9H5QcxBq3nMbWyHR1muVronvAD21WFi/VTSSNJsqDvOr
	p6Iw89j4g1vmvce7SkDOj79Dtooydux173ykZ1bhKe9G4z+bUEiaJqit2vshVVSF8eOjXw
	gLo3XjaylTup6FgOEl604WNTRoQvhW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708610002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbqWkMNxY5Tx9OpvF030nuidakoQOAL/iSFwACm4dPM=;
	b=pOvhH5UXVRZGWI3deBi3XPrTLjoFsngOta9y35+6s/Q+YQ98AVMnU/tg7ndD/SI+1eLHnx
	9ggAEnW/wk1K4lDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708610002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbqWkMNxY5Tx9OpvF030nuidakoQOAL/iSFwACm4dPM=;
	b=x4Rls0UNXfRG23CzE+A9UniY3R9H5QcxBq3nMbWyHR1muVronvAD21WFi/VTSSNJsqDvOr
	p6Iw89j4g1vmvce7SkDOj79Dtooydux173ykZ1bhKe9G4z+bUEiaJqit2vshVVSF8eOjXw
	gLo3XjaylTup6FgOEl604WNTRoQvhW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708610002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbqWkMNxY5Tx9OpvF030nuidakoQOAL/iSFwACm4dPM=;
	b=pOvhH5UXVRZGWI3deBi3XPrTLjoFsngOta9y35+6s/Q+YQ98AVMnU/tg7ndD/SI+1eLHnx
	9ggAEnW/wk1K4lDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0855213A8C;
	Thu, 22 Feb 2024 13:53:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FIpBOtFR12U2QAAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Thu, 22 Feb 2024 13:53:21 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 905f8873;
	Thu, 22 Feb 2024 13:53:21 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-ext4@vger.kernel.org
Subject: Re: fstest generic/696 failure on ext4 fs with quotas+idmap
In-Reply-To: <20240222-knast-reifen-953312ce17a9@brauner> (Christian Brauner's
	message of "Thu, 22 Feb 2024 14:26:27 +0100")
References: <87jzmxisqm.fsf@suse.de>
	<20240222-knast-reifen-953312ce17a9@brauner>
Date: Thu, 22 Feb 2024 13:53:21 +0000
Message-ID: <87il2ghage.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.31
X-Spamd-Result: default: False [-1.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.01)[50.92%]
X-Spam-Flag: NO

Christian Brauner <brauner@kernel.org> writes:

> On Wed, Feb 21, 2024 at 06:20:49PM +0000, Luis Henriques wrote:
>> Hi!
>>=20
>> The fstest generic/696 (and 697) fail on ext4 when the filesystem is
>> created with quota support (-O quota).  It's really easy to reproduce, a=
nd
>> it fails when doing the idmapped tests (setgid_create_umask_idmapped() a=
nd
>> setgid_create_umask_idmapped_in_userns()).
>>=20
>> The failure happens when the test does an openat() with O_TMPFILE:
>>=20
>>   ext4_tmpfile()
>>     __ext4_new_inode()
>>       dquot_initialize()
>>         dqget()
>>=20
>> and at this point the error occurs:
>>=20
>> 	if (!qid_has_mapping(sb->s_user_ns, qid))
>> 		return ERR_PTR(-EINVAL);
>>=20
>> qid is '-1', which is invalid, but I'm failing to understand if it should
>> really be invalid or if dqget() should handle this invalid qid some other
>> way.  Earlier, __ext4_new_inode() called inode_init_owner(), which indeed
>> sets inode->i_uid with '-1'.
>
> I think that's a misanalysis? The dquot_initialize happens to be before
> the inode creation for that tmpfile. Anyway, see below.
>
>>=20
>> I've been trying to figure it out, but it's very tricky to follow all the
>> details, so I decided to ask here and see if anyone has any idea.  Is th=
is
>> a known issue?  Maybe the issue is with the test itself, and not with
>> ext4, quota or idmapped code.
>
> So good new is that it's neither an ext4, quota, or idmapped bug. It's
> just the test being broken because openat_tmpfile_supported() is called
> after we created an idmapped mount on the idmapped mount which means
> that the callers fs{g,u}id might not be mapped. That means
> make_kquid_*id() will return INVALID_*ID which will later fail that
> check whether the qid is mapped in dqget().
>
> I sent a patch to xfstests with you can ext4 Cced. I've tested it here
> and it's fixed. Feel free to test as well.

Wow! Awesome, thanks a lot for looking into this, Christian.  I'll test
that patch, but from your description it looks like it should be fix.

Cheers,
--=20
Lu=C3=ADs

