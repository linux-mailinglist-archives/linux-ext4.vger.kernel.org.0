Return-Path: <linux-ext4+bounces-4333-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CED69873DA
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2024 14:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5EB8B20DD1
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2024 12:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2C018B1A;
	Thu, 26 Sep 2024 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pt5O8dGS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PTYn38tN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pt5O8dGS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PTYn38tN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEA714AA9
	for <linux-ext4@vger.kernel.org>; Thu, 26 Sep 2024 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355168; cv=none; b=bRLECa4O8SHC/rBEFDCo9kd4vjTHBCmRiKqT3rWu4QO+Uq6a+h0Yop9yj6PsISzEEOpRQN4BYHAXoE/KQ1zn8lC7DyMDvPMin92u3FPquYmuQFJUOIAybvggYU60mX91uSaIXnWlTAGaVZGHZZ/FNy8HHXY5fD8o1majudq+HU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355168; c=relaxed/simple;
	bh=YKvkCbYYX96uHzRnhRFa6acMzVl1qgPVY4W1T1nVUuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhfa+TXCphl7Fd54IWO0aqTso+6Nc4BI751ojwmCQNRNbZEzoLBW0S8Ot20t0FoVXCMUD4f4Bckx1plwoLykcZiKWplwGHtsGZ6JrpPNSjAJ0xlQGGHHHPMw0Vt3n+PUQrB49lizNYUGofXOQ5QtSxuXPikC66rWQV/XAS+4Sjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pt5O8dGS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PTYn38tN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pt5O8dGS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PTYn38tN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88C6721B22;
	Thu, 26 Sep 2024 12:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727355164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hWwzoJdFTz6olNoe91QYoTLlBSttKYZxPmaM9wHjbDY=;
	b=Pt5O8dGSgbm+6mt94xLNYhTQ71AiGQHxFHaqJW2H4poPj01I3JVuz4S3poIv2DdK8F7taQ
	bBWgVyxVZshUS8f/PLdM29rkSuGkgkvwkwHeMNUUIGmOrJ9YVGTggdJ7tOE7S0oZjeZCbN
	ZIKQhCNeqtiDZxb4IJ/iQcQCcEOrE9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727355164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hWwzoJdFTz6olNoe91QYoTLlBSttKYZxPmaM9wHjbDY=;
	b=PTYn38tN7gyiI9QBjxY/caPfaXDdxrUvqEqQwXUw8G/FdPXrsC32XNUQfdJpnacquovDGo
	xBZex5XD0KSU+dAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727355164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hWwzoJdFTz6olNoe91QYoTLlBSttKYZxPmaM9wHjbDY=;
	b=Pt5O8dGSgbm+6mt94xLNYhTQ71AiGQHxFHaqJW2H4poPj01I3JVuz4S3poIv2DdK8F7taQ
	bBWgVyxVZshUS8f/PLdM29rkSuGkgkvwkwHeMNUUIGmOrJ9YVGTggdJ7tOE7S0oZjeZCbN
	ZIKQhCNeqtiDZxb4IJ/iQcQCcEOrE9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727355164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hWwzoJdFTz6olNoe91QYoTLlBSttKYZxPmaM9wHjbDY=;
	b=PTYn38tN7gyiI9QBjxY/caPfaXDdxrUvqEqQwXUw8G/FdPXrsC32XNUQfdJpnacquovDGo
	xBZex5XD0KSU+dAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A00013318;
	Thu, 26 Sep 2024 12:52:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /5eJHRxZ9WZbWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Sep 2024 12:52:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1CFF7A0845; Thu, 26 Sep 2024 14:52:44 +0200 (CEST)
Date: Thu, 26 Sep 2024 14:52:44 +0200
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jack@suse.cz, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 1/5] jbd2: remove redundant judgments for check v1
 checksum
Message-ID: <20240926125244.5l2ajllkdfcbpko5@quack3>
References: <20240918113604.660640-1-yebin@huaweicloud.com>
 <20240918113604.660640-2-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918113604.660640-2-yebin@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 18-09-24 19:36:00, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> 'need_check_commit_time' is only used by v2/v3 checksum, so there isn't
> need to add 'need_check_commit_time' judegement for v1 checksum logic.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/recovery.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 667f67342c52..5efbca6a98c4 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -619,7 +619,6 @@ static int do_one_pass(journal_t *journal,
>  			if (pass != PASS_REPLAY) {
>  				if (pass == PASS_SCAN &&
>  				    jbd2_has_feature_checksum(journal) &&
> -				    !need_check_commit_time &&
>  				    !info->end_transaction) {
>  					if (calc_chksums(journal, bh,
>  							&next_log_block,
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

