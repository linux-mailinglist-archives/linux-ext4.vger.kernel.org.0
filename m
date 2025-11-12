Return-Path: <linux-ext4+bounces-11838-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B4098C54483
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 20:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3076C342CD6
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 19:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3A7299A8F;
	Wed, 12 Nov 2025 19:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wBw/ziiX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SipfPQFZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wBw/ziiX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SipfPQFZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FF8212F98
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977321; cv=none; b=eY5TA8q+NXmLCVt0G+jpHtWAlHkgxV0eSqBmMw6pMNiCBuRCVDNm1Np/iknGhHrKm1HhWbdRIS/xq0oaN3ESMPSnjzIPPETDiubvhfqxoW7GnHbXoeM0413FoPy7WJgKqtlWF1q8+oIP9ZjG24iza0vIYOPi7vfkOAfDqCAtLqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977321; c=relaxed/simple;
	bh=7KwzpnVa4ckT1X/29kDOu8EW7pbWH4rIWiaVAvqxiIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdvfBq86Sj53+KsUX95mnHC0cewAykORm29+UQfb8ujSb1woyvfSD07Itm9IwifXtINekWmZYYeAPPCfiXrX2qyR+YT6MP0Aq6RJ2CPMcEBIMTDsFfHe124gsY1A0WP+lL8OS7YPRq8yjEArEKLF7GO6lYtl7r4A6D+zhNsxPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wBw/ziiX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SipfPQFZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wBw/ziiX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SipfPQFZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A11A21952;
	Wed, 12 Nov 2025 19:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762977317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/JKn0dGY6Y534OD8L7ladRnYcc0F3zUMKK1vfrZ8R0=;
	b=wBw/ziiXBrFN/56nVyhqNI+AED8hAzr6wossBpJU8kXEAFRyl9A0CHGvh8ueZ0CAHzqxPW
	/xvx+mPQWf1TT7T+L9ggTiNFaYJ+l4DLek5sU+qEGYZBXz4laOjJSaFO4Ig98u15Aaed58
	QYdA/6JfaDmNgBykFsS+YCStWxxcBEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762977317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/JKn0dGY6Y534OD8L7ladRnYcc0F3zUMKK1vfrZ8R0=;
	b=SipfPQFZuW7ie9WgZ/jdpVRsfBevXMkv0jILEYpQqL8c4yJtsqD1x5ei6g+ZD0AbX4zwKX
	bCRALi/t67p7IgAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="wBw/ziiX";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SipfPQFZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762977317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/JKn0dGY6Y534OD8L7ladRnYcc0F3zUMKK1vfrZ8R0=;
	b=wBw/ziiXBrFN/56nVyhqNI+AED8hAzr6wossBpJU8kXEAFRyl9A0CHGvh8ueZ0CAHzqxPW
	/xvx+mPQWf1TT7T+L9ggTiNFaYJ+l4DLek5sU+qEGYZBXz4laOjJSaFO4Ig98u15Aaed58
	QYdA/6JfaDmNgBykFsS+YCStWxxcBEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762977317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/JKn0dGY6Y534OD8L7ladRnYcc0F3zUMKK1vfrZ8R0=;
	b=SipfPQFZuW7ie9WgZ/jdpVRsfBevXMkv0jILEYpQqL8c4yJtsqD1x5ei6g+ZD0AbX4zwKX
	bCRALi/t67p7IgAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E66B3EA61;
	Wed, 12 Nov 2025 19:55:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4TDVHiXmFGnvcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 12 Nov 2025 19:55:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1CAE8A06F7; Wed, 12 Nov 2025 20:55:17 +0100 (CET)
Date: Wed, 12 Nov 2025 20:55:17 +0100
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, jack@suse.cz, yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH e2fsprogs] libext2fs: fix orphan file size > kernel limit
 with large blocksize
Message-ID: <gqpzieqatnjndg64ui3rwaxzaq4bym34hydf6qnevrbk5jk73n@in4zjfln4ahs>
References: <20251112122157.1990595-1-libaokun@huaweicloud.com>
 <20251112183609.GN196358@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251112183609.GN196358@frogsfrogsfrogs>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 8A11A21952
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.21

On Wed 12-11-25 10:36:09, Darrick J. Wong wrote:
> On Wed, Nov 12, 2025 at 08:21:57PM +0800, libaokun@huaweicloud.com wrote:
> > From: Baokun Li <libaokun1@huawei.com>
> > 
> > Kernel commit 0a6ce20c1564 ("ext4: verify orphan file size is not too big")
> > limits the maximum supported orphan file size to 8 << 20.
> > 
> > However, in e2fsprogs, the orphan file size is set to 32–512 filesystem
> > blocks when creating a filesystem.
> > 
> > With 64k block size, formatting an ext4 fs >32G gives an orphan file bigger
> > than the kernel allows, so mount prints an error and fails:
> > 
> >     EXT4-fs (vdb): orphan file too big: 8650752
> >     EXT4-fs (vdb): mount failed
> > 
> > Therefore, synchronize the kernel change to e2fsprogs to avoid creating
> > orphan files larger than the kernel limit.
> > 
> > Signed-off-by: Baokun Li <libaokun1@huawei.com>
...
> >  /*
> >   * Find reasonable size for orphan file. We choose orphan file size to be
> > - * between 32 and 512 filesystem blocks and not more than 1/4096 of the
> > - * filesystem unless it is really small.
> > + * between 32 filesystem blocks and EXT4_DEFAULT_ORPHAN_FILE_SIZE, and not
> > + * more than 1/fs->blocksize of the filesystem unless it is really small.
> >   */
> >  e2_blkcnt_t ext2fs_default_orphan_file_blocks(ext2_filsys fs)
> >  {
> >  	__u64 num_blocks = ext2fs_blocks_count(fs->super);
> > -	e2_blkcnt_t blks = 512;
> > +	e2_blkcnt_t blks = EXT4_DEFAULT_ORPHAN_FILE_SIZE / fs->blocksize;
> >  
> >  	if (num_blocks < 128 * 1024)
> >  		blks = 32;
> > -	else if (num_blocks < 2 * 1024 * 1024)
> > -		blks = num_blocks / 4096;
> > +	else if (num_blocks < EXT4_DEFAULT_ORPHAN_FILE_SIZE)
> > +		blks = num_blocks / fs->blocksize;
> 
> If the number of blocks in the filesystem is less than the default
> orphan file size in bytes?  I don't understand that logic, particularly
> because EXT4_DEFAULT_ORPHAN_FILE_SIZE == 2<<20 == 2097152 == 2 * 1024 *
> 1024.

Yeah, these were just more or less ad hoc constants picked by me to make
sure orphan file doesn't consume too much space and they are unrelated to
the constant I've picked in the kernel limiting orphan file size. And I
agree making sure blks isn't larger than EXT4_DEFAULT_ORPHAN_FILE_SIZE
makes sense but otherwise I don't think we need to change anything here.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

