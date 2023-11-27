Return-Path: <linux-ext4+bounces-200-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209167FA5CA
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Nov 2023 17:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC041F2021D
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Nov 2023 16:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DF2358B5;
	Mon, 27 Nov 2023 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B1F1BB
	for <linux-ext4@vger.kernel.org>; Mon, 27 Nov 2023 08:11:52 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E7CA11FB4A;
	Mon, 27 Nov 2023 16:11:49 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DBEB613440;
	Mon, 27 Nov 2023 16:11:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 5ICsNcW/ZGXxXgAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 27 Nov 2023 16:11:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6B895A07CB; Mon, 27 Nov 2023 17:11:49 +0100 (CET)
Date: Mon, 27 Nov 2023 17:11:49 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH 2/2] jbd2: increase the journal IO's priority
Message-ID: <20231127161149.2s7yizu72gw332s2@quack3>
References: <20231125121740.1035816-1-yi.zhang@huaweicloud.com>
 <20231125121740.1035816-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125121740.1035816-2-yi.zhang@huaweicloud.com>
X-Spamd-Bar: +++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.39 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,huawei.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: 5.39
X-Rspamd-Queue-Id: E7CA11FB4A

Hello!

On Sat 25-11-23 20:17:39, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Current jbd2 only add REQ_SYNC for descriptor block, metadata log
> buffer, commit buffer and superblock buffer, the submitted IO could be
> throttled by writeback throttle in block layer, that could lead to
> priority inversion in some cases. The log IO looks like a kind of high
> priority metadata IO, so it should not be throttled by WBT like QOS
> policies in block layer, let's add REQ_SYNC | REQ_IDLE to exempt from
> writeback throttle, and also add REQ_META together indicates it's a
> metadata IO.

So I agree about REQ_META but with REQ_IDLE I'm not so sure. __REQ_IDLE is
documented as "anticipate more IO after this one" so that is a good fit for
normal transaction writes but not so much for journal superblock writes.
OTOH as far as I'm checking XFS uses REQ_IDLE as well for its log IO and
the only places where REQ_IDLE is really checked is in blk-wbt... So I
guess this makes sense.

> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 52772c826c86..f7e8274b46ae 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1374,6 +1374,9 @@ JBD2_FEATURE_INCOMPAT_FUNCS(csum2,		CSUM_V2)
>  JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
>  JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
>  
> +/* Journal high priority write IO operation flags */
> +#define JBD2_REQ_HIPRIO		(REQ_META | REQ_SYNC | REQ_IDLE)

Since all journal IO is submitted with these flags I'd maybe name this
JBD2_JOURNAL_REQ_FLAGS? Otherwise the patch looks good to me so feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

