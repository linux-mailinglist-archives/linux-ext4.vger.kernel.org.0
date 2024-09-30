Return-Path: <linux-ext4+bounces-4388-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197DD989F5B
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 12:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A57C2B22EBC
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 10:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60433189F41;
	Mon, 30 Sep 2024 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YPF+QVoj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+596mUK6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YPF+QVoj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+596mUK6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548AE180A80
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692218; cv=none; b=s52Wc+sJXqVDfF25ncpldcCxLwxDGpFTUJVFktPuVstaT7TFxMG2nwP+8dCYiIVRIgZ1LRaKMXP68G8AmeVvlGD3q4es2V7HpmWr40ZIIJ71q6o9HmbjRmQoHD1KNL9EdKMr6maJwS+qjV+qKUP95JxboE6ICYHBrshtWEOaN1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692218; c=relaxed/simple;
	bh=MNSZCuEEc0OEZ/3li6t1K4aOua3unbqEmONwGFXx224=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMyT1/7hGhG8CdZbQF/oJ71Vb///eYvJQiUHIimXBsv2ZL7DWmSQmM/7ieosALseWECJnYtrgSCNhvQqj2xyrc5VKYx8kv+1OOSemKe/SoUQf/IIlq8XWtuQ0JjuPxOh5XAVIuYVm9Kvh3KamLB+g3UPkeE6qzG0uzFbgAMzdsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YPF+QVoj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+596mUK6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YPF+QVoj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+596mUK6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80DE721A3C;
	Mon, 30 Sep 2024 10:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727692214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HecexJzGepw4RYP7F3VkVnFjkwP+8Z7myLMjLgd4Aws=;
	b=YPF+QVoj4BcwiOBdTDCWHwy/oqWkXv9nYcmiqbW1EQNKvgpT/kNmv/Avt3XOW+I0m6SK5Z
	2QfOVdnX+oQEMELsRs1F4F2LmQKuQD4uYEKvJMa4YHkqPnq+dwfLkVX6jRCSh++20M1dWw
	aomlWElg3M3npKjXazm1D/UBOMkPlII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727692214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HecexJzGepw4RYP7F3VkVnFjkwP+8Z7myLMjLgd4Aws=;
	b=+596mUK6BEs+CoWJHDEpFQu5jyzZLhBGWYuYgJPRYoBWayq4jIrNoSVu/Khwssw/H4X8Gy
	9w/yK/OTPim7kyDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YPF+QVoj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+596mUK6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727692214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HecexJzGepw4RYP7F3VkVnFjkwP+8Z7myLMjLgd4Aws=;
	b=YPF+QVoj4BcwiOBdTDCWHwy/oqWkXv9nYcmiqbW1EQNKvgpT/kNmv/Avt3XOW+I0m6SK5Z
	2QfOVdnX+oQEMELsRs1F4F2LmQKuQD4uYEKvJMa4YHkqPnq+dwfLkVX6jRCSh++20M1dWw
	aomlWElg3M3npKjXazm1D/UBOMkPlII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727692214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HecexJzGepw4RYP7F3VkVnFjkwP+8Z7myLMjLgd4Aws=;
	b=+596mUK6BEs+CoWJHDEpFQu5jyzZLhBGWYuYgJPRYoBWayq4jIrNoSVu/Khwssw/H4X8Gy
	9w/yK/OTPim7kyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7315613A8B;
	Mon, 30 Sep 2024 10:30:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EnzIG7Z9+mZNQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Sep 2024 10:30:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 22DB4A0845; Mon, 30 Sep 2024 12:30:14 +0200 (CEST)
Date: Mon, 30 Sep 2024 12:30:14 +0200
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jack@suse.cz, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH v2 4/6] jbd2: factor out jbd2_do_replay()
Message-ID: <20240930103014.lf2bdwmbde2f2bu3@quack3>
References: <20240930005942.626942-1-yebin@huaweicloud.com>
 <20240930005942.626942-5-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930005942.626942-5-yebin@huaweicloud.com>
X-Rspamd-Queue-Id: 80DE721A3C
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,huawei.com:email,suse.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 30-09-24 08:59:40, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Factor out jbd2_do_replay() no funtional change.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just one style nit below:

> +			lock_buffer(nbh);
> +			memcpy(nbh->b_data, obh->b_data, journal->j_blocksize);
> +			if (flags & JBD2_FLAG_ESCAPE) {
> +				*((__be32 *)nbh->b_data) =
> +				cpu_to_be32(JBD2_MAGIC_NUMBER);
				^^ this needs one more indent

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

