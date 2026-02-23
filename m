Return-Path: <linux-ext4+bounces-13773-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tHvACz2pm2l94QMAu9opvQ
	(envelope-from <linux-ext4+bounces-13773-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 02:11:25 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA681710F3
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 02:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 746E2301CCD4
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 01:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0AA223DEA;
	Mon, 23 Feb 2026 01:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="TjQPHEqc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D79199E89
	for <linux-ext4@vger.kernel.org>; Mon, 23 Feb 2026 01:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771809076; cv=none; b=Axf0Lg+b76ozvX/9wsLbIcIzVR4/lKo3lAofltBZzEIhv7BnRn1oGJV54DHsXHBQ2DjHe7dbEd5EjbQGcuT+y5FEVwTCIemjReTO3gnEn6Jb1nBKPlZipquK5ITmLv54tPRvJ3RFrH/6RDT8U4u20kXLbv3GsZwd/2HrYTNGw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771809076; c=relaxed/simple;
	bh=L24fpwGeD7px2wf3dFOvRPZK8x7DN7NZLZ/Tn53Csu8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GpuVHHa7Q0Z6Qe/tXLMqQ44W0nIp9T1kDcDqPRSxV1kCF7hiRuGNA6OxHffE7piYXfX9dI80AwXE3yjanJAH1Y9p996N9WJ9pgK0MvZacJyVUEEw34CAZcpMhj4goyh0PFC4OJACyM3Dq+WS4xPOmgp+nPllwAH5ctt0DbShZUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=TjQPHEqc; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35480b0827bso2288079a91.0
        for <linux-ext4@vger.kernel.org>; Sun, 22 Feb 2026 17:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1771809074; x=1772413874; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvESBW1qrUuw3Rqh3QinWReW7kdD3jhBUVJZUasGnN0=;
        b=TjQPHEqcC2VmBXSBFJNSRf1X8+AvN6E4IZrkqtvZ7RdNIDDFNKiThCezwk1+xrN0av
         lW7vrjcYbcZMJ69s+Vxva82wCnu3TFG9kx9BYPvP/cSAx+cePdg0JbojcAUS9kS0IoDC
         3l/KgnscW47agDAaErZSZdgBh7+ZGKqCKKYl+BOJoElptl/NkXkdZ1NN3mXvaCzpnDmM
         uj8wuQy/KmoaggJl6fcL5Wu4nhgALQb5M4zVmWaVxXyhtkHX8hWQnMIMBiehFEdfLsj5
         rFt4xIUbYCTF3sdDWhST2hLpHoX24TVzv5fVlhyERdzl8gAk7nIbSV95TRi30n6OvJmO
         CfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771809074; x=1772413874;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RvESBW1qrUuw3Rqh3QinWReW7kdD3jhBUVJZUasGnN0=;
        b=ljymHDcqcXRpdYrvjkz5W/Cqrvm8vZP8Sp6aByCOWnunOvyqfxxfJKm4cvkdY+jkMj
         ACHsCzpTYa2O51rM7fawoCHzsOhJ+GJ/n1Tya7Zj4lAISySJ/BJyKiKupUbf/rPC5cdk
         nXJWr+/RiBAa/jQ30IbZ/EeUpTozd3tGCNadD2jeJvO4NdyVF+0O7xtHly24gAF8CMCz
         wr+O/xuSix26naapWXlREjy1IP5OiiEx6gCbQ93NrudXwf564yvizFbCz/U/b914/n9V
         2ug7j+t+nuMll9cxsaUUroDVjGaCcilS/W/UhUzEF6snHntQplNMKYzIrXhh80DxvVV7
         eIXg==
X-Forwarded-Encrypted: i=1; AJvYcCVfoJNSI4tA4sMiNsWpnQXMYU9fmTlGv1p/JGnhmY5K8zz7ZLAHTkA83TO5jtkYauSjzutEZHb1KMe4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4XZitjXPOROHEeEVI9CRFRulYLljy7DmCJZDr0+yVDKYnNqW7
	XZeTfsf1mzdcWzWSIIrP4cbHXDdFBnOyPS9qRaHpTVH58dG60+vheN6a6yF2prI1IjLC+25LTNz
	0ZIqBvy8=
X-Gm-Gg: AZuq6aLQwn+hj3ECdPIWvJKWe1EBU8kg+BI6NJBAXinI7bn2BDmamWELvtNpPJSd09j
	AJa6sPq2cyJlSGIK/WLtRg9Xf400p9TBzXFC8jwVXRDivpPmCO1u8sCGkHtNqh66Np5IdKvWIM0
	JB5NQnAB0zHroZBMxePz8CHY6RjOPJXyzh4GVpkTPcyaD7ObLyNKEJjWky3FcABZe0RCelJVIQZ
	2w4LFir3muCPKPwTomCPrZ4LW0FeJisCEp9VLyv71uH9Gx7dzxsbZPsZlWDgpIUcOGbXfej7PbI
	vOgGy1NiGJcblo6Pr+c20cpnR6EQD3JkA+cP/E81wJDt+kumgKxxXBL5FqGEtlI+TlGpQyaP9v7
	KI8Dd2S7DHoD9wgjSPBK9nNtmAIFYAVjvzieVTNy3CrEUvxTFXFGN04r/Wcvuy/23rbkDGswd1s
	EQOh2baOsHnWpz+YYfWQOyip432LkF8sMPNdFi/rm1U3lMaUVOjwY4tNdk2o1z/a5znKt2YiQyP
	Q6lA5CZmqLtiDvx
X-Received: by 2002:a17:90b:2cc7:b0:34c:ab9b:837c with SMTP id 98e67ed59e1d1-358983a8b41mr10989438a91.0.1771809074558;
        Sun, 22 Feb 2026 17:11:14 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358a1a2cb62sm6227722a91.0.2026.02.22.17.11.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Feb 2026 17:11:13 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v2 1/3] jbd2: store jinode dirty range in PAGE_SIZE units
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <19c79ca43a6.6b379cc81360187.4397285579129640737@linux.beauty>
Date: Sun, 22 Feb 2026 18:11:02 -0700
Cc: Theodore Ts'o <tytso@mit.edu>,
 Jan Kara <jack@suse.cz>,
 Mark Fasheh <mark@fasheh.com>,
 linux-ext4 <linux-ext4@vger.kernel.org>,
 ocfs2-devel <ocfs2-devel@lists.linux.dev>,
 Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <890EF4B9-1907-4122-8272-680845C2058E@dilger.ca>
