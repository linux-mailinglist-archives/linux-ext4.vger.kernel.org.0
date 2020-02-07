Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C1E1550DE
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2020 04:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgBGDNb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Feb 2020 22:13:31 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:58376 "EHLO
        MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgBGDNb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Feb 2020 22:13:31 -0500
Received: by mail.13thfloor.at (Postfix, from userid 1001)
        id 0B9D416309; Fri,  7 Feb 2020 04:13:26 +0100 (CET)
Date:   Fri, 7 Feb 2020 04:13:25 +0100
From:   Herbert Poetzl <herbert@13thfloor.at>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: EXT4: unsupported inode size: 4096
Message-ID: <20200207031325.GA27737@MAIL.13thfloor.at>
References: <B9D2B0DE-EAD0-461B-9BA3-E55ADDE38F72@dilger.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B9D2B0DE-EAD0-461B-9BA3-E55ADDE38F72@dilger.ca>
User-Agent: Mutt/1.5.11
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 06, 2020 at 10:55:04PM +0000, Andreas Dilger wrote:

> --Apple-Mail=_7CDF64A9-C7FD-4E08-9AB4-1843C57439EC
> Content-Transfer-Encoding: 7bit
> Content-Type: text/plain;
> 	charset=us-ascii

> On Feb 6, 2020, at 8:35 AM, Herbert Poetzl <herbert@13thfloor.at> wrote:

>> I recently updated one of my servers from an older 4.19
>> Linux kernel to the latest 5.5 kernel mainly because of
>> the many filesystem improvements, just to find that some
>> of my filesystems simply cannot be mounted anymore.

>> The kernel reports: EXT4-fs: unsupported inode size: 4096

>> Here is a simple test to reproduce the issue:

>>  truncate --size 16G data
>>  losetup /dev/loop0 data
>>  mkfs.ext4 -I 4096 /dev/loop0
>>  mount /dev/loop0 /media

> Does this still fail if you also specify "-b 4096"?

mkfs.ext4 -b 4096 -I 4096 /dev/loop0
mount /dev/loop0 /media

[66723.456449] EXT4-fs (loop0): unsupported inode size: 4096

>> [33700.299204] EXT4-fs (loop0): unsupported inode size: 4096

> It looks like this is a bug in the code?  This check is using

> 3641:	blocksize = sb_min_blocksize(sb, EXT4_MIN_BLOCK_SIZE);

> 3782:		if ((sbi->s_inode_size < EXT4_GOOD_OLD_INODE_SIZE) ||
> 3783:		    (!is_power_of_2(sbi->s_inode_size)) ||
> 3784:		    (sbi->s_inode_size > blocksize)) {
> 3785:			ext4_msg(sb, KERN_ERR,
> 3786:			       "unsupported inode size: %d",
> 3787:			       sbi->s_inode_size);
> 3788:			goto failed_mount;
> 3789:		}

> which is set from the hardware sector size of the device, while
> the ext4 filesystem blocksize is not set until later during
> mount:

> 3991:	blocksize = BLOCK_SIZE << le32_to_cpu(es->s_log_block_size);

> It looks like this was just introduced in commitv5.4-rc3-96-g9803387 
> "ext4: validate the debug_want_extra_isize mount option at 
> parse time" so it is a relatively recent change, and looks 
> to be unintentional. 

> This check was previously on line 4033, after "blocksize" was
> updated from the superblock, but it wasn't noticed because it
> works for all "normal" filesystems.

> I suspect nobody has noticed because having an inode *size* of
> 4KB is very unusual, while having an inode *ratio* of 4KB is
> more normal (one 256-byte inode for each 4096-byte block in the
> filesystem). Was the use of "-I 4096" intentional, or did you
> mean to use "-i 4096"?

> The only reason to have a 4096-byte inode *size* is if you have a
> ton of xattrs for every file and/or you have tiny files (< 3.5KB)
> and you are using inline data.

Indeed the filesystems in question have a huge number of small
files with lots and lots of xattrs for each file.

IIRC, back when I created them, I ran some tests iterating 
over various block and group sizes and simply chose the one
with the best performance over a given testset.

>> Note: this works perfectly fine under 4.19.84 and 4.14.145.

>> My guess so far is that somehow the ext4 filesystem now
>> checks that the inode size is not larger than the logical
>> block size of the underlying block device.

>>  # cat /sys/block/loop0/queue/logical_block_size
>>  512

> Yes, this appears to be the case.  We have LOT of filesystems that
> are using 1024-byte inodes, but I suspect that most of them are on
> devices that report 4096-byte sector size and/or are running older
> kernels that have not included this bug.

>> Any ideas how to address this problem and get the file-
>> systems to mount under Linux 5.5?

> Probably the easiest, and likely correct, fix is to move the update
> of "blocksize" from line 3991: up to before this check.  

> There are a bunch of sanity checks that should also be moved
> for a proper patch, but the one-line fix is enough to get your
> filesystems mounting again.

Yes, I can confirm that moving line 3991 before the check
fixes the issue and the test as well as the filesystem
mount passes without problems.

Thanks a bunch for the quick and accurate information!
Appreciated!

> Cheers, Andreas

All the best,
Herbert


> --Apple-Mail=_7CDF64A9-C7FD-4E08-9AB4-1843C57439EC
> Content-Transfer-Encoding: 7bit
> Content-Disposition: attachment;
> 	filename=signature.asc
> Content-Type: application/pgp-signature;
> 	name=signature.asc
> Content-Description: Message signed with OpenPGP

> -----BEGIN PGP SIGNATURE-----
> Comment: GPGTools - http://gpgtools.org

> iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl48mUgACgkQcqXauRfM
> H+ASGg/8DycAju0NbXzVaKiOvovbvjZRyJq7nF6M+KBJevm0928uLjg8qkWvIdXp
> Jj1AM93mikp4A/BULggBBpa8wOCIG9Z7bx1tATaQrvQh/3cI5KuWd7ssfTR9INWJ
> yzgZ1Y/1vjwiU/YD1i922CK4M3sEwmB5fzrNC/H9HruwHpuMe0ek44lNmsuNPjGh
> c+hBkTFlmOPF9n9bW4mr2Da/v1BA+ffSI2NJW3TejR7k6UvvNKWpLrbzheMSMVCf
> y5xuD9mWuh/1FL77tdDfDVbPo6VRS6I1JBoz14EUl9mz6IrCWulVgIIi/7NzRviF
> onDLo/t3pA/2Yx5G+AAVsIM9tClXXGbNT4WquU2vrO9CdnuRT6rr1pc8vKCz7lch
> 2US+UhmorTVVd/NeXQMxT2i6NPNbRsoaBqxP5TcLAtp8b5aDAUCUSAHyIEWtoydm
> GRPRfXZJauqBYDffGdBWsvsMmepceMC4CMiezfoIWBbfnMfH8wVI+D3qEO6gLDkr
> sNm1/dl/7BfIFjF3ndItsgKTVCGIiFgQ86juEDwDwO/+UB9O9K7nngoEe0ZLt/sy
> Kn7RLdkOGR689vc/1WArbM31HntWbp88xTe3s2tPlWv4r9hVZebZXFIAYrwvqviS
> NrZwqOyjeAmlHWJcqaXQS7kV6tYDpT6Je7weNgZmQA1Xc7Ig12o=
> =rKs+
> -----END PGP SIGNATURE-----

> --Apple-Mail=_7CDF64A9-C7FD-4E08-9AB4-1843C57439EC-
