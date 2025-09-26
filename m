Return-Path: <linux-ext4+bounces-10441-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B212ABA53EE
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 23:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0063A1C0092F
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 21:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB7029A30A;
	Fri, 26 Sep 2025 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="kxixSHYF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B4228B4FD
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923282; cv=none; b=KtYFSXvsCYY4RsinlY9LArXc2GsQyubU8Xt0DUVwi2E2q2DYkG7guhGQ9/YHVGFs1nIA5o2vXeDvBtcoYTb9x7BbxCfFfwWu87VSTSlGr93nXKe0vYjN8R9qbEk39duZnJMJza7GJKprZ2ieYwlvPW+uB/Fv993r9VUmea1f+2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923282; c=relaxed/simple;
	bh=9NNO5o373SqWmt6lRk8DvxTwe9onkIyB00giMfN4AYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KguWTpFcHyvwyaXolk72Oj3TOX7Xpu93bpUmn6xgZMPM5SMXE3EhFQRQqQB/GCVS6dT4rOVs0ug7WxInzfIi/2e9XmbOnFycXOpPJR913ZPzfCtHLcp1mxE6k3D0RxGvGedLg6DvaI7zqHpaHBzPC2FK3rdi3NQ8i5IBYVBy7gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=kxixSHYF; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLlslu014684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758923276; bh=5zfWWRMDmJQ6sgyIHjdjHF2ZrLrX84iVpbUGQfi3jjs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=kxixSHYF6P1m94PzYyxOuBt82NAYLUHFK9vEdlDALwwVYgr8QsYmUOyLpV6RBIJ4f
	 G6DAvXllMeLqUdcUjDBGllNpwmcMCqV+nDBbFqn/vjLrdnQ8jF5/Qbaq1bolxWW3o3
	 eZ1RXymYlJpeGh1/jz9FSKiXRCdK3OBBnBn9IlxMPpfesKd6NnUA6aXRfFEyNIKoGy
	 sWHbbTS2EPT2iqzQcKDbGfaAllg/n048smGwJwl0ZTTKrF+/7ltJYHgMhEKmIrzbyY
	 0bFP+dl653KnehjvZe/ymzfUYUTG+iLp9LuZ2Xf2szztiw+5knoh4YxaO+Yn4VOxIQ
	 58KC8iLSx5eVg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D31B82E00D5; Fri, 26 Sep 2025 17:47:53 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Ahmet Eray Karadag <eraykrdg1@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com,
        Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: Re: [PATCH v2] Fix: ext4: guard against EA inode refcount underflow in xattr update
Date: Fri, 26 Sep 2025 17:47:35 -0400
Message-ID: <175892300646.128029.18166257596583769324.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920021342.45575-1-eraykrdg1@gmail.com>
References: <20250918175545.48297-1-eraykrdg1@gmail.com> <20250920021342.45575-1-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 20 Sep 2025 05:13:43 +0300, Ahmet Eray Karadag wrote:
> syzkaller found a path where ext4_xattr_inode_update_ref() reads an EA
> inode refcount that is already <= 0 and then applies ref_change (often
> -1). That lets the refcount underflow and we proceed with a bogus value,
> triggering errors like:
> 
>   EXT4-fs error: EA inode <n> ref underflow: ref_count=-1 ref_change=-1
>   EXT4-fs warning: ea_inode dec ref err=-117
> 
> [...]

Applied, thanks!

[1/1] Fix: ext4: guard against EA inode refcount underflow in xattr update
      commit: 57295e835408d8d425bef58da5253465db3d6888

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

