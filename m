Return-Path: <linux-ext4+bounces-13683-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNgTEIiujWmz5wAAu9opvQ
	(envelope-from <linux-ext4+bounces-13683-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 11:42:16 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BC012CA02
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 11:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D5F0303F076
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 10:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAE42BDC1C;
	Thu, 12 Feb 2026 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="szoykUKH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+E6bMDa5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="szoykUKH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+E6bMDa5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F02882B2
	for <linux-ext4@vger.kernel.org>; Thu, 12 Feb 2026 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892924; cv=none; b=as1tR2o/MDne6vAIFdKOQBV6BLRBlfzaEuy1PDw4mN1hKYsNKCdg9SiHQpkh8vLrZyaElVyGLkz1QSlAESqgJWJIPS0//zLbCEJl8FkEJzXddgvVBBY6W11mYMWN/4VXjLUStzAsTofstRfA6lj1OZMUukP7Mqw/QxmAf0fmmno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892924; c=relaxed/simple;
	bh=mv2ooTFnpte7OX5FS7AVDcn7T+zhkjdMkOi97RDw8Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuepZO2C6E+8GIOArzWVPS06YisBnJH+AjA6CLeRdTYGWdIUouFM6Uf+4UJUQklYmmsvrVd+WGsapBYjoSqyLaalj5y6n2wB72uuFs0vu//XIAKNuM8gr2dpjlUIJyf/agBNAw5tCZx5UfvFpui39e2hwp0r4PCGEdZKfk+AXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=szoykUKH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+E6bMDa5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=szoykUKH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+E6bMDa5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 068865BCDB;
	Thu, 12 Feb 2026 10:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770892920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B8tSzUkagDQHxUmZWW3obG+1BxZuYAeWeNIG1IuZZpk=;
	b=szoykUKH70uwJRMMbRfsDtB9IwqPcQLRzMH9h8ug/HkOW//4FcsC+pKagrMnbWT7AiedRs
	7LTPmzanqnOtHDbWbCL3u51/mWOmNiZnF9kphc/NXmG5l4A3tNGqyi+eycttq9Po8tAtNR
	rX3YFufSDGTSROrAYB/aARuEfDItw/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770892920;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B8tSzUkagDQHxUmZWW3obG+1BxZuYAeWeNIG1IuZZpk=;
	b=+E6bMDa5KVJNBWHNHLMEpBMn+lopiBTnRGYjp1lJKtvR5ZghGb1ZJh1KbhCCTiudwT0NF5
	UEhctG71xWxOM5Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770892920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B8tSzUkagDQHxUmZWW3obG+1BxZuYAeWeNIG1IuZZpk=;
	b=szoykUKH70uwJRMMbRfsDtB9IwqPcQLRzMH9h8ug/HkOW//4FcsC+pKagrMnbWT7AiedRs
	7LTPmzanqnOtHDbWbCL3u51/mWOmNiZnF9kphc/NXmG5l4A3tNGqyi+eycttq9Po8tAtNR
	rX3YFufSDGTSROrAYB/aARuEfDItw/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770892920;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B8tSzUkagDQHxUmZWW3obG+1BxZuYAeWeNIG1IuZZpk=;
	b=+E6bMDa5KVJNBWHNHLMEpBMn+lopiBTnRGYjp1lJKtvR5ZghGb1ZJh1KbhCCTiudwT0NF5
	UEhctG71xWxOM5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E62BF3EA62;
	Thu, 12 Feb 2026 10:41:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RKUqOHeujWmAewAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Feb 2026 10:41:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ABFDBA0A4C; Thu, 12 Feb 2026 11:41:59 +0100 (CET)
Date: Thu, 12 Feb 2026 11:41:59 +0100
From: Jan Kara <jack@suse.cz>
To: Zorro Lang <zlang@redhat.com>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Avoid failing shutdown tests without a journal
Message-ID: <zh372qbq2tq722476eaqrirmi55hxwzfs6msmzxfj6zv3jws5y@rdip5a6twsf6>
References: <20260210111707.17132-1-jack@suse.cz>
 <20260212084050.uim52ck6zhffd5kl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212084050.uim52ck6zhffd5kl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13683-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D2BC012CA02
X-Rspamd-Action: no action

On Thu 12-02-26 16:40:50, Zorro Lang wrote:
> On Tue, Feb 10, 2026 at 12:20:17PM +0100, Jan Kara wrote:
> > Hello,
> > 
> > this patch series adds requirement for metadata journalling to couple
> > of tests using filesystem shutdown. After shutdown a filesystem without
> > a journal is not guaranteed to be consistent and thus tests often fail.
> 
> Hi Jan,
> 
> This patchset makes sense to me, thanks for fixing them :)
> 
> Since you brought this up, I just tried to check all cases using _require_scratch_shutdown
> but lack _require_metadata_journaling, I got this:
> 
> $ for f in `grep -rsnl _require_scratch_shutdown tests/`;do grep -q _require_metadata_journaling $f || echo $f;done
> tests/ext4/051       <=== fixed by this patchset
> tests/generic/050
> tests/generic/461
> tests/generic/474
> tests/generic/536
> tests/generic/599
> tests/generic/622
> tests/generic/635    <=== fixed by this patchset
> tests/generic/646    <=== fixed by this patchset
> tests/generic/705    <=== fixed by this patchset
> tests/generic/722
> tests/generic/730
> tests/generic/737
> tests/generic/775
> tests/generic/778
> tests/overlay/078
> tests/overlay/087
> tests/xfs/270
> tests/xfs/546
> 
> g/050 tests ro mount, so it might not need _require_metadata_journaling.

Yes, g/050 checks using _has_metadata_journaling and treats the fs
accordingly.

> g/461 doesn't care the fs consistency, so ignore it too.

Ack.

> g/730 looks like doesn't need _require_metadata_journaling.

Ack.

> overlay/087 looks like can ignore _require_metadata_journaling.

I think this actually needs it since we shutdown the fs and then mount it
again which may fail with inconsistent fs.

> Others, include g/474, g/536, g/599, g/622, g/722, g/737, g/775, g/778,
> overlay/078
> look like all need a journal fs.

g/474 seems good to test without metadata journalling it does syncfs and
then shutdown. In that case the data checksums should be valid even without
journalling.

g/599 should be also fine - we shutdown after remounting ro so that should
be working even without journalling.

g/622 - some bits should work even without journalling but for now I guess
we should just require it for simplicity.

g/737 - uses O_SYNC - should work even without journalling (perhaps the
test should be extended to fsync also the parent dir for complete correctness).

g/775 - tests atomic writes - should work even without journalling if the
fs claims to support atomic writes

g/778 - ditto

overlay/078 - this fsyncs the file before shutdown so it should work even
without journalling (but might need to fsync the parent dir for complete
correctness).

> About x/270 and x/546, if we don't suppose other fs would like to run
> xfs cases, then xfs always support journal.

Correct.

> I initially considered calling _require_metadata_journaling directly inside
> _require_scratch_shutdown. However, I decided against it because some cases might
> only need the shutdown ioctl and don't strictly require a journal.

Absolutely. I think they should stay separate.

So to summarize I think we should still add _require_metadata_journaling to:

overlay/087
g/536
g/622
g/722

and we might add fsync of parent directory before shutdown to g/737 and
overlay/078. Does this sound good?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

