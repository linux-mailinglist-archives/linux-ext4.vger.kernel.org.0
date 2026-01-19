Return-Path: <linux-ext4+bounces-12994-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A31C3D3A928
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 13:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7D14304AD9E
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB9835BDB9;
	Mon, 19 Jan 2026 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="f9SVYO1z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79EF3254BA;
	Mon, 19 Jan 2026 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768826239; cv=pass; b=sCUh7I+DGzkthcStLndW0n5SyiRG9Q+I5MZR7LrV3ounoV03bmtpccS5k6P/cX23XGd6C/jHneC4LVHQTXQfJCs4rudFOq9FSbE79eqhSx4K0nV0zsNO15e/GirZtlLanXCnfU29fBz6AlXP+qaYaaQ8+ZTXZsVpLtAEwlmeFP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768826239; c=relaxed/simple;
	bh=8iuRL5iDQxhFERdi7kyXrTfaJXiRvp/YjS7SSZHA7QM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XWU8UBS98WEsQ3jC3EDXWx4FlkLXz2591xW6EVLfXoBcmDIQdlR8/ZwLwUN2jt8eJVYiVegSFGg3f2F3CGK/u6YdW+j9++p7jW4Ia/aTHaWLT3XOqDbqzVTsXxcEuSMAii2H8FdE1dH0HDohYYVOLwSmPAdAd680SSA/crH2peo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=f9SVYO1z; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1768826227; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OCQLWip0V8ycRN0le3IfSbZrXLRwuQWgeseKJVnGbxfKFLTBbGLPQacrlhMTPZQZrzcznTvUSCGAgrO21AAb7uPK9ZoUfPyx8Us0tHF6vesggD0awsMEK2rbgKIvjttOPB09YjZKclaVBbPWPEpNf+7HoLG2Wkj8nd/r7ruL9hc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768826227; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=a2cOf9QgloVERotVQElpm03ru32mC8PtAxtjolWNNg0=; 
	b=ZQ4iN8KlpYr5SIbN5oT11ySs+whBcLr5zK8PXtXAO2WRvQXJuAe6Oz9695RCMd/ZEzfbJHcdoeJv+kZsDZdkf1d6EXOV+ea7J8bPSrr2HUVu1Ze9fPKPylGHwryGL8dk6Yn1SGY610NTkorNKHKzfDE86IgPza6Ee3Yj8NAHqlA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768826227;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=a2cOf9QgloVERotVQElpm03ru32mC8PtAxtjolWNNg0=;
	b=f9SVYO1zGCAK4F31mDIqp3MDWLvNjFARdxaIss0JgFB82sYzkhWp4OPTlUvzHmQK
	weVq5DSPmjMa88Rsy+DtVdxgLcmBfkAViW1QDQx2zwI5DpiDjD2MwL30DhzIVMBiJEB
	ZomG2epoat5F+MpwKrjLUyESf+4FPbG5sWVuHZI0=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1768826226169704.2831446307098; Mon, 19 Jan 2026 04:37:06 -0800 (PST)
Date: Mon, 19 Jan 2026 20:37:06 +0800
From: Li Chen <me@linux.beauty>
To: "Theodore Tso" <tytso@mit.edu>
Cc: "Andreas Dilger" <adilger.kernel@dilger.ca>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Masami Hiramatsu" <mhiramat@kernel.org>,
	"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
	"linux-ext4" <linux-ext4@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>
Message-ID: <19bd642457a.3b9e5d002518428.1219702468395791363@linux.beauty>
In-Reply-To: <20260119025857.GC19954@macsyma.local>
References: <20251211115146.897420-1-me@linux.beauty>
 <20251211115146.897420-6-me@linux.beauty> <20260119025857.GC19954@macsyma.local>
Subject: Re: [RFC 5/5] ext4: mark group extend fast-commit ineligible
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

Hi Theodore,

Thanks for your reply.

 > On Thu, Dec 11, 2025 at 07:51:42PM +0800, Li Chen wrote:
 > > Fast commits only log operations that have dedicated replay support.
 > > EXT4_IOC_GROUP_EXTEND grows the filesystem to the end of the last
 > > block group and updates the same on-disk metadata without going
 > > through the fast commit tracking paths.
 > > In practice these operations are rare and usually followed by further
 > > updates, but mixing them into a fast commit makes the overall
 > > semantics harder to reason about and risks replay gaps if new call
 > > sites appear.
 > >=20
 > > Teach ext4 to mark the filesystem fast-commit ineligible when
 > > EXT4_IOC_GROUP_EXTEND grows the filesystem.
 > > This forces those transactions to fall back to a full commit,
 > > ensuring that the group extension changes are captured by the normal
 > > journal rather than partially encoded in fast commit TLVs.
 > > This change should not affect common workloads but makes online
 > > resize via GROUP_EXTEND safer and easier to reason about under fast
 > > commit.
 > >=20
 > > Testing:
 > > 1. prepare:
 > >     dd if=3D/dev/zero of=3D/root/fc_resize.img bs=3D1M count=3D0 seek=
=3D256
 > >     mkfs.ext4 -O fast_commit -F /root/fc_resize.img
 > >     mkdir -p /mnt/fc_resize && mount -t ext4 -o loop /root/fc_resize.i=
mg /mnt/fc_resize
 > > 2. Extended the filesystem to the end of the last block group using a
 > >    helper that calls EXT4_IOC_GROUP_EXTEND on the mounted filesystem
 > >    and checked fc_info:
 > >     ./group_extend_helper /mnt/fc_resize
 > >     cat /proc/fs/ext4/loop0/fc_info
 > >    shows the "Resize" ineligible reason increased.
 > > 3. Fsynced a file on the resized filesystem and confirmed that the fas=
t
 > >    commit ineligible counter incremented for the resize transaction:
 > >     touch /mnt/fc_resize/file
 > >     /root/fsync_file /mnt/fc_resize/file
 > >     sync
 > >     cat /proc/fs/ext4/loop0/fc_info
 > >=20
 > > Signed-off-by: Li Chen <me@linux.beauty>
 >=20
 > I'm curious what version of the kernel you were testing against?  I
 > needed to mnake the final fix up to allow the patch to compile:
=20
I'm sorry I didn't mention the kernel version in the cover letter. This pat=
chset is built against 7d0a66e4bb90 (tag: v6.18) Linux 6.18.

Regards,
Li=E2=80=8B

 > diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
 > index 9354083222b1..ce1f738dff93 100644
 > --- a/fs/ext4/move_extent.c
 > +++ b/fs/ext4/move_extent.c
 > @@ -321,7 +321,8 @@ static int mext_move_extent(struct mext_data *mext, =
u64 *m_len)
 >          ret =3D PTR_ERR(handle);
 >          goto out;
 >      }
 > -    ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_MOVE_EXT, handle);
 > +    ext4_fc_mark_ineligible(orig_inode->i_sb, EXT4_FC_REASON_MOVE_EXT,
 > +                handle);
 > =20
 >      ret =3D mext_move_begin(mext, folio, &move_type);
 >      if (ret)
 >=20
 >                         - Ted
 >=20


