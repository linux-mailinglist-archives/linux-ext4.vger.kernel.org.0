Return-Path: <linux-ext4+bounces-496-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4465F8174D8
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 16:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1AA0285DE6
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 15:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E1142372;
	Mon, 18 Dec 2023 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FXDRgfEP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F8XqATFZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FXDRgfEP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F8XqATFZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669563D576;
	Mon, 18 Dec 2023 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 272B51F441;
	Mon, 18 Dec 2023 15:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702912146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3NGha/MXIhl7G6dbrriyzZQRltx6nNC4V8clVaTSp6k=;
	b=FXDRgfEP0ySc78RlgNzO7KY5rZxJVVkx8wTWid+9JrVpPrh6Jm2iNrffyv2VBrOBU3LE1X
	7cJM6HPHbRKWO2+eA9IytKAZ8VRgoQM7djL0XLM/hZ06qRpNQtJlMuy6f6B8pyZdGjpP+m
	QQe9ZIh7RXeieW4yipiqbrvXz0jHOAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702912146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3NGha/MXIhl7G6dbrriyzZQRltx6nNC4V8clVaTSp6k=;
	b=F8XqATFZnZLRWOahdM4ufChjURT19gnwgIm3Homm9gw71jGE1V5zmyGeNAcJ4jrD3T+6p9
	sGZOWAucGdPMx5DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702912146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3NGha/MXIhl7G6dbrriyzZQRltx6nNC4V8clVaTSp6k=;
	b=FXDRgfEP0ySc78RlgNzO7KY5rZxJVVkx8wTWid+9JrVpPrh6Jm2iNrffyv2VBrOBU3LE1X
	7cJM6HPHbRKWO2+eA9IytKAZ8VRgoQM7djL0XLM/hZ06qRpNQtJlMuy6f6B8pyZdGjpP+m
	QQe9ZIh7RXeieW4yipiqbrvXz0jHOAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702912146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3NGha/MXIhl7G6dbrriyzZQRltx6nNC4V8clVaTSp6k=;
	b=F8XqATFZnZLRWOahdM4ufChjURT19gnwgIm3Homm9gw71jGE1V5zmyGeNAcJ4jrD3T+6p9
	sGZOWAucGdPMx5DQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1451613927;
	Mon, 18 Dec 2023 15:09:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id nAvyBJJggGU3dwAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 18 Dec 2023 15:09:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 84782A07E0; Mon, 18 Dec 2023 16:09:05 +0100 (CET)
Date: Mon, 18 Dec 2023 16:09:05 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/4] ext4: avoid dividing by 0 in
 mb_update_avg_fragment_size() when block bitmap corrupt
Message-ID: <20231218150905.llu5tgjgen4nxthq@quack3>
References: <20231218141814.1477338-1-libaokun1@huawei.com>
 <20231218141814.1477338-5-libaokun1@huawei.com>
 <20231218144342.2we3j2dtyedulfga@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218144342.2we3j2dtyedulfga@quack3>
X-Spam-Score: 1.80
X-Spamd-Result: default: False [1.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.10)[64.96%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Flag: NO

On Mon 18-12-23 15:43:42, Jan Kara wrote:
> On Mon 18-12-23 22:18:14, Baokun Li wrote:
> > When bb_free is not 0 but bb_fragments is 0, return directly to avoid
> > system crash due to division by zero.
> 
> How could this possibly happen? bb_fragments is the number of free space
> extents and bb_free is the number of free blocks. No free space extents =>
> no free blocks seems pretty obvious? You can see the logic in
> ext4_mb_generate_buddy()...

Oh, I see. This is probably about "bitmap corrupted case". But still both
allocation and freeing of blocks shouldn't operate on bitmaps marked as
corrupted so this should not happen?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

