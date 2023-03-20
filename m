Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F4E6C08D1
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Mar 2023 03:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCTCIS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Mar 2023 22:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCTCIR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Mar 2023 22:08:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A70A5DF
        for <linux-ext4@vger.kernel.org>; Sun, 19 Mar 2023 19:08:14 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pfyjw2B5Kz17LbT;
        Mon, 20 Mar 2023 10:05:08 +0800 (CST)
Received: from [10.174.179.254] (10.174.179.254) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 10:08:10 +0800
Subject: Re: [PATCH] tune2fs: check whether dev is mounted or in use before
 setting
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        <adilger@whamcloud.com>, Jan Kara <jack@suse.cz>,
        linfeilong <linfeilong@huawei.com>,
        wuguanghao <wuguanghao3@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>, <libaokun1@huawei.com>
References: <8babc8eb-1713-91c9-1efa-496909340a6f@huawei.com>
 <20230318162421.GB11916@mit.edu>
 <138552dd-c323-f9f9-9b26-84346527fd05@huawei.com>
 <20230319130220.GD11916@mit.edu>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <3a0f4e60-b2a1-ba77-3a32-d0429e512455@huawei.com>
Date:   Mon, 20 Mar 2023 10:08:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20230319130220.GD11916@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2023/3/19 21:02, Theodore Ts'o wrote:
> On Sun, Mar 19, 2023 at 01:44:57PM +0800, Zhiqiang Liu wrote:
>>
>> Does quota setting is safely done on mounted or busy filesystems?
> 
> No, and tune2fs already disallows this.
> 
> 	if (Q_flag) {
> 		if (mount_flags & EXT2_MF_MOUNTED) {
> 			fputs(_("The quota feature may only be changed when "
> 				"the filesystem is unmounted.\n"), stderr);
> 			rc = 1;
> 			goto closefs;
> 		}
> 
> 
>> We have met a problem as follows,
>> # mkfs.ext4 /dev/sdd
>> # mount /dev/sdd /test
>> 			# /test mountpoint is used in other namespace
>> # umount /dev/sdd
>> # tune2fs -O project,quota /dev/sdd
> 
> First of all, you unmounted /dev/sdd above.  If it had remained
> mounted...
> 
> root@kvm-xfstests:~# mkfs.ext4 -q /dev/vdc
> root@kvm-xfstests:~# mount /dev/vdc /vdc
> [  103.424437] EXT4-fs (vdc): mounted filesystem 37d825ba-e289-4507-a17b-71c4b84cc773 with ordered data mode. Quota mode: none.
> root@kvm-xfstests:~# tune2fs -O project,quota /dev/vdc
> tune2fs 1.47.0 (5-Feb-2023)
> The quota feature may only be changed when the filesystem is unmounted.
> root@kvm-xfstests:~# 
> 
>> # mount -o prjquota /dev/sdd /test
>> # mount | grep sdd
>> /dev/sdd on /test type ext4 (rw,relatime,seclabel,prjquota)
>> # quotaon -Ppv /test
>> quotaon: Mountpoint (or device) /test not found or has no quota enabled
> 
> Your problem is that a problem of understanding.  The quotaon and
> quotaoff commands are not needed and are not supported once you use
> the ext4 "quota as a first class feature".
> 
> Before the existence of the ext4 quota feature, ext4 had quota
> support, but it was done using visible files (aquota.user and
> aquota.group in the top-level directory of the file system).  This
> older quota system had a lot of problems.  The top-level files were
> visible, and could be corrupted by users.  Since you had to explicitly
> enable quota support, the quota files could easily get out of sync
> with reality, which required use of a separate quotacheck command;
> since it ran on the mounted file system, it was (a) slow, and (b)
> while quotacheck was running, if anything else created or deleted
> files, the quota files could be out of sync with reality even before
> the quotacheck was completed.
> 
> The new ext4 quota feature means that the moment the file system is
> mounted, the quota information is updated.  You don't have the option
> of turning off quota tracking (other than unmounting the file system,
> and removing the quota feature, of course).  You also don't need to
> run quotacheck; if the quota information is out of date, e2fsck will
> notice and correct the problem.
> 
> For example:
> 
> root@kvm-xfstests:~# tune2fs -O project,quota /dev/vdc 
> tune2fs 1.47.0 (5-Feb-2023)
> root@kvm-xfstests:~# mount /dev/vdc /vdc
> [   18.920024] EXT4-fs (vdc): recovery complete
> [   18.920342] EXT4-fs (vdc): mounted filesystem 37d825ba-e289-4507-a17b-71c4b84cc773 with ordered data mode. Quota mode: journalled.
> root@kvm-xfstests:~# mkdir /vdc/quota
> root@kvm-xfstests:~# chattr -p 123 /vdc/quota
> root@kvm-xfstests:~# cp /etc/issue /vdc/quota
> root@kvm-xfstests:~# repquota -P /vdc
> *** Report for project quotas on device /dev/vdc
> Block grace time: 7days; Inode grace time: 7days
>                         Block limits                File limits
> Project         used    soft    hard  grace    used  soft  hard  grace
> ----------------------------------------------------------------------
> #0        --      24       0       0              3     0     0       
> #123      --       4       0       0              1     0     0       
> 
> See?  No need to use quotaon!
> 
Thank you very much for your patient explanation.


>> Here, tune2fs only check whether /test is mountted when setting project,quota,
>> it does not check whether /test is busy (/test is mounted in other namespace).
>> Users will be very confused about why prjquota does no take effect.
> 
> The question is whether or not /test is mounted, but whether or not
> the device is mounted.  In your example, you actually formatted the
> file system, so the device was clearly not mounted:
> 
>> # mkfs.ext4 /dev/sdd
>> # mount /dev/sdd /test
> 
> Are you saying that the problem is after this point, you created
> addditional mount namespaces, which where cloned off of the existing
> mount namespace, and left /dev/sdd mounted there?
Yes, that's exactly what I meant.
I'm so sorry for my confusing expression.

> 
> #1, don't do that.  #2, your patch wouldn't have helped, since you
> were also only checking EXT2_MF_MOUNTED, and it works by checking
> /proc/mounts.  If you are using mount namespaces, yes, it's possible
> for ext2fs_check_if_mounted() to give incorrect results.  So I'm
> pretty sure you must not have tested your patch before you fired it
> off to me.  :-)
Thanks for pointing out it.
In fact, I have tested my patch before sending it to you. In my patch,
I check both EXT2_MF_MOUNTED and EXT2_MF_BUSY flags similar to check_mount().
In my test, the /dev/sdd is unmounted in current namespace, but it was left
mounted in other mount namespace. So only checking EXT2_MF_MOUNTED does not
make sense. Actually, current tune2fs has already check EXT2_MF_MOUNTED flag
when Q_flag is set. So, I refer to check_mount() to add EXT2_MF_BUSY check.

