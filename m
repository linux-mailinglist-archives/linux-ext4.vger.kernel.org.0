Return-Path: <linux-ext4+bounces-13753-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAgPDb4CmGnw/AIAu9opvQ
	(envelope-from <linux-ext4+bounces-13753-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Feb 2026 07:44:14 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EDA165082
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Feb 2026 07:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 614B13019827
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Feb 2026 06:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CC432E138;
	Fri, 20 Feb 2026 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="L9Ay0Tdg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE41862A;
	Fri, 20 Feb 2026 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771569847; cv=pass; b=Cm5yLN8DALUOwaeUV2I9SW6UGljRyX5ynJHGX7nXU/jwP+AUKGWJ6ISUEKe+zcU2jrASf2Kqa821N2AE+xHCp9x357Q/BidMwKdFotN9d8bDdH3YyA8uyrZQyF77cXlQVC8Z/uSdTdkAsb9rpbDEM5JGA63IX2YnghO5LHjvK8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771569847; c=relaxed/simple;
	bh=xiLdXXTT77hKWwTz2ZB3HFYX7+Yw674RvCpL9vzzw/Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=TfGZFrA+2+a8lOQuzXz5pNwtxNz3W0yWK2ujrrfT1WUb8P0s7cJMc67shJu5UgycHjjsoq4qxcdQGy74XhvjMEvwCwVlDdPnKSvQ/WbRryLbgKAW4ZA/TVL5g82XXReAyQv25ERo59Ml+LPmQmGQhygNh7wm/4+Jy2VxXlMBRDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=L9Ay0Tdg; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1771569826; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Le0VkAL20hqQDkX6S0FziJY8DUaGgqZhBDg8LOtWF5l95FWV2S0Jd+Le+yjDqYKqAV4+gqSrBm+Br2Ss/rwbCwp4BbfHUIAXuOiNmq+FLnUZfXo7HsWQoTrO7eetfdrbFa0vgUVYY0ZexRXQ5y3iUb7iHC+dSQLw+rN/3jCD6Qs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771569826; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zFnXr7Gv21y89XW/CUX7uI1ixjIhrwQ+bzwEz833C/o=; 
	b=J8+CS2XAG2TCgRhXJe0xMAtUEPfZUph33826T4oAHtprr+iOlAT0eqqZoDWrKpQ0tSEhC97FE3ZmeSLgYXbyGgmm94S+8KUvpsatiiwoQOJ7lzGX1o6uC9h1jTwgELviXAug6ub6BMnyLkSN08BrsBn4vRVBzx3TVBz3Id4uKBU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771569826;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zFnXr7Gv21y89XW/CUX7uI1ixjIhrwQ+bzwEz833C/o=;
	b=L9Ay0Tdg8pzsnhGSmjCJPhYvbZ1OUWGrCOyfiPhY4jbmdp1nHXBSXuwZ6j5GzZK1
	OSX3aE88xqsBCYxBGsqmE3qklutOAJCnuMDioHoNJ2N+ECvFDiIiy5xMtjDTux9xWnw
	0v7/scWqRUc12Tidk4f5XUsjlmydvMEotD4Bpe/w=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1771569824809302.1211205076038; Thu, 19 Feb 2026 22:43:44 -0800 (PST)
Date: Fri, 20 Feb 2026 14:43:44 +0800
From: Li Chen <me@linux.beauty>
To: "Andreas Dilger" <adilger@dilger.ca>
Cc: "Theodore Ts'o" <tytso@mit.edu>, "Jan Kara" <jack@suse.cz>,
	"Mark Fasheh" <mark@fasheh.com>,
	"linux-ext4" <linux-ext4@vger.kernel.org>,
	"ocfs2-devel" <ocfs2-devel@lists.linux.dev>,
	"Matthew Wilcox" <willy@infradead.org>, "Jan Kara" <jack@suse.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19c79ca43a6.6b379cc81360187.4397285579129640737@linux.beauty>
In-Reply-To: <63C86D0D-9EF6-4D33-95B2-8D0F5B305B0B@dilger.ca>
References: <20260219114645.778338-1-me@linux.beauty>
 <20260219114645.778338-2-me@linux.beauty> <63C86D0D-9EF6-4D33-95B2-8D0F5B305B0B@dilger.ca>
Subject: Re: [PATCH v2 1/3] jbd2: store jinode dirty range in PAGE_SIZE
 units
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linux.beauty,none];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13753-lists,linux-ext4=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dilger.ca:email]
X-Rspamd-Queue-Id: 72EDA165082
X-Rspamd-Action: no action

