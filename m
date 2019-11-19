Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B51F1101212
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Nov 2019 04:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfKSDQa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Nov 2019 22:16:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:51512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfKSDQa (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 18 Nov 2019 22:16:30 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C886219F6;
        Tue, 19 Nov 2019 03:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574133389;
        bh=6w+hmrvX3cmERk62aB4MJXEcf8Z+Q7jruLYEJi9Lous=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sev8G4IL/HOaHin4JdR9dY1l+RywQcWd5hoLPRtpdQ0LX70NemWq9tQTgC7dKfQu3
         IcaSNHGoCXlHAkcU/8vDxW5D+cMzznrffKxCgTTRE1Yr+PAVc7rH6TouqEEIFzdjKO
         qjgQGXw7kZtLxdoo2R432rBU0U0tg5Cc8Y5onUN8=
Date:   Mon, 18 Nov 2019 19:16:27 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+9567fda428fba259deba@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, riteshh@linux.ibm.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: general protection fault in ext4_writepages
Message-ID: <20191119031627.GJ3147@sol.localdomain>
References: <20191111182417.GB5165@mit.edu>
 <00000000000079c18b059717166e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000079c18b059717166e@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 11, 2019 at 11:25:00AM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger
> crash:
> 
> Reported-and-tested-by:
> syzbot+9567fda428fba259deba@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         4d06bfb9 ext4: Add error handling for io_end_vec struct al..
> git tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2cc209e226c8fbbd
> dashboard link: https://syzkaller.appspot.com/bug?extid=9567fda428fba259deba
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Note: testing is done by a robot and is best-effort only.
> 

Marking this fixed for syzbot.

#syz fix: ext4: Add error handling for io_end_vec struct allocation
