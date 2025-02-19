Return-Path: <linux-ext4+bounces-6511-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C96A3CBB3
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Feb 2025 22:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015F9179E19
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Feb 2025 21:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EAB24394C;
	Wed, 19 Feb 2025 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y2OGIaEe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3lvcavXT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y2OGIaEe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3lvcavXT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49A31C6FE9
	for <linux-ext4@vger.kernel.org>; Wed, 19 Feb 2025 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001444; cv=none; b=ow4PCVLpFz6byyr21eDci01157koxRn7Yrqo9kOkh6n1C7vFoDlk90L8EcDiPG8LKFk5s08dbmaT+ZfMi0S+3AyTOnAExAQ3LW49dGnHPp7By1Iyfex7cBLy1ai/UgQwPXhY9OWylI6xak+PmoqxTRiFv0l8OuzF7m6LmjnFLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001444; c=relaxed/simple;
	bh=x3uJV5zX52L6s3Lnu11vTzgBvC5rM6GQigSl/sJrsFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A60PZ2LgsY326SN9b8lrm05pC/qhNHaS9UGlyh3KfKIAEKR6fZKx1kkr1zTcBYDiU41R5Pf87iPWU/SNS6ZhURXZyZms2JvZhgOmadj2FlzN+76aE9yf+qN0fE1Qg3JBoFNqU+bD++C+mNNqxTGanvv2uXczFDi4UiSCWHYxfuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y2OGIaEe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3lvcavXT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y2OGIaEe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3lvcavXT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB0291FB3D;
	Wed, 19 Feb 2025 21:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740001440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agq+zSRk6ATHCI1KXVD57uIBBWWFIkg7Rr5IyhiyENA=;
	b=Y2OGIaEeH6z1YKRhtiBN29bf/ZFfMqevmNRM2heE2ENBH5aB9C5hW+HeAy5qIsH5VEjjv3
	827gmrRrDXEFQk78lvr6Kfcklsey2wFHN3q/evjZZ3qZweodi39kWjYxBAw5BiJdsx4QoH
	5MavbY1RD7Mh/kucvfAKDLONHyhiSn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740001440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agq+zSRk6ATHCI1KXVD57uIBBWWFIkg7Rr5IyhiyENA=;
	b=3lvcavXTiyhJ+jD69PaEj4e2BPPBgItZKR+rViXDa75URG6MnUSCxDY9mjRTKjlCYwFq5x
	BztV45jmHSEMIKBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Y2OGIaEe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3lvcavXT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740001440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agq+zSRk6ATHCI1KXVD57uIBBWWFIkg7Rr5IyhiyENA=;
	b=Y2OGIaEeH6z1YKRhtiBN29bf/ZFfMqevmNRM2heE2ENBH5aB9C5hW+HeAy5qIsH5VEjjv3
	827gmrRrDXEFQk78lvr6Kfcklsey2wFHN3q/evjZZ3qZweodi39kWjYxBAw5BiJdsx4QoH
	5MavbY1RD7Mh/kucvfAKDLONHyhiSn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740001440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agq+zSRk6ATHCI1KXVD57uIBBWWFIkg7Rr5IyhiyENA=;
	b=3lvcavXTiyhJ+jD69PaEj4e2BPPBgItZKR+rViXDa75URG6MnUSCxDY9mjRTKjlCYwFq5x
	BztV45jmHSEMIKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EB3213715;
	Wed, 19 Feb 2025 21:44:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aNP1GKBQtmcVKgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 19 Feb 2025 21:44:00 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Theodore Ts'o <tytso@mit.edu>,  Ext4 Developers List
 <linux-ext4@vger.kernel.org>,  drosen@google.com
