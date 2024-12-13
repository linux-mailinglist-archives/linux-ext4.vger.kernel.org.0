Return-Path: <linux-ext4+bounces-5625-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C219F107C
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 16:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5CF167007
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 15:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266161E1A33;
	Fri, 13 Dec 2024 15:10:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048241DFE08
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102633; cv=none; b=Vwmf0kvHJy4lSHz/nCc6xlmPcPz1aVE4mTKKh3bR4waultiOsA3tSYDdcVrLxNN9LHSesysJZoOIXAXWPm33xAyoScZ1VWbqrjhYuD4UTo5u0o80GJ36f0YFEMwLrrupK8N7mGXe/9nyc8sZI+o2gZnDhZ762wgS0LoqIUigciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102633; c=relaxed/simple;
	bh=DHsEASYPpHiSIP5MOwhtIPsU0AjvY5rHgiZDzo1IMqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAxZ44cAL1Bj8xEZ2Q09bdpKORxeaHCCR9YC4U/RvVxfVl155+0klnS68776c2GjIdqZhuGl4h5nydINzEhxt5q7qT+T8Hk0uTw/585wpIjPRPa5ijRiPKVj6dK6KglCrwutLZMAExJS6/C+ZGszTm55ATRDXffk4PyCBzntkYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C41F211B0;
	Fri, 13 Dec 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C6C413927;
	Fri, 13 Dec 2024 15:10:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tNebCmZOXGc2LwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Dec 2024 15:10:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C6B2FA0B0E; Fri, 13 Dec 2024 16:10:29 +0100 (CET)
Date: Fri, 13 Dec 2024 16:10:29 +0100
From: Jan Kara <jack@suse.cz>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
	harshads@google.com
Subject: Re: [PATCH v7 2/9] ext4: for committing inode, make
 ext4_fc_track_inode wait
Message-ID: <20241213151029.qeuctijrbibqoqp5@quack3>
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
 <20240818040356.241684-4-harshadshirwadkar@gmail.com>
 <20241212220043.a6hiif444v4jwnkm@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212220043.a6hiif444v4jwnkm@quack3>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3C41F211B0
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Thu 12-12-24 23:00:43, Jan Kara wrote:
> On Sun 18-08-24 04:03:49, Harshad Shirwadkar wrote:
> > +
> > +	while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
> > +#if (BITS_PER_LONG < 64)
> > +		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
> > +				EXT4_STATE_FC_COMMITTING);
> > +		wq = bit_waitqueue(&ei->i_state_flags,
> > +				   EXT4_STATE_FC_COMMITTING);
> > +#else
> > +		DEFINE_WAIT_BIT(wait, &ei->i_flags,
> > +				EXT4_STATE_FC_COMMITTING);
> > +		wq = bit_waitqueue(&ei->i_flags,
> > +				   EXT4_STATE_FC_COMMITTING);
> > +#endif
> > +		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> > +		if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
> > +			schedule();
> > +		finish_wait(wq, &wait.wq_entry);
> > +	}
> 
> But what protects us from fastcommit setting EXT4_STATE_FC_COMMITTING at
> this moment before we call ext4_fc_track_template(). Don't you need
> to grab sbi->s_fc_lock and hold it until the inode is attached to the
> fastcommit?
> 
> I might be missing something so some documentation (like a comment here)
> would be nice to explain what are you actually trying to achieve with the
> waiting...

Ah, I see now. In patch 4 you make setting of EXT4_STATE_FC_COMMITTING
protected by journal locking so holding a handle open protects us. Good.
But please comment about it in the changelog.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

