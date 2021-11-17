Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1A0453FF2
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Nov 2021 06:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhKQFYC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Nov 2021 00:24:02 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50480 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231638AbhKQFYB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Nov 2021 00:24:01 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1AH5KuMv020686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 00:20:57 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8A17615C3E24; Wed, 17 Nov 2021 00:20:56 -0500 (EST)
Date:   Wed, 17 Nov 2021 00:20:56 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Mark Hills <mark@xwax.org>
Cc:     Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: Maildir quickly hitting max htree
Message-ID: <YZSROKrWcazsRuXk@mit.edu>
References: <2111121900560.16086@stax.localdomain>
 <36FABD31-B636-4D94-B14D-93F3D2B4C148@dilger.ca>
 <d1f5c468-4afa-accc-7843-83b484dc081@xwax.org>
 <YZFK56zBKXpnIncI@mit.edu>
 <2111161753010.26337@stax.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2111161753010.26337@stax.localdomain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 16, 2021 at 07:31:10PM +0000, Mark Hills wrote:
> 
> I see a definition in mke2fs.conf for "small" which uses 1024 blocksize, 
> and I assume it originated there and not "floppy".

Ah, yes, I forgot that we also had the "small" config for file systems
less than 512 mb.


There are a bunch of anti-patterns that I've seen with users using
VM's.  And I'm trying to understand them, so we can better document
why folks shouldn't be doing things like that.  For example, one of
the anti-patterns that I see on Cloud systems (e.g., at Amazon, Google
Cloud, Azure, etc.) is people who start with a super-tiny file system,
say, 10GB, and then let it grow until it's 99 full, and then they grow
it by another GB, so it's now 11GB, and then they fill it until it's
99% full, and then they grow it by another GB.  That's because (for
example) Google's PD Standard is 4 cents per GB per month, and they
are trying to cheap out by not wanting to spend that extra 4 cents per
month until they absolutely, positively have to.  Unfortunately, that
leaves the file system horribly fragmented, and performance is
terrible.  (BTW, this is true no matter what file system they use:
ext4, xfs, etc.)

File systems were originally engineered assuming that resizing would
be done in fairly big chunks.  For example, you might have a 50 TB
disk array, and you add another 10TB disk to the array, and you grow
the file system by 10TB.  You can grow it in smaller chunks, but
nothing comes for free, and trying to save 4 cents per month as
opposed to growing a file system from say, 10GB to 20GB on Google
Cloud, and paying an extra, princely *forty* cents (USD) per month
will probably result in far better performance, which you'll more than
make up when you consider the cost of the CPU and memory of said
VM....

> I haven't looked at resize2fs code, so this comes just from a user's 
> point-of-view but... if it is already reading mke2fs.conf, it could make 
> comparisons using an equivalent new filesystem as benchmark.

Resize2fs doens't read mke2fs.conf, and my point was that the system
where resize2fs is run is not necessary same as the system where
mke2fs is run, especially when it comes to cloud images for the root
file system.

> I imagine it's not a panacea, but it would be good to be more concrete on 
> what the gotchas are; "bad performance" is vague, and since the tool 
> exists it must be possible to use it properly.

Well, we can document the issues in much greater detail in a man page,
or in LWN article, but we need it's a bit complicated to explain it
all warning messages built into resize2fs.  There's the failure mode
of starting with a 100MB file system containing a root file system,
dropping it on a 10TB disk, or even worse, a 100TB raid array, and
trying to blow it up the 100MB file system to 100TB.  There's the
failure mode of waiting until the file system is 99% full, and then
expanding it one GB at a time, repeatedly, until it's several hundred
GB or TB, and then users wonder why performance is crap.

There are so many different ways one can shoot one's foot off, and
until I understand why people are desining their own particular
foot-guns, it's hard to write a man page warning about all of the
particular bad ways one can be a system administrator.  Unfortunately,
my imagination is not necessarily up to the task of figuring them all
out.  For example...


> For info, our use case here is the base image used to deploy persistent 
> VMs which use very different disk sizes. The base image is build using 
> packer+QEMU managed as code. Then written using "dd" and LVM partitions 
> expanded without needing to go single-user or take the system offline. 
> This method is appealling because it allows to pre-populate /home with 
> some small amount of data; SSH keys etc.

May I suggest using a tar.gz file instead and unpacking it onto a
freshly created file sysetem?  It's easier to inspect and update the
contents of the tarball, and it's actually going to be smaller than
using a file system iamge and then trying to expand it using
resize2fs....

To be honest, that particular use case didn't even *occur* to me,
since there are so many more efficient ways it can be done.  I take it
that you're trying to do this before the VM is launched, as opposed to
unpacking it as part of the VM boot process?

If you're using qemu/KVM, perhaps you could drop the tar.gz file in a
directory on the host, and launch the VM using a virtio-9p.  This can
be done by launching qemu with arguments like this:

qemu ... \
     -fsdev local,id=v_tmp,path=/tmp/kvm-xfstests-tytso,security_model=none \
     -device virtio-9p-pci,fsdev=v_tmp,mount_tag=v_tmp

and then in the guest's /etc/fstab, you might have an entry like this:

v_tmp           /vtmp   9p      trans=virtio,version=9p2000.L,msize=262144,nofail,x-systemd.device-timeout=1       0       0

This will result in everything in /tmp/kvm-xfstests-tytso on the host
system being visible as /vtmp in the guest.  A worked example of this
can be found at:

https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/kvm-xfstests#L115
https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/kvm-xfstests#L175
https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/test-appliance/files/etc/fstab#L7

If you are using Google Cloud Platform or AWS, you could use Google
Cloud Storage or Amazon S3, respectively, and then just copy the
tar.gz file into /run and unpack it.  An example of this might get
done can be found here for Google Cloud Storage:

https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/test-appliance/files/usr/local/lib/gce-load-kernel#L65

Cheers,

					- Ted