Subject: Re: [PATCH -v2] ext4: introduce linear search for dentries
In-Reply-To: <9ED1B796-23FE-422A-B6C9-5BEAE4FAA912@dilger.ca> (Andreas
	Dilger's message of "Wed, 19 Feb 2025 13:30:05 -0700")
Organization: SUSE
References: <20250212164448.111211-1-tytso@mit.edu>
	<20250213201021.464223-1-tytso@mit.edu>
	<9ED1B796-23FE-422A-B6C9-5BEAE4FAA912@dilger.ca>
Date: Wed, 19 Feb 2025 16:43:59 -0500
Message-ID: <87cyfdvcdc.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BB0291FB3D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Andreas Dilger <adilger@dilger.ca> writes:

> On Feb 13, 2025, at 1:10 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>>=20
>> This patch addresses an issue where some files in case-insensitive
>> directories become inaccessible due to changes in how the kernel
>> function, utf8_casefold(), generates case-folded strings from the
>> commit 5c26d2f1d3f5 ("unicode: Don't special case ignorable code
>> points").
>>=20
>> There are good reasons why this change should be made; it's actually
>> quite stupid that Unicode seems to think that the characters =E2=9D=A4 a=
nd =E2=9D=A4=EF=B8=8F
>> should be casefolded.  Unfortimately because of the backwards
>> compatibility issue, this commit was reverted in 231825b2e1ff.
>>=20
>> This problem is addressed by instituting a brute-force linear fallback
>> if a lookup fails on case-folded directory, which does result in a
>> performance hit when looking up files affected by the changing how
>> thekernel treats ignorable Uniode characters, or when attempting to
>> look up non-existent file names.  So this fallback can be disabled by
>> setting an encoding flag if in the future, the system administrator or
>> the manufacturer of a mobile handset or tablet can be sure that there
>> was no opportunity for a kernel to insert file names with incompatible
>> encodings.
>
> I don't have the full context here, but falling back to a full directory
> scan for every failed lookup in a casefolded directory would be *very*
> expensive for a large directory.

The context is that I made a change in unicode that caused a change in
the filename hash of case-insensitive dirents, which are calculated from
the casefolded form of the name.  While that change was reverted, users
have created files with the broken kernels and there are reports of
files inaccessible.

> This could be made conditional upon a much narrower set of conditions:
> - if the filename has non-ASCII characters (already uncommon)
> - if the filename contains characters that may be case folded
> (normalized?)

It could be even simpler, by only doing it to filenames that have
zero-length characters before normalization.  We can easily check it
with utf8nlen or utf8ncursor.  I'm very wary of differentiating ASCII
from other characters if we can avoid it.

> This avoids a huge performance hit for every name lookup in very common
> workloads that do not need it (i.e. most computer-generated filenames are
> still only using ASCII characters).

Right.  But this also only affects case-insensitive filesystems, which
have very specific and controlled applications and hardly thousands of
files in the same directory.  If we really need it, I'd suggest we don't
differentiating ASCII from utf8, but only filenames with those
sequences.

IMO, Ted's patch seems fine as a temporary stopgap to recover those
filesystems.

>
> Also, depending on the size of the directory vs. the number of case-folded
> (normalized?) characters in the filename, it might be faster to do
> 2^(ambiguous_chars) htree lookups instead of a linear scan of the whole d=
ir.
>
> That could be checked easily whether 2^(ambiguous_chars) < dir blocks, si=
nce
> the htree leaf blocks will always be fully scanned anyway once found.  Th=
at
> could be a big win if there are only a few remapped characters in a filen=
ame.
>
> Cheers, Andreas
>
>>=20
>> Fixes: 5c26d2f1d3f5 ("unicode: Don't special case ignorable code points")
>> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>> Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
>> ---
>> v2:
>>   * Fix compile failure when CONFIG_UNICODE is not enabled
>>   * Added reviewed-by from Gabriel Krisman
>>=20
>> fs/ext4/namei.c    | 14 ++++++++++----
>> include/linux/fs.h | 10 +++++++++-
>> 2 files changed, 19 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
>> index 536d56d15072..820e7ab7f3a3 100644
>> --- a/fs/ext4/namei.c
>> +++ b/fs/ext4/namei.c
>> @@ -1462,7 +1462,8 @@ static bool ext4_match(struct inode *parent,
>> 		 * sure cf_name was properly initialized before
>> 		 * considering the calculated hash.
>> 		 */
>> -		if (IS_ENCRYPTED(parent) && fname->cf_name.name &&
>> +		if (sb_no_casefold_compat_fallback(parent->i_sb) &&
>> +		    IS_ENCRYPTED(parent) && fname->cf_name.name &&
>> 		    (fname->hinfo.hash !=3D EXT4_DIRENT_HASH(de) ||
>> 		     fname->hinfo.minor_hash !=3D EXT4_DIRENT_MINOR_HASH(de)))
>> 			return false;
>> @@ -1595,10 +1596,15 @@ static struct buffer_head *__ext4_find_entry(str=
uct inode *dir,
>> 		 * return.  Otherwise, fall back to doing a search the
>> 		 * old fashioned way.
>> 		 */
>> -		if (!IS_ERR(ret) || PTR_ERR(ret) !=3D ERR_BAD_DX_DIR)
>> +		if (IS_ERR(ret) && PTR_ERR(ret) =3D=3D ERR_BAD_DX_DIR)
>> +			dxtrace(printk(KERN_DEBUG "ext4_find_entry: dx failed, "
>> +				       "falling back\n"));
>> +		else if (!sb_no_casefold_compat_fallback(dir->i_sb) &&
>> +			 *res_dir =3D=3D NULL && IS_CASEFOLDED(dir))
>> +			dxtrace(printk(KERN_DEBUG "ext4_find_entry: casefold "
>> +				       "failed, falling back\n"));
>> +		else
>> 			goto cleanup_and_exit;
>> -		dxtrace(printk(KERN_DEBUG "ext4_find_entry: dx failed, "
>> -			       "falling back\n"));
>> 		ret =3D NULL;
>> 	}
>> 	nblocks =3D dir->i_size >> EXT4_BLOCK_SIZE_BITS(sb);
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 2c3b2f8a621f..aa4ec39202c3 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1258,11 +1258,19 @@ extern int send_sigurg(struct file *file);
>> #define SB_NOUSER       BIT(31)
>>=20
>> /* These flags relate to encoding and casefolding */
>> -#define SB_ENC_STRICT_MODE_FL	(1 << 0)
>> +#define SB_ENC_STRICT_MODE_FL		(1 << 0)
>> +#define SB_ENC_NO_COMPAT_FALLBACK_FL	(1 << 1)
>>=20
>> #define sb_has_strict_encoding(sb) \
>> 	(sb->s_encoding_flags & SB_ENC_STRICT_MODE_FL)
>>=20
>> +#if IS_ENABLED(CONFIG_UNICODE)
>> +#define sb_no_casefold_compat_fallback(sb) \
>> +	(sb->s_encoding_flags & SB_ENC_NO_COMPAT_FALLBACK_FL)
>> +#else
>> +#define sb_no_casefold_compat_fallback(sb) (1)
>> +#endif
>> +
>> /*
>>  *	Umount options
>>  */
>> --
>> 2.45.2
>>=20
>>=20
>
>
> Cheers, Andreas
>
>
>
>
>

--=20
Gabriel Krisman Bertazi

