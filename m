Return-Path: <linux-ext4+bounces-12590-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CD1CF8464
	for <lists+linux-ext4@lfdr.de>; Tue, 06 Jan 2026 13:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B497730141C0
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jan 2026 12:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9323D27E05A;
	Tue,  6 Jan 2026 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="ZYSpEm/0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC41B23EA8A;
	Tue,  6 Jan 2026 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701899; cv=pass; b=rzEdGnIfvTpNDwfgsYFXUUZxKER67e5VJv5/DGKlGcAc5Ri6U2/GLhTNCt1rt7PEw58OlMyXS7eRRz7jR2Yl2TAjjruUBpTlKmVd2dAtkkI4XICKNsEyGJCKpOXuMpTk0SfdCzeuhfi1apCIEEsNsaRpRsFERXgsQU9IfM3JS7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701899; c=relaxed/simple;
	bh=Cm8lCYz2yF3U0Mh/cqFh1h62SCKID9ZwqQk1eZvb8mM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=cNMOU/o1lEJ/zIWsHQ5zjud1miIPQLgn7OYbN2SSZTmhSqEs9ldR4uFCc2HSdbAG73Q1N5CWV2PSYbRm1rUL+lReBgc5PCK0tag+A+Zow4sOw/nbArUx7waIaEvAZsYNFHFwuTTJ9SFqMgmwBQUc0BM728eyfC6vWw6YlJVMYOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=ZYSpEm/0; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1767701892; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GMR7rU8Cr3tlDY9jCf5rG2nnTApZhR+VBHJys17nK5rHzqCZMhl4cxIIF6pslF1gcPAS0f2sRtL6FMeWpwcm/bE0RBGowIxmEpU4Svd2U2yJ4/wEX+zQJBd1WEsy3Cqf0hm1DLeRxLbTiFPOvFe7UK1KcCr2h5UxjYdQ2iGme4k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767701892; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XgTnZeJnXxOJlAw0I8dRzvE+FagytitptWpP2wl+8QE=; 
	b=Gi36Q4nMZo1C8pIO5+aFDc2cPT881U73PC0vK7ue5N49Gan1gJmS1LJNfLvrOT0UA7QYRaNdRlbXeEIyTE5r7dP2LQxPK9BvBlw2EXhlkyJQN1gAR1w6UjgIdcx6oayhDbBhGJk/6q1bFSbfNCNgylY7u4n/f1mBwIW7fvkixlk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767701892;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=XgTnZeJnXxOJlAw0I8dRzvE+FagytitptWpP2wl+8QE=;
	b=ZYSpEm/00TeHHDxnz8I0darEy65S1z7w6oMw+Bs+OOuLunq2AJF6k6tVB5y2hkpM
	ZVSeTi/vwB9vQDCxZnLSrqcSZXb1VZCqkLTFfTlvu7RR9fdBqS8sIlIYO33DL6J7hvm
	o479hfrCIbI/8Ly/1p40WJu2/4OHNqpX1U8m1N6o=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1767701891387807.4953823463848; Tue, 6 Jan 2026 04:18:11 -0800 (PST)
Date: Tue, 06 Jan 2026 20:18:11 +0800
From: Li Chen <me@linux.beauty>
To: "Zhang Yi" <yi.zhang@huaweicloud.com>
Cc: "linux-ext4" <linux-ext4@vger.kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Andreas Dilger" <adilger.kernel@dilger.ca>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19b933e4928.7e19f7474492475.8810694155148118128@linux.beauty>
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

Hi Zhang Yi,

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
 >=20
 > I currently don't quite understand why only ext4_fc_track_inode() needs
 > to wait for the inode being fast committed to be completed, instead of
 > adding it to the FC_Q_STAGING list like other tracking operations. So
 > now I don't have a good idea to fix this problem either.  Perhaps we
 > need to rethink the necessity of this waiting, or find a way to avoid
 > acquiring i_data_sem during fast commit.

Thanks a lot for your kind review! I'll provide feedback tomorrow.

Regards,
Li=E2=80=8B


