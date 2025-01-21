Return-Path: <linux-ext4+bounces-6167-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62214A17CBE
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 12:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B471885E03
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 11:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5261F12F7;
	Tue, 21 Jan 2025 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XBYv5y3b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o/ePimk1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="13pr1xL6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mHPAz+Aj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51081B4137;
	Tue, 21 Jan 2025 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737458063; cv=none; b=dedGNQ7Qoke1bw3XhU8PwMPw+eiwxdOz5sfoXqRpwELn890OEl9gE4ZC43GLqkwDZRMO5zvNu7xEIHmPMIi0lJHSZrLDfsXemtQX1JwhcxTvOaCNRiJJJ68/haJ1fmpwkiING5Z4tDa993Lhjy57+t/KeJdaV8PZ82sZ8ueyOso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737458063; c=relaxed/simple;
	bh=m15FfV6xZ+HENFdnlVxswdSiX3mJk9PSp5GECYsoGXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNAFZcguPgBMxccNMz94b/TSgrd99ln6N8j2lkYpGgqYTRbFIyq2D22Fuq9Rj78mELKl+9gt72chPsfpSWP58iSPSCj7BHUZEwI/MU+Mvoi61DSGZt4izkT/Rl4PF6mmwDdyViqTZoLcfIti5Ek6BT3Uo6sgTZpPUY2DyUMi5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XBYv5y3b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o/ePimk1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=13pr1xL6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mHPAz+Aj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4FC11F78A;
	Tue, 21 Jan 2025 11:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737458060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sU6WBnEKOmoFNoiAFTcY/ukOVupZUOqtVhQA9+t0fOw=;
	b=XBYv5y3btOdzAhiX5quWWBIF0x30/3i15A67bp89OkTRjuls0VTpI4n150mMB811CHmC8T
	76vZ5vFL6Gc//JtoaNyXYO7ciiusY7N1DALwgetWhOccCQJGpD3R3AYvGJiceDdNdfAdOb
	AOF6OyR3LH1bxCCB3gcAS+mkFbFf4R8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737458060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sU6WBnEKOmoFNoiAFTcY/ukOVupZUOqtVhQA9+t0fOw=;
	b=o/ePimk15LBBzGqwaDAbP3A88UkjK1xNDlTDG9QqIMhvUbZ/BQuyKohSczUxZt+se0V7md
	KISR8Add/xkN0RBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737458059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sU6WBnEKOmoFNoiAFTcY/ukOVupZUOqtVhQA9+t0fOw=;
	b=13pr1xL66W8f4YuSV3o3k7ZbD/hBmE3lDcaU4F2UGbQF78mDtDiYEbj0eNzVBn+r1LrIEJ
	YZudvck4KwhZyYtZ0psszv9zBwuqltI9XGe1S5J/zrycRy97u7JQCnPLiK+30m31iy9Ad9
	kGDsGqgF/HVvSH6R4ShqwIQgkwXvQOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737458059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sU6WBnEKOmoFNoiAFTcY/ukOVupZUOqtVhQA9+t0fOw=;
	b=mHPAz+AjjijNjEH77bXM+Vm7+grg9HoTekohZCAi1EEf5vkVgcYMKhalPSMCw4EALNp2Dk
	S5Ckt06HGwzMEOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CADC51387C;
	Tue, 21 Jan 2025 11:14:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wQ+FMYuBj2fLZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Jan 2025 11:14:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 92754A0889; Tue, 21 Jan 2025 12:14:19 +0100 (CET)
Date: Tue, 21 Jan 2025 12:14:19 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v2 6/8] ext4: update the descriptions of data_err=abort
 and data_err=ignore
Message-ID: <ibyxhbx3y3cbkt6pjn4th7omtflsba7xi6pwbbqq3xhokshdvb@j5s524uarmoo>
References: <20250121071050.3991249-1-libaokun@huaweicloud.com>
 <20250121071050.3991249-7-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121071050.3991249-7-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 21-01-25 15:10:48, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> We now print error messages in ext4_end_bio() when page writeback
> encounters an error. If data_err=abort is set, the journal will also
> be aborted in a kworker. This means that we now check all Buffer I/O
> in all modes and decide whether to abort the journal based on the
> data_err option. Therefore, we remove the ordered mode restriction
> in the descriptions of data_err=abort and data_err=ignore.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/admin-guide/ext4.rst | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/ext4.rst b/Documentation/admin-guide/ext4.rst
> index 2418b0c2d3df..b857eb6ca1b6 100644
> --- a/Documentation/admin-guide/ext4.rst
> +++ b/Documentation/admin-guide/ext4.rst
> @@ -238,11 +238,10 @@ When mounting an ext4 filesystem, the following option are accepted:
>          configured using tune2fs)
>  
>    data_err=ignore(*)
> -        Just print an error message if an error occurs in a file data buffer in
> -        ordered mode.
> +        Just print an error message if an error occurs in a file data buffer.
> +
>    data_err=abort
> -        Abort the journal if an error occurs in a file data buffer in ordered
> -        mode.
> +        Abort the journal if an error occurs in a file data buffer.
>  
>    grpid | bsdgroups
>          New objects have the group ID of their parent.
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

