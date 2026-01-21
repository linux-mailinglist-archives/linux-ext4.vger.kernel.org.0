Return-Path: <linux-ext4+bounces-13168-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEoLE64mcWmqewAAu9opvQ
	(envelope-from <linux-ext4+bounces-13168-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 20:19:10 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA475BFE0
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 20:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5BC8D7E860F
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 19:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2821B36B05B;
	Wed, 21 Jan 2026 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke3b0iRs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E031936C5A6
	for <linux-ext4@vger.kernel.org>; Wed, 21 Jan 2026 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022013; cv=pass; b=YH1o5R5+UN6+HiVyXT3vxWZ1i7wVH6Bkjn9v8KYrrDgnOKxlBmEBZhRhgjcljb3D0IO+mCTTaZ/L1AS0JjAy9085bIEi/hlxFFSs0h6eC+dmfCO48b2slIWeHklnMhpBycPewqmureSfGrqPcd+rcvsWgx5vtUY72m8sLKA0dVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022013; c=relaxed/simple;
	bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyzON5uLaYJ4YHtAKDdKhZeymxwrCU/kQyhiIewdg0Yrk/ZH/6VGYxX7DCxlaluQj0M04WgxsACJj5UDrcUULM7mXiYe/7tvFszbHbKUvSD51ouXHRpVcmVbqNGdWqBwMj9XpnKb4MwpGVhiNk3oUWpFlXC91aGODE7P4ogCMHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ke3b0iRs; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b87693c981fso20613866b.1
        for <linux-ext4@vger.kernel.org>; Wed, 21 Jan 2026 11:00:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769022008; cv=none;
        d=google.com; s=arc-20240605;
        b=a3Uf6M3XnFpHTbu5w4RF05Qpqhy7ZfKEfmlEQXZU2ng0gfUNQ2lu8kK9080JbikoxK
         /OqLoBQkjJ4fAez5vUuNCC7Vhn2Lo/TiGPzk3BF4rtb/MTu1T0gZEsC3QMLU50eCV5FA
         DDYLdWGly1lbIrvzXfLg+o7iKFf1q76t5yh8XgP3XQ07sF8uEl1H6abLqhU0ftmHc6Fq
         Sy+jgOparI4NAl3AoVOYzWL6QZL9OGWpC3gzSr3JDJtWGVzUY7F3qSG5v+qDdIxs3Ce/
         MinEH05QSr7H/aOPZfQEv1NCiYUWRQu9FlYB3x9qqjQncYDakwt0hbUOhmE7NbOp/2ry
         ak+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
        fh=ea4FStsmir9UNSBmAfTugQ3nvVwLlBdzrmt5bYGuH7A=;
        b=DBxScAP2JZK0m//34wZBRMOcOCyKkI1fzTCOhiJNI0zY53ghey1t1iMss9EmJmZvne
         Cr800WPxEHSwCUig6vShZ6Wc/7eVCNsxSB7glBBYh6ALoM0wCfIjU5CFl0BhYLNS+urK
         Lv3dn+O3sKoW3vU+F37G+t8PYT2RpCAdhCyLQ3cSpEi4qh/D422C0tGgyykjlQIsNqxU
         OlB09HCt51UMI2QzhlHnmqH7CSXmy8PdEPAcArtNhla5eE9uH7oZql7WilRkpADZOVdY
         y9tvCDkuinR3/+FaXPg2flHKexpGtnTOUzgI8FUD36XJcOSOgr/WJcXSIKfoJQeOnMFS
         FVnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769022008; x=1769626808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
        b=ke3b0iRsOPGdb9oGItiqf3p2ocGTfsItthso0F5B2fak03CUA0liWLn/Ve+kCx5qdQ
         JombE0ayrWVRZQXIZl23qp9IKs0OR39m8RilvLRQvVGHRFm30KkpG++OotWZ92AwuCGc
         mfAvUOj8NIFwo25zttpr2t9oiEAh7Td8L4n9JqF49lbt65BYqwZMpd8IuL+pjuR3w7Cx
         uwF7vQXLdVLV63Ny5cgNkQ66Jb7r0JOenkZbCMRNua5Ow/a8OGWNheD6DVKMa3a6U1VX
         hddDJM9Nq2Z5pHCrVaA1w4AG9WOs41axr0x1rUqjUrhki3bUl8DCRQXOnsnH+8mR9kKE
         KgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769022008; x=1769626808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
        b=mPBxDhS5bhVELfKlPnlC3+ofTR1OQzdLpDxV4LgBECKobZKvPuS40VhToErz2Y7SIy
         q41zWCqoNWORdQhOpPc3WoFjr80VlmKJRIQRsuYFQuGIMiz7PDCZSGYTCFKi8NfAszhF
         U4SAhIISnymkM+s0jpwL0rHPhwyXSvfzfL0TQ7VguQ10Vdzp+paXN+6Ef6rjMyuM+p2o
         tOPg6ToG8sjmi6bBM5tG8OpMkBlwaVNiC9tOmZK+BxQhVUSDVuGinx1V9dJ6MuT/V1lV
         Qo++ksJU/lsEAwWEcwJaY71Psl/VtxUrY8XA6LWRJv73Ks0EX7Bh8NTOyJwkenxFENhO
         ypYw==
X-Forwarded-Encrypted: i=1; AJvYcCV/XtlYld0dEi31/stPk0NvmcudzjXvrx8Gt19QEa+UGyImWZcU7sBqwERCJSBKGSkKsIj5xKAGdY/O@vger.kernel.org
X-Gm-Message-State: AOJu0YxtWHYJGYFAm/cCOPc2gUMotUia/osUdJkINkPoUKhgVRtfHZf+
	OiQVCs0nRUHA5IWQyBx4w1Awf58zSZbQIMy4XOfyXykrNHqVKZOoboRZ474AermYKq4IzcAqNqF
	m32YEYbMk1NAmXw9BgthBsprHEhje7hw=
X-Gm-Gg: AZuq6aLerqRnP+cE05B/iDrxtO/xHtdJmt45yoQiYuR+qp8n3tM298nmCuMFUz+KxsZ
	KsPn1r0+r5sSZoH8KYHOPjQw1yPzpxmB5ZtTzB451UrivMyXkTvEQENuYnPun20cchPoIT9WUOf
	H2qWuVnMVYwTc1ZWAzLEYs7R5QcZQPN1SCa0LCrVwsXZD+A9LPaoX8upPQS2ByBu3OpyMb+65cN
	1QCh9bh2IdsxJkrBFucd+4H1DSlNqFn9Xx888LkhC0wSiHX6C7NTXM/gfAIlTNg7+NjYxdVJIMT
	fwKwJuHuQzIQyJeeK60hodt5NFk=
X-Received: by 2002:a17:906:6a13:b0:b87:206a:a23b with SMTP id
 a640c23a62f3a-b8792f79852mr1477117366b.34.1769022007470; Wed, 21 Jan 2026
 11:00:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>
 <aW3SAKIr_QsnEE5Q@infradead.org> <176880736225.16766.4203157325432990313@noble.neil.brown.name>
 <20260119-kanufahren-meerjungfrau-775048806544@brauner> <176885553525.16766.291581709413217562@noble.neil.brown.name>
 <20260120-entmilitarisieren-wanken-afd04b910897@brauner> <176890211061.16766.16354247063052030403@noble.neil.brown.name>
 <20260120-hacken-revision-88209121ac2c@brauner> <a35ac736d9ebc6c92a6e7d61aeb5198234102442.camel@kernel.org>
 <176896790525.16766.11792073987699294594@noble.neil.brown.name> <ccb32c576cc4ebf943d5ec35e3d7ba4ae8892acd.camel@kernel.org>
In-Reply-To: <ccb32c576cc4ebf943d5ec35e3d7ba4ae8892acd.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 21 Jan 2026 19:59:56 +0100
X-Gm-Features: AZwV_Qh050IhjThhArfxNo-53HjJR0uLCcITEQOtntS-75Lw875opD6ONQssxps
Message-ID: <CAOQ4uxg+dC1o+6V7Nvxf8UW3H=0OvsGjEe76LNY6q8ZcpGDDJw@mail.gmail.com>
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
	ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[brown.name,kernel.org,infradead.org,zeniv.linux.org.uk,oracle.com,redhat.com,talpey.com,google.com,linux.alibaba.com,linux-foundation.org,mit.edu,dilger.ca,suse.com,gmail.com,huawei.com,vivo.com,dubeyko.com,fb.com,squashfs.org.uk,samba.org,manguebit.org,microsoft.com,szeredi.hu,omnibond.com,fasheh.com,evilplan.org,paragon-software.com,nod.at,suse.cz,mail.parknet.co.jp,vger.kernel.org,kvack.org,lists.ozlabs.org,lists.orangefs.org,lists.linux.dev,lists.sourceforge.net,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13168-lists,linux-ext4=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[72];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: BFA475BFE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 12:56=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
...
> > But if you really really want to set this new flag on almost every
> > export_operations, can I ask that you please set it on EVERY export
> > operations, then allow maintainers to remove it as they see fit.
> > I think that approach would be much easier to review.
> >
>
> We could probably do that, but I think the main ones that excludes it
> are kernfs, pidfs and nsfs. ovl and fuse also have export ops in
> certain modes that exclude NFS access, so the flag was left off of
> those as well.
>

For the record, my comments regarding fuse_export_fid_operations
and ovl_export_fid_operations variants were purely semantic -
it did not make sense to mark them as _STABLE_HANDLE, but
it does not matter if you set a flag on those ops, because they do
not implement ->fh_to_dentry(), on purpose, they are not
exportfs_can_decode_fh() by design.

Thanks,
Amir.

