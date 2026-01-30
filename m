Return-Path: <linux-ext4+bounces-13439-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK1qEmaYfGmJNwIAu9opvQ
	(envelope-from <linux-ext4+bounces-13439-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jan 2026 12:39:18 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE429BA235
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jan 2026 12:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F9C9300CFEA
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jan 2026 11:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9EC36B074;
	Fri, 30 Jan 2026 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="DKP87hE4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA8234BA3A
	for <linux-ext4@vger.kernel.org>; Fri, 30 Jan 2026 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769773153; cv=pass; b=J7fXhXZp+WE/iL15EXCC6tK7SdnidDExtFdVSYLQjkecOENwO+IiAIFOh1X3i7oZBVb8JH6+wlhmmE8GB5/8gqoGaKgb6NSs0zCRF5Jqpt25I/jFBOmzB9uWySJilt/AoFOskFDDXOMaVZ6eP7WhzPuGyak9XxjpHe4hgXUKLMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769773153; c=relaxed/simple;
	bh=9tUUo4RtUgVZritVYhQgn/RZrkmrP28pId3YXTu6M7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNcV4TdqRzNTKZKCuQ3yv9erVTqlcHFNNltBymHuDaGl6hCX7Lv8NCEZ7Il0KRt80TJ28Asl5N0rsM7owQd6cWjwoDpziPPbHRkEJUbxk0j23sLtghkoL7GwrTD+EjLw9hsrbvKuGnCfjcBmWJdfImdw9XA6ESWuI6S0BIOIFYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=DKP87hE4; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A1D0C3F363
	for <linux-ext4@vger.kernel.org>; Fri, 30 Jan 2026 11:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1769773147;
	bh=tIM6HekHVbizDpWLVzh0TOuAujWuJlKP0VbNWwnAEtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=DKP87hE446rFi0efZ7f9bwv6RV2J7yKkFK9MmHP/DJiGYntVT5GDY1Gzx//kGkFPx
	 PFcM/+xT0y0KmTn2JZwqN/Nk5DoRieNqD0VjWVrGdujOxtIAcJNWr66LI2vKb9RYWF
	 PKYZn485mkWq8tKMO89DN5WbbXOD4UakjcTGCRymTETc6QxLIFIxghVAWP4/IYQsTK
	 Tn/wPzL3RdQviQBXnfigpuz7qOe0T/fWreTlDlgBaNIJ+v788BQcsM9fe9+6oqJwCI
	 OiDGLppQLi+NQ8iIlSG9zLuB3eR3AD1c3czehO9yFfnDts6xd7Xzf41XSz2Xb6fRg0
	 GPFPAmw3y38E8k26Mlawtx16Op1DbDTplWdyZA4V5XiGNm3cvxB/ETJlmm9UjpusoJ
	 Oc/cLCO/Tda81Bbsl1PLrht0EFATsgshg5QgvyCPORHA7nSYYjwLcxzEgiw4RDwL8Q
	 ZKIkO7LYviwoBG+EWlOkfFTKykQJ5LTWf50Si/Ar8+wR4l5WhtQIc77MCIscbAPTJE
	 yMayccMxzI/cJ/pG5CUIFgzLty8EMhIF/f8G67qSnCLGZM4KHwwLxcjFBT12KZPu+d
	 k/qSlEaTU9l+iyKRfB2EiO9JRlM8AH0tnRZDUmsMh4jxEzkhbT92j/pmF/VpHwpa3h
	 lNAZ12RgMAhu5djORsfRSzKo=
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-59b786498b0so1362825e87.3
        for <linux-ext4@vger.kernel.org>; Fri, 30 Jan 2026 03:39:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769773147; cv=none;
        d=google.com; s=arc-20240605;
        b=N5egx3qXlo+xTgSdGPMi17XvjI/wFPuda7HvdXx+nYRNUCkyn/EXGwHS/93HUKpSP+
         l9NGJ9bOBd9ngtE0xoXVBnLMqG7fDbA4YR4gjyzCVH8j8o0j9midwpLciqkisy5K3DNM
         D6oPdsnDy487AYLI+QenPJjCUEdIUUqAI7yjSGyT1K1pm/CycP4lYYK7siM3AJzPH/Cj
         tLGzE7+ls/ycmjdikWqfvVF3FQvgJYY4RALK1iSqBbKPppYbFHzT2oE3x4+6wAq46CrD
         4pnSZ6+gCYw2uenBagPQ38fJ89eAQNM6uEQLH66WGPXh4ktQb2Gf3mmfDBIdLeIeDz/y
         +pmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=tIM6HekHVbizDpWLVzh0TOuAujWuJlKP0VbNWwnAEtE=;
        fh=3fdPMa4koKMyyZgCNQhTKsV4AkHoeBAz73p97nHl3YM=;
        b=HVfrv3x8jc3/tmyaptjdzWge2Vw8+cq82tkogdQqW0+W2zjJe+r8bjwKR0N18XjKN2
         jTiyoM6ndhxWeNFJHyrIjJiqQtQVO27grdjK2rfgGtLBvlt+Zp5fR6/OoevV9+v7pNfI
         Bg5KVvop2hHGr9VvXTTaJOwM0BbqUkR/kIzGC35VDLL4SD97px/ZERbcF1qDSTpLXi+0
         /Jzg35oM6yurVw95MixQfgxffHQPJu+I9JbN/7yEarzP8XTd2euCv7/phz0YoJXVXa/R
         48mLE1X8o7Ld9QLJV9QwHLKr8ks/Ti/Fn66olm7tlJOjo0ZNskY1GUZmyetJcAkZJp0l
         tklA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769773147; x=1770377947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tIM6HekHVbizDpWLVzh0TOuAujWuJlKP0VbNWwnAEtE=;
        b=lVzOPZ5OHZ3/RFGIw89T7G3RAesWhXrPspH8M8qsweLvpQ0+Hpx7bwiMnxJCzwTMRL
         Am0l51VK/wr1MqnDlYvcnzY5oJlfjpoTNoIF7fjmxStdxOGbIWzRXH6EvAhcKvg2lHAb
         4Z8b4cs7egC0Pn30ZJ0dP1Esh2HeNKZsZzA+z9RxPYZcrlux5cs1ei3SZNzUQWdYleIa
         yp/nOZB8uxlvE0KVvtUjMoV2Fcre5kUi1JJa3UOmetdPK1KMoPAgUfCsPPH1FGZnL8Wl
         eSkt+n6/PdVoziEyQV7mB8uHukwGN7lSHo3LWpVI/EVmlnlcT7Uy9VVxv81MvBFTM3ge
         4sDw==
X-Forwarded-Encrypted: i=1; AJvYcCUzc2ZwSv4+HQpeAVcJERPErjTTsfEMrPeIZteEqNciayE3N3pksdY+NuqAf9Ro2YOPBd9Bqwyk7U8Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6E96lfgaMIsXnZGsrU6Jx8UFmrNa27j8HdQrcQs4Zbf+KRBkg
	K7He3TlwN47mFOsdQPtsCDRN4O6GfeH8sEKDewiN1ye0JqgsApYmK+ieLJwIhYWmreY/eb5l+Tb
	vBEscVZ2d0cKXRLTkWjBs3kKYUnYVzF+Db9D/IjEKzm/R1RTx1CJTry4BWh251kwiJKnRm3sTit
	Qa2QfXsyzcKs5yGJ+3RAWNWN+zBTGOzfss2gbGH6Hz2oxt86wbqJq5pg==
X-Gm-Gg: AZuq6aLF4qMv5DBWslZrbmhfgyQ81oe5rgwbYW6J6/HoQxR3SxX3H7iVcKmJguu1euR
	R/atQ7YUDIqRT5hiWrXg1Xs9SzDGMtqPI7BYPJZbl34i3HmdBB1x/SQwTZP4a0W07vUnJPJnd44
	xjLGphiOnqIGYJ66bsB7twpJOB81yrRiR55Do1loyL+2ur3Vlt1HK9jOalmu3en9Yf5ak=
X-Received: by 2002:ac2:51c2:0:b0:59b:6dbc:e507 with SMTP id 2adb3069b0e04-59e16438a68mr864129e87.47.1769773146797;
        Fri, 30 Jan 2026 03:39:06 -0800 (PST)
X-Received: by 2002:ac2:51c2:0:b0:59b:6dbc:e507 with SMTP id
 2adb3069b0e04-59e16438a68mr864123e87.47.1769773146261; Fri, 30 Jan 2026
 03:39:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128074515.2028982-1-gerald.yang@canonical.com>
 <4u2l4huoj7zsfy2u37lgdzlmwwdntgqaer7wta7ud3kat7ox2n@oxhbcqryre3r>
 <CAMsNC+s1R-AUzhe80vjxYCSRu0X9Ybp33sSMHGHKpBL6=dG2_w@mail.gmail.com> <bycdopvwzfaskilhk3nsljuk3gkztvoa3is466a6utuj2lozmj@pxf44ulcnqup>
In-Reply-To: <bycdopvwzfaskilhk3nsljuk3gkztvoa3is466a6utuj2lozmj@pxf44ulcnqup>
From: Gerald Yang <gerald.yang@canonical.com>
Date: Fri, 30 Jan 2026 19:38:55 +0800
X-Gm-Features: AZwV_Qh0Kr11VSn_nVMICaIteNKsDUMaj1E7Lu6_E758RDu01GJpglwtzW8ZVXk
Message-ID: <CAMsNC+ve3dRwT1xGWB0pvBJXqBpeksf7PgbEeihcnfs=AmwVRQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: Fix call trace when remounting to read only in
 data=journal mode
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	gerald.yang.tw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13439-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerald.yang@canonical.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[canonical.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,canonical.com:email,canonical.com:dkim,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE429BA235
X-Rspamd-Action: no action

Thanks for sharing the findings, I'd also like to share some findings:
I tried to figure out why the buffer is dirty after calling sync_filesystem=
,
in mpage_prepare_extent_to_map, first I printed folio_test_dirty(folio):

while (index <=3D end)
    ...
    for (i =3D 0; i < nr_folios; i++) {
        ...
        (print if folio is dirty here)

and actually all folios are clean:
if (!folio_test_dirty(folio) ||
    ...
    folio_unlock(folio);
    continue;       <=3D=3D=3D=3D continue here without writing anything

Because the call trace happens before going into the above while loop:

if (ext4_should_journal_data(mpd->inode)) {
    handle =3D ext4_journal_start(mpd->inode, EXT4_HT_WRITE_PAGE,

it checks if the file system is read only and dumps the call trace in
ext4_journal_check_start, but it doesn't check if there are any real writes
that will happen later in the loop.

To confirm this, first I added 2 more lines in the reproduce script before
remounting read only:
sync      <=3D=3D=3D=3D it calls ext4_sync_fs to flush all dirty data same =
as what's
                         called during remount read only
echo 1 > /proc/sys/vm/drop_caches       <=3D=3D=3D=3D drop clean page cache
mount -o remount,ro ext4disk mnt

Then I can no longer reproduce the call trace.

Another way I tried was to add drop_pagecache_sb in __ext4_remount:

if ((bool)(fc->sb_flags & SB_RDONLY) !=3D sb_rdonly(sb)) {
    ...
    if (fc->sb_flags & SB_RDONLY) {
        err =3D sync_filesystem(sb);
        if (err < 0)
            goto restore_opts;
        (drop page caches for this file system here)

With this, I can not reproduce the issue too. But I'm not sure if drop clea=
n
page cache after sync file system is a proper way to fix the issue, those
page cache might still be read. Any thoughts?


On Thu, Jan 29, 2026 at 5:31=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 29-01-26 11:31:43, Gerald Yang wrote:
> > Thanks Jan for the review, originally this issue was observed during re=
boot
> > because the root filesystem is remounted to read only before shutdown t=
o
> > make sure all data is flushed to disk.
> > We don't see any issue on the machine because the data is persisted to
> > journal. But I think your suggestion is the correct way to fix it, I
> > will look into
> > why ext4_writepages doesn't flush data to real file location after call=
ing
> > sync_filesystem and re-submit the patch for review, thanks again.
>
> FWIW yesterday I did some investigation and it is always the tail (last
> written) folio that is somehow kept dirty. In particular at the beginning
> for ext4_do_writepages() we commit the running transaction and the bh
> attached to the folio is just dirty but by the time we get to
> ext4_bio_write_folio() to write it, the bh attached to the tail folio is
> already part of the running transaction again and so ext4_bio_write_folio=
()
> fails to write it. I didn't figure out how the bh gets reattached to the
> transaction yet. Now I likely won't be able to dig more into this for a f=
ew
> days so I'm just sharing my findings until now.
>
>                                                                 Honza
>
> > On Wed, Jan 28, 2026 at 6:22=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 28-01-26 15:45:15, Gerald Yang wrote:
> > > > When remounting the filesystem to read only in data=3Djournal mode
> > > > it may dump the following call trace:
> > > >
> > > > [   71.629350] CPU: 0 UID: 0 PID: 177 Comm: kworker/u96:5 Tainted: =
G            E       6.19.0-rc7 #1 PREEMPT(voluntary)
> > > > [   71.629352] Tainted: [E]=3DUNSIGNED_MODULE
> > > > [   71.629353] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)/L=
XD, BIOS unknown 2/2/2022
> > > > [   71.629354] Workqueue: writeback wb_workfn (flush-7:4)
> > > > [   71.629359] RIP: 0010:ext4_journal_check_start+0x8b/0xd0
> > > > [   71.629360] Code: 31 ff 45 31 c0 45 31 c9 e9 42 ad c4 00 48 8b 5=
d f8 b8 fb ff ff ff c9 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 c3 cc cc c=
c cc <0f> 0b b8 e2 ff ff ff eb c2 0f 0b eb
> > > >  a9 44 8b 42 08 68 c7 53 ce b8
> > > > [   71.629361] RSP: 0018:ffffcf32c0fdf6a8 EFLAGS: 00010202
> > > > [   71.629364] RAX: ffff8f08c8505000 RBX: ffff8f08c67ee800 RCX: 000=
0000000000000
> > > > [   71.629366] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
> > > > [   71.629367] RBP: ffffcf32c0fdf6b0 R08: 0000000000000001 R09: 000=
0000000000000
> > > > [   71.629368] R10: ffff8f08db18b3a8 R11: 0000000000000000 R12: 000=
0000000000000
> > > > [   71.629368] R13: 0000000000000002 R14: 0000000000000a48 R15: fff=
f8f08c67ee800
> > > > [   71.629369] FS:  0000000000000000(0000) GS:ffff8f0a7d273000(0000=
) knlGS:0000000000000000
> > > > [   71.629370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [   71.629371] CR2: 00007b66825905cc CR3: 000000011053d004 CR4: 000=
0000000772ef0
> > > > [   71.629374] PKRU: 55555554
> > > > [   71.629374] Call Trace:
> > > > [   71.629378]  <TASK>
> > > > [   71.629382]  __ext4_journal_start_sb+0x38/0x1c0
> > > > [   71.629383]  mpage_prepare_extent_to_map+0x4af/0x580
> > > > [   71.629389]  ? sbitmap_get+0x73/0x180
> > > > [   71.629399]  ext4_do_writepages+0x3cc/0x10a0
> > > > [   71.629400]  ? kvm_sched_clock_read+0x11/0x20
> > > > [   71.629409]  ext4_writepages+0xc8/0x1b0
> > > > [   71.629410]  ? ext4_writepages+0xc8/0x1b0
> > > > [   71.629411]  do_writepages+0xc4/0x180
> > > > [   71.629416]  __writeback_single_inode+0x45/0x350
> > > > [   71.629419]  ? _raw_spin_unlock+0xe/0x40
> > > > [   71.629423]  writeback_sb_inodes+0x260/0x5c0
> > > > [   71.629425]  ? __schedule+0x4d1/0x1870
> > > > [   71.629429]  __writeback_inodes_wb+0x54/0x100
> > > > [   71.629431]  ? queue_io+0x82/0x140
> > > > [   71.629433]  wb_writeback+0x1ab/0x330
> > > > [   71.629448]  wb_workfn+0x31d/0x410
> > > > [   71.629450]  process_one_work+0x191/0x3e0
> > > > [   71.629455]  worker_thread+0x2e3/0x420
> > > >
> > > > This issue can be easily reproduced by:
> > > > mkdir -p mnt
> > > > dd if=3D/dev/zero of=3Dext4disk bs=3D1G count=3D2 oflag=3Ddirect
> > > > mkfs.ext4 ext4disk
> > > > tune2fs -o journal_data ext4disk
> > > > mount ext4disk mnt
> > > > fio --name=3Dfiotest --rw=3Drandwrite --bs=3D4k --runtime=3D3 --ioe=
ngine=3Dlibaio --iodepth=3D128 --numjobs=3D4 --filename=3Dmnt/fiotest --fil=
esize=3D1G --group_reporting
> > > > mount -o remount,ro ext4disk mnt
> > > > sync
> > > >
> > > > In data=3Djournal mode, metadata and data are both written to the j=
ournal
> > > > first, but for the second write, ext4 relies on the writeback threa=
d to
> > > > flush the data to the real file location.
> > > >
> > > > After the filesystem is remounted to read only, writeback thread st=
ill
> > > > writes data to it and causes the issue. Return early to avoid start=
ing
> > > > a journal transaction on a read only filesystem, once the filesyste=
m
> > > > becomes writable again, the write thread will continue writing data=
.
> > > >
> > > > Signed-off-by: Gerald Yang <gerald.yang@canonical.com>
> > >
> > > Thanks for the report and the patch! I can indeed reproduce this warn=
ing.
> > > But the patch itself is certainly not the right fix for this problem.
> > > ext4_remount() must make sure there are no dirty pages on the filesys=
tem
> > > anymore when remounting filesystem read only and it apparently fails =
to do
> > > so. In particular it calls sync_filesystem() which should make sure a=
ll
> > > data is written. So this bug needs more investigation why there are s=
ome
> > > dirty pages left in the inode in data=3Djournal mode because
> > > ext4_writepages() should have written them all...
> > >
> > >                                                                 Honza
> > >
> > > > ---
> > > >  fs/ext4/inode.c | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >
> > > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > > index 15ba4d42982f..4e3bbf17995e 100644
> > > > --- a/fs/ext4/inode.c
> > > > +++ b/fs/ext4/inode.c
> > > > @@ -2787,6 +2787,17 @@ static int ext4_do_writepages(struct mpage_d=
a_data *mpd)
> > > >       if (unlikely(ret))
> > > >               goto out_writepages;
> > > >
> > > > +     /*
> > > > +      * For data=3Djournal, if the filesystem was remounted read-o=
nly,
> > > > +      * the writeback thread may still write dirty pages to it.
> > > > +      * Return early to avoid starting a journal transaction on a
> > > > +      * read-only filesystem.
> > > > +      */
> > > > +     if (ext4_should_journal_data(inode) && sb_rdonly(inode->i_sb)=
) {
> > > > +             ret =3D -EROFS;
> > > > +             goto out_writepages;
> > > > +     }
> > > > +
> > > >       /*
> > > >        * If we have inline data and arrive here, it means that
> > > >        * we will soon create the block for the 1st page, so
> > > > --
> > > > 2.43.0
> > > >
> > > --
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

