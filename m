Return-Path: <linux-ext4+bounces-13686-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDDVLGUDjmlf+gAAu9opvQ
	(envelope-from <linux-ext4+bounces-13686-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 17:44:21 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0957112F8C8
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 17:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B8CE30297AA
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 16:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A897135D5FB;
	Thu, 12 Feb 2026 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFmPHFdK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F57121E0AD;
	Thu, 12 Feb 2026 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914648; cv=none; b=SVd86ruEoV8gLsLquZJ7U2D90yAqd42iricKl8n5kjuaQD6MRJSShJOvDwUYbWOmv4qiRucXLwhRB0sx24yTcqDKXtTqLkaG3eI70WUH/0RhkexlDBraGf+R9wkn7AyGnwdSrJvSMvgak4LDTmRlc5PZXYcra7iKFQ2zyUblyX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914648; c=relaxed/simple;
	bh=fBMZV8xeH7Lcc1Qw6/Gnc3TMizQuKDrdeQ4lbPdBWZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdAyWEGwx8FNT+/aS/ysicwB62h2/ADvBB50gXpRIYi6Q3q6nvrSw9vEYjx2COvB6ePyZedxFOeJ61WqR7M/gDaqMii+v29uvYrRSvFeRT4Cs5ZscA8IA49tmcIrVR8WqI4YHCPH07Mt39d2RVQ46i8cG/q+5/9FhXVdBrLoa0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFmPHFdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D3FC4CEF7;
	Thu, 12 Feb 2026 16:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770914647;
	bh=fBMZV8xeH7Lcc1Qw6/Gnc3TMizQuKDrdeQ4lbPdBWZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFmPHFdKqSXPmhasKk6ip96QkCcVfaVRkXY7xGL6mi5SQ+PWdnwV+TJyb4uHxV0Io
	 Ml8w67wprqX1XcrjdfahMTCL6vanjqAX4V2+xN89eJSOJI1CRM3Th3iPmtoHZUn1RO
	 FLug9OcVocwGHa96XI29iqIbWjXvrbV5Y0QzbmcctCQzYVHSn6xNmPhiOpNnhp9+gw
	 FNKTR7Y13CeTxnl0cMEcB2RmindzLLwohYtvTJoP4SrS/GNDbCKVAlF6KcVTSYNdxv
	 QS9s0A9Dkgrjw0SckBQY8Sgp+tiJq2vOJP0lB4QBYzLRgy4kBvAz3QA7f92CwTMdSH
	 9T6KlpgbpD3Dw==
Date: Fri, 13 Feb 2026 00:44:02 +0800
From: Zorro Lang <zlang@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Avoid failing shutdown tests without a journal
Message-ID: <20260212164402.tbjcalfmeq6jfwum@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260210111707.17132-1-jack@suse.cz>
 <20260212084050.uim52ck6zhffd5kl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <zh372qbq2tq722476eaqrirmi55hxwzfs6msmzxfj6zv3jws5y@rdip5a6twsf6>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zh372qbq2tq722476eaqrirmi55hxwzfs6msmzxfj6zv3jws5y@rdip5a6twsf6>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13686-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zlang@kernel.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,dell-per750-06-vm-08.rhts.eng.pek2.redhat.com:mid]
X-Rspamd-Queue-Id: 0957112F8C8
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 11:41:59AM +0100, Jan Kara wrote:
> On Thu 12-02-26 16:40:50, Zorro Lang wrote:
> > On Tue, Feb 10, 2026 at 12:20:17PM +0100, Jan Kara wrote:
> > > Hello,
> > > 
> > > this patch series adds requirement for metadata journalling to couple
> > > of tests using filesystem shutdown. After shutdown a filesystem without
> > > a journal is not guaranteed to be consistent and thus tests often fail.
> > 
> > Hi Jan,
> > 
> > This patchset makes sense to me, thanks for fixing them :)
> > 
> > Since you brought this up, I just tried to check all cases using _require_scratch_shutdown
> > but lack _require_metadata_journaling, I got this:
> > 
> > $ for f in `grep -rsnl _require_scratch_shutdown tests/`;do grep -q _require_metadata_journaling $f || echo $f;done
> > tests/ext4/051       <=== fixed by this patchset
> > tests/generic/050
> > tests/generic/461
> > tests/generic/474
> > tests/generic/536
> > tests/generic/599
> > tests/generic/622
> > tests/generic/635    <=== fixed by this patchset
> > tests/generic/646    <=== fixed by this patchset
> > tests/generic/705    <=== fixed by this patchset
> > tests/generic/722
> > tests/generic/730
> > tests/generic/737
> > tests/generic/775
> > tests/generic/778
> > tests/overlay/078
> > tests/overlay/087
> > tests/xfs/270
> > tests/xfs/546
> > 
> > g/050 tests ro mount, so it might not need _require_metadata_journaling.
> 

Hi Jan,

Thanks for your detailed response.

> Yes, g/050 checks using _has_metadata_journaling and treats the fs
> accordingly.

I didn't notice that line, thanks.

> 
> > g/461 doesn't care the fs consistency, so ignore it too.
> 
> Ack.
> 
> > g/730 looks like doesn't need _require_metadata_journaling.
> 
> Ack.
> 
> > overlay/087 looks like can ignore _require_metadata_journaling.
> 
> I think this actually needs it since we shutdown the fs and then mount it
> again which may fail with inconsistent fs.

Thanks for the reminder, I totally overlooked the sync call. You're right, even
aside from the journal, sync effectively help filesystem to be a consistent
state (if no any hardware crashes during the sync running)

> 
> > Others, include g/474, g/536, g/599, g/622, g/722, g/737, g/775, g/778,
> > overlay/078
> > look like all need a journal fs.
> 
> g/474 seems good to test without metadata journalling it does syncfs and
> then shutdown. In that case the data checksums should be valid even without
> journalling.

Sure.

> 
> g/599 should be also fine - we shutdown after remounting ro so that should
> be working even without journalling.

Oh, there's "_scratch_remount ro" before shutdown, sure.

> 
> g/622 - some bits should work even without journalling but for now I guess
> we should just require it for simplicity.
> 
> g/737 - uses O_SYNC - should work even without journalling (perhaps the
> test should be extended to fsync also the parent dir for complete correctness).
> 
> g/775 - tests atomic writes - should work even without journalling if the
> fs claims to support atomic writes
> 
> g/778 - ditto
> 
> overlay/078 - this fsyncs the file before shutdown so it should work even
> without journalling (but might need to fsync the parent dir for complete
> correctness).

I'm not sure we can arbitrarily add more sync calls before or after a specific
fsync step. Doing so might break the original intent of the test. So I think
we can keep it, and see if anyone complains or hits a bug later :)

> 
> > About x/270 and x/546, if we don't suppose other fs would like to run
> > xfs cases, then xfs always support journal.
> 
> Correct.
> 
> > I initially considered calling _require_metadata_journaling directly inside
> > _require_scratch_shutdown. However, I decided against it because some cases might
> > only need the shutdown ioctl and don't strictly require a journal.
> 
> Absolutely. I think they should stay separate.
> 
> So to summarize I think we should still add _require_metadata_journaling to:
> 
> overlay/087
> g/536
> g/622
> g/722

Agree :)

> 
> and we might add fsync of parent directory before shutdown to g/737 and
> overlay/078. Does this sound good?

I'm concerned that adding broader sync or fsync operations might interfere with the
test's original intent. We should probably evaluate the impact further. Alternatively,
we could simply use _require_metadata_journaling to ensure we at least keep the
coverage for the original bug :)

Any more ideas please feel free to tell me.

Thanks,
Zorro

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

