Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D238039411
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jun 2019 20:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbfFGSOz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jun 2019 14:14:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730714AbfFGSOy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 7 Jun 2019 14:14:54 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5E0F20868;
        Fri,  7 Jun 2019 18:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559931294;
        bh=LxudLXFwIaUztX21uuzZxR9BQPiNn2gcYe1CrVHlIpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vq4lNXknvXpojbbxwVutq1e98PNZ+2cktRMP5UB2b11YqzlHrohjFwN8gPSG8R5if
         4VqGZgob+EB/5hghf/MtYAXLfyg69xNUfQ8iFxDLxwNOpEoe3brLCVjZNmUqu8LzwM
         z27fVAL1tuQ3twRpu2UIwQgou4aAu0ofhEdWHetI=
Date:   Fri, 7 Jun 2019 11:14:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Wang Shilong <wshilong@ddn.com>
Cc:     Wang Shilong <wangshilong1991@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbZjJmcy1kZXZdIFtQ?= =?utf-8?Q?ATCH?= 1/2]
 ext4: only set project inherit bit for directory
Message-ID: <20190607181452.GC648@sol.localdomain>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
 <20190606224525.GB84833@gmail.com>
 <MN2PR19MB3167ED3E8C9C85AE510F7BF4D4100@MN2PR19MB3167.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR19MB3167ED3E8C9C85AE510F7BF4D4100@MN2PR19MB3167.namprd19.prod.outlook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 07, 2019 at 07:51:18AM +0000, Wang Shilong wrote:
> Hi,
> 
> > --
> > 2.21.0
> 
> Won't this break 'chattr' on files that already have this flag set?
> FS_IOC_GETFLAGS will return this flag, so 'chattr' will pass it back to
> FS_IOC_SETFLAGS which will return EOPNOTSUPP due to this:
> 
>         if (ext4_mask_flags(inode->i_mode, flags) != flags)
>                 return -EOPNOTSUPP;
> 
> >>>>
> 
> You are right for this and we also need take care of this in EXT4_IOC_FSSETXATTR/
> this is a bit strange behavior as chattr read existed flags
> but could not set them again, there are several possible ways that I could think
> of to fix the issue?
> 
> 1) change chattr to filter Project inherit bit before call FS_IOC_SETFLAGS
> 
> 2) we automatically fixed the flag before mask check, something like:
> if reg:
>      flags &= ~PROJECT_INHERT;
>       if (ext4_mask_flags(inode->i_mode, flags) != flags)
>                 return -EOPNOTSUPP;
> But this might be not good..
> 
> I would prefer solution 1)
> What do you think?

Existing versions of chattr can't be changed, and people don't necessarily
upgrade the kernel and e2fsprogs at the same time.  So (1) wouldn't really work.

A better solution might be to make FS_IOC_GETFLAGS and FS_IOC_FSGETXATTR never
return the project inherit flag on regular files.

- Eric
