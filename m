Return-Path: <linux-ext4+bounces-1572-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AA3876456
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Mar 2024 13:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4227D1C21128
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Mar 2024 12:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BE9EEA9;
	Fri,  8 Mar 2024 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wzQP0KLu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/idQu7OV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wzQP0KLu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/idQu7OV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EEB817
	for <linux-ext4@vger.kernel.org>; Fri,  8 Mar 2024 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709901091; cv=none; b=DxAZq4S2Qh7zfrG6eiGZbGTwSBhpKkjRPNIHZMXq4JVLnHPMQehvcAWASpl1XyNmSobBDxAZPB30N32AuBJ7f+UXwyDIqGxMv1p3ikdWRzo3vPVoXzka8VaJcpYmSHDqRGxjMSW/HmsYcsVrdsIDTy8nlHsox6ArN6W0fClc85A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709901091; c=relaxed/simple;
	bh=K8InnZE87VhORjyT1523hx+1/Xoa175pq8h4T1VIBNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C4ztexKnok16Ze9ho12mVu9YRe8Bsy+73wLBXCQJlQ39OrIQSN19svfEs1ATj4p2NZExIxvkUphDbpSVkv7KNskTafYBG/PHfDcwJgldUaoC+huPCXmjFSnv/I2tG1qElnrP6dklbGUWVmyJRB0p6Kt1i/kyh2TxAmhGqGKbD2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wzQP0KLu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/idQu7OV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wzQP0KLu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/idQu7OV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E08421E54;
	Fri,  8 Mar 2024 11:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709897173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLQxyUIwv0n74bgrFlNHRZcXveiN+qMlqlK7dJLltnw=;
	b=wzQP0KLuW5MDVj84nk35CVRm72qHVQFoBVLmImjNO2Et0Pf4QCc6AsNjbYEXsChr4fidld
	Cqz48sfH/zJM/piGQXhREJBOzXCSPp6qqPcA7fkR/0oQqK4wXFZ6IafdzI2TKkkOe7FDn3
	BrTU4QkbDrWQU0zaDhKFpEiS1L6Zpcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709897173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLQxyUIwv0n74bgrFlNHRZcXveiN+qMlqlK7dJLltnw=;
	b=/idQu7OVU9xBtUMSp/U7kcL7pvYrDehE07dQqdHNcq4iWzZmPZ/KhutnyPIhDxfStCdgiR
	HHjghRc6PPihOHBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709897173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLQxyUIwv0n74bgrFlNHRZcXveiN+qMlqlK7dJLltnw=;
	b=wzQP0KLuW5MDVj84nk35CVRm72qHVQFoBVLmImjNO2Et0Pf4QCc6AsNjbYEXsChr4fidld
	Cqz48sfH/zJM/piGQXhREJBOzXCSPp6qqPcA7fkR/0oQqK4wXFZ6IafdzI2TKkkOe7FDn3
	BrTU4QkbDrWQU0zaDhKFpEiS1L6Zpcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709897173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLQxyUIwv0n74bgrFlNHRZcXveiN+qMlqlK7dJLltnw=;
	b=/idQu7OVU9xBtUMSp/U7kcL7pvYrDehE07dQqdHNcq4iWzZmPZ/KhutnyPIhDxfStCdgiR
	HHjghRc6PPihOHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C5F8133DC;
	Fri,  8 Mar 2024 11:26:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V0tjD9X16mVdfQAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Fri, 08 Mar 2024 11:26:13 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 1388ad45;
	Fri, 8 Mar 2024 11:26:12 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Jan Kara <jack@suse.cz>
Cc: Ted Tso <tytso@mit.edu>,  <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: Avoid excessive credit estimate in ext4_tmpfile()
In-Reply-To: <20240307115320.28949-1-jack@suse.cz> (Jan Kara's message of
	"Thu, 7 Mar 2024 12:53:20 +0100")
References: <20240307115320.28949-1-jack@suse.cz>
Date: Fri, 08 Mar 2024 11:26:12 +0000
Message-ID: <87v85xrmln.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wzQP0KLu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/idQu7OV"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.65 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.14)[68.35%]
X-Spam-Score: -1.65
X-Rspamd-Queue-Id: 9E08421E54
X-Spam-Flag: NO

Jan Kara <jack@suse.cz> writes:

> A user with minimum journal size (1024 blocks these days) complained
> about the following error triggered by generic/697 test in
> ext4_tmpfile():
>
> run fstests generic/697 at 2024-02-28 05:34:46
> JBD2: vfstest wants too many credits credits:260 rsv_credits:0 max:256
> EXT4-fs error (device loop0) in __ext4_new_inode:1083: error 28
>
> Indeed the credit estimate in ext4_tmpfile() is huge.
> EXT4_MAXQUOTAS_INIT_BLOCKS() is 219, then 10 credits from ext4_tmpfile()
> itself and then ext4_xattr_credits_for_new_inode() adds more credits
> needed for security attributes and ACLs. Now the
> EXT4_MAXQUOTAS_INIT_BLOCKS() is in fact unnecessary because we've
> already initialized quotas with dquot_init() shortly before and so
> EXT4_MAXQUOTAS_TRANS_BLOCKS() is enough (which boils down to 3 credits).
>
> Fixes: af51a2ac36d1 ("ext4: ->tmpfile() support")
> Signed-off-by: Jan Kara <jack@suse.cz>

FWIW, I've run generic/697 with a 1GiB device, with a block size of 65536.
Without this patch the test fails.  Feel free to add my

Tested-by: Luis Henriques <lhenriques@suse.de>

Cheers,
--=20
Lu=C3=ADs

> ---
>  fs/ext4/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 05b647e6bc19..58fee3c6febc 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2898,7 +2898,7 @@ static int ext4_tmpfile(struct mnt_idmap *idmap, st=
ruct inode *dir,
>  	inode =3D ext4_new_inode_start_handle(idmap, dir, mode,
>  					    NULL, 0, NULL,
>  					    EXT4_HT_DIR,
> -			EXT4_MAXQUOTAS_INIT_BLOCKS(dir->i_sb) +
> +			EXT4_MAXQUOTAS_TRANS_BLOCKS(dir->i_sb) +
>  			  4 + EXT4_XATTR_TRANS_BLOCKS);
>  	handle =3D ext4_journal_current_handle();
>  	err =3D PTR_ERR(inode);
> --=20
>
> 2.35.3
>

