Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62870101287
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Nov 2019 05:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKSEgn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Nov 2019 23:36:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfKSEgm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 18 Nov 2019 23:36:42 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EFC4222DD;
        Tue, 19 Nov 2019 04:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574138202;
        bh=cbaM61dNUYFafEJ8WccG4FE54uY5qL0guPYtReMqLrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hW06FRaShXqHJItKoZWFgjy/eR46sipyYpEy1XibENDVVj5w0B4bb9vp4t7oaAPaX
         Y30S0MwTfRTPyHRZz7eD59TmY7kvg+mWuapGzy99/CHWXvFtqPphGLZ28kGv19aI/3
         1fS7jrTkMejLIGBoCpzxVI8Yzvv66UGrEGTm/AKk=
Date:   Mon, 18 Nov 2019 20:36:40 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        syzbot+f8d6f8386ceacdbfff57@syzkaller.appspotmail.com,
        stable@kernel.org
Subject: Re: [PATCH -v2] ext4: add more paranoia checking in
 ext4_expand_extra_isize handling
Message-ID: <20191119043640.GE163020@sol.localdomain>
References: <20191108024841.9668-1-tytso@mit.edu>
 <201911101835.qg5bu1Me%lkp@intel.com>
 <20191110121510.GH23325@mit.edu>
 <20191119021526.GB3147@sol.localdomain>
 <20191119042120.GD4262@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119042120.GD4262@mit.edu>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 18, 2019 at 11:21:20PM -0500, Theodore Y. Ts'o wrote:
> On Mon, Nov 18, 2019 at 06:15:26PM -0800, Eric Biggers wrote:
> > Is this patch intended to address
> > https://lore.kernel.org/linux-ext4/000000000000950f21059564e4c7@google.com
> > as well?  If so, you can add the second Reported-by line so that both syzbot
> > reports get closed.
> 
> Yes, it appears to be the same issue.  Thanks for pointing this out!
> 
>      		      	       	       - Ted

There's actually a third that looks very similar too:

"KASAN: use-after-free Write in __ext4_expand_extra_isize (2)"
https://lkml.kernel.org/linux-ext4/0000000000000d74c7059564e17f@google.com/

If these are all fixed by this patch, you can use:

Reported-by: syzbot+f8d6f8386ceacdbfff57@syzkaller.appspotmail.com
Reported-by: syzbot+33d7ea72e47de3bdf4e1@syzkaller.appspotmail.com
Reported-by: syzbot+44b6763edfc17144296f@syzkaller.appspotmail.com
