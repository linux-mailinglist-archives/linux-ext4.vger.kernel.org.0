Return-Path: <linux-ext4+bounces-12611-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCDECFE459
	for <lists+linux-ext4@lfdr.de>; Wed, 07 Jan 2026 15:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AC1A30C7168
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jan 2026 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825BF3081AD;
	Wed,  7 Jan 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="E/QT3Lxo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF8933F8BB
	for <linux-ext4@vger.kernel.org>; Wed,  7 Jan 2026 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795574; cv=pass; b=qNhizmdYjtsCO4ncoS7vMXf6Y907WurxiISH8TGI1iJGVuQ4M55li/9rBulpWef4o/+2UWFWhzFVe+fuC5gTEPVgT1uQ5kdoFRbGq/Cj83lRdsmMoTmyvPke97WQ+Ar4Pdwd8LbdwNje0A9az1HvRjC9RNkcZ3LiqJDBzoxJfLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795574; c=relaxed/simple;
	bh=7jaRDaJxLVAGQ1GJCJtsT1GbN8AIwL8i0iJ1qpHdUMg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=IK0l+mtjsT7guppk1u/nC02eHvEGxTTC7FhhTkCjEHtb6j21Xx0irW4j5+E9mJrX2EF4kuHaN3RFIISjM4VYlJiEtBtXGjXBt2K3V0BGkpDOXAX3uG6ZLkOAyCNJOmuegYvyEw8uOGF0ydE36s8uo/dpkzpBVww6GdKt/GDRuK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=E/QT3Lxo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1767795562; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JqQ999Z1RTmXqklrVpGtRrDKWo3tf76SJHUxP/h6zSAMev75wfAz9oMmO4eWPu/e0wAWe2jfO6Y4JV+xC9SK8+U1KYyV/kvTmJg6PkTXJFBfcBBl/2clKo4l/cEtF1cjFbtWG6ih7jYOOfO7OBb3l0kFKhNq2qvfdUA0xgOgEDs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767795562; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iqhIUfBevoGJGsstOFRB5NLFts/FmlQNPdT/xcEN6DE=; 
	b=jLzWPEC5hxTlPIOW8vDDWoY9p1BkRjF3Q+44EXDj7gN+eY0FHBDQPFD8JdxciEcHD/uIGHxVz95JsFhgsIt7ZVQyYTnFYpBiLG9KF0Kx2D+kCE98JBhBxJlBHsJ3x2XYeA5a7gBNQcsitwX3G1nI2BN3Ukmj2/gESFEu43pmZSY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767795562;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=iqhIUfBevoGJGsstOFRB5NLFts/FmlQNPdT/xcEN6DE=;
	b=E/QT3LxosritVp6g2wtp3bdyZU0qci6oBovviz6oNuTEqt0XgZ9KgVFysPDNAqeq
	iBo1NU6pVtR0V360hSgb+Eu+S8ptioOk0Ox8g8vvlorBUZD+8JuxlUVHvM3Rm3E0ylo
	oWX2c8XzL/8COk1t+8MVRo85k1F9+c8rKJTSIOq4=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1767795560492567.7120386748766; Wed, 7 Jan 2026 06:19:20 -0800 (PST)
Date: Wed, 07 Jan 2026 22:19:20 +0800
From: Li Chen <me@linux.beauty>
To: "Zhang Yi" <yi.zhang@huaweicloud.com>
Cc: "linux-ext4" <linux-ext4@vger.kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Andreas Dilger" <adilger.kernel@dilger.ca>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19b98d3901d.6853c0d25256967.6003033557062251155@linux.beauty>
In-Reply-To: <e3465e09-0b6f-419c-9af5-00e750448e53@huaweicloud.com>
References: <20251224032943.134063-1-me@linux.beauty>
 <20251224032943.134063-2-me@linux.beauty> <e3465e09-0b6f-419c-9af5-00e750448e53@huaweicloud.com>
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

Thanks a lot for your comments!

 ---- On Mon, 05 Jan 2026 20:18:42 +0800  Zhang Yi <yi.zhang@huaweicloud.co=
