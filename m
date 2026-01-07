Return-Path: <linux-ext4+bounces-12612-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A77CFEEF8
	for <lists+linux-ext4@lfdr.de>; Wed, 07 Jan 2026 17:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F67C31DFF93
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jan 2026 16:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48FB3446D1;
	Wed,  7 Jan 2026 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="hh1HlCob"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10333446A0;
	Wed,  7 Jan 2026 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796240; cv=pass; b=Dc3Q54KXplXmguNuY3S33dW0e+Uie+W2CDHnHIgh6fxYR9Ej7PP++PbEYaVtRuhgdI0tqz2pY4Am6TZm6B4YhhM8G1n/y7I5KkLw7CeHTz0jSxDNL4ZyIZku5Owl/RDgZig4d3qNoBG7Fv2cH0pTBwxavyUPPZX0k/2jkOsaqG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796240; c=relaxed/simple;
	bh=VazaG8fKnrdrclnpjh9pm6+587POHVlCKO9amzOd8kU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QPuVIe25bz5YGgGQkAjJHhFzmpSaQh4A2Io87QmDXw303OeICgHSfyUZLkdqgjaYP32vjP2bU7++XDkxC/7jt/2nIb9PLWyVkH0KbQjPxiaBDAclv1C6HPTjaZ3cJ94ZFKmvmfoYYks81Lb7AtzlB+YF6V7NyJsItR6LcdGt9+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=hh1HlCob; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1767796235; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VHiFLjp7+gXKVnCFg29dJmijO/6YjHoi4mCEJOj/rdBXpbK+W7AD0oKOCUEoIBhkpJ0QQPg6mbPVpvoefIFiAOpYqw8vRnfPhbiwwV9APLeRsVth5XudCCCBCTlOhY2uU6y6nD0J2hZey/5FmNTP9qHj65vGowyZWDZyvOznffc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767796235; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dLcpAXrRiG6zIAgFWPxpdj/w09uFYZ3OsZqoWHN3WHc=; 
	b=YQffBEkOaDXknfNZrVeWiiKFuBFVH8lr1IhWh16tC/9EG2y4vVTQFzQSZPVbWSW7l5E1TMOaxyGYsX0TxnX4Jb3gJoy8TuqpbyBOke5xhP9ELli/dCGDqJK/LvTQ/DM6/S2m6hHLBcv5GQG6FjfL+cLIFkyD7r9OedjtR6jYRJc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767796235;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=dLcpAXrRiG6zIAgFWPxpdj/w09uFYZ3OsZqoWHN3WHc=;
	b=hh1HlCobc30bcvgjAS9CaputvGnnF94EJCTFyaByiSbmxdWqPwxZooyV1JsVDdrg
	H9jUf+5wLJdGFJ27yxZ4gNDh7do/UsfwEmFjIRZ2RccBRTIsIF4MRtt6lhZPtevpM27
	Oxa3ZS9fOnvpH/dhpkLn7PjtZZKWA1JDCMCyB1/w=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1767796232516623.2821289037377; Wed, 7 Jan 2026 06:30:32 -0800 (PST)
Date: Wed, 07 Jan 2026 22:30:32 +0800
From: Li Chen <me@linux.beauty>
To: "Zhang Yi" <yi.zhang@huaweicloud.com>
Cc: "linux-ext4" <linux-ext4@vger.kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Andreas Dilger" <adilger.kernel@dilger.ca>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19b98ddd118.2300666e5265102.1629777029508214951@linux.beauty>
In-Reply-To: <a507a2ce-a2ae-4592-b171-63974034fc1b@huaweicloud.com>
References: <20251224032943.134063-1-me@linux.beauty>
 <20251224032943.134063-2-me@linux.beauty>
 <e3465e09-0b6f-419c-9af5-00e750448e53@huaweicloud.com>
 <19b933e4928.7e19f7474492475.8810694155148118128@linux.beauty> <a507a2ce-a2ae-4592-b171-63974034fc1b@huaweicloud.com>
Subject: Re: [RFC v3 1/2] ext4: fast_commit: assert i_data_sem only before
 sleep
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

Hi Zhang,

Thanks a lot for your detailed review!

 ---- On Wed, 07 Jan 2026 10:00:23 +0800  Zhang Yi <yi.zhang@huaweicloud.co=
m> wrote ---=20
 > On 1/6/2026 8:18 PM, Li Chen wrote:
 > > Hi Zhang Yi,
 > >=20
 > >  ---- On Mon, 05 Jan 2026 20:18:42 +0800  Zhang Yi <yi.zhang@huaweiclo=
ud.com> wrote ---=20
 > >  > Hi Li,
 > >  >=20
 > >  > On 12/24/2025 11:29 AM, Li Chen wrote:
 > >  > > ext4_fc_track_inode() can return without sleeping when
 > >  > > EXT4_STATE_FC_COMMITTING is already clear. The lockdep assertion =
