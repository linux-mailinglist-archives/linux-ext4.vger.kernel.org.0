Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED02218BCAD
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Mar 2020 17:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbgCSQgQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Mar 2020 12:36:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:53500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbgCSQgP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 19 Mar 2020 12:36:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 38FA3AD88;
        Thu, 19 Mar 2020 16:36:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DE54C1E0D46; Thu, 19 Mar 2020 17:36:13 +0100 (CET)
Date:   Thu, 19 Mar 2020 17:36:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: Ext4 corruption with VM images as 3 > drop_caches
Message-ID: <20200319163613.GA3339@quack2.suse.cz>
References: <87pndagw7s.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pndagw7s.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi!

On Wed 18-03-20 09:17:51, Aneesh Kumar K.V wrote:
> With new vm install I am finding corruption with the vm image if I
> follow up the install with echo 3 > /proc/sys/vm/drop_caches 
> 
> The file system reports below error.
> 
> Begin: Running /scripts/local-bottom ... done.
> Begin: Running /scripts/init-bottom ...
> [    4.916017] EXT4-fs error (device vda2): ext4_lookup:1700: inode #787185: comm sh: iget: checksum invalid
> done.
> [    5.244312] EXT4-fs error (device vda2): ext4_lookup:1700: inode #917954: comm init: iget: checksum invalid
> [    5.257246] EXT4-fs error (device vda2): ext4_lookup:1700: inode #917954: comm init: iget: checksum invalid
> /sbin/init: error while loading shared libraries: libc.so.6: cannot open shared object file: Error 74
> [    5.271207] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
> 
> And debugfs reports
> 
> debugfs:  stat <917954>
> Inode: 917954   Type: bad type    Mode:  0000   Flags: 0x0
> Generation: 0    Version: 0x00000000
> User:     0   Group:     0   Size: 0
> File ACL: 0
> Links: 0   Blockcount: 0
> Fragment:  Address: 0    Number: 0    Size: 0
> ctime: 0x00000000 -- Wed Dec 31 18:00:00 1969
> atime: 0x00000000 -- Wed Dec 31 18:00:00 1969
> mtime: 0x00000000 -- Wed Dec 31 18:00:00 1969
> Size of extra inode fields: 0
> Inode checksum: 0x00000000
> BLOCKS:
> debugfs:  
> 
> Bisecting this finds 
> Commit 244adf6426ee31a83f397b700d964cff12a247d3("ext4: make
> dioread_nolock the default") as bad. If I revert the same on top of linus
> upstream(fb33c6510d5595144d585aa194d377cf74d31911) I don't hit the
> corrupttion anymore.

Thanks for report and the bisection! Is this guest or host kernel that you
were bisecting? I presume host but I want to make sure.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
