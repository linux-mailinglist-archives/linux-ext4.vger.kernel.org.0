Return-Path: <linux-ext4+bounces-5750-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B819F6AA4
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 17:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E647C7A6934
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 15:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8E91F2396;
	Wed, 18 Dec 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YIiyuT+B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JNBpqo5H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FyerPoDP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7Zz/hbAW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E283F1591EA;
	Wed, 18 Dec 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734537592; cv=none; b=nY+MT07yjxgDhKasXiwzAkp3pYVYwrBvPuT2E8PszpPb9JKzzV+L2iWhnIsb8xYKhe3kA1CFGs1WDEFweh91F5GvrnD6K0qoahH/h11tkjA/c6EdzIJ/8eprOQJ5QTpULgOmuLEMgKqnazhAV69jyDx26RCXj0iHpIBWSzC+lDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734537592; c=relaxed/simple;
	bh=xqRCZi47ssybpFZmQ9iD4OT8RCvrCkNnYwDuOCAbG/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9XF8im3MCIGVIr0RVCA7wPrXNlVm4nVVvrGXKoYEaR/J+AqoYrzWr9u4lVbKWHTzFnRh4DL31LgzoI5hNbJOjf2mTS08ylSK0J1VzFtQdt8PwGUnjSJ1oMwmV/sUY30VENVHB9Zcf6Qzgti1o+AQ2vBrIY6M+NHkrmAQDvjqZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YIiyuT+B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JNBpqo5H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FyerPoDP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7Zz/hbAW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD1FA21153;
	Wed, 18 Dec 2024 15:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734537588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=736W051uo2m2PQ7K3wbgdieBkT9c+WicYFLODup6hqc=;
	b=YIiyuT+BhTqzkJFTEg+SlyRZ7Id2/MEIK6MjlhT9/zFJqV54DL+kogUXW0Qh0BPP70aqZ3
	Zuk0BdJJ+1hDsNSwZbhorSjc3KzuU6j18olt5DJIUkJJ+BWBlFEGFG0Yvfa+jiWFrR4vcH
	rdlG+5jMQoRir1FvxqArG00U374iqSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734537588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=736W051uo2m2PQ7K3wbgdieBkT9c+WicYFLODup6hqc=;
	b=JNBpqo5HCmp8zvrobhiDZTsm840xyacIVp9odDxVXiqDCAxjP1xFoCl3MJykzvwlt/BhBo
	LnOmDGowrBa1RTBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FyerPoDP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="7Zz/hbAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734537587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=736W051uo2m2PQ7K3wbgdieBkT9c+WicYFLODup6hqc=;
	b=FyerPoDPwaLY0i9qG9FM5AGH5aqTakFZowQp+cdC5MVRS7ZDeSaug8yqzNm4lYcmRXbdzN
	5LEc/ze83D6/yMskW8x7/G18h83PTqTr9s3IEIZ3MwxatrZX4J9TLrWNzlt766aRJTzgLk
	TOEQZtThz2hWZEbSDiETHY3BowCrXLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734537587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=736W051uo2m2PQ7K3wbgdieBkT9c+WicYFLODup6hqc=;
	b=7Zz/hbAW/4Sok4prx9FCx5QzFWePX+UIOchUpo+yqpKHZDut8ET8kyTFPragOQRwpkDT3F
	c+bZLOgudF6s+xCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2E70137CF;
	Wed, 18 Dec 2024 15:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EXt1M3PxYmdYQQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Dec 2024 15:59:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7A3C4A0435; Wed, 18 Dec 2024 16:59:47 +0100 (CET)
Date: Wed, 18 Dec 2024 16:59:47 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Brian Foster <bfoster@redhat.com>,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/4] ext-common: create a new test directory for ext*
 common tests
Message-ID: <20241218155947.ocbq6hjdzaud6ioj@quack3>
References: <20241210065900.1235379-1-hch@lst.de>
 <20241210065900.1235379-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210065900.1235379-4-hch@lst.de>
X-Rspamd-Queue-Id: DD1FA21153
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 10-12-24 07:58:27, Christoph Hellwig wrote:
> Split the tests shared with ext2 and ext3 from the ext4 directory.
> This makes ext4 a normal file system specific directory and cuts down
> the number of _supported_fs calls to a little more than a handful
> for tests that can't run on ext2.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

So I went through all ext4 tests and I think:
  ext4/004 should work for all ext? types -> move to ext_common

  ext4/006 should work for all ext? types -> move to ext_common
  ext4/007 should work for all ext? types -> move to ext_common
  ext4/008 should work for all ext? types -> move to ext_common
  ext4/009 should work for all ext? types -> move to ext_common
  ext4/010 should work for all ext? types -> move to ext_common
  ext4/011 should work for all ext? types -> move to ext_common
  ext4/012 should work for all ext? types -> move to ext_common
  ext4/013 should work for all ext? types -> move to ext_common
  ext4/014 should work for all ext? types -> move to ext_common
  ext4/016 should work for all ext? types -> move to ext_common
    - but I've now noticed that the last ten call _scratch_mkfs_ext4
      instead of _scratch_mkfs so that would need fixing up. So maybe leave
      it as is for now
  ext4/017 should work for all ext3 & ext4 types -> move to ext_common
    - similar caveat with _scratch_mkfs_ext4
  ext4/018 should work for all ext? types -> move to ext_common
  ext4/019 should work for all ext? types -> move to ext_common
    - similar caveat with _scratch_mkfs_ext4

  ext4/022 should work for ext3 & ext4 -> move to ext_common
  ext4/023 should work for all ext? types -> move to ext_common

  ext4/044 should work for all ext? types -> move to ext_common

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

