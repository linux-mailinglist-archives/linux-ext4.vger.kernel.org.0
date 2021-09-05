Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F4A401052
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Sep 2021 16:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbhIEOhy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Sep 2021 10:37:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51381 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237914AbhIEOhs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Sep 2021 10:37:48 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 185EaV3V016209
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 5 Sep 2021 10:36:32 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5BA4715C33F9; Sun,  5 Sep 2021 10:36:31 -0400 (EDT)
Date:   Sun, 5 Sep 2021 10:36:31 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     =?utf-8?B?6IKW5p2w6Z+s?= <20151213521@stu.xidian.edu.cn>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        security@kernel.org
Subject: Re: Report bug to Linux ext4 file system about inode
Message-ID: <YTTV7x02dI7rvZyp@mit.edu>
References: <52000f5c.6b0.17bb6268e72.Coremail.20151213521@stu.xidian.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52000f5c.6b0.17bb6268e72.Coremail.20151213521@stu.xidian.edu.cn>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 05, 2021 at 09:29:45PM +0800, 肖杰韬 wrote:
> Hi, our team has found a problem in ext4 system on Linux kernel
> v5.10, leading to DoS attacks.
> 
> The struct inode can be exhausted by normal users by calling syscall
> such as creat. A normal user can repeatedly make the creat syscalls
> to creat files and exhaust all struct inode. As a result，although
> there is still a lot of space in the disk, there are no available
> inodes and all ext4 files/directories creation of all other users
> will fail.

You can use project quotas to control the number of blocks and inodes
that are used under a particular directory hierarchy.  So if a
particular container is chroot'ed to the top-level of the directory
using project quota, you can control the amount of file system
resources used by that container.

Indeed, project quotas were added to ext4 specifically to address the
issue of different containers sharing a file system potentially using
all of the blocks or inodes in that shared file system.  (See more
below for a discussion of the on-going effort to add various point
solutions for the sake of containers.)  If you are not using
containers, normal user and group quotas would be the appropriate
solution.

If you are referring to memory utilization (which is normally what
people refer to when they use terms like "struct inode") it
appropriate solution is the memcg controller to limit how much memory
can be used by a particular container.

These techniques are applicable to any file system, and the issue you
raised is not specific to the ext4 file system.  The real issue is the
mistaken belief that containers provide perfect (or some would say,
even adequate) isolation between mutually suspicious users --- and
they do not.

There are people who are trying to sell the benefits of containers who
will try to make this claim, and the obvious issues such as the one
you have identified, have point solutions.  However, if you are really
concerned about providing iron-clad isolation between two users such
that if one of them is malicious, they can not affect the other, the
much better solution is to use Virtual Machines.  VM's are not as
efficient, of course, but that is the nature of engineering tradeoffs.

That being said, people who are developing containers do work to patch
up each isolation failure as they come up, but people need to
understand that there is a certain amount of whack-a-mole[1] that is
happening.  This continuing effort is because of the clear efficiency
gains of containers vs VM's.  But there is a reason why cloud products
such as Google Kubernetes Engine use VM's *plus* containers such that
each GCP Project has exclusive use of a particular VM.  This avoids
the problems where two mutually suspicious customers, such as for
example, Qingju Bike and Meituan Bike, or Hauwei and Samsung, would be
in a position to try to breach the isolation of a pure container-based
system, and cause problems for their competitor(s).

[1] https://en.wikipedia.org/wiki/Whac-A-Mole#Colloquial_usage

Cheers,

					- Ted