The details as follows,

--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -3327,6 +3327,22 @@ retry_open:
 		goto closefs;
 	}

+	if (open_flag & EXT2_FLAG_RW) {
+		if (mount_flags & EXT2_MF_MOUNTED) {
+			fprintf(stderr, _("Warning! %s is mounted.\n"), device_name);
+			if (!f_flag) {
+				rc = 1;
+				goto closefs;
+			}
+		} else if (mount_flags & EXT2_MF_BUSY) {
+			fprintf(stderr, _("Warning! %s is in use by the system.\n"),
+					device_name);
+			if (!f_flag) {
+				rc = 1;
+				goto closefs;
+			}
+		}

> 
> Now, what we *can* do if we want to bullet-proof against people using
> mount namespaces and doing stupid things would be to change the test
> 
> 	(mount_flags & EXT2_MF_MOUNTED)
> 
> to
> 
> 	(mount_flags & (EXT2_MF_BUSY | EXT2_MF_MOUNTED)))
> 
> The EXT2_MF_BUSY flag will indicates that an attempt to open the
> device with O_EXCL will fail.  We do this in some places in tune2fs.c,
> but we missed this for a couple of cases, including in the tests for
> I_flag and Q_flag.
> 
> Cheers,
> 
> 					- Ted
Thanks for your suggestion.
At the begin, I wanted to add EXT2_MF_BUSY check only in the Q_flag test.
Because I didn't understand that tune2fs is designed for mounted file systems,
I added the EXT2_MF_BUSY and EXT2_MF_MOUNTED before all tests.

I will follow your suggestions to add EXT2_MF_BUSY check
in both I_flag and Q_flag tests, and send a new patch.

Thank you again for your patient explanation.

Zhiqiang Liu.

> .
> 