References: <20260219114645.778338-1-me@linux.beauty>
 <20260219114645.778338-2-me@linux.beauty>
 <63C86D0D-9EF6-4D33-95B2-8D0F5B305B0B@dilger.ca>
 <19c79ca43a6.6b379cc81360187.4397285579129640737@linux.beauty>
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
	DKIM_TRACE(0.00)[dilger-ca.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-13773-lists,linux-ext4=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dilger.ca:mid,dilger.ca:email]
X-Rspamd-Queue-Id: 5DA681710F3
X-Rspamd-Action: no action

On Feb 19, 2026, at 23:43, Li Chen <me@linux.beauty> wrote:
>=20
> Hi Andreas,
>=20
> Thanks a lot for your review!
>=20
> ---- On Fri, 20 Feb 2026 05:00:13 +0800  Andreas Dilger =
<adilger@dilger.ca> wrote ---
>> On Feb 19, 2026, at 04:46, Li Chen <me@linux.beauty> wrote:
>>>=20
>>> jbd2_inode fields are updated under journal->j_list_lock, but some =
paths
>>> read them without holding the lock (e.g. fast commit helpers and =
ordered
>>> truncate helpers).
>>>=20
>>> READ_ONCE() alone is not sufficient for i_dirty_start/end as they =
are
>>> loff_t and 32-bit platforms can observe torn loads. Store the dirty =
range
>>> in PAGE_SIZE units as pgoff_t so lockless readers can take non-torn
>>> snapshots.
>>=20
>> When making semantic changes like this, it is best to change the =
variable
>> names as well, so that breaks compilation if bisection happens to =
land
>> between these patches.  Otherwise, that could cause some random =
behavior
>> if jbd2 is treating these as pages, but ext4/ocfs2 are treating them =
as
>> bytes or vice versa.
>>=20
>> Something like i_dirty_{start,end} -> i_dirty_{start,end}_page would =
make
>> this very clear what the units are.
>=20
> Agreed. I=E2=80=99ll make the units explicit in the field names (e.g. =
*_page).
>=20
>> To avoid breakage between the patches (which is desirable to avoid =
problems
>> with automated bisection) you should make an initial patch with =
wrappers to
>> access these values and convert ext4/ocfs2 to use them:
>>=20
>> static inline loff_t jbd2_jinode_dirty_start(struct jbd2_inode =
*jinode)
>> {
>>    return jinode->i_dirty_start;
>> }
>>=20
>> static inline loff_t jbd2_jinode_dirty_end(struct jbd2_inode *jinode)
>> {
>>    return jinode->i_dirty_end;
>> }
>>=20
>> then change this in the jbd2 patch at the end, which would then be =
self-contained:
>>=20
>> static inline loff_t jbd2_jinode_dirty_start(struct jbd2_inode =
*jinode)
>> {
>>    return (loff_t)jinode->i_dirty_start_page << PAGE_SHIFT;
>> }
>>=20
>> static inline loff_t jbd2_jinode_dirty_end(struct jbd2_inode *jinode)
>> {
>>    return ((loff_t)jinode->i_dirty_end_page << PAGE_SHIFT) + =
~PAGE_MASK;
>> }
>=20
>=20
> Agreed as well. I=E2=80=99ll add an accessor and switch ext4/ocfs2 =
over to it first,
> Then do the internal representation change later.
>=20
> I plan to use a single helper that returns the (start,end) pair in
> bytes:
>=20
> static inline bool jbd2_jinode_get_dirty_range(const struct jbd2_inode =
*jinode,
> loff_t *start, loff_t *end)
> {
>    pgoff_t start_page =3D READ_ONCE(jinode->i_dirty_start_page);
>    pgoff_t end_page =3D READ_ONCE(jinode->i_dirty_end_page);
>=20
>    if (end_page =3D=3D JBD2_INODE_DIRTY_RANGE_NONE)
>      return false;
>=20
>    *start =3D (loff_t)start_page << PAGE_SHIFT;
>    *end =3D ((loff_t)end_page << PAGE_SHIFT) + PAGE_SIZE - 1;
>    return true;
>=20
> }
>=20
> I think this is a bit easier to use correctly than separate start/end =
helpers
> (keeps start/end together, and the end-of-page conversion lives in one =
place).
>=20
> Does that sound OK, or would you rather see separate
> jbd2_jinode_dirty_start()/jbd2_jinode_dirty_end() helpers?

This is fine with me.  I had only proposed the other option as a =
"typical"
interface for such fields.  If start/end are always used together then =
it
is fine that there is only one function to get these fields, and one to
set them.

Cheers, Andreas





