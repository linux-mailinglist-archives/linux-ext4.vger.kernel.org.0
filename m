Return-Path: <linux-ext4+bounces-5113-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC5B9C60A6
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 19:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAFA61F224A5
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 18:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC123218955;
	Tue, 12 Nov 2024 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="ecmIViAN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0C2185A0
	for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437058; cv=none; b=t50AeBk94QlyhY9EECREyvyCjEBt4iFXVl9GmUSL1v+Qih0YcBwsOifA2OZ/0Sf8SyEKiZxQUppdEdhzY5eKYESfSgCzTAd3XHpgRqZpYzyWDv5bsX0+21zBTaWnCed4kmTzo2egHTjr4g5wrr71daq2BIfTNIODpHvB5KUOp4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437058; c=relaxed/simple;
	bh=1mUZ8DzjqX0JWLmnRIpli58oO0BPAz19BQ1+9z/fFXY=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=oqiFTxVlCNgQ7PEtQc3LBLtU8dP9qjdStdbb7FST4rpqlokIDkXwLY8wQjGweHsIfd1zrA1eFawuRZV+45rl27xlfHZd+OX2BBGYbVW4D7ssdF53oWyOugazF8XtFCifREP5RDX/iC43tTlMyxnwFF8Ocd80MlDjdHInnhnqfzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=ecmIViAN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso5529511b3a.3
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 10:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1731437053; x=1732041853; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MEc/9ksk1wBSa1VtuWODruUbwynLxcKKZbc1LazGnRA=;
        b=ecmIViANBLnQi1lC4R1btSgXhd6q6EcduFy2fekYnrbpFZc0MwA+6QZG2yyrHAL6Xs
         S7Cjz+wl83P8d+ubF0RNy3aszR18/Fv5KNt2YmcPTh5Zv1RmTqnMhTN2+cNaILXlBML2
         lKTAb8p6sfTUeY4S6biDwdWYx3PER1J6MzTIMI550vvC3bxhtl/gHI1lqX/ec1RWcwF8
         8oHpJJYkmKtebBDxLrNY4ot6WqY7QcO1nZA9nt+YwjgDNkVdYusrKWL3JX8wP3SiXOCN
         h66IgItqKLkYzrjaqf5yyOZtybuky9ip78xA+X9ZeZPfOyBtgHyWR9ToqcgLGB/NX7Ek
         MNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437053; x=1732041853;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEc/9ksk1wBSa1VtuWODruUbwynLxcKKZbc1LazGnRA=;
        b=cM+WqDMr+6X1xIvwVJ/lyRe3Eq8NTZ3BjRbE8MOwi1ku52Z4LD5uiCCzL88ove3MUl
         slIl782MKjtAT2siLZSOsQRazQpqDbc2+x0k+9RISEk6fdNKCoe3D2eNwAVytB6MXChx
         gwNTF+pJ+KQ4GuDtYo6Yh5T3Oo+YWl7UwxuzszBsnuOGm76kV0VlIzMGSlIDsaHLVn9y
         RqKkENZAHX7kldhqqJMXRLcmB7sOjzmTEGkbDhM6z/ddo2NiiYOs+cRvh/CIHy1IHg6u
         n8MN07s19H0g9sNN4bpB7kSPFl3szQy7q7oP/+2R0lahegf6e0Js8UztOmG5xlAR0WsS
         S/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVG4jQhBeLXQXN45cgF97uOVmNpk5H0DXtVjoQEHSmAOMp/ov9hVCz3xav42u6BtYI1Kzep/ew0Nyjh@vger.kernel.org
X-Gm-Message-State: AOJu0YyZrbhc1cmUJXgzRTM4CTS81uYb17BUm6jWH136aMPk6ykyT3xL
	W51IhbLXweVH701u1g2A8Mf9vZP0TBdujPxjIS3WsY9J4P02INY5ZCaM0RjK1Wg=
X-Google-Smtp-Source: AGHT+IFIA2DZlNujVQPKJ/NHAQ020wacRmSdl4I++kP0LYlNFjNPh/EsiB44VHmIR6MMlpCM5uj9BA==
X-Received: by 2002:a05:6a20:918a:b0:1d6:fb3e:78cf with SMTP id adf61e73a8af0-1dc22b91c6amr25585805637.41.1731437053447;
        Tue, 12 Nov 2024 10:44:13 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a571eesm11474106b3a.178.2024.11.12.10.44.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2024 10:44:12 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <11AF8D3C-411F-436C-AC8D-B1C057D02091@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D139CE8F-DAA8-4E32-AC77-A3549CBF5E73";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH V2] jbd2: use rhashtable for revoke records during replay
