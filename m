Return-Path: <linux-ext4+bounces-14676-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBI9GrRpqmlORAEAu9opvQ
	(envelope-from <linux-ext4+bounces-14676-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 06:44:20 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EFB21BC79
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 06:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44CA130312D0
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2026 05:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECAA36BCE6;
	Fri,  6 Mar 2026 05:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="OPRQUG6U"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F46176FB1;
	Fri,  6 Mar 2026 05:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772775854; cv=pass; b=pblOyvuobbXw1de2LaxYy3B9iqrJCKZgEAcZ/q72j47+T2GalUxcwfa5s35C6r/LnzjFgQWr6nzd4fGK5Tj6kNLYXyR9NKsnLzxms07hy1jXPmNTslatIWwseGQfxfQpAYkYlyqpagY+I43sVsEY8wFh7Sqqg6BamrClWcNknFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772775854; c=relaxed/simple;
	bh=+gw9a13s/gpFYd7R4D8rPabgnSrLYbHjrHv4qORcdDw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tH/m7cu8lY6E550S4iaMHeWcDpX/ioElJWcmGYReHi6likYss8PgCo56wDRY/ysFEXNve0kqsw+DQwhidn7bwPXf2CeW/RwnjMvTm8R1v2yTnBnEpxC2qgVnC44S/lKpzEZEb6pdI+rQ1CbjR4E2fJU4WeU70yC59tTPUm6uNnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=OPRQUG6U; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1772775845; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NKyOr2GzhDU50pX4+41PO+nbs7YHpx0o3MZoa0U28kXbTB0nPO7ayGnzfofyvMRFmPyChJBApXxVw9d10eBLum7pjMTQlH44sgCx3WkWNa38pPj74AXpT5/YhRPaQKbDZfZgDD+qw9E5dD24J2DZwEPkBNz8REE4Sfek78//7xo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772775845; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PBu0A6neLi68xI/PdHKRu6u86C6sbuG0XFMMa6rEgiU=; 
	b=k5zxAtUzagdFJGb6sTZksraCVQZmwuJTCRciSMdbZk+1WpTwFwF/I44+kggDT1BAvBUvgyxfro7ESaATXrkTDiNj4/AWa58r7x09g6uZ7WhgbiM0+OyyE0gwar1Deh7CgppIaBqceGnsU3RIQf5AUuLawa6p+imSXK6qb5KNEdE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772775845;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PBu0A6neLi68xI/PdHKRu6u86C6sbuG0XFMMa6rEgiU=;
	b=OPRQUG6UHTrxCiAuEzrOaGn3dMt06Qa2WTBygfGKtdWnqGW/vj7hFHRCqoqHXPx9
	KpzXWskC1+3mwAShy72F9SBl5Ln+UmYxXWN7aIi4/YqUxCfu4k5jnBcS3az4IGJTRCS
	2OgPtZETJUA81T3MmoPHyayKQDUCoG6TBk7ufmRA=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1772775842483476.0281196095559; Thu, 5 Mar 2026 21:44:02 -0800 (PST)
Date: Fri, 06 Mar 2026 13:44:02 +0800
From: Li Chen <me@linux.beauty>
To: "Jan Kara" <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, "Mark Fasheh" <mark@fasheh.com>,
	"linux-ext4" <linux-ext4@vger.kernel.org>,
	"ocfs2-devel" <ocfs2-devel@lists.linux.dev>,
	"Jan Kara" <jack@suse.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19cc1aca2a2.6a1ddcaa4201103.2951903079220142463@linux.beauty>
In-Reply-To: <jekg3rqfscaashwrnzisjjwpcyep2d4w6niyiahcastic4gmcz@3lgz3oqsfavk>
References: <20260224092434.202122-1-me@linux.beauty>
 <20260224092434.202122-5-me@linux.beauty>
 <6oexp6kpanvquzjn3nnqqg6wyyhh6og7jjb7fitlj7vzlj5vzp@cobcxovcgzg5> <jekg3rqfscaashwrnzisjjwpcyep2d4w6niyiahcastic4gmcz@3lgz3oqsfavk>
Subject: Re: [PATCH v3 4/4] jbd2: store jinode dirty range in PAGE_SIZE
 units
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Rspamd-Queue-Id: D3EFB21BC79
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linux.beauty,none];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14676-lists,linux-ext4=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.beauty:dkim,linux.beauty:email,linux.beauty:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Jan,

 ---- On Tue, 03 Mar 2026 17:01:28 +0800  Jan Kara <jack@suse.cz> wrote --- 
 > On Mon 02-03-26 19:27:13, Jan Kara wrote:
 > > On Tue 24-02-26 17:24:33, Li Chen wrote:
 > > > jbd2_inode fields are updated under journal->j_list_lock, but some paths
 > > > read them without holding the lock (e.g. fast commit helpers and ordered
 > > > truncate helpers).
 > > > 
 > > > READ_ONCE() alone is not sufficient for the dirty range fields when they
 > > > are stored as loff_t because 32-bit platforms can observe torn loads.
 > > > Store the dirty range in PAGE_SIZE units as pgoff_t instead.
 > > > 
 > > > Use READ_ONCE() on the read side and WRITE_ONCE() on the write side for the
 > > > dirty range and i_flags to match the existing lockless access pattern.
 > > > 
 > > > Suggested-by: Jan Kara <jack@suse.cz>
 > > > Reviewed-by: Jan Kara <jack@suse.cz>
 > > > Signed-off-by: Li Chen <me@linux.beauty>
 > > ...
 > > > @@ -2654,15 +2655,20 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
 > > >      jbd2_debug(4, "Adding inode %lu, tid:%d\n", jinode->i_vfs_inode->i_ino,
 > > >              transaction->t_tid);
 > > >  
 > > > +    start_page = (pgoff_t)(start_byte >> PAGE_SHIFT);
 > > > +    end_page = (pgoff_t)(end_byte >> PAGE_SHIFT);
 > > 
 > > MAX_LFS_SIZE on 32-bit is ULONG_MAX << PAGE_SHIFT and that's maximum file
 > > size. So we could do here end_page = DIV_ROUND_UP(end_byte, PAGE_SIZE) and
 > > just use end_page as exclusive end of a range to flush and get rid of
 > > special JBD2_INODE_DIRTY_RANGE_NONE value.
 > > 
 > > The problem with the scheme you use is that files of MAX_LFS_SIZE would be
 > > treated as having empty flush range...
 > 
 > Or perhaps even easier might be to set start_page to ULONG_MAX and end_page
 > to 0 and use start_page > end_page as an indication of empty range.

Great idea! Thanks for the detailed review.

I will update the range handling to avoid the sentinel collision.

Regards,
Li

