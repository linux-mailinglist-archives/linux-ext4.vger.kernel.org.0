Return-Path: <linux-ext4+bounces-4433-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0562598CD24
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Oct 2024 08:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E681C21C1F
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Oct 2024 06:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2F5126C08;
	Wed,  2 Oct 2024 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cHzhCsS5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E172C6A3;
	Wed,  2 Oct 2024 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727850529; cv=none; b=eUgdjBVesqBzFgv90lFdjXeHQHdpRJk99muT2gyUnfqKBtK55UUaTYrD+kVbPgNnoakaraDKcqMqMhkuTrU28cs10R+NKy+PvKDh08iaWGTfYS7WLOR5WclveUX7d7OCENmIzELpjbkCvDWkkYbQS68+RfJsI8TPQ0Vg+CNxmyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727850529; c=relaxed/simple;
	bh=S5xccmIRR4s1Or0tRBqBbDGOve1wlRJ5zzwghsFnIJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSo/rO1KcZxT4EIOnJ5HxWGQOqbvFVVTrdw8sFvW1gQWsb8xAfZ1mzgmHrX7yOEApMAVJ4lyGOAMcFw5qMu/h6jdytmfC2jLpZ5hUi8TIpc9zsFWZNTRj9e6YiJIwGGSW/dKn6E5QsdxEdpvw49KaVC9mGGXuniSJ3DpPddel/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cHzhCsS5; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Pa1dqC3zt1K9YdrDdf2lINVA4EvokGytw/w7g3ObwDM=;
	b=cHzhCsS5hKHHzqiX8n+PInmCpEar31kNg34UnEt9aRxzA9t1Laqed2OqhbV8vo
	KoxtggdrEMRo119wd1JBJdvMrG2a4ii4VTx067oT6+fT8DyEMLvVC1i2LeKN6Xh4
	MnIQT75tyRBdA9oJnpqWXF9HTMRvwChmSxfI5+q+UD4Vk=
Received: from localhost (unknown [36.5.132.7])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3n5rv5_xmmTVbAg--.30150S2;
	Wed, 02 Oct 2024 14:28:00 +0800 (CST)
Date: Wed, 2 Oct 2024 14:27:59 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca,
	syzbot <syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ext4: fix out-of-bounds issue in ext4_xattr_set_entry
Message-ID: <Zvzn73lrBnVrwNp5@fedora>
References: <Zu+vI3EipxSsPOMe@thinkpad.lan>
 <66efba95.050a0220.3195df.008c.GAE@google.com>
 <Zu+8aQBJgMn7xVws@thinkpad.lan>
 <ZvvD2FeVm3ViPWIl@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvvD2FeVm3ViPWIl@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-CM-TRANSID:_____wD3n5rv5_xmmTVbAg--.30150S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrWrGrWrury8urWfGFWfZrb_yoW5XFW7pF
	WSywn3Gr4kXr9FgrWIy3yUZw1S9w17G3y5ZryfG34xAFs8Zrn3XFyrKa4FgFyj93ykW3Wj
	qF4jg34UAana93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UDkusUUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLwJsamb82pnXTgAAsr

Hi Ojaswin,

On Tue, Oct 01, 2024 at 03:11:44PM +0530, Ojaswin Mujoo wrote:
> 
> Hey Qianqiang,
> 
> Thanks for the patch. I'm still reviewing this codepath but I do have
> some questions around the patch. So I understand that xattrs are
> arranged in the following format:
> 
>  *   +------------------+
>  *   | header           |
>  *   | entry 1          | 
>  *   | entry 2          | 
>  *   | entry 3          | 
>  *   | four null bytes  | <--- last
>  *   | . . .            | 
>  *   | . . .            | <--- here
>  *   | . . .            | 
>  *   | value 1          | 
>  *   | value 3          | 
>  *   | value 2          | 
>  *   +------------------+
> 
> Now, in this error, my understanding is that we are actually ending up
> in a case where "here" ie the place where the new xattr entry will go is
> beyond the "last" ie the last slot for xattr entry and that is causing
> an underflow, something like the above diagram.
> 
> My only concern is that why were we not able to detect this in the logic
> near the start of the function where we explcity check if we have enough
> space? 
> 
> Perhaps we should be fixing the logic in that if {..} instead
> since the comment a few lines above your fix:
> 
> 	/* No failures allowed past this point. */
> 
> does suggest that we can't error out below that point, so ideally all
> the checks would have been done before that.
> 
> I'm still going through the issue, will update here if needed.
> 
> Regards,
> ojaswin
> 

I reviewed the codepath, and here is the backtrace when the error occurs:

=> vfs_unlink
=> ext4_unlink
=> __ext4_unlink
=> __ext4_mark_inode_dirty
=> ext4_try_to_expand_extra_isize
=> __ext4_expand_extra_isize
=> ext4_expand_extra_isize_ea
=> ext4_xattr_make_inode_space
=> ext4_xattr_move_to_block -> ext4_xattr_block_find -> xattr_find_entry
=> ext4_xattr_block_set
=> ext4_xattr_set_entry
=> memmove((void *)here + size, here, rest);

The xattr_find_entry function return -ENODATA, but beacuase of the
following code, the error does not be returned to caller:

static int
ext4_xattr_block_find(struct inode *inode, struct ext4_xattr_info *i,
		      struct ext4_xattr_block_find *bs)
{
	...
	error = xattr_find_entry(inode, &bs->s.here, bs->s.end,
				 i->name_index, i->name, 1);
	if (error && error != -ENODATA)
		return error;
	...
}

So, perhaps we could modify the code as follows:

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

Or, we could check if s->not_found is -ENODATA in the ext4_xattr_set_entry function.

Any suggestions?

-- 
Best,
Qianqiang Liu


