Return-Path: <linux-ext4+bounces-4434-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5BE98CD31
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Oct 2024 08:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B323B28739F
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Oct 2024 06:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C05E12C474;
	Wed,  2 Oct 2024 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZuDeVOjT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FEA85654;
	Wed,  2 Oct 2024 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727850744; cv=none; b=Q//uaL8Y6URk/BU6+2lmWKaWMpOTwtZQGUpBHwcJP9XcP1NAF7J864LFdPuudqiKDko/g+Ll8PYMU8aUZ3RBji9fwlmWhFtZghYjgrFFUMtbsLeCUp8PKMxoa4+YzXU0izIxQDaGqPtWwEAZMjmMYU0rFXZReBSrFi+yJPBZsSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727850744; c=relaxed/simple;
	bh=beSXTZNpSQJrgm/dboc9lG2J79cbrUBdIP3owcfLmtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsYiL1F7dMxMJO0MroFLOq3A/mJplHjS5reMZ8GXUoB512wETwuY5GNq6QO5iwl4VnhRDEyCmxIX7lVLnn/rLH4JylLw3g6fC19HYh1JH5Yb8y6Qz4coXp0XpLc/SkeWVz6nYOsLU4Fbqyj1nLISCRRT7Etfa+boIJ8ZdtcNIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZuDeVOjT; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=rytnYam0s/Yg5MZoj6b9skHoupLyhogGL8l7TQ+yPE0=;
	b=ZuDeVOjTv+bzDeCJ4+/kCtl9PGxcfiTDUIjK3NhUhRha48iSJgl8RpE3lsU5Lu
	osGAmD+L5vxaroOHL2bYuqa4PWyrjW4yMtwrprsSpciJKCyypHDW4Yk5fLDSNNL1
	fCdxwGaoA/LXqyzrmeHCbCgcz6Bd9NqXKje/PM7Nw7LsU=
Received: from localhost (unknown [36.5.132.7])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3XzbV6PxmhmxQAg--.15482S2;
	Wed, 02 Oct 2024 14:31:49 +0800 (CST)
Date: Wed, 2 Oct 2024 14:31:49 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: syzbot <syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com>
Cc: ojaswin@linux.ibm.com, adilger.kernel@dilger.ca, tytso@mit.edu,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] KASAN: out-of-bounds Read in
 ext4_xattr_set_entry
Message-ID: <Zvzo1RC8scv-muur@fedora>
References: <Zu+vI3EipxSsPOMe@thinkpad.lan>
 <66efba95.050a0220.3195df.008c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66efba95.050a0220.3195df.008c.GAE@google.com>
X-CM-TRANSID:_____wD3XzbV6PxmhmxQAg--.15482S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUUEfODUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLwJsamb82pnXTgABsq

#syz test

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index e0e1956dcdd3..649b278d4c1f 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1884,7 +1884,7 @@ ext4_xattr_block_find(struct inode *inode, struct ext4_xattr_info *i,
 		bs->s.here = bs->s.first;
 		error = xattr_find_entry(inode, &bs->s.here, bs->s.end,
 					 i->name_index, i->name, 1);
-		if (error && error != -ENODATA)
+		if (error)
 			return error;
 		bs->s.not_found = error;
 	}

-- 
Best,
Qianqiang Liu


