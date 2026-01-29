Return-Path: <linux-ext4+bounces-13425-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKLBIMbUemlX+wEAu9opvQ
	(envelope-from <linux-ext4+bounces-13425-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jan 2026 04:32:22 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E37AB761
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jan 2026 04:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE335300809E
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jan 2026 03:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E724A35C18A;
	Thu, 29 Jan 2026 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Id8elMGE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C5C35B64A
	for <linux-ext4@vger.kernel.org>; Thu, 29 Jan 2026 03:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769657527; cv=pass; b=qSzC/1x+OcFaAGDy1xcET4jOLuG3wv/NFGaxVP1XTlhSFVjLa9KWrXdcwuXmJe2f9ng52a+cQWvUUFmjvNzFCdF6hP+6wtdqFrMS1O9qrUmVpaD9MD9qgbUVYaozNq+pzHZ15RD0u9xgnRUNWbqUHnFEwUQ8ofRJIZVDqO5K3qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769657527; c=relaxed/simple;
	bh=n8GjO5lp9SGF1K2bbz0aCjAo8QnGSnHnGg8TRWSU56I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRRU1FP8gEq93htN3v0h/E4DvuIDDzZy45RwwAGW/YfY+KaoIcR3rTJKzCy8kPp0RAmkeJtAc09P7PVlQveWRyRjfuQXzvqtYlnqV46Kuuufmtv4KcPBpVXObPH65LtdcRq8RZ5V8MoL9G0EbpOHW0gZQtqFn/RUUFCS/XPtr/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Id8elMGE; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 613573FA6D
	for <linux-ext4@vger.kernel.org>; Thu, 29 Jan 2026 03:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1769657517;
	bh=QK1xHO1Pg/29AuoBU3QEa4tmi+YQ3GS5tQx/F6TzO64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Id8elMGE1nb+WQ3X57JcO37VsmqDX6Bk5xk2QyQFdn14psYWUdPPvttZyj+JfaRk+
	 xivOGfypDDK2r94z1ML4MOT7fjUSpoyd9jjeFPtNPDyDUHmiQwJBJfPS29PcrZ3T0f
	 hwevWmM1sxA7sW+FJhyQF68iQH3b+cRq3yROYkdWZNBVakFzD/2URH5G8w7YTNODx1
	 1eQ0vq+f9MOqjwoOwLW6KYE5WvkxRYK4Lx51tUr5mWOZUDYpDrBKLei5+3Yj/W/Ywa
	 t0OYpwovAh1bCgds2+9Q0jkwWzND1GexONRY9+g6cUAY9qSBzm1x7+7sdodzFhm3su
	 6E/o6R9mjXMGP7ALeppBcPPOqUR9BsjvCQZ+1/K0Lr27qhnCKXGHQDA/9WDRhdOlUI
	 MeFkuHALbIr7SHyBaI/eh5vFxjNoWKW8WmxatgIiEoxGM8OvpYZoBNbWmUn4OO5i9/
	 nFV/y/9LQ3+fvpxKSGLqqcUEmOae4hvAESyLMDE4vpaKbuiV+0NFk4mo0nYeCzwR+w
	 u/ol6bWl0VUQIzrBYNuFYp2oTITf9fCqeUl8lnZ8psWdfrbblwvXcpsYwD3VaSMIg4
	 A43VsBQiULreHSSY4SCDWccTyUrnk9Pf7GMVQ9M62CLUKSOMw4WvT1ZKTtBjdnRr6v
	 Bqu0nt6nuhFX9PviUBzH6w+k=
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-59e0c9ac987so294236e87.1
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jan 2026 19:31:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769657516; cv=none;
        d=google.com; s=arc-20240605;
        b=bUdQFOd55VpzqGdrYp0HfVvnqWmPTHb8j9peuc2I3p34vkqx+4+fmaAPxJ4rBAlBJy
         q6Wf8SRbibN5B4L6XsK35V1AwjFPcm48g/LYTv++iMxJS5lPPB0jAf2y+tCtWfoKt3wW
         xWJO9tMnmqtIi9NFTB1pSJMsKeL8Gq7l0+Xylsqe0X+LN53DPJxYno90t5aZ9ZXKuCa6
         iZJJtHb26VJqXHXbIE28DhsM9ovA+MrnqWrAFGQJGQiZ9MQRjXSGJq+i5eKxg+wLRdeA
         DAGe9PfA8GL7+AsQF63hEPuD54rpNDKCPtpbWCt3oYMC2Qs+/5kYWtiXaYo/2qF3kbOZ
         7eLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=QK1xHO1Pg/29AuoBU3QEa4tmi+YQ3GS5tQx/F6TzO64=;
        fh=lzO5NWXL3zyioRmYouqbQ5HMygVBTUpSUy3wjuSoOaY=;
        b=lvYjLHoJvqRtiNaIlMjCRt1Mw7aHiEe4c4K37/0tDFDg8bB0eMp9jrm3RzQdmjq4Lh
         5CMZ6cKixQ698HWJFZUWCIcqzDWagRNSph1YJ0nZqfsNiPokRkcx1reQ8NvcImgmhXgy
         ZU7asd0UcpBvu2S/3SnYApm9fuhgSVsSLvr+yuK6ZtNoNL2f1KLAbfUAe9QkHSqhbhTb
         eUQfbueWUfnY82uAPjgfp8Rpg3PGeGRZMXQYKrvfHd0rqCpG5QiPLBVPUAUvf5TI+PeJ
         U//Im4CkUuEPi46AjVue9RuFePPTbjKHLG5U1P4bUeLeDQfnJ/xzGIDptKiGmFDHDgtl
         BDKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769657516; x=1770262316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QK1xHO1Pg/29AuoBU3QEa4tmi+YQ3GS5tQx/F6TzO64=;
        b=kVVA2hf4et6Uolu4x6CxF8Gmzcp+vRqfcHr5aNoPkdUa03G2414WfCiG/06XG3Hhtc
         2k+Yup7A8uZIda0fAOpXIvUPeLUBervERY04XeyPdL5EG+YJmeUMwSfMSCg0qjG3tbUw
         U0/RQMexMWcjUy2f4fmBnZ/ltd6tDZhGa2b56ZFWBLOLPS0Xdl1xSnfep3D0C5b+PxGE
         7k8CU6AENuEWhL2U/PpAiLOvldySP3SLlSQ+4Yi4gfnpTNmusX45T3La8cr30A0B6UIl
         Mk5xg+R9bpXbGsHaR+/wv3O+fxzFeLQL1BxF7cAI/svVucm5boDPxdINP8aEVo527lxz
         GFPA==
X-Forwarded-Encrypted: i=1; AJvYcCUSyO9HyWA57A6EEGg8O49Pn/i71UFherQG9prV+cPprL5mVVPS4rN9j7im3bHtGbgooiXSo69S6OeD@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvAeQJWmUvCou4Jun2q3uTIgcXW07YGFqhDA/vCiOM5RvRWrw
	/fk0BvL5EeafZFkgtW2QIsK77tIs8eJmp3tEkJGxC0/6u9Cp2Z7826KrhG2kU2dGu1elRKmoHVm
	N6xqRv5pfZwd1nsXU/bWOv1hwgtqQyjbe0AVi+9x1/nXMJvh9r+vW4mpmOst9NTuBNcnT9nYugA
	tqCAAa3LUvhR5OSZT+yyReA/78BgFwt1ZZN367jq9l4dIsiswRnMsRSnQpoeguygIX
X-Gm-Gg: AZuq6aJL809OjNfb42tF2rMbSypZC89BukELY0kDJvXbYlwfe/wm/QH+rFKxHwQOtUY
	ZXYLgGOhna0PLlLKUJnR5juTsn9vsq9uI0GDarYiHmdWIqFSYesMIo4dh4Y58yviBpV6wGHvkSg
	DIvtyFZ9f9GeSzwUEc+osIEI2EWsj1xCQL28EbW/Nea+0qmZEYi6jX5ibCeV2rFBy3fLE=
X-Received: by 2002:a05:6512:12ce:b0:59d:fbe8:ba61 with SMTP id 2adb3069b0e04-59e04020f3amr2972929e87.17.1769657515897;
        Wed, 28 Jan 2026 19:31:55 -0800 (PST)
X-Received: by 2002:a05:6512:12ce:b0:59d:fbe8:ba61 with SMTP id
 2adb3069b0e04-59e04020f3amr2972922e87.17.1769657515402; Wed, 28 Jan 2026
 19:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128074515.2028982-1-gerald.yang@canonical.com> <4u2l4huoj7zsfy2u37lgdzlmwwdntgqaer7wta7ud3kat7ox2n@oxhbcqryre3r>
In-Reply-To: <4u2l4huoj7zsfy2u37lgdzlmwwdntgqaer7wta7ud3kat7ox2n@oxhbcqryre3r>
From: Gerald Yang <gerald.yang@canonical.com>
Date: Thu, 29 Jan 2026 11:31:43 +0800
X-Gm-Features: AZwV_QgiXLCXzLcZroT26SBf46ab125vXIwXq813Kw_HAevw8VhGtbd2D0ZTSh0
Message-ID: <CAMsNC+s1R-AUzhe80vjxYCSRu0X9Ybp33sSMHGHKpBL6=dG2_w@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13425-lists,linux-ext4=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A3E37AB761
X-Rspamd-Action: no action

Thanks Jan for the review, originally this issue was observed during reboot
because the root filesystem is remounted to read only before shutdown to
make sure all data is flushed to disk.
We don't see any issue on the machine because the data is persisted to
journal. But I think your suggestion is the correct way to fix it, I
will look into
why ext4_writepages doesn't flush data to real file location after calling
sync_filesystem and re-submit the patch for review, thanks again.


On Wed, Jan 28, 2026 at 6:22=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 28-01-26 15:45:15, Gerald Yang wrote:
> > When remounting the filesystem to read only in data=3Djournal mode
> > it may dump the following call trace:
> >
> > [   71.629350] CPU: 0 UID: 0 PID: 177 Comm: kworker/u96:5 Tainted: G   =
         E       6.19.0-rc7 #1 PREEMPT(voluntary)
> > [   71.629352] Tainted: [E]=3DUNSIGNED_MODULE
> > [   71.629353] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)/LXD, =
BIOS unknown 2/2/2022
> > [   71.629354] Workqueue: writeback wb_workfn (flush-7:4)
> > [   71.629359] RIP: 0010:ext4_journal_check_start+0x8b/0xd0
> > [   71.629360] Code: 31 ff 45 31 c0 45 31 c9 e9 42 ad c4 00 48 8b 5d f8=
 b8 fb ff ff ff c9 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 c3 cc cc cc cc=
 <0f> 0b b8 e2 ff ff ff eb c2 0f 0b eb
