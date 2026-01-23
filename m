Return-Path: <linux-ext4+bounces-13281-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ50Jty2c2ncyAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13281-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 18:58:52 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4F679453
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 18:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C728308845B
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 17:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC8827F005;
	Fri, 23 Jan 2026 17:57:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A627B4FA;
	Fri, 23 Jan 2026 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769191039; cv=none; b=ZIATnswe6vCE451VAP4CEOrD1vppxewkSkYa21X9ZdldkgceLHcAtyCuc2C5YOtZZN/+kTxbsrZo2rRBR+jjK5Bdtbpezv7fGCiXSwOqoSyLe2nR3ATHWS2/e28wOEnCtXgfCeoby0ZzvZwqbA7HSgAZ2BbkPqEZRm/zf1TDW04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769191039; c=relaxed/simple;
	bh=4+QLjb/CwCDeH3ExRuHJJg9vjVRhUFB/O1UZTA+VLAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nX4UF+duEP8iUL78d6rM49Fu9jMC1kHTotx5YO5KP3qiT7v2ZhS7d82n07JBERi2opeKKBpZdM0d0TXRwZpCLMkc1J4q0oRb4LX853iL/3F9G/leRVTJnfK4PYJPH86zFVrjKzkp6FRkT3kQ2fJdOe71iBo4VKBJ6qkaUmiH+mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id EAA1A16022B;
	Fri, 23 Jan 2026 17:57:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id D940920024;
	Fri, 23 Jan 2026 17:57:08 +0000 (UTC)
Date: Fri, 23 Jan 2026 12:57:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Chen <me@linux.beauty>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, "Theodore Ts'o" <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC v4 6/7] ext4: fast commit: add lock_updates tracepoint
Message-ID: <20260123125737.2b6ddbbe@gandalf.local.home>
In-Reply-To: <20260120112538.132774-7-me@linux.beauty>
References: <20260120112538.132774-1-me@linux.beauty>
	<20260120112538.132774-7-me@linux.beauty>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5cfcpomb4bsdhw65j6p7jyceep8ki3oe
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18ayUQTicwAkS19YmBMQjsoWLi9S4LSZbM=
X-HE-Tag: 1769191028-289448
X-HE-Meta: U2FsdGVkX18itwA3BKwJlBEvi7szA+ksv6rm9NUwPu/bfijaonP9EG+vaXbUVIXknmiNkJfv7pQwpqC/XM9UwwY9lcXu3qgum5zj5LeL1mbHMaWD2eX8t1r5uWLyWgMOduLC0zptT1ezNzx8y32jslJZ9MX3IV7ZZk4xBdkPyIjdbET6KzCLiH6S0O2jbBkH5drxKnanh6Ou79hNJxRgbBAkqQOHH7HLeIOx4XDbZddKY+aqrvzPsM0z5K+9vNWuSB+TZ7zoKEtGicmz9PbvOM7OUciy8gM/YImsLvrmxMTC1lJdklb9DcsmKb+8ACcU
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.999];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13281-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.beauty:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB4F679453
X-Rspamd-Action: no action

On Tue, 20 Jan 2026 19:25:35 +0800
Li Chen <me@linux.beauty> wrote:

