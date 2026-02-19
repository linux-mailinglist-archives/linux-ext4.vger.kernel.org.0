Return-Path: <linux-ext4+bounces-13752-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XOTEB/R5l2mWzAIAu9opvQ
	(envelope-from <linux-ext4+bounces-13752-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 22:00:36 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AB2162805
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 22:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5835830247F6
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 21:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB2E30BF75;
	Thu, 19 Feb 2026 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="mDYFazp/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6F1285071
	for <linux-ext4@vger.kernel.org>; Thu, 19 Feb 2026 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771534828; cv=none; b=SXAlJbQaEiNRLpzCe+NzZg94lxwL/PSexMud8bo4kzilKgeDSgjT30jX20yeVw+kUqiCPsFHKXmTFxDarywX2WLlwVaawMt9asE5MPcJxLl/y/nUf7c6LRbUFfl4tk0fQ9z9tQ8pq7TDwLQheRLFKMFHnErARwhCOsApvDcSgOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771534828; c=relaxed/simple;
	bh=1m+LHmJ2ii2fMCL5Yw8BNOu1FGvmwApnkiD4zM/oDwo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CZ/9+rLD7gX2PVXaC2koIqDu9FYWxo0SSOVFbMDVfELERKmYKsoCaY4Vw09dbP81w0h+dEzNUo2MwxENyuuBblEoAeqOysgij8dQ2X4fNtwKV0xD6qzAfnspVXk1mO4oBDf2F19qbPcKBcDGSmKZbfIiFPVXZ4TUHGLFDf4Op9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=mDYFazp/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a9296b3926so9695705ad.1
        for <linux-ext4@vger.kernel.org>; Thu, 19 Feb 2026 13:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1771534826; x=1772139626; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gN2p81ub7C7asTTClWhi8yTk7OGAaWSTbhCB/Ej6QE=;
        b=mDYFazp/q5dHkr00wdDLrO07hA78wAMf5POC4ZuILXDtq+3T/yBR7jkSoiSlHccWSE
         VFRQqvsOv7VKlUEtfOikZjPZ2VTu19Ns7u6OpJoDmbUFJXzxrYI9ELCdeG+Lql/7SD+0
         7HAW6IxqRb38KNc1SxDSP4pKJG7Ccn2e8ZHSt0/5rs142bLsiM9T0JQG6MlqoxUsR4pT
         IeOQjNi9ewzCfrGQQa6kcTQgSlRIqnFqeXNMZkvudYTDcTXJ2dGm5TBGlEbxNcxymn6j
         k8+Ohc3TGAAPYLLF+q2YvDF8xXrZ8Qy2/KW1piR+RT29FC8cp6HVFKTrpU27XViHYEtK
         quJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771534826; x=1772139626;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gN2p81ub7C7asTTClWhi8yTk7OGAaWSTbhCB/Ej6QE=;
        b=iJ+wST3z1PElYxryW+vJDWMjHQMtiC0L8Yxwm0uEvmotU5CAFR56tVCbVOxrgMrlSX
         BJpgD4BaMN/XS24RgOjmk6FEWUy67FLXi+ttGILCoxv4iteVuk1tsWoINSkjaQGqaHkD
         qo1QTl/orp+Hd58lLdZpzDEqp+cyiYGqO52Y5ZK0D2uk5DoiJoHCrA9Hx3D2YoAE5gdv
         rpzpgnccr7Z2odN+UY4MN6nu2i3g6eH8rsQVqrXYQCSCZGco+mhKjSjNoHmj7a5UTZLj
         YLiSLkdFtIdCx7XQnMTvGfrBqVKUmmIqDmgIa4xA/Dzzf0occOkn2NVBM47uGbs4bZkL
         E8+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXt2QFHBlM/FiLJRuVw1M21APkhTRP5KSqoVMEO49tHZh90P1YuMsYeLlZuDfZGMrHIsL/EP3BSQxYB@vger.kernel.org
X-Gm-Message-State: AOJu0YwTK9lYmQC4zsp10W2hwzWOlPkmps9gHkNnYty0h6SHYprl8QGY
	bfCTHhdh61U78D4jlcpNnTyHPNPTqlvjZx3eoflSH+QaU+B0vWYd3npBEopIEspY94I=
X-Gm-Gg: AZuq6aKR4cDRWhhzC1m1qWcctWsQ/wgBnSjEr7kvxHkfuV8MNYBUK5TpzzeAVSJawrg
	fGgqc8NGcY4rp0XvNHCmcvWoMa9I2DO0WsHOCaPHQecfec0AnHcr/S+DYy1tcwqMm5+ntWXGG0k
	bIVdKI+lBVlFdDzpiSPykDDiPsz+YdW7oQ6JjMD2IxzaEH8OYsSPKHevRkXKlm5J77GnLRHv9c+
	kSMFamY4rYyp8irGP2Lnaqw0EreQTGb9V6jt1f7vnw5cuQY5efJzLvJ3wWJ+jyz0k2Q6FUo3HyZ
	1OzGEjt2QsxodWr/nBikbeF3GEgi5hC1eAQ5RO0ikeZ3IuT+IHDzqdXZH8rhGMyXDEbMpAgwvR8
	25sW9Fg/w2vwfll4sf9Nt7+CFnNh5ZfRflzVnB7QdZXC1c97Fmd1+c322jE++YKFmdravfSRPQ+
	pSnQx67cj8ZfZ0dgHYj07fPujKAYqJlJ6nlL5c7fYUfLBmV8AbDHfaKLJo+jFs86wjyOfhuZPZA
	RHcwwmAO+mKbuaY
X-Received: by 2002:a17:902:db02:b0:2aa:d671:fdf9 with SMTP id d9443c01a7336-2ad50ecf977mr59971045ad.26.1771534825843;
        Thu, 19 Feb 2026 13:00:25 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a6fa260sm169579405ad.5.2026.02.19.13.00.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Feb 2026 13:00:25 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v2 1/3] jbd2: store jinode dirty range in PAGE_SIZE units
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260219114645.778338-2-me@linux.beauty>
Date: Thu, 19 Feb 2026 14:00:13 -0700
Cc: Theodore Ts'o <tytso@mit.edu>,
 Jan Kara <jack@suse.cz>,
 Mark Fasheh <mark@fasheh.com>,
 linux-ext4@vger.kernel.org,
 ocfs2-devel@lists.linux.dev,
 Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.com>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <63C86D0D-9EF6-4D33-95B2-8D0F5B305B0B@dilger.ca>