> >  a9 44 8b 42 08 68 c7 53 ce b8
> > [   71.629361] RSP: 0018:ffffcf32c0fdf6a8 EFLAGS: 00010202
> > [   71.629364] RAX: ffff8f08c8505000 RBX: ffff8f08c67ee800 RCX: 0000000=
000000000
> > [   71.629366] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000=
000000000
> > [   71.629367] RBP: ffffcf32c0fdf6b0 R08: 0000000000000001 R09: 0000000=
000000000
> > [   71.629368] R10: ffff8f08db18b3a8 R11: 0000000000000000 R12: 0000000=
000000000
> > [   71.629368] R13: 0000000000000002 R14: 0000000000000a48 R15: ffff8f0=
8c67ee800
> > [   71.629369] FS:  0000000000000000(0000) GS:ffff8f0a7d273000(0000) kn=
lGS:0000000000000000
> > [   71.629370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   71.629371] CR2: 00007b66825905cc CR3: 000000011053d004 CR4: 0000000=
000772ef0
> > [   71.629374] PKRU: 55555554
> > [   71.629374] Call Trace:
> > [   71.629378]  <TASK>
> > [   71.629382]  __ext4_journal_start_sb+0x38/0x1c0
> > [   71.629383]  mpage_prepare_extent_to_map+0x4af/0x580
> > [   71.629389]  ? sbitmap_get+0x73/0x180
> > [   71.629399]  ext4_do_writepages+0x3cc/0x10a0
> > [   71.629400]  ? kvm_sched_clock_read+0x11/0x20
> > [   71.629409]  ext4_writepages+0xc8/0x1b0
> > [   71.629410]  ? ext4_writepages+0xc8/0x1b0
> > [   71.629411]  do_writepages+0xc4/0x180
> > [   71.629416]  __writeback_single_inode+0x45/0x350
> > [   71.629419]  ? _raw_spin_unlock+0xe/0x40
> > [   71.629423]  writeback_sb_inodes+0x260/0x5c0
> > [   71.629425]  ? __schedule+0x4d1/0x1870
> > [   71.629429]  __writeback_inodes_wb+0x54/0x100
> > [   71.629431]  ? queue_io+0x82/0x140
> > [   71.629433]  wb_writeback+0x1ab/0x330
> > [   71.629448]  wb_workfn+0x31d/0x410
> > [   71.629450]  process_one_work+0x191/0x3e0
> > [   71.629455]  worker_thread+0x2e3/0x420
> >
> > This issue can be easily reproduced by:
> > mkdir -p mnt
> > dd if=3D/dev/zero of=3Dext4disk bs=3D1G count=3D2 oflag=3Ddirect
> > mkfs.ext4 ext4disk
> > tune2fs -o journal_data ext4disk
> > mount ext4disk mnt
> > fio --name=3Dfiotest --rw=3Drandwrite --bs=3D4k --runtime=3D3 --ioengin=
e=3Dlibaio --iodepth=3D128 --numjobs=3D4 --filename=3Dmnt/fiotest --filesiz=
e=3D1G --group_reporting
> > mount -o remount,ro ext4disk mnt
> > sync
> >
> > In data=3Djournal mode, metadata and data are both written to the journ=
al
> > first, but for the second write, ext4 relies on the writeback thread to
> > flush the data to the real file location.
> >
> > After the filesystem is remounted to read only, writeback thread still
> > writes data to it and causes the issue. Return early to avoid starting
> > a journal transaction on a read only filesystem, once the filesystem
> > becomes writable again, the write thread will continue writing data.
> >
> > Signed-off-by: Gerald Yang <gerald.yang@canonical.com>
>
> Thanks for the report and the patch! I can indeed reproduce this warning.
> But the patch itself is certainly not the right fix for this problem.
> ext4_remount() must make sure there are no dirty pages on the filesystem
> anymore when remounting filesystem read only and it apparently fails to d=
o
> so. In particular it calls sync_filesystem() which should make sure all
> data is written. So this bug needs more investigation why there are some
> dirty pages left in the inode in data=3Djournal mode because
> ext4_writepages() should have written them all...
>
>                                                                 Honza
>
> > ---
> >  fs/ext4/inode.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 15ba4d42982f..4e3bbf17995e 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -2787,6 +2787,17 @@ static int ext4_do_writepages(struct mpage_da_da=
ta *mpd)
> >       if (unlikely(ret))
> >               goto out_writepages;
> >
> > +     /*
> > +      * For data=3Djournal, if the filesystem was remounted read-only,
> > +      * the writeback thread may still write dirty pages to it.
> > +      * Return early to avoid starting a journal transaction on a
> > +      * read-only filesystem.
> > +      */
> > +     if (ext4_should_journal_data(inode) && sb_rdonly(inode->i_sb)) {
> > +             ret =3D -EROFS;
> > +             goto out_writepages;
> > +     }
> > +
> >       /*
> >        * If we have inline data and arrive here, it means that
> >        * we will soon create the block for the 1st page, so
> > --
> > 2.43.0
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

