Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59AC33AE3B
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jun 2019 06:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfFJEis (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Jun 2019 00:38:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42004 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728469AbfFJEis (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Jun 2019 00:38:48 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5A4cS90014550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jun 2019 00:38:29 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 83D27420481; Mon, 10 Jun 2019 00:38:28 -0400 (EDT)
Date:   Mon, 10 Jun 2019 00:38:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Wang Shilong <wshilong@ddn.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbZjJmcy1kZXZdIFtQ?= =?utf-8?Q?ATCH?= 1/2]
 ext4: only set project inherit bit for directory
Message-ID: <20190610043828.GC15963@mit.edu>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
 <20190606224525.GB84833@gmail.com>
 <MN2PR19MB3167ED3E8C9C85AE510F7BF4D4100@MN2PR19MB3167.namprd19.prod.outlook.com>
 <20190607181452.GC648@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607181452.GC648@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 07, 2019 at 11:14:52AM -0700, Eric Biggers wrote:
> 
> Existing versions of chattr can't be changed, and people don't necessarily
> upgrade the kernel and e2fsprogs at the same time.  So (1) wouldn't really work.
> 
> A better solution might be to make FS_IOC_GETFLAGS and FS_IOC_FSGETXATTR never
> return the project inherit flag on regular files.

I've amended this patch by adding the following to fix it for
FS_IOC_GETFLAGS (which is chattr uses):

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7af835ac8d23..74648d42c69b 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -779,6 +779,8 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return ext4_ioc_getfsmap(sb, (void __user *)arg);
 	case EXT4_IOC_GETFLAGS:
 		flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
+		if (S_ISREG(inode->i_mode))
+			flags &= ~EXT4_PROJINHERIT_FL;
 		return put_user(flags, (int __user *) arg);
 	case EXT4_IOC_SETFLAGS: {
 		int err;

						- Ted
