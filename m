Return-Path: <linux-ext4+bounces-13352-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPDwJAiqeGl9rwEAu9opvQ
	(envelope-from <linux-ext4+bounces-13352-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 13:05:28 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE68793FD1
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 13:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B72B301AA8C
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 12:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167703101BB;
	Tue, 27 Jan 2026 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="cK2AEMYX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FE31CAA68;
	Tue, 27 Jan 2026 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769515520; cv=pass; b=E52NUePbemiQEnCv8O4rwgn0TOS9+UfHl7218y+qLThojLTZpwuZMKlxhZ1b3Np1L62F0ck7nj9XJVkMJGc8pQXx9GM3rsvk2r7ljTZX8l142tbmBOK0TjIZ6nHCAiZManjXXdz6zbqXpb+vWpX+7lT58kLXhmJFt5d5lE7i6oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769515520; c=relaxed/simple;
	bh=gjpsAVrLFLn/ss6XSGzdQaSgkaMs5epCB+WRN5bMyvQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=G0J3gOKSdkvCuNbE1K0e0H8wjHlWGP2rdds57VS4iMNeTHHeLMLoiqliYX38+shDvLjnedt7AOPBUwNHmc3+L4qeXWMjsRiihf6HUzFIgxcArqWP98kINx3kWUj9ozaGyKVAD+B5W8In+hPK5aGxiNbyJtCEv2Kj/ac2wq3EZxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=cK2AEMYX; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1769515508; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VxQ+2p318SvV1Cd5z3HIRr8jUi5wUMbcDsUi3BKcTcNENORANSY05wIPZhEkYMbvJ6DKhNZaDLKuqGPQK9SmgiFPxbUZibUxZlXYgCyL9zXr/BsJ1Btwb6KhDXEdFIL6KUQbuqa6nC2jggNyJdzAZ6CyyUpsgkfBvFy38sYEvFk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769515508; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2i50/OElbdVUVGR3fITaTkJTxabogHfd1vXgzQrqXRQ=; 
	b=P599rkF57/2OaMvqavUwtusNyb+VzJakRG+xiyKlvTP0f3RDmMxu5foKbrYLZlGbziiYndGWSqHl4A742ov50hh+OsVCMtMME/mLABMnlJ9G5qX90XvmwnPxMueebc+lf6i82hzENbT8fuSkNvUgRybV3wecdLKH0U01Mp6EDrE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769515508;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2i50/OElbdVUVGR3fITaTkJTxabogHfd1vXgzQrqXRQ=;
	b=cK2AEMYXy6Wn1YRAIvm65LnoTvI0q/7wx7hihECrbgKo47hpLhO0Ba5xHCzpDFKj
	Yk7+1bcdtPv5oj3UqEM44uUk5dQAM2YRMlJx5ao19aCfIpC67n2aJlhipGjIZvoBUuq
	OVqvPatBgeTHXgigPxWX58kqS+eR99t6I/xJb34Q=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1769515505474648.5210275858253; Tue, 27 Jan 2026 04:05:05 -0800 (PST)
Date: Tue, 27 Jan 2026 20:05:05 +0800
From: Li Chen <me@linux.beauty>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "Zhang Yi" <yi.zhang@huaweicloud.com>, "Theodore Ts'o" <tytso@mit.edu>,
	"Andreas Dilger" <adilger.kernel@dilger.ca>,
	"Masami Hiramatsu" <mhiramat@kernel.org>,
	"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
	"linux-ext4" <linux-ext4@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>
Message-ID: <19bff57d732.675dda83304172.1851572061101730667@linux.beauty>
In-Reply-To: <20260123125737.2b6ddbbe@gandalf.local.home>
References: <20260120112538.132774-1-me@linux.beauty>
	<20260120112538.132774-7-me@linux.beauty> <20260123125737.2b6ddbbe@gandalf.local.home>
Subject: Re: [RFC v4 6/7] ext4: fast commit: add lock_updates tracepoint
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
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux.beauty];
	TAGGED_FROM(0.00)[bounces-13352-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE68793FD1
X-Rspamd-Action: no action

Hi Steven,

 > On Tue, 20 Jan 2026 19:25:35 +0800
 > Li Chen <me@linux.beauty> wrote:
 >=20
 > > Commit-time fast commit snapshots run under jbd2_journal_lock_updates(=
),
 > > so it is useful to quantify the time spent with updates locked and to
 > > understand why snapshotting can fail.
 > >=20
 > > Add a new tracepoint, ext4_fc_lock_updates, reporting the time spent i=
n
 > > the updates-locked window along with the number of snapshotted inodes
 > > and ranges. Record the first snapshot failure reason in a stable snap_=
err
 > > field for tooling.
 > >=20
 > > Signed-off-by: Li Chen <me@linux.beauty>
 > > ---
 > >  fs/ext4/fast_commit.c       | 86 ++++++++++++++++++++++++++++++------=
-
 > >  include/trace/events/ext4.h | 33 ++++++++++++++
 > >  2 files changed, 104 insertions(+), 15 deletions(-)
 > >=20
 > > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
 > > index d1eefee60912..d266eb2a4219 100644
 > > --- a/fs/ext4/fast_commit.c
 > > +++ b/fs/ext4/fast_commit.c
 > > @@ -193,6 +193,27 @@ static struct kmem_cache *ext4_fc_range_cachep;
 > >  #define EXT4_FC_SNAPSHOT_MAX_INODES    1024
 > >  #define EXT4_FC_SNAPSHOT_MAX_RANGES    2048
 > > =20
 > > +/*
 > > + * Snapshot failure reasons for ext4_fc_lock_updates tracepoint.
 > > + * Keep these stable for tooling.
 > > + */
 > > +enum ext4_fc_snap_err {
 > > +    EXT4_FC_SNAP_ERR_NONE =3D 0,
 > > +    EXT4_FC_SNAP_ERR_ES_MISS,
 > > +    EXT4_FC_SNAP_ERR_ES_DELAYED,
 > > +    EXT4_FC_SNAP_ERR_ES_OTHER,
 > > +    EXT4_FC_SNAP_ERR_INODES_CAP,
 > > +    EXT4_FC_SNAP_ERR_RANGES_CAP,
 > > +    EXT4_FC_SNAP_ERR_NOMEM,
 > > +    EXT4_FC_SNAP_ERR_INODE_LOC,
 > > +};
 > > +
 > > +static inline void ext4_fc_set_snap_err(int *snap_err, int err)
 > > +{
 > > +    if (snap_err && *snap_err =3D=3D EXT4_FC_SNAP_ERR_NONE)
 > > +        *snap_err =3D err;
 > > +}
 > > +
 >=20
 >=20
 >=20
 > > diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
 > > index fd76d14c2776..a1493971821d 100644
 > > --- a/include/trace/events/ext4.h
 > > +++ b/include/trace/events/ext4.h
 > > @@ -2812,6 +2812,39 @@ TRACE_EVENT(ext4_fc_commit_stop,
 > >            __entry->num_fc_ineligible, __entry->nblks_agg, __entry->ti=
d)
 > >  );
 > > =20
 >=20
 > Why not make the snap_err into a human readable format?
 >=20
 > #define TRACE_SNAP_ERR        \
 >     EM(NONE)        \
 >     EM(ES_MISS)        \
 >     EM(ES_DELAYED)        \
 >     EM(ES_OTHER)        \
 >     EM(INODES_CAP)        \
 >     EM(RANGES_CAP)        \
 >     EM(NOMEM)        \
 >     EMe(INODE_LOC)        \
 >=20
 > #undef EM
 > #undef EMe
 >=20
 > #define EM(a)    TRACE_DEFINE_ENUM(EXT4_FC_SNAP_ERR_##a);
 > #define EMe(a)    TRACE_DEFINE_ENUM(EXT4_FC_SNAP_ERR_##a);
 >=20
 > TRACE_SNAP_ERR
 >=20
 > #undef EM
 > #undef EMe
 >=20
 > #define EM(a)    { EXT4_FC_SNAP_ERR_##a, #a },
 > #define EM(a)    { EXT4_FC_SNAP_ERR_##a, #a }
 >=20
 >=20
 > > +TRACE_EVENT(ext4_fc_lock_updates,
 > > +        TP_PROTO(struct super_block *sb, tid_t commit_tid, u64 locked=
_ns,
 > > +             unsigned int nr_inodes, unsigned int nr_ranges, int err,
 > > +             int snap_err),
 > > +
 > > +    TP_ARGS(sb, commit_tid, locked_ns, nr_inodes, nr_ranges, err, sna=
p_err),
 > > +
 > > +    TP_STRUCT__entry(/* entry */
 > > +        __field(dev_t, dev)
 > > +        __field(tid_t, tid)
 > > +        __field(u64, locked_ns)
 > > +        __field(unsigned int, nr_inodes)
 > > +        __field(unsigned int, nr_ranges)
 > > +        __field(int, err)
 > > +        __field(int, snap_err)
 > > +    ),
 > > +
 > > +    TP_fast_assign(/* assign */
 > > +        __entry->dev =3D sb->s_dev;
 > > +        __entry->tid =3D commit_tid;
 > > +        __entry->locked_ns =3D locked_ns;
 > > +        __entry->nr_inodes =3D nr_inodes;
 > > +        __entry->nr_ranges =3D nr_ranges;
 > > +        __entry->err =3D err;
 > > +        __entry->snap_err =3D snap_err;
 > > +    ),
 > > +
 > > +    TP_printk("dev %d,%d tid %u locked_ns %llu nr_inodes %u nr_ranges=
 %u err %d snap_err %d",
 > > +          MAJOR(__entry->dev), MINOR(__entry->dev), __entry->tid,
 > > +          __entry->locked_ns, __entry->nr_inodes, __entry->nr_ranges,
 > > +          __entry->err, __entry->snap_err)
 >=20
 > And instead of having the raw value of __entry->snap_err, use:
 >=20
 >         __entry->err, __print_symbolic(__entry->snap_err, TRACE_SNAP_ERR=
))

Good point. I'll switch snap_err to __print_symbolic() in v5.

Regards,
Li=E2=80=8B