Date: Tue, 12 Nov 2024 11:44:11 -0700
In-Reply-To: <20241108161118.GA42603@mit.edu>
Cc: Jan Kara <jack@suse.cz>,
 Li Dongyang <dongyangli@ddn.com>,
 linux-ext4@vger.kernel.org,
 Alex Zhuravlev <bzzz@whamcloud.com>
To: Theodore Ts'o <tytso@mit.edu>
References: <20241105034428.578701-1-dongyangli@ddn.com>
 <20241108103358.ziocxsyapli2pexv@quack3> <20241108161118.GA42603@mit.edu>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_D139CE8F-DAA8-4E32-AC77-A3549CBF5E73
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Nov 8, 2024, at 9:11 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> 
> On Fri, Nov 08, 2024 at 11:33:58AM +0100, Jan Kara wrote:
>>> 1048576 records - 95 seconds
>>> 2097152 records - 580 seconds
>> 
>> These are really high numbers of revoke records. Deleting couple GB of
>> metadata doesn't happen so easily. Are they from a real workload or just
>> a stress test?
> 
> For context, the background of this is that this has been an
> out-of-tree that's been around for a very long time, for use with
> Lustre servers where apparently, this very large number of revoke
> records is a real thing.

Yes, we've seen this in production if there was a crash after deleting
many millions of log records.  This causes remount to take potentially
several hours before completing (and this was made worse by HA causing
failovers due to mount being "stuck" doing the journal replay).

>> If my interpretation is correct, then rhashtable is unnecessarily
>> huge hammer for this. Firstly, as the big hash is needed only during
>> replay, there's no concurrent access to the data
>> structure. Secondly, we just fill the data structure in the
>> PASS_REVOKE scan and then use it. Thirdly, we know the number of
>> elements we need to store in the table in advance (well, currently
>> we don't but it's trivial to modify PASS_SCAN to get that number).
>> 
>> So rather than playing with rhashtable, I'd modify PASS_SCAN to sum
>> up number of revoke records we're going to process and then prepare
>> a static hash of appropriate size for replay (we can just use the
>> standard hashing fs/jbd2/revoke.c uses, just with differently sized
>> hash table allocated for replay and point journal->j_revoke to
>> it). And once recovery completes jbd2_journal_clear_revoke() can
>> free the table and point journal->j_revoke back to the original
>> table. What do you think?
> 
> Hmm, that's a really nice idea; Andreas, what do you think?

Implementing code to manually count and resize the recovery hashtable
will also have its own complexity, including possible allocation size
limits for a huge hash table.  That could be worked around by kvmalloc(),
but IMHO this essentially starts "open coding" something rhashtable was
exactly designed to avoid.

Since the rhashtable is only used during the journal recovery phase,
IMHO it isn't adding any complexity to the normal operational code, but
if there was ongoing overhead then this would be a different discussion.

Cheers, Andreas






--Apple-Mail=_D139CE8F-DAA8-4E32-AC77-A3549CBF5E73
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmczofsACgkQcqXauRfM
H+DLMhAAsOy8qi7T602QLeXKfv7vhZNz846fo15Cp5ZYVoZZOvweAJeFvY+rOKkY
GVYO8stDn+t/N0Q+4N0i/h/cTUO/cxb+s7wixqfqrjRgPHPZlcoWlmVtQlHCOdyg
fF6h2lO7gcUrzj+3HaP2NV7NbHkHQmuUZf11GTWzpUab0ItzO7G+stRaGeXo9h2Q
b5lfiA9DE++QOXQvi4AjC9to2u4Fx/lnPOFvQFQSTpuyNznQf0EtognFWZqUtJZc
1rpeKBWCPHFLxAyBwV3z1du5b00Si2gsxPYE/xI6cdiZFi7zzgVfI+CQEhcY187z
VkgLYjlzlJB1J8adiOesRwdFS6btNHi1clrsTo+I3Z5YVxgW7w3EMF47NQFdP+ak
DfJjOkInz8ufLFbZQRuToFO9coMF7FFd/Lpt6MgIIsPDUszrWw0QEAcMJpiAdQy4
ajXnTL7ZkXPoFNMiHy/1XTwuCNIm0ebycRInkL92UGvamwiai1GeLA8xSvKBbrnp
GaaEGelRnCIhpJPtjI/UDLFKB433kmK4uPVyMV9GTSCnvFMEFbyjvqO1RPAC9KqU
L2W7HHQTRCuBYvBIxAiFULwnNADs+l2Z3jP5cvS3btB8fQutNubva18OUywi+rZt
6K9Ysc04B5yjre2T19chW82pZUhFoQwAbdD26ZT21IWVwva2O7E=
=rFbh
-----END PGP SIGNATURE-----

--Apple-Mail=_D139CE8F-DAA8-4E32-AC77-A3549CBF5E73--

