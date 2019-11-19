Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0830E101129
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Nov 2019 03:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfKSCP2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Nov 2019 21:15:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbfKSCP2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 18 Nov 2019 21:15:28 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 981BF222A0;
        Tue, 19 Nov 2019 02:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574129727;
        bh=MrkxAgBNWjrlOs3B+5mIO6wecBol8itI/obPKgZNi5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1RVNPIS5Qk5K5+Io5ZglGBJezZiFvCEvIa40gSX5OEFrzUBh8HC0Y2h6nI4Um1QP7
         QyJgCMDylvVvnfgUjw/bSCMyfbhN3RPHW3QWHuH14A2wWEWFKGL3R3SUTnHsZYrkdD
         vcfALOH3sZSB792liEzXFQdCi2tPuDPNgQev9F64=
Date:   Mon, 18 Nov 2019 18:15:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        syzbot+f8d6f8386ceacdbfff57@syzkaller.appspotmail.com,
        stable@kernel.org
Subject: Re: [PATCH -v2] ext4: add more paranoia checking in
 ext4_expand_extra_isize handling
Message-ID: <20191119021526.GB3147@sol.localdomain>
References: <20191108024841.9668-1-tytso@mit.edu>
 <201911101835.qg5bu1Me%lkp@intel.com>
 <20191110121510.GH23325@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110121510.GH23325@mit.edu>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Nov 10, 2019 at 07:15:10AM -0500, Theodore Y. Ts'o wrote:
> I hadn't gotten around to resending the patch.  The original version
> had a number of last-minute typos that had crept in...
> 
>       	     		    	       	   - Ted
> 
> From a67ad537964d10f94a4b990c084365e75316cde8 Mon Sep 17 00:00:00 2001
> From: Theodore Ts'o <tytso@mit.edu>
> Date: Thu, 7 Nov 2019 21:43:41 -0500
> Subject: [PATCH] ext4: add more paranoia checking in ext4_expand_extra_isize
>  handling
> 
> 
> It's possible to specify a non-zero s_want_extra_isize via debugging
> option, and this can cause bad things(tm) to happen when using a file
> system with an inode size of 128 bytes.
> 
> Add better checking when the file system is mounted, as well as when
> we are actually doing the trying to do the inode expansion.
> 
> Reported-by: syzbot+f8d6f8386ceacdbfff57@syzkaller.appspotmail.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Cc: stable@kernel.org

Is this patch intended to address
https://lore.kernel.org/linux-ext4/000000000000950f21059564e4c7@google.com
as well?  If so, you can add the second Reported-by line so that both syzbot
reports get closed.

- Eric
