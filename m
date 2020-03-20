Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A91C318CD40
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Mar 2020 12:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgCTLtn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Mar 2020 07:49:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:57136 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgCTLtn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Mar 2020 07:49:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 32DB4AE7B;
        Fri, 20 Mar 2020 11:49:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2E4771E0D66; Fri, 20 Mar 2020 12:49:40 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:49:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: Ext4 corruption with VM images as 3 > drop_caches
Message-ID: <20200320114940.GA20455@quack2.suse.cz>
References: <87pndagw7s.fsf@linux.ibm.com>
 <20200320053451.B7AD0AE04D@d06av26.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200320053451.B7AD0AE04D@d06av26.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 20-03-20 11:04:50, Ritesh Harjani wrote:
> On 3/19/20 6:54 PM, Ritesh Harjani wrote:
> > On 3/18/20 9:17 AM, Aneesh Kumar K.V wrote:
> > > Hi,
> > > 
> > > With new vm install I am finding corruption with the vm image if I
> > > follow up the install with echo 3 > /proc/sys/vm/drop_caches
> > > 
> > > The file system reports below error.
> > > 
> > > Begin: Running /scripts/local-bottom ... done.
> > > Begin: Running /scripts/init-bottom ...
> > > [    4.916017] EXT4-fs error (device vda2): ext4_lookup:1700: inode
> > > #787185: comm sh: iget: checksum invalid
> > > done.
> > > [    5.244312] EXT4-fs error (device vda2): ext4_lookup:1700: inode
> > > #917954: comm init: iget: checksum invalid
> > > [    5.257246] EXT4-fs error (device vda2): ext4_lookup:1700: inode
> > > #917954: comm init: iget: checksum invalid
> > > /sbin/init: error while loading shared libraries: libc.so.6: cannot
> > > open shared object file: Error 74
> > > [    5.271207] Kernel panic - not syncing: Attempted to kill init!
> > > exitcode=0x00007f00
> > > 
> > > And debugfs reports
> > > 
> > > debugfs:  stat <917954>
> > > Inode: 917954   Type: bad type    Mode:  0000   Flags: 0x0
> > > Generation: 0    Version: 0x00000000
> > > User:     0   Group:     0   Size: 0
> > > File ACL: 0
> > > Links: 0   Blockcount: 0
> > > Fragment:  Address: 0    Number: 0    Size: 0
> > > ctime: 0x00000000 -- Wed Dec 31 18:00:00 1969
> > > atime: 0x00000000 -- Wed Dec 31 18:00:00 1969
> > > mtime: 0x00000000 -- Wed Dec 31 18:00:00 1969
> > > Size of extra inode fields: 0
> > > Inode checksum: 0x00000000
> > > BLOCKS:
> > > debugfs:
> > > 
> > > Bisecting this finds
> > > Commit 244adf6426ee31a83f397b700d964cff12a247d3("ext4: make
> > > dioread_nolock the default")
> > > as bad. If I revert the same on top of linus
> > > upstream(fb33c6510d5595144d585aa194d377cf74d31911)
> > > I don't hit the corrupttion anymore.
> > 
> > Tried replicating this and could easily replicate it on Power box.
> > I tried to reproduce this on x86 too, but could not reproduce on x86.
> > Now one difference on Power could be that pagesize is 64K and fs
> > blocksize is 4K.
> > 
> > The issue looks like the guest qemu image file is not properly written
> > back, after host does echo 3 > drop_caches. (correct me if this is not
> > the case).
> 
> Ok. So tried this issue with passing "cache=directsync" parameter to
> drive file. This parameter says it should bypass the host side page
> cache. With this parameter, I don't see this issue on Power box.

OK, so this likely means that there is something hosed in the writeback
path using unwritten extents when blocksize < pagesize. Maybe we miss some
conversion of unwritten extent to a written one and thus after dropping
caches we effectively loose data?

								Honza

> > I tried replicating via below test, but it could not reproduce.
> > 
> > Any idea what kind of unit test could be written for this?
> > I am not sure how exactly qemu is writing to it's image file.
> > 
> > 
> > 1. Create 2 files. "mmap-file", "mmap-data".
> > 2. "mmap-file" is a 2GB sparse file. Then at some random offsets (tried
> > with both 64KB align and 4KB align offsets), try to write
> > pagesize/blocksize amount of known data pattern.
> > 3. These offsets (which are pagesize/blocksize align) are recorded into
> > "mmap-data" file via normal read/write calls.
> > 4. Then after we wrote to both files, we munmap the "mmap-file" and
> > close both of these files.
> > 5. Then we do echo 3 > drop_caches.
> > 6. Then in the verify phase, using the offsets written in "mmap-data"
> > file, I read the "mmap-file" to verify if it's contents are proper or
> > not.
> > With that could not reproduce this issue.
> > 
> > 
> > -ritesh
> > 
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
