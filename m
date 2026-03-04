Return-Path: <linux-ext4+bounces-14598-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL2ILRz8p2mlnAAAu9opvQ
	(envelope-from <linux-ext4+bounces-14598-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 10:32:12 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E2D1FDA00
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 10:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F3CE30BFAB6
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Mar 2026 09:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0094F3542E1;
	Wed,  4 Mar 2026 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9sIRKFF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0175F3988F0
	for <linux-ext4@vger.kernel.org>; Wed,  4 Mar 2026 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616639; cv=none; b=KhZudyn4z/u8QpeRs/bfFs3sFxH76iZ6G0mOsPczX+YhCcIYKDKBMGdMvxkT4qW3Tdx/D6ZQV6rztNTxCo2Bip3q4jc7tPaOnNNooPbk4nMML/RiuQDxoZkb4Nu1mREA75umstSZTTtjDZUPifuDDcveUF294zq4ioavIdslmkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616639; c=relaxed/simple;
	bh=qyvL/iXE6+TakoKVVxVCaopqm1BpX+f7Q05dx5gBHDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwyo+svmMDYXiYxG8SfbGuVK6aXGevH1jQU2fvuks1qBiGTDLVxTT98v0GV3IIotCKZwnpXbdOn6YAPHchvBkI+D6Dtz7EcJTNVta4dJnO+Ei3sQYsTl5lxyzrAvrJHQFA2JsPYPJJxhHlwSUX9zwIk1f86DVgz35DIYDokR2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9sIRKFF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483a233819aso64872335e9.3
        for <linux-ext4@vger.kernel.org>; Wed, 04 Mar 2026 01:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772616636; x=1773221436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUzQoESoh9/PqMSFbMpuw4Pmh5IPXiGP/qvOjxX4wwo=;
        b=b9sIRKFFaokgkSrgeWrbA/ViOpJjWP1ViLK9R1Hc1//m2coegBzgKtpFqwevCmiACZ
         C7afbaacWCHtjdaHICcRaatb9x6ZEJn6NhG6Zj9DIWESFWJ1Wfs22M1hBHSvsJT6ov0y
         u+gbatvToXFWw4Ws1z6B810aDtF2H+NtjWSzWUXjnH2Uagh4gEk5+S1nkLp8lVzxzopS
         A1lgIkzEEAlqX7ANlEMButL3162rmrsjjiFCTqL06qEr4gqfcdGAwI6S5Z1yvtqPS7rR
         QeMeyyLIZ4ZsiMHZmsjBPBW/Gjz82S/2K6mHxq88plnIdodtUPQPjzOSR2cd/SZiIcXY
         bgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772616636; x=1773221436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BUzQoESoh9/PqMSFbMpuw4Pmh5IPXiGP/qvOjxX4wwo=;
        b=fpUt+xz7lhRnjAmUlBvcMjKI4M+7ie+fm5GC5bZRCffUDtBjuXm/7QLdAaQRCmzmCX
         0m4VD9vN8AjahHpOt3oT4lwnaMIiIF6O2VJA8hSIwim2d/IJObmIBNhglioM41DXG4oR
         opb5aODsF1BII5oDA9woIEf8Af6bS97TuSGNtgReFsDj6H6aFd1MjN+xPW385c/2+db4
         ls4Hp5/zdVZTt221sJgk7hvNU0nkoGHNKBMoU1RVOVU+mFE3UdiA92Ilhdv6DKuXnSnY
         1XGK5cs+jTy2h2CyemgG/zH4EeU5oRBs5jBlMWa2fVyUzbXSNLUAJmKGo42f/3w+sGGa
         wC5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSvNjAUpPYmaVkkiJBFSHPGQll21PcM9nth/yTfLjZnr5CZ+mm0ZjQKy3qlsFkjBCEsnQBS1KHpHHR@vger.kernel.org
X-Gm-Message-State: AOJu0YxuQ/5elod3qcBdf6X7j1spol7gPVOATjg8S+IF1nWLhBKfqiBT
	g9avSZuWBKdPcZ6HCqlXY9KW02zN1Nr7uj8SC/3TNmtSo4pOdBm3nzck
X-Gm-Gg: ATEYQzxzH+gFLeRI/C+Qam8Ja01hUQW4q00932ckfkH2kcgJErsHP7kPV70bK9m/Goy
	DJG7iirJWdqPjuM/UFY1pqrcf9AU1xy+7Tzj/MpFCPysXByoWBjc1osqhCGO5fW+8M38Dwaai/x
	gt6/bHc0DvZHu+mSOX4afTDTFCQWvcdsycFycFbK9Py73jDvOlnnbULJJ/TP5/LVyXvLbd0Y/eA
	g5faGzZwGvyfsNu0AfKhi7AoyZ3H5nERoicPZoXrXXL933s5n7pgIxJpdssJJ8VDXYEAuxVttY/
	C85pTzzi2VRQSDRhdidCdqZnCTFc5vedRrXnd+2ap48anGQ4L/uc+kujcCHuQligoxnLoWWTdl5
	veIjAb6UmueJm0EBb33zV/ld7MkrmWb7tlfhtzrkj60OL0w1QYTmZhh6hCb8PgwlELEjW1n7REh
	SIe61MUlPMPR0gZQaeLdig1xDmMsZMIv2nl0VRw3+00ICVwEXnZTZlE3e4ysuRKBvB
X-Received: by 2002:a05:600c:8b53:b0:483:498f:7963 with SMTP id 5b1f17b1804b1-4851989024emr19550785e9.26.1772616636117;
        Wed, 04 Mar 2026 01:30:36 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851884225asm38972555e9.6.2026.03.04.01.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:30:35 -0800 (PST)
Date: Wed, 4 Mar 2026 09:30:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: NeilBrown <neilb@ownmail.net>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, fsverity@lists.linux.dev, linux-mm@kvack.org,
 netfs@lists.linux.dev, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-nilfs@vger.kernel.org, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, autofs@vger.kernel.org,
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
 linux-x25@vger.kernel.org, audit@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
 linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 000/110] vfs: change inode->i_ino from unsigned long
 to u64
