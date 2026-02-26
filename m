Return-Path: <linux-ext4+bounces-14175-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKgNLuC3oGnClwQAu9opvQ
	(envelope-from <linux-ext4+bounces-14175-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 22:15:12 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9F71AF930
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 22:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D264D30FAC2C
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 21:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1429945104A;
	Thu, 26 Feb 2026 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HW/o4Vat"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB0B4657E5
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140319; cv=pass; b=iX2rnaKhfyrvGFaCmaYeFlUWiDBxH/ew3JMRRed8KOH+wo/uFpE5LhLhc8zAgjul8oDRROI4WuER9EvjVMfibdpST62O8Gatpc+FKnPBs/+ecmJFLHplcAxFMfbJfy4OabxE3/eIsG2LvohVUJ21+yhLi5IH3mp+H2pwo9A2Yoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140319; c=relaxed/simple;
	bh=bnDaNoU6qjKfC/eAGGjHl/JBEfLQ2MSCDsq35dJ1WO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ryoEP3HtyCA4HQ9dmrtIueWPCbw2cA1fC2BhuXTOUGQhhDYa/dUG9ViNeJl+AtcKOWz1FViiPMcTEba+hFSWhII8iPo1TmxIs72MDkM0cAlfi3AR3HvOjcJkhqfK1+H3KrdGVuGrEwoeqPWLWK6caPXU4qE8g+0GVyIr6I51//k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HW/o4Vat; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-354c67da885so1100827a91.3
        for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 13:11:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772140314; cv=none;
        d=google.com; s=arc-20240605;
        b=IbIvKMqnc5TVfJ/tj38pJ3hrnVe1xIp0Rrb1ybMGCGKb66sB5PI9XVUIDMgvV7sPPB
         SufxIfQ5wHzVLMeQhbr36LY7AnN188AS82/VKO98H6fF4l4mEZt6iZLDAeuOEsB5N2uH
         UH93QTwIQv5iYuctxNSnbcHGu+IJnsXWeYtHNU6R6C6hU/uaWQa4jzE6qpLg+17iIn98
         0LMKop+2++O2W1PeSUGSCoPfEuYwogij8C2OAB9JoGtQdosRN4UkFoDEHLLfiw6Ja2xT
         76CMPsNyvkpnrc6UvuzwTdGJ3622NQx642iKsoZVqeACX5cYDSNckn4OTiDMLQnQT9LW
         AZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zmNhsrxkJsNmzJoSll+GD0SvmHq0rQdZiw5NaBd3y6o=;
        fh=VNa+1LfM8sH5gSxV0aLopSLyvBNrGF8yuNPE1thbiTk=;
        b=TbX8gIJBUmKsfHbVQ8SqDAcx7LDqYc6LP/gusmZ4SxywjKth0PVXeOvbyDXyJVXyEn
         zjcohOODMc/wR1WDEO9Yn6g9kVTCCufsAQFD6myCCDFIPa/8aLINY6c18JnhMzyOir4r
         d9AOItuAMv9dKfKy3MoUCqNie+vuCGyBhLIac2XNsvhLBHm5ihM6If+GovOxzVbnZcqA
         nEWKBsOlPC+ONZKwbi7sSlrZH9OiBP6N0Ta2zUbMDrSenAEijmpqPGsXJ2hk25VLHqtw
         a4WM1lZ4C2Lp+k2oAr9+mAzYY81QSnqu7D+dI4HGflDTwYFWCcbYNXcec4qifnjleRgu
         GvDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772140314; x=1772745114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmNhsrxkJsNmzJoSll+GD0SvmHq0rQdZiw5NaBd3y6o=;
        b=HW/o4Vata6iL0319Ebvg+XwcmFV3aXvPxwJavhnSNkrdZzg0DUnb3gyhur+Z5qjlLy
         DF8ktagjV0h021ZkfaIiy95wdENx8nhp/3Vvz2748i/fBYrVuloVbagkkQGgRNG86+Xf
         7YlzwOmtdpv3bWcOUuDxueD4ZLfhl1dx7sRZkDnHp2PU66qfJaPiPJAVJ/M8KD8ERzr8
         bIQQxKK/DZLsihhNuRa8yQlW78+eqc562C9u6niHHz0B0ONpkKGa75Gk3umCQziU6XHm
         celOWJX9fFF/7lcRec9du77GkDGs1yNtYP28Isk20pFkO0mQFH92SHVI+gBYVb/yj5+Z
         wXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140314; x=1772745114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zmNhsrxkJsNmzJoSll+GD0SvmHq0rQdZiw5NaBd3y6o=;
        b=WPf7u6WDJa4Sf5x6TOjyffPM4xNJe6clYlOV9EmqQeKv33b9xhNj/VkpJASrD1JOaF
         6ta+KuzNG0RsZZOngtIwGlQuQEHZtWSy65q4Q4PaVRL8/FPJJYjlyrJ2vwFw+wHbZcE1
         nvFhG3FpldGiVWjhebWS/7p8DxqSkLbMiq6dhCygGSsn7CLA0uCUev3Hzw/BAdB/nKGZ
         GDP7C2RBWWp/Hf9wkRGROg2UoxCS0gqtYVLAELjMsNPIpHYTNBBCJtLV+s5POMvebx1E
         Tx1+1WTYWIZ0azKVOkMnlY0WrUV8z72mB79d9ccgs8yMVnFmo1ywBu2yfkv4/eKqp0fw
         V6Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWjhgvkgAqYvW+C6bWhvp/ikHNYO7BQYhFOcKIB6tds16/xr0dvxbeUy0E5mfqrDbjGAvuSIyb0s+9j@vger.kernel.org
X-Gm-Message-State: AOJu0YxPrQCm7a/E5JAyPi7+8AKJrxTszq53RaYfo5bvfgXZOLy3uhGN
	VDeRyMu6EFFRRNWYIqy6ODgsXEfeN9+QMUVW2fqFxzTDo9SwQItgpk2tI3WIkg8ngORFxcwtVvW
	y60/Ze5b+Dgjr/ESVHhESDSksFzsqsh5rbKHlrx5p
X-Gm-Gg: ATEYQzwmWzURzBPdGJp3rgGsBbdCKA9eqrWSEf7qWz9k7Nluvr2aM7h35x7CkGb9CZ1
	6/B2CWsTfasuf1f/8/IDGO9jIjBj9mErTWalbGl+oXlioc9Xm6MCe+U1OElanXtm/RYnLbIfRuI
	X/yV51BpjLY/VIbSfSRDgJqumx0y9viqjXz0A3890SsPAATCPYbRSFIN2QnRA02Jdbu97klOt2o
	lHqG5Hk2aHscpwjNVOoARFrlrb5oBZE25MlJZCa5Fts5zlSUyzbxXpWxdTlZCtmdYC9aVv2r2mt
	GTwfVLc=
X-Received: by 2002:a17:90b:574f:b0:359:877:370f with SMTP id
 98e67ed59e1d1-35965ccf029mr498632a91.17.1772140313953; Thu, 26 Feb 2026
 13:11:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org> <20260226-iino-u64-v1-51-ccceff366db9@kernel.org>
In-Reply-To: <20260226-iino-u64-v1-51-ccceff366db9@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 26 Feb 2026 16:11:41 -0500
X-Gm-Features: AaiRm51CHDvKlRV2Z04ZUK5c4lU9AiJhpRFTzD6a70HHA0FgEKDqsojtRqG1Wpw
Message-ID: <CAHC9VhTPutzjNfYoRJigC2AQS4wz1A3vTEYn2koeR0kKetYk0w@mail.gmail.com>
Subject: Re: [PATCH 51/61] security: update audit format strings for u64 i_ino
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Steve French <sfrench@samba.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Alexander Aring <alex.aring@gmail.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>, Amir Goldstein <amir73il@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Martin Schiller <ms@dev.tdt.de>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-x25@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.org];
	TAGGED_FROM(0.00)[bounces-14175-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[145];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:url,paul-moore.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D9F71AF930
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:06=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> Update %lu/%ld to %llu/%lld in security audit logging functions that
> print inode->i_ino, since i_ino is now u64.
>
> Files updated: apparmor/apparmorfs.c, integrity/integrity_audit.c,
> ipe/audit.c, lsm_audit.c.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  security/apparmor/apparmorfs.c       |  4 ++--
>  security/integrity/integrity_audit.c |  2 +-
>  security/ipe/audit.c                 |  2 +-
>  security/lsm_audit.c                 | 10 +++++-----
>  security/selinux/hooks.c             |  4 ++--
>  security/smack/smack_lsm.c           | 12 ++++++------
>  6 files changed, 17 insertions(+), 17 deletions(-)

...

> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 7d623b00495c14b079e10e963c21a9f949c11f07..737f5a263a8f79416133315ed=
f363ece3d79c722 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c

Everything in security/lsm_audit.c looks okay.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d8224ea113d1ac273aac1fb52324f00b3301ae75..150ea86ebc1f7c7f8391af410=
9a3da82b12d00d2 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1400,7 +1400,7 @@ static int inode_doinit_use_xattr(struct inode *ino=
de, struct dentry *dentry,
>         if (rc < 0) {
>                 kfree(context);
>                 if (rc !=3D -ENODATA) {
> -                       pr_warn("SELinux: %s:  getxattr returned %d for d=
ev=3D%s ino=3D%ld\n",
> +                       pr_warn("SELinux: %s:  getxattr returned %d for d=
ev=3D%s ino=3D%lld\n",
>                                 __func__, -rc, inode->i_sb->s_id, inode->=
i_ino);
>                         return rc;
>                 }

Additionally, later in this function there are pr_notice_ratelimited()
and pr_warn() calls that print inode numbers and need to be updated.

--=20
paul-moore.com