Hi Andreas,

Thanks a lot for your review!

 ---- On Fri, 20 Feb 2026 05:00:13 +0800  Andreas Dilger <adilger@dilger.ca=
> wrote ---=20
 > On Feb 19, 2026, at 04:46, Li Chen <me@linux.beauty> wrote:
 > >=20
 > > jbd2_inode fields are updated under journal->j_list_lock, but some pat=
hs
 > > read them without holding the lock (e.g. fast commit helpers and order=
ed
 > > truncate helpers).
 > >=20
 > > READ_ONCE() alone is not sufficient for i_dirty_start/end as they are
 > > loff_t and 32-bit platforms can observe torn loads. Store the dirty ra=
nge
 > > in PAGE_SIZE units as pgoff_t so lockless readers can take non-torn
 > > snapshots.
 >=20
 > When making semantic changes like this, it is best to change the variabl=
e
 > names as well, so that breaks compilation if bisection happens to land
 > between these patches.  Otherwise, that could cause some random behavior
 > if jbd2 is treating these as pages, but ext4/ocfs2 are treating them as
 > bytes or vice versa.
 >=20
 > Something like i_dirty_{start,end} -> i_dirty_{start,end}_page would mak=
e
 > this very clear what the units are.

Agreed. I=E2=80=99ll make the units explicit in the field names (e.g. *_pag=
e).

 > To avoid breakage between the patches (which is desirable to avoid probl=
ems
 > with automated bisection) you should make an initial patch with wrappers=
 to
 > access these values and convert ext4/ocfs2 to use them:
 >=20
 > static inline loff_t jbd2_jinode_dirty_start(struct jbd2_inode *jinode)
 > {
 >     return jinode->i_dirty_start;
 > }
 >=20
 > static inline loff_t jbd2_jinode_dirty_end(struct jbd2_inode *jinode)
 > {
 >     return jinode->i_dirty_end;
 > }
 >=20
 > then change this in the jbd2 patch at the end, which would then be self-=
contained:
 >=20
 > static inline loff_t jbd2_jinode_dirty_start(struct jbd2_inode *jinode)
 > {
 >     return (loff_t)jinode->i_dirty_start_page << PAGE_SHIFT;
 > }
 >=20
 > static inline loff_t jbd2_jinode_dirty_end(struct jbd2_inode *jinode)
 > {
 >     return ((loff_t)jinode->i_dirty_end_page << PAGE_SHIFT) + ~PAGE_MASK=
;
 > }


Agreed as well. I=E2=80=99ll add an accessor and switch ext4/ocfs2 over to =
it first,
Then do the internal representation change later.

I plan to use a single helper that returns the (start,end) pair in
bytes:

static inline bool jbd2_jinode_get_dirty_range(const struct jbd2_inode *jin=
ode,
loff_t *start, loff_t *end)
{
    pgoff_t start_page =3D READ_ONCE(jinode->i_dirty_start_page);
    pgoff_t end_page =3D READ_ONCE(jinode->i_dirty_end_page);

    if (end_page =3D=3D JBD2_INODE_DIRTY_RANGE_NONE)
      return false;

    *start =3D (loff_t)start_page << PAGE_SHIFT;
    *end =3D ((loff_t)end_page << PAGE_SHIFT) + PAGE_SIZE - 1;
    return true;

}

I think this is a bit easier to use correctly than separate start/end helpe=
rs
(keeps start/end together, and the end-of-page conversion lives in one plac=
e).

Does that sound OK, or would you rather see separate
jbd2_jinode_dirty_start()/jbd2_jinode_dirty_end() helpers?

Regards,
Li=E2=80=8B