> Commit-time fast commit snapshots run under jbd2_journal_lock_updates(),
> so it is useful to quantify the time spent with updates locked and to
> understand why snapshotting can fail.
> 
> Add a new tracepoint, ext4_fc_lock_updates, reporting the time spent in
> the updates-locked window along with the number of snapshotted inodes
> and ranges. Record the first snapshot failure reason in a stable snap_err
> field for tooling.
> 
> Signed-off-by: Li Chen <me@linux.beauty>
> ---
>  fs/ext4/fast_commit.c       | 86 ++++++++++++++++++++++++++++++-------
>  include/trace/events/ext4.h | 33 ++++++++++++++
>  2 files changed, 104 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index d1eefee60912..d266eb2a4219 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -193,6 +193,27 @@ static struct kmem_cache *ext4_fc_range_cachep;
>  #define EXT4_FC_SNAPSHOT_MAX_INODES	1024
>  #define EXT4_FC_SNAPSHOT_MAX_RANGES	2048
>  
> +/*
> + * Snapshot failure reasons for ext4_fc_lock_updates tracepoint.
> + * Keep these stable for tooling.
> + */
> +enum ext4_fc_snap_err {
> +	EXT4_FC_SNAP_ERR_NONE = 0,
> +	EXT4_FC_SNAP_ERR_ES_MISS,
> +	EXT4_FC_SNAP_ERR_ES_DELAYED,
> +	EXT4_FC_SNAP_ERR_ES_OTHER,
> +	EXT4_FC_SNAP_ERR_INODES_CAP,
> +	EXT4_FC_SNAP_ERR_RANGES_CAP,
> +	EXT4_FC_SNAP_ERR_NOMEM,
> +	EXT4_FC_SNAP_ERR_INODE_LOC,
> +};
> +
> +static inline void ext4_fc_set_snap_err(int *snap_err, int err)
> +{
> +	if (snap_err && *snap_err == EXT4_FC_SNAP_ERR_NONE)
> +		*snap_err = err;
> +}
> +



> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index fd76d14c2776..a1493971821d 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -2812,6 +2812,39 @@ TRACE_EVENT(ext4_fc_commit_stop,
>  		  __entry->num_fc_ineligible, __entry->nblks_agg, __entry->tid)
>  );
>  

Why not make the snap_err into a human readable format?

#define TRACE_SNAP_ERR		\
	EM(NONE)		\
	EM(ES_MISS)		\
	EM(ES_DELAYED)		\
	EM(ES_OTHER)		\
	EM(INODES_CAP)		\
	EM(RANGES_CAP)		\
	EM(NOMEM)		\
	EMe(INODE_LOC)		\

#undef EM
#undef EMe

#define EM(a)	TRACE_DEFINE_ENUM(EXT4_FC_SNAP_ERR_##a);
#define EMe(a)	TRACE_DEFINE_ENUM(EXT4_FC_SNAP_ERR_##a);

TRACE_SNAP_ERR

#undef EM
#undef EMe

#define EM(a)	{ EXT4_FC_SNAP_ERR_##a, #a },
#define EM(a)	{ EXT4_FC_SNAP_ERR_##a, #a }


> +TRACE_EVENT(ext4_fc_lock_updates,
> +	    TP_PROTO(struct super_block *sb, tid_t commit_tid, u64 locked_ns,
> +		     unsigned int nr_inodes, unsigned int nr_ranges, int err,
> +		     int snap_err),
> +
> +	TP_ARGS(sb, commit_tid, locked_ns, nr_inodes, nr_ranges, err, snap_err),
> +
> +	TP_STRUCT__entry(/* entry */
> +		__field(dev_t, dev)
> +		__field(tid_t, tid)
> +		__field(u64, locked_ns)
> +		__field(unsigned int, nr_inodes)
> +		__field(unsigned int, nr_ranges)
> +		__field(int, err)
> +		__field(int, snap_err)
> +	),
> +
> +	TP_fast_assign(/* assign */
> +		__entry->dev = sb->s_dev;
> +		__entry->tid = commit_tid;
> +		__entry->locked_ns = locked_ns;
> +		__entry->nr_inodes = nr_inodes;
> +		__entry->nr_ranges = nr_ranges;
> +		__entry->err = err;
> +		__entry->snap_err = snap_err;
> +	),
> +
> +	TP_printk("dev %d,%d tid %u locked_ns %llu nr_inodes %u nr_ranges %u err %d snap_err %d",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->tid,
> +		  __entry->locked_ns, __entry->nr_inodes, __entry->nr_ranges,
> +		  __entry->err, __entry->snap_err)

And instead of having the raw value of __entry->snap_err, use:

		__entry->err, __print_symbolic(__entry->snap_err, TRACE_SNAP_ERR))

-- Steve


> +);
> +
>  #define FC_REASON_NAME_STAT(reason)					\
>  	show_fc_reason(reason),						\
>  	__entry->fc_ineligible_rc[reason]

1