for
 > >  > > ei->i_data_sem was done unconditionally before the wait loop, whi=
ch can
 > >  > > WARN in call paths that hold i_data_sem even though we never bloc=
k. Move
 > >  > > lockdep_assert_not_held(&ei->i_data_sem) into the actual sleep pa=
th,
 > >  > > right before schedule().
 > >  > >=20
 > >  > > Signed-off-by: Li Chen <me@linux.beauty>
 > >  >=20
 > >  > Thank you for the fix patch! However, the solution does not seem to=
 fix
 > >  > the issue. IIUC, the root cause of this issue is the following race
 > >  > condition (show only one case), and it may cause a real ABBA dead l=
ock
 > >  > issue.
 > >  >=20
 > >  > ext4_map_blocks()
 > >  >  hold i_data_sem // <- A
 > >  >  ext4_mb_new_blocks()
 > >  >   ext4_dirty_inode()
 > >  >                                  ext4_fc_commit()
 > >  >                                   ext4_fc_perform_commit()
 > >  >                                    set EXT4_STATE_FC_COMMITTING  <-=
B
 > >  >                                    ext4_fc_write_inode_data()
 > >  >                                    ext4_map_blocks()
 > >  >                                     hold i_data_sem  // <- A
 > >  >    ext4_fc_track_inode()
 > >  >     wait EXT4_STATE_FC_COMMITTING  <- B
 > >  >                                   jbd2_fc_end_commit()
 > >  >                                    ext4_fc_cleanup()
 > >  >                                     clear EXT4_STATE_FC_COMMITTING(=
)
 > >  >=20
=20
I think the ABBA reasoning is plausible: if a caller violates the ordering
contract and enters ext4_fc_track_inode() while holding i_data_sem, and the
recheck still finds EXT4_STATE_FC_COMMITTING set (so we actually schedule()=
),
then we can get A -> wait(B). If the commit task, while holding the inode
in COMMITTING, still needs i_data_sem (e.g. via mapping/log writing), that
gives B -> wait(A), forming a cycle.

 > >  > Postponing the lockdep assertion to the point where sleeping is act=
ually
 > >  > necessary does not resolve this deadlock issue, it merely masks the
 > >  > problem, right?
 > >  >=20
 > >  > I currently don't quite understand why only ext4_fc_track_inode() n=
eeds
 > >  > to wait for the inode being fast committed to be completed, instead=
 of
 > >  > adding it to the FC_Q_STAGING list like other tracking operations.
 >=20
 > It seems that the inode metadata of the tracked inode was not recorded
 > during the __track_inode(), so the inode metadata committed at commit
 > time reflects real-time data. However, the current
 > ext4_fc_perform_commit() lacks concurrency control, allowing other
 > processes to simultaneously initiate new handles that modify the inode
 > metadata while the previous metadata is being fast committed. Therefore,
 > to prevent recording newly changed inode metadata during the old commit
 > phase, the ext4_fc_track_inode() function must wait for the ongoing
 > commit process to complete before modifying.
 >=20
 > >  > So
 > >  > now I don't have a good idea to fix this problem either.  Perhaps w=
e
 > >  > need to rethink the necessity of this waiting, or find a way to avo=
id
 > >  > acquiring i_data_sem during fast commit.
 >=20
 > Ha, the solution seems to have already been listed in the TODOs in
 > fast_commit.c.
 >=20
 >   Change ext4_fc_commit() to lookup logical to physical mapping using ex=
tent
 >   status tree. This would get rid of the need to call ext4_fc_track_inod=
e()
 >   before acquiring i_data_sem. To do that we would need to ensure that
 >   modified extents from the extent status tree are not evicted from memo=
ry.
 >=20
 > Alternatively, recording the mapped range of tracking might also be
 > feasible.

Thanks a lot for your insights!

For the next revesion, I plan to follow the "Alternatively" way firstly:
record the mapped ranges (and relvant inode metadata) at commit time in a
snapshot, when journal updates are locked/handles are drained, and then
consume only the snapshot during log writing. This avoids doing
logical-to-physical mapping (and thus avoids taking i_data_sem) in the log
writing phase, and removes the need for ext4_fc_track_inode() to wait for
EXT4_STATE_FC_COMMITTING.

I did not pick the extent status tree approach because it would require
additional work to guarantee the needed mappings are resident and not
evicted under memory pressure, which seems like a larger correctness
surface(Please correct me if I'm wrong). If you believe the extent stats tr=
ee
approach is better, please let me know, and I will do my best to implement =
it.

Thanks again for the guidance. I'll post an RFC v3 later.

Regards,
Li=E2=80=8B