m> wrote ---=20
 > Hi Li,
 >=20
 > On 12/24/2025 11:29 AM, Li Chen wrote:
 > > ext4_fc_track_inode() can return without sleeping when
 > > EXT4_STATE_FC_COMMITTING is already clear. The lockdep assertion for
 > > ei->i_data_sem was done unconditionally before the wait loop, which ca=
n
 > > WARN in call paths that hold i_data_sem even though we never block. Mo=
ve
 > > lockdep_assert_not_held(&ei->i_data_sem) into the actual sleep path,
 > > right before schedule().
 > >=20
 > > Signed-off-by: Li Chen <me@linux.beauty>
 >=20
 > Thank you for the fix patch! However, the solution does not seem to fix
 > the issue. IIUC, the root cause of this issue is the following race
 > condition (show only one case), and it may cause a real ABBA dead lock
 > issue.
 >=20
 > ext4_map_blocks()
 >  hold i_data_sem // <- A
 >  ext4_mb_new_blocks()
 >   ext4_dirty_inode()
 >                                  ext4_fc_commit()
 >                                   ext4_fc_perform_commit()
 >                                    set EXT4_STATE_FC_COMMITTING  <-B
 >                                    ext4_fc_write_inode_data()
 >                                    ext4_map_blocks()
 >                                     hold i_data_sem  // <- A
 >    ext4_fc_track_inode()
 >     wait EXT4_STATE_FC_COMMITTING  <- B
 >                                   jbd2_fc_end_commit()
 >                                    ext4_fc_cleanup()
 >                                     clear EXT4_STATE_FC_COMMITTING()
 >=20
 > Postponing the lockdep assertion to the point where sleeping is actually
 > necessary does not resolve this deadlock issue, it merely masks the
 > problem, right?
=20
I agree. Moving lockdep_assert_not_held(&ei->i_data_sem) closer to the
schedule() site can reduce spurious warnings (since the wait-bit pattern
rechecks the bit after prepare_to_wait()), but it does not remove the
underlying deadlock risk if we ever end up sleeping there, althoughI still=
=20
haven't been able to reproduce this ABBA issue.

 > I currently don't quite understand why only ext4_fc_track_inode() needs
 > to wait for the inode being fast committed to be completed, instead of
 > adding it to the FC_Q_STAGING list like other tracking operations. So
 > now I don't have a good idea to fix this problem either.  Perhaps we
 > need to rethink the necessity of this waiting, or find a way to avoid
 > acquiring i_data_sem during fast commit.
 >=20
 > Thanks,
 > Yi.
 >=20
 > > ---
 > >  fs/ext4/fast_commit.c | 17 +++++++++--------
 > >  1 file changed, 9 insertions(+), 8 deletions(-)
 > >=20
 > > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
 > > index d0926967d086..b0c458082997 100644
 > > --- a/fs/ext4/fast_commit.c
 > > +++ b/fs/ext4/fast_commit.c
 > > @@ -566,13 +566,6 @@ void ext4_fc_track_inode(handle_t *handle, struct=
 inode *inode)
 > >      if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
 > >          return;
 > > =20
 > > -    /*
 > > -     * If we come here, we may sleep while waiting for the inode to
 > > -     * commit. We shouldn't be holding i_data_sem when we go to sleep=
 since
 > > -     * the commit path needs to grab the lock while committing the in=
ode.
 > > -     */
 > > -    lockdep_assert_not_held(&ei->i_data_sem);
 > > -
 > >      while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
 > >  #if (BITS_PER_LONG < 64)
 > >          DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
 > > @@ -586,8 +579,16 @@ void ext4_fc_track_inode(handle_t *handle, struct=
 inode *inode)
 > >                     EXT4_STATE_FC_COMMITTING);
 > >  #endif
 > >          prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
 > > -        if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
 > > +        if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
 > > +            /*
 > > +             * We might sleep while waiting for the inode to commit.
 > > +             * We shouldn't be holding i_data_sem when we go to sleep
 > > +             * since the commit path may grab it while committing thi=
s
 > > +             * inode.
 > > +             */
 > > +            lockdep_assert_not_held(&ei->i_data_sem);
 > >              schedule();
 > > +        }
 > >          finish_wait(wq, &wait.wq_entry);
 > >      }
 > > =20
 >=20
 >=20

Regards,
Li=E2=80=8B