Message-ID: <20260304092559.554ac9a9@pumpkin>
In-Reply-To: <177260561903.7472.14075475865748618717@noble.neil.brown.name>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
	<1787281.1772535332@warthog.procyon.org.uk>
	<1c28e34c7167acf4e20c3e201476504135aa44e8.camel@kernel.org>
	<177260561903.7472.14075475865748618717@noble.neil.brown.name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 51E2D1FDA00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14598-lists,linux-ext4=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[ownmail.net];
	RCPT_COUNT_TWELVE(0.00)[46];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 04 Mar 2026 17:26:59 +1100
NeilBrown <neilb@ownmail.net> wrote:

> On Tue, 03 Mar 2026, Jeff Layton wrote:
> > On Tue, 2026-03-03 at 10:55 +0000, David Howells wrote:  
> > > Jeff Layton <jlayton@kernel.org> wrote:
> > >   
> > > > This version splits the change up to be more bisectable. It first adds a
> > > > new kino_t typedef and a new "PRIino" macro to hold the width specifier
> > > > for format strings. The conversion is done, and then everything is
> > > > changed to remove the new macro and typedef.  
> > > 
> > > Why remove the typedef?  It might be better to keep it.
> > >   
> > 
> > Why? After this change, internel kernel inodes will be u64's -- full
> > stop. I don't see what the macro or typedef will buy us at that point.  
> 
> Implicit documentation?
> ktime_t is (now) always s64, but we still keep the typedef;
> 
> It would be cool if we could teach vsprintf to understand some new
> specifier to mean "kinode_t" or "ktime_t" etc.  But that would trigger
> gcc warnings.

A more interesting one would be something that made gcc re-write the
format with the correct 'length modifier' for the parameter.

That would save a lot of effort!

	David

> 
> NeilBrown
> 