References: <20260219114645.778338-1-me@linux.beauty>
 <20260219114645.778338-2-me@linux.beauty>
To: Li Chen <me@linux.beauty>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13752-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[dilger-ca.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: 46AB2162805
X-Rspamd-Action: no action

On Feb 19, 2026, at 04:46, Li Chen <me@linux.beauty> wrote:
>=20
> jbd2_inode fields are updated under journal->j_list_lock, but some =
paths
> read them without holding the lock (e.g. fast commit helpers and =
ordered
> truncate helpers).
>=20
> READ_ONCE() alone is not sufficient for i_dirty_start/end as they are
> loff_t and 32-bit platforms can observe torn loads. Store the dirty =
range
> in PAGE_SIZE units as pgoff_t so lockless readers can take non-torn
> snapshots.

When making semantic changes like this, it is best to change the =
variable
names as well, so that breaks compilation if bisection happens to land
between these patches.  Otherwise, that could cause some random behavior
if jbd2 is treating these as pages, but ext4/ocfs2 are treating them as
bytes or vice versa.

Something like i_dirty_{start,end} -> i_dirty_{start,end}_page would =
make
this very clear what the units are.

To avoid breakage between the patches (which is desirable to avoid =
problems
with automated bisection) you should make an initial patch with wrappers =
to
access these values and convert ext4/ocfs2 to use them:

static inline loff_t jbd2_jinode_dirty_start(struct jbd2_inode *jinode)
{
	return jinode->i_dirty_start;
}

static inline loff_t jbd2_jinode_dirty_end(struct jbd2_inode *jinode)
{
	return jinode->i_dirty_end;
}

then change this in the jbd2 patch at the end, which would then be =
self-contained:

static inline loff_t jbd2_jinode_dirty_start(struct jbd2_inode *jinode)
{
	return (loff_t)jinode->i_dirty_start_page << PAGE_SHIFT;
}

static inline loff_t jbd2_jinode_dirty_end(struct jbd2_inode *jinode)
{
	return ((loff_t)jinode->i_dirty_end_page << PAGE_SHIFT) + =
~PAGE_MASK;
}


Cheers, Andreas

> Use READ_ONCE() on the read side and WRITE_ONCE() on the write side =
for
> the dirty range and i_flags to match the existing lockless access =
pattern.
>=20
> Suggested-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Li Chen <me@linux.beauty>
> ---
>=20


