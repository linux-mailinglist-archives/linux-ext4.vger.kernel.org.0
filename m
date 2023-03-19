Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616BB6C01E9
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Mar 2023 14:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjCSND3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Mar 2023 09:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjCSNDY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Mar 2023 09:03:24 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8C223322
        for <linux-ext4@vger.kernel.org>; Sun, 19 Mar 2023 06:02:54 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32JD2Kg3018573
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Mar 2023 09:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679230944; bh=YddC3+S4bqhZbKrAo69N7fiDWtOO8+hPOjNq9RD4bmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kD7IsxcLO/aYd/iJ+qOh+lt3iNFI5yp3sElxHAxMsBjH13pP1d1cCLrTUAOKhrs/n
         spMMBlVCNBiY58Mkf5imHki42OZ8Wz/S8Ku/Qqb5rcLf+zbpfTxKujDysSxadoIbCB
         Me0rFWQ3LQuasadvvDcfaJmFQFF+RLftGHWuTm2heUrvCecI8GDypFrYbCd032rIcF
         RNhKj+hRA5sNNGKsoYFc6rNA/VGqEJvq5vBoRzb2PzrrysFlQa+9bZ5JsnD+KX9GqP
         Xr67Se2JThwn6r4onOJIUsjtXwFuDpK9mCzPr7qc8tKzo+4rquH8dCKzshKW/Ws8B9
         9UUWzB4VHJEDg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 283E815C3AC6; Sun, 19 Mar 2023 09:02:20 -0400 (EDT)
Date:   Sun, 19 Mar 2023 09:02:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        adilger@whamcloud.com, Jan Kara <jack@suse.cz>,
        linfeilong <linfeilong@huawei.com>,
        wuguanghao <wuguanghao3@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>, libaokun1@huawei.com
Subject: Re: [PATCH] tune2fs: check whether dev is mounted or in use before
 setting
Message-ID: <20230319130220.GD11916@mit.edu>
References: <8babc8eb-1713-91c9-1efa-496909340a6f@huawei.com>
 <20230318162421.GB11916@mit.edu>
 <138552dd-c323-f9f9-9b26-84346527fd05@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <138552dd-c323-f9f9-9b26-84346527fd05@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Mar 19, 2023 at 01:44:57PM +0800, Zhiqiang Liu wrote:
> 
> Does quota setting is safely done on mounted or busy filesystems?

No, and tune2fs already disallows this.

	if (Q_flag) {
		if (mount_flags & EXT2_MF_MOUNTED) {
			fputs(_("The quota feature may only be changed when "
				"the filesystem is unmounted.\n"), stderr);
			rc = 1;
			goto closefs;
		}


> We have met a problem as follows,
> # mkfs.ext4 /dev/sdd
> # mount /dev/sdd /test
> 			# /test mountpoint is used in other namespace
> # umount /dev/sdd
> # tune2fs -O project,quota /dev/sdd

First of all, you unmounted /dev/sdd above.  If it had remained
mounted...

root@kvm-xfstests:~# mkfs.ext4 -q /dev/vdc
root@kvm-xfstests:~# mount /dev/vdc /vdc
[  103.424437] EXT4-fs (vdc): mounted filesystem 37d825ba-e289-4507-a17b-71c4b84cc773 with ordered data mode. Quota mode: none.
root@kvm-xfstests:~# tune2fs -O project,quota /dev/vdc
tune2fs 1.47.0 (5-Feb-2023)
The quota feature may only be changed when the filesystem is unmounted.
root@kvm-xfstests:~# 

> # mount -o prjquota /dev/sdd /test
> # mount | grep sdd
> /dev/sdd on /test type ext4 (rw,relatime,seclabel,prjquota)
> # quotaon -Ppv /test
> quotaon: Mountpoint (or device) /test not found or has no quota enabled

Your problem is that a problem of understanding.  The quotaon and
quotaoff commands are not needed and are not supported once you use
the ext4 "quota as a first class feature".

Before the existence of the ext4 quota feature, ext4 had quota
support, but it was done using visible files (aquota.user and
aquota.group in the top-level directory of the file system).  This
older quota system had a lot of problems.  The top-level files were
visible, and could be corrupted by users.  Since you had to explicitly
enable quota support, the quota files could easily get out of sync
with reality, which required use of a separate quotacheck command;
since it ran on the mounted file system, it was (a) slow, and (b)
while quotacheck was running, if anything else created or deleted
files, the quota files could be out of sync with reality even before
the quotacheck was completed.

The new ext4 quota feature means that the moment the file system is
mounted, the quota information is updated.  You don't have the option
of turning off quota tracking (other than unmounting the file system,
and removing the quota feature, of course).  You also don't need to
run quotacheck; if the quota information is out of date, e2fsck will
notice and correct the problem.

For example:

root@kvm-xfstests:~# tune2fs -O project,quota /dev/vdc 
tune2fs 1.47.0 (5-Feb-2023)
root@kvm-xfstests:~# mount /dev/vdc /vdc
[   18.920024] EXT4-fs (vdc): recovery complete
[   18.920342] EXT4-fs (vdc): mounted filesystem 37d825ba-e289-4507-a17b-71c4b84cc773 with ordered data mode. Quota mode: journalled.
root@kvm-xfstests:~# mkdir /vdc/quota
root@kvm-xfstests:~# chattr -p 123 /vdc/quota
root@kvm-xfstests:~# cp /etc/issue /vdc/quota
root@kvm-xfstests:~# repquota -P /vdc
*** Report for project quotas on device /dev/vdc
Block grace time: 7days; Inode grace time: 7days
                        Block limits                File limits
Project         used    soft    hard  grace    used  soft  hard  grace
----------------------------------------------------------------------
#0        --      24       0       0              3     0     0       
#123      --       4       0       0              1     0     0       

See?  No need to use quotaon!

> Here, tune2fs only check whether /test is mountted when setting project,quota,
> it does not check whether /test is busy (/test is mounted in other namespace).
> Users will be very confused about why prjquota does no take effect.

The question is whether or not /test is mounted, but whether or not
the device is mounted.  In your example, you actually formatted the
file system, so the device was clearly not mounted:

> # mkfs.ext4 /dev/sdd
> # mount /dev/sdd /test

Are you saying that the problem is after this point, you created
addditional mount namespaces, which where cloned off of the existing
mount namespace, and left /dev/sdd mounted there?

#1, don't do that.  #2, your patch wouldn't have helped, since you
were also only checking EXT2_MF_MOUNTED, and it works by checking
/proc/mounts.  If you are using mount namespaces, yes, it's possible
for ext2fs_check_if_mounted() to give incorrect results.  So I'm
pretty sure you must not have tested your patch before you fired it
off to me.  :-)

Now, what we *can* do if we want to bullet-proof against people using
mount namespaces and doing stupid things would be to change the test

	(mount_flags & EXT2_MF_MOUNTED)

to

	(mount_flags & (EXT2_MF_BUSY | EXT2_MF_MOUNTED)))

The EXT2_MF_BUSY flag will indicates that an attempt to open the
device with O_EXCL will fail.  We do this in some places in tune2fs.c,
but we missed this for a couple of cases, including in the tests for
I_flag and Q_flag.

Cheers,

					- Ted
